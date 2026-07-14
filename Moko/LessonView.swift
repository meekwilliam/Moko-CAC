import SwiftUI
import Combine

// MARK: - Lesson player (state machine)

final class LessonPlayer: ObservableObject {
    let lesson: Lesson
    let unit: (main: Color, dark: Color)
    let isReplay: Bool                   // already completed → reward shows +25 XP
    let unitBonusEligible: Bool          // completing this lesson finishes its whole unit
    let isTestLesson: Bool               // debug mechanics-test lesson → shows a Skip button
    let isUnitTest: Bool                 // last lesson of a unit → a review test over the whole unit

    /// Live queue of screens; a missed question is re-appended so you must get
    /// it right to finish (mirrors the web LessonEngine).
    @Published var screens: [LessonScreen]

    @Published var index = 0
    @Published var revealed = false      // an answer has been graded / step resolved
    @Published var lastCorrect = false
    @Published var correctCount = 0
    @Published var answeredCount = 0
    @Published var missedSkills: [String: Int] = [:]
    @Published var correctCompetencies: [String: Int] = [:]
    @Published var missedCompetencies: [String: Int] = [:]
    @Published var missedSourceLessons: [String: Int] = [:]
    @Published var finished = false      // reward screen

    // Single-choice selection (true_false / multiple_choice / fill_blank / ingredient_match)
    @Published var selectedIndex: Int? = nil
    @Published var selectedSet: Set<Int> = []          // tap_candles multi-select
    @Published var markedLevel: Double? = nil          // mark_level: the price the user marked
    var markTrueLevel: Double? = nil                   // the correct level (set by the view)
    var markTolerance: Double = 0                      // acceptable distance for mark_level
    // draw_trendline: the two candle indices the learner dragged between
    @Published var trendStart: Int? = nil
    @Published var trendEnd: Int? = nil
    // mark_consolidation: the contiguous candle-index range the learner dragged across
    @Published var consolidationLo: Int? = nil
    @Published var consolidationHi: Int? = nil
    // ohlc_label: which label (0=Open,1=High,2=Low,3=Close) sits in each slot
    // (0=top wick, 1=body top, 2=body bottom, 3=bottom wick), and the correct map.
    @Published var ohlcPlacement: [Int: Int] = [:]
    var ohlcExpected: [Int: Int] = [:]
    // number_slider: the value the learner dragged to
    @Published var numberValue: Double? = nil
    // fill_blank_multi
    @Published var multiSelections: [Int?] = []
    @Published var multiSelectionLabels: [String?] = []
    @Published var multiSelectionIDs: [String?] = []
    // matching: original left-pair index -> original right-pair index
    @Published var matchingSelections: [Int: Int] = [:]
    // sequence_builder / drag_order
    @Published var builtOrder: [String] = []
    @Published var optionOrder: [Int] = []
    @Published var scenarioStage = 0
    @Published var decisionTick: Int? = nil
    @Published var scenarioHadMistake = false

    var onFinished: (() -> Void)?
    /// Called with the new screen index each time the player advances, so the
    /// native lesson can persist mid-lesson progress (resume on reopen).
    var onAdvance: ((Int) -> Void)?
    /// Called before revealing an original question's result. Returns false
    /// when the learner is out of hearts, so the answer stays ungraded.
    var onSpendHeart: (() -> Bool)?

    init(lesson: Lesson, startIndex: Int = 0, isReplay: Bool = false,
         unitColor: (main: Color, dark: Color)? = nil, unitBonusEligible: Bool = false,
         isTestLesson: Bool = false, isUnitTest: Bool = false) {
        self.lesson = lesson
        self.isReplay = isReplay
        self.unitBonusEligible = unitBonusEligible
        self.isTestLesson = isTestLesson
        self.isUnitTest = isUnitTest
        // Drop the lesson-opening "intro" reading screen — straight into the
        // first question. Attention spans are short and it read as dead air.
        let screens = lesson.screens.filter { $0.type != "intro" }
        self.screens = screens.isEmpty ? lesson.screens : screens
        // Prefer the caller-supplied unit color (the lesson's real unit banner
        // color, works for any unit size); fall back to the legacy node-range
        // guess only if the caller doesn't have section data on hand.
        self.unit = unitColor ?? Theme.unitColor(lesson.node)
        self.index = min(max(0, startIndex), max(0, self.screens.count - 1))
        configureOptionOrder()
        if self.index > 0 { resetForScreen() }
    }

    var screen: LessonScreen { screens[min(index, max(0, screens.count - 1))] }
    var isLastScreen: Bool { index >= screens.count - 1 }
    var progress: CGFloat { CGFloat(index + 1) / CGFloat(screens.count + 1) }

    var isIntro: Bool { screen.type == "intro" }
    var isMatching: Bool { screen.type == "matching" }
    var isOrdering: Bool { screen.type == "sequence_builder" || screen.type == "drag_order" }
    var activeTradeStage: TradeStage? {
        guard screen.type == "trade_scenario", let stages = screen.tradeStages,
              stages.indices.contains(scenarioStage) else { return nil }
        return stages[scenarioStage]
    }
    var hasMoreScenarioStages: Bool {
        screen.type == "trade_scenario" && scenarioStage + 1 < (screen.tradeStages?.count ?? 0)
    }

    var currentOptions: [String] {
        if let stage = activeTradeStage { return stage.options ?? ["LONG", "SHORT", "WAIT"] }
        if screen.type == "trade_decision" { return screen.options ?? ["LONG", "SHORT", "WAIT"] }
        if screen.type == "trade_manage" { return screen.options ?? ["HOLD", "EXIT", "REDUCE", "WAIT FOR MORE EVIDENCE"] }
        if screen.type == "entry_select" { return screen.options ?? ["MARKET", "LIMIT", "NO ENTRY"] }
        if screen.type == "true_false" { return ["True", "False"] }
        if screen.type == "ingredient_match" { return (screen.ingredientOptions ?? []).map { $0.label } }
        if screen.type == "aggressor" { return ["The buyer", "The seller"] }
        if screen.type == "book_drag" { return ["the bid", "the ask"] }
        let options = screen.options ?? []
        return optionOrder.count == options.count ? optionOrder.map { options[$0] } : options
    }
    var currentCorrectIndex: Int {
        if let stage = activeTradeStage { return stage.correct }
        if screen.type == "true_false" { return (screen.correctBool ?? false) ? 0 : 1 }
        if screen.type == "ingredient_match" {
            return screen.ingredientOptions?.firstIndex(where: { $0.correct == true }) ?? 0
        }
        let original = screen.correctIndex ?? 0
        return optionOrder.firstIndex(of: original) ?? original
    }

    /// Whether the primary button can be tapped in the "check" phase.
    var canCheck: Bool {
        switch screen.type {
        case "matching":
            let n = screen.pairs?.count ?? 0
            return n > 0 && matchingSelections.count == n
        case "fill_blank_multi":
            let n = screen.blanks?.count ?? 0
            return n > 0 &&
                multiSelectionLabels.count == n &&
                !multiSelectionLabels.contains(where: { $0 == nil })
        case "sequence_builder", "drag_order":
            return !builtOrder.isEmpty && builtOrder.count == (screen.items?.count ?? 0)
        case "tap_candles":
            return !selectedSet.isEmpty
        case "evidence_select":
            let needed = screen.targets?.count ?? 0
            return needed > 0 && selectedSet.count == needed
        case "orderflow_sim_select":
            let needed = screen.targets?.count ?? 0
            return needed > 0 && selectedSet.count == needed
        case "mark_level":
            return markedLevel != nil
        case "draw_trendline":
            return trendStart != nil && trendEnd != nil && trendStart != trendEnd
        case "mark_consolidation":
            return consolidationLo != nil && consolidationHi != nil
        case "ohlc_label":
            return ohlcPlacement.count == 4
        case "number_slider":
            return numberValue != nil
        default:
            return selectedIndex != nil
        }
    }

    func resetForScreen() {
        selectedIndex = nil
        selectedSet = []
        markedLevel = nil
        markTrueLevel = nil
        trendStart = nil
        trendEnd = nil
        consolidationLo = nil
        consolidationHi = nil
        ohlcPlacement = [:]
        ohlcExpected = [:]
        numberValue = nil
        decisionTick = nil
        matchingSelections = [:]
        revealed = false
        lastCorrect = false
        builtOrder = []
        configureOptionOrder()
        if screen.type == "fill_blank_multi" {
            multiSelections = Array(repeating: nil, count: screen.blanks?.count ?? 0)
            multiSelectionLabels = Array(repeating: nil, count: screen.blanks?.count ?? 0)
            multiSelectionIDs = Array(repeating: nil, count: screen.blanks?.count ?? 0)
        } else {
            multiSelections = []
            multiSelectionLabels = []
            multiSelectionIDs = []
        }
    }

    private func configureOptionOrder() {
        let options = screen.options ?? []
        let shuffleTypes: Set<String> = ["multiple_choice", "time_sales", "footprint", "orderflow_sim", "book_compare", "replay_compare"]
        optionOrder = shuffleTypes.contains(screen.type) ? Array(options.indices).shuffled() : Array(options.indices)
    }

    func check() {
        guard !revealed else { return }
        guard canCheck else { return }
        guard spendHeartIfNeeded() else { return }
        var correct = true
        switch screen.type {
        case "matching":
            let n = screen.pairs?.count ?? 0
            correct = n > 0 && matchingSelections.count == n &&
                matchingSelections.allSatisfy { left, right in left == right }
        case "fill_blank_multi":
            if let blanks = screen.blanks {
                for (i, b) in blanks.enumerated() {
                    let selectedLabel: String? = multiSelectionLabels.indices.contains(i) ? multiSelectionLabels[i] : nil
                    let correctLabel: String? = b.options.indices.contains(b.correct) ? b.options[b.correct] : nil
                    if selectedLabel != correctLabel { correct = false }
                }
            }
        case "sequence_builder", "drag_order":
            correct = (builtOrder == (screen.correctOrder ?? []))
        case "tap_candle":
            correct = (selectedIndex == screen.target)
        case "time_sales_tap", "footprint_tap", "volume_profile_tap", "dom_tap", "cvd_tap", "orderflow_sim_tap":
            correct = (selectedIndex == screen.target)
        case "tap_candles":
            correct = (selectedSet == Set(screen.targets ?? []))
        case "evidence_select":
            correct = (selectedSet == Set(screen.targets ?? []))
        case "orderflow_sim_select":
            correct = (selectedSet == Set(screen.targets ?? []))
        case "mark_level":
            if let marked = markedLevel, let truth = markTrueLevel {
                correct = abs(marked - truth) <= markTolerance
            } else { correct = false }
        case "draw_trendline":
            if let a = trendStart, let b = trendEnd,
               let ts = screen.targetStart, let te = screen.targetEnd {
                let chosen = Set([a, b]), target = Set([ts, te])
                correct = chosen.count == 2 && target.count == 2 &&
                    abs(chosen.min()! - target.min()!) <= 1 && abs(chosen.max()! - target.max()!) <= 1
            } else { correct = false }
        case "mark_consolidation":
            if let lo = consolidationLo, let hi = consolidationHi,
               let tlo = screen.targetLo, let thi = screen.targetHi {
                correct = abs(lo - tlo) <= 1 && abs(hi - thi) <= 1
            } else { correct = false }
        case "ohlc_label":
            correct = !ohlcExpected.isEmpty && ohlcPlacement == ohlcExpected
        case "number_slider":
            if let v = numberValue, let truth = screen.numberCorrect {
                correct = abs(v - truth) <= (screen.numberTolerance ?? 0)
            } else { correct = false }
        default:
            correct = (selectedIndex == currentCorrectIndex)
        }
        lastCorrect = correct
        answeredCount += 1
        if correct {
            correctCount += 1
            if let competency = screen.competencyId { correctCompetencies[competency, default: 0] += 1 }
        } else {
            if let skill = screen.skillId { missedSkills[skill, default: 0] += 1 }
            if let competency = screen.competencyId { missedCompetencies[competency, default: 0] += 1 }
            if let sourceLesson = screen.sourceLesson { missedSourceLessons[sourceLesson, default: 0] += 1 }
        }
        revealed = true
        if screen.type == "trade_scenario" && !correct { scenarioHadMistake = true }
        let shouldRequeueScenario = screen.type == "trade_scenario" && !hasMoreScenarioStages && scenarioHadMistake
        let shouldRequeueQuestion = screen.type != "trade_scenario" && !correct
        if (shouldRequeueQuestion || shouldRequeueScenario) && lesson.lessonType != "TEST_OUT" {
            var missed = screen          // requeue the missed question to the end
            missed.isPreviousMistake = true
            screens.append(missed)
        }
        // Outcome haptic to match the reveal banner: success buzz / error buzz.
        if correct { Haptics.success() } else { Haptics.error() }
    }

    private func spendHeartIfNeeded() -> Bool {
        guard !screen.isPreviousMistake else { return true }
        return onSpendHeart?() ?? true
    }

    func advance() {
        if isIntro { revealed = true } // intro has nothing to grade
        if hasMoreScenarioStages {
            scenarioStage += 1
            resetForScreen()
            return
        }
        if isLastScreen {
            finished = true
            Haptics.impact(.medium)
            return
        }
        scenarioStage = 0
        scenarioHadMistake = false
        index += 1
        resetForScreen()
        onAdvance?(index)
    }

    /// A detached copy of the current question state. SwiftUI keeps outgoing
    /// transition views alive, but an `ObservedObject` would otherwise make the
    /// old page immediately render the new question as soon as `index` changes.
    func frozenCopy() -> LessonPlayer {
        let copy = LessonPlayer(
            lesson: lesson,
            startIndex: index,
            isReplay: isReplay,
            unitColor: unit,
            unitBonusEligible: unitBonusEligible,
            isTestLesson: isTestLesson,
            isUnitTest: isUnitTest
        )
        copy.screens = screens
        copy.index = index
        copy.revealed = revealed
        copy.lastCorrect = lastCorrect
        copy.correctCount = correctCount
        copy.answeredCount = answeredCount
        copy.missedSkills = missedSkills
        copy.correctCompetencies = correctCompetencies
        copy.missedCompetencies = missedCompetencies
        copy.missedSourceLessons = missedSourceLessons
        copy.finished = finished
        copy.selectedIndex = selectedIndex
        copy.selectedSet = selectedSet
        copy.markedLevel = markedLevel
        copy.markTrueLevel = markTrueLevel
        copy.markTolerance = markTolerance
        copy.trendStart = trendStart
        copy.trendEnd = trendEnd
        copy.consolidationLo = consolidationLo
        copy.consolidationHi = consolidationHi
        copy.ohlcPlacement = ohlcPlacement
        copy.ohlcExpected = ohlcExpected
        copy.numberValue = numberValue
        copy.multiSelections = multiSelections
        copy.multiSelectionLabels = multiSelectionLabels
        copy.multiSelectionIDs = multiSelectionIDs
        copy.matchingSelections = matchingSelections
        copy.builtOrder = builtOrder
        copy.optionOrder = optionOrder
        copy.scenarioStage = scenarioStage
        copy.decisionTick = decisionTick
        copy.scenarioHadMistake = scenarioHadMistake
        return copy
    }
}

// MARK: - Container

struct LessonView: View {
    @StateObject private var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var theme: ThemeManager
    @State private var showExitConfirm = false
    @State private var checkReadyPulse = false
    @State private var outgoingPlayer: LessonPlayer?
    @State private var questionSlideProgress: CGFloat = 0
    @State private var questionSlideGeneration = 0
    // The progress bar reads this instead of player.progress directly, so it can
    // ease forward on its own timing. Advancing changes player.progress inside a
    // disablesAnimations transaction (to install the slide pages instantly),
    // which would otherwise make the bar jump.
    @State private var displayedProgress: CGFloat = 0
    let hearts: Int
    let isUnlimitedHearts: Bool
    var onClose: () -> Void
    var onComplete: (Int) -> Void   // node number
    var onAssessmentComplete: (Int, Int, [String: Int], [String: Int]) -> Void

    init(lesson: Lesson, startIndex: Int = 0, isReplay: Bool = false,
         unitColor: (main: Color, dark: Color)? = nil,
         unitBonusEligible: Bool = false,
         isTestLesson: Bool = false,
         isUnitTest: Bool = false,
         hearts: Int = ProgressStore.maxHearts,
         isUnlimitedHearts: Bool = false,
         onClose: @escaping () -> Void,
         onComplete: @escaping (Int) -> Void,
         onAssessmentComplete: @escaping (Int, Int, [String: Int], [String: Int]) -> Void = { _, _, _, _ in },
         onSaveProgress: @escaping (Int) -> Void = { _ in },
         onSpendHeart: @escaping () -> Bool = { true }) {
        let p = LessonPlayer(lesson: lesson, startIndex: startIndex, isReplay: isReplay,
                             unitColor: unitColor, unitBonusEligible: unitBonusEligible,
                             isTestLesson: isTestLesson, isUnitTest: isUnitTest)
        p.onAdvance = onSaveProgress
        p.onSpendHeart = onSpendHeart
        _player = StateObject(wrappedValue: p)
        // Start at the right width so the bar slides in already-filled with the
        // rest of the lesson, rather than doing a separate fill-from-empty on
        // open. It only animates on advance from here.
        _displayedProgress = State(initialValue: p.progress)
        self.hearts = hearts
        self.isUnlimitedHearts = isUnlimitedHearts
        self.onClose = onClose
        self.onComplete = onComplete
        self.onAssessmentComplete = onAssessmentComplete
    }

    private var bg: Color { Theme.appBackground }
    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }

    // Answer-interaction accent: a fixed blue for the progress bar, Check /
    // Got It buttons and selected options — consistent regardless of the unit's
    // own (now per-unit) button color on the path.
    private let accent = Theme.answer
    private let accentDark = Theme.answerDark

    var body: some View {
        ZStack {
            ThemedBackground()

            if player.finished {
                RewardView(player: player) {
                    if player.lesson.lessonType == "TEST_OUT" {
                        onAssessmentComplete(player.correctCount, player.answeredCount,
                                             player.correctCompetencies, player.missedCompetencies)
                    } else {
                        onComplete(player.lesson.node)
                    }
                }
                .transition(.opacity)
            } else {
                VStack(spacing: 0) {
                    header
                    questionPager
                }
            }

            if showExitConfirm {
                ExitDialog(
                    onKeepGoing: { withAnimation(.easeOut(duration: 0.18)) { showExitConfirm = false } },
                    onExit: { showExitConfirm = false; onClose() }
                )
                .transition(.opacity)
                .zIndex(100)
            }
        }
        .animation(.easeInOut(duration: 0.22), value: player.finished)
        .onChange(of: player.canCheck) { ready in
            guard ready && !player.revealed else { return }
            checkReadyPulse = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                checkReadyPulse = false
            }
        }
    }

    // MARK: Question-to-question paging

    private var questionPager: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            ZStack(alignment: .topLeading) {
                if let outgoingPlayer {
                    questionPage(outgoingPlayer)
                        .frame(width: width, height: geometry.size.height)
                        .offset(x: -width * questionSlideProgress)
                        .allowsHitTesting(false)
                }

                questionPage(player)
                    .id(player.index)
                    .frame(width: width, height: geometry.size.height)
                    .offset(x: outgoingPlayer == nil ? 0 : width * (1 - questionSlideProgress))
                    .allowsHitTesting(outgoingPlayer == nil)
            }
            // The app window already clips the horizontal page offsets. Do not
            // clip this container vertically: the feedback footer deliberately
            // bleeds through the bottom safe area to the physical screen edge.
        }
    }

    /// The order-flow simulation/decision boards are meant to read as a clean
    /// live chart with just answer buttons — no TEST OUT badge on top.
    private func isCleanBoard(_ type: String) -> Bool {
        ["trade_decision", "trade_scenario", "trade_manage", "entry_select",
         "invalidation_mark", "orderflow_sim", "orderflow_sim_tap", "orderflow_sim_select"].contains(type)
    }

    private func questionPage(_ pagePlayer: LessonPlayer) -> some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if pagePlayer.lesson.lessonType == "TEST_OUT" && !isCleanBoard(pagePlayer.screen.type) { testOutBadge }
                    if pagePlayer.screen.isPreviousMistake { retryBadge }
                    LessonScreenRouter(player: pagePlayer, ink: ink)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 24)
            }
            footer(for: pagePlayer)
        }
        .background(Color.clear)
    }

    private func advanceQuestion() {
        guard outgoingPlayer == nil else { return }

        // A trade scenario is one uninterrupted replay. Move its decision
        // point forward without replacing or sliding the simulation view.
        if player.hasMoreScenarioStages {
            withAnimation(.easeInOut(duration: 0.22)) { player.advance() }
            return
        }

        // The reward screen has its own transition; only question changes use
        // the horizontal pager.
        guard !player.isLastScreen else {
            withAnimation(.easeInOut(duration: 0.25)) { player.advance() }
            return
        }

        questionSlideGeneration += 1
        let generation = questionSlideGeneration
        let frozenOutgoing = player.frozenCopy()

        // Install both pages without animation first. The outgoing copy keeps
        // the answered state while the live player advances and resets.
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            outgoingPlayer = frozenOutgoing
            questionSlideProgress = 0
            player.advance()
        }

        DispatchQueue.main.async {
            // Set outside the disablesAnimations transaction so the bar's
            // .animation(value: displayedProgress) eases it forward.
            displayedProgress = player.progress
            withAnimation(.easeInOut(duration: 0.32)) {
                questionSlideProgress = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.34) {
                guard generation == questionSlideGeneration else { return }
                var cleanup = Transaction(animation: nil)
                cleanup.disablesAnimations = true
                withTransaction(cleanup) {
                    outgoingPlayer = nil
                    questionSlideProgress = 0
                }
            }
        }
    }

    private var retryBadge: some View {
        HStack(spacing: 5) {
            Image(systemName: "arrow.counterclockwise")
                .font(.system(size: 12, weight: .black))
            Text("Second try")
                .font(Theme.font(13, .black)).textCase(.uppercase).tracking(0.5)
        }
        .foregroundColor(Theme.warning)
    }

    private var testOutBadge: some View {
        Label("PLACEMENT CHALLENGE", systemImage: "scope")
            .font(Theme.font(10, .black)).tracking(1.1)
            .foregroundColor(Theme.progress)
            .padding(.horizontal, 10).padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: Theme.Radius.small, style: .continuous)
                    .fill(Theme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.small, style: .continuous)
                            .strokeBorder(Theme.progress.opacity(0.45), lineWidth: 1)
                    )
            )
    }

    // MARK: Header — close, progress bar, hearts

    private var header: some View {
        HStack(spacing: 14) {
            Button(action: { Haptics.selection(); withAnimation(.easeOut(duration: 0.18)) { showExitConfirm = true } }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Theme.muted)
            }
            .buttonStyle(Circle3DStyle(
                face: Theme.surface,
                slab: Theme.surfaceStrong,
                size: 36, depth: 1))

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Theme.surfaceStrong)
                    Capsule().fill(
                        LinearGradient(colors: [Theme.mastery, Theme.progress],
                                       startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(16, geo.size.width * displayedProgress))
                }
            }
            .frame(height: 5)
            .animation(.easeInOut(duration: 0.32), value: displayedProgress)

            lessonHeartBadge
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    private var lessonHeartBadge: some View {
        HStack(spacing: 5) {
            Image(systemName: "shield.lefthalf.filled")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor((isUnlimitedHearts || hearts > 0) ? Theme.warning : Theme.subtle)
            if isUnlimitedHearts {
                Image(systemName: "infinity")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(ink)
            } else {
                Text("\(hearts)")
                    .font(Theme.marketFont(14, .semibold))
                    .foregroundColor(ink)
                    .monospacedDigit()
                    .contentTransition(.numericText())
            }
        }
        .frame(minWidth: 52, alignment: .trailing)
    }

    // MARK: Footer — feedback banner + primary button

    private func footer(for pagePlayer: LessonPlayer) -> some View {
        VStack(spacing: 0) {
            if pagePlayer.isTestLesson && pagePlayer.lesson.lessonType != "TEST_OUT" {
                Button("Skip →") { advanceQuestion() }
                    .font(Theme.font(13, .black))
                    .foregroundColor(Theme.muted)
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 20)
            }
            if pagePlayer.revealed && !pagePlayer.isIntro && pagePlayer.lesson.lessonType != "TEST_OUT" {
                // The feedback card carries its own WHY? / Got It / Continue
                // buttons, so it replaces the primary button entirely.
                FeedbackBanner(player: pagePlayer) { advanceQuestion() }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                primaryButton(for: pagePlayer)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
            }
        }
        .background(
            (pagePlayer.revealed && !pagePlayer.isIntro ? Theme.backgroundElevated : Color.clear)
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: pagePlayer.revealed && !pagePlayer.isIntro ? Theme.Radius.large : 0,
                    bottomLeadingRadius: 0, bottomTrailingRadius: 0,
                    topTrailingRadius: pagePlayer.revealed && !pagePlayer.isIntro ? Theme.Radius.large : 0,
                    style: .continuous))
                .overlay(alignment: .top) {
                    if pagePlayer.revealed && !pagePlayer.isIntro {
                        Rectangle().fill(Theme.surfaceBorder).frame(height: 1)
                    }
                }
                .ignoresSafeArea(edges: .bottom)
        )
        .animation(.easeOut(duration: 0.22), value: pagePlayer.revealed)
    }

    @ViewBuilder
    private func primaryButton(for pagePlayer: LessonPlayer) -> some View {
        if pagePlayer.isIntro {
            Button("CONTINUE") { advanceQuestion() }
                .buttonStyle(Chunky3DStyle(fill: accent, slab: accentDark))
        } else if !pagePlayer.revealed {
            // Solid (not translucent) grays when disabled — a translucent fill
            // let the dark background bleed through unevenly at the seam
            // between the top face and the slab, showing as a stray line.
            Button("CHECK READ") { withAnimation(.easeOut(duration: 0.16)) { pagePlayer.check() } }
                .buttonStyle(Chunky3DStyle(
                    fill: pagePlayer.canCheck ? accent : Color(hex: "#4B5563"),
                    slab: pagePlayer.canCheck ? accentDark : Color(hex: "#333B47")))
                .disabled(!pagePlayer.canCheck)
                .scaleEffect(checkReadyPulse ? 1.01 : 1)
                .animation(.easeOut(duration: 0.14), value: checkReadyPulse)
        } else if pagePlayer.lesson.lessonType == "TEST_OUT" {
            Button(pagePlayer.isLastScreen ? "Finish Assessment" : "Next Question") { advanceQuestion() }
                .buttonStyle(Chunky3DStyle(fill: accent, slab: accentDark))
        } else {
            Button(pagePlayer.isLastScreen ? "Finish" : "Continue") { advanceQuestion() }
                .buttonStyle(Chunky3DStyle(
                    fill: pagePlayer.lastCorrect ? Theme.correct : Theme.incorrect,
                    slab: pagePlayer.lastCorrect ? Theme.correctDark : Theme.incorrectDark))
        }
    }
}

// MARK: - Feedback banner

// Analytical debrief shown after a read or decision is submitted.
struct FeedbackBanner: View {
    @ObservedObject var player: LessonPlayer
    var onContinue: () -> Void
    @State private var showWhy = false

    private var correct: Bool { player.lastCorrect }
    private var tint: Color { correct ? Theme.correct : Theme.incorrect }
    private var tintDark: Color { correct ? Theme.correctDark : Theme.incorrectDark }
    private var isTradeDecision: Bool {
        ["trade_decision", "trade_scenario", "trade_manage", "entry_select", "invalidation_mark"].contains(player.screen.type)
    }
    private var feedbackTitle: String {
        guard isTradeDecision else { return correct ? "Read Confirmed" : "Review the Read" }
        if correct { return "Decision Confirmed" }
        let chosen = player.selectedIndex.flatMap { player.currentOptions[safe: $0] }
        return (chosen == "LONG" || chosen == "SHORT") && player.currentOptions[safe: player.currentCorrectIndex] == "WAIT"
            ? "Wait for Confirmation" : "Decision Needs Review"
    }

    private var explanationText: String? {
        let s = player.screen
        if let stage = player.activeTradeStage {
            if !correct, let idx = player.selectedIndex,
               let wrong = stage.wrongExplanations?[safe: idx] ?? nil { return wrong }
            return stage.explanation
        }
        // Prefer a targeted wrong-explanation for the chosen option, else the general one.
        if !correct, let idx = player.selectedIndex {
            if s.type == "ingredient_match", let opt = s.ingredientOptions?[safe: idx],
               let wrong = opt.wrongExplanation {
                return wrong
            }
            if let arr = s.wrongExplanations, idx < arr.count, let wrong = arr[idx] {
                return wrong
            }
        }
        return s.explanation
    }

    /// The right answer, spelled out for the "Oops!" state.
    private var correctAnswerText: String? {
        let s = player.screen
        switch s.type {
        case "true_false", "multiple_choice", "fill_blank", "ingredient_match", "live_chart",
             "aggressor", "book_drag", "book_compare", "replay_compare", "time_sales",
             "footprint", "orderflow_sim", "trade_decision", "trade_scenario",
             "trade_manage", "entry_select", "invalidation_mark":
            let opts = player.currentOptions
            let i = player.currentCorrectIndex
            return opts.indices.contains(i) ? opts[i] : nil
        case "fill_blank_multi":
            let parts = (s.blanks ?? []).compactMap { $0.options[safe: $0.correct] }
            return parts.isEmpty ? nil : parts.joined(separator: ", ")
        case "sequence_builder", "drag_order":
            return s.correctOrder?.joined(separator: " → ")
        case "evidence_select":
            let options = s.options ?? []
            let answers = (s.targets ?? []).compactMap { options[safe: $0] }
            return answers.isEmpty ? nil : answers.joined(separator: ", ")
        default:
            return nil
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: correct ? "checkmark" : "exclamationmark")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(tint)
                    .frame(width: 28, height: 28)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(tint.opacity(0.12))
                            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(tint.opacity(0.32), lineWidth: 1))
                    )
                Text(feedbackTitle)
                    .font(Theme.font(20, .bold)).foregroundColor(tint)
                // No XP callout when re-doing a missed question.
                if correct && !player.screen.isPreviousMistake {
                    Text("+10 XP")
                        .font(Theme.marketFont(13, .semibold))
                        .foregroundColor(tint.opacity(0.9))
                        .padding(.top, 3)
                }
                Spacer(minLength: 0)
            }

            if !correct, let ans = correctAnswerText {
                VStack(alignment: .leading, spacing: 4) {
                    Text("EXPECTED READ").font(Theme.font(10, .black)).tracking(0.8)
                    Text(ans).font(Theme.bodyFont(15))
                }
                .foregroundColor(Theme.muted)
                .fixedSize(horizontal: false, vertical: true)
            }

            if isTradeDecision {
                HStack(spacing: 8) {
                    Text("DECISION QUALITY: \(correct ? "STRONG" : "WEAK")")
                        .font(Theme.font(10, .black)).foregroundColor(tint)
                    if let outcome = player.screen.tradeOutcome {
                        Text("TRADE OUTCOME: \(outcome.uppercased())")
                            .font(Theme.font(10, .black)).foregroundColor(Theme.muted)
                    }
                }
            }

            if showWhy, let ex = explanationText {
                Text(RichText.attributed(ex,
                                         base: Theme.font(15, .semibold),
                                         bold: Theme.font(15, .black),
                                         color: Color(hex: "#cbd5e1")))
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }

            HStack(spacing: 12) {
                if explanationText != nil {
                    Button(showWhy ? "HIDE" : "DEBRIEF") {
                        Haptics.selection()
                        withAnimation(.easeInOut(duration: 0.2)) { showWhy.toggle() }
                    }
                    .buttonStyle(Chunky3DStyle(fill: Color(hex: "#4B5563"), slab: Color(hex: "#333B47"),
                                               depth: 4, radius: 14, font: Theme.font(16, .black)))
                    .frame(width: 108)
                }
                Button(correct ? (player.isLastScreen ? "FINISH" : "CONTINUE") : "CONTINUE") { onContinue() }
                    .buttonStyle(Chunky3DStyle(fill: tint, slab: tintDark, depth: 4, radius: 14,
                                               font: Theme.font(18, .black)))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity)
        // Background is drawn by the footer so it fills the bottom safe area.
        .onChange(of: player.index) { _ in
            showWhy = false
        }
        .onChange(of: player.scenarioStage) { _ in
            showWhy = false
        }
    }
}

// MARK: - Reward screen

// MARK: - Custom quit dialog (matches the old web exit-dialog, not an Apple alert)

struct ExitDialog: View {
    var onKeepGoing: () -> Void
    var onExit: () -> Void
    @State private var appear = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.45).ignoresSafeArea()
                .onTapGesture { onKeepGoing() }

            VStack(spacing: 0) {
                Image(systemName: "pause")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Theme.progress)
                    .frame(width: 42, height: 42)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Theme.progress.opacity(0.12)))
                    .padding(.bottom, 12)
                Text("Pause this session?")
                    .font(Theme.font(18, .bold)).foregroundColor(.white)
                    .padding(.bottom, 8)
                Text("Your progress so far will be saved and you can pick up where you left off.")
                    .font(Theme.font(14, .bold)).foregroundColor(Color(hex: "#94A3B8"))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 22)
                VStack(spacing: 10) {
                    Button("CONTINUE SESSION") { onKeepGoing() }
                        .buttonStyle(Chunky3DStyle(fill: Color(hex: "#2B70C9"), slab: Color(hex: "#1C4A85"),
                                                   depth: 4, radius: 14, font: Theme.font(15, .black)))
                    Button("SAVE & EXIT") { onExit() }
                        .buttonStyle(Chunky3DStyle(fill: Theme.surface, slab: Theme.surfaceSlab,
                                                   textColor: Color(hex: "#94A3B8"),
                                                   depth: 4, radius: 14, font: Theme.font(15, .black)))
                }
            }
            .padding(.horizontal, 24).padding(.top, 28).padding(.bottom, 20)
            .frame(maxWidth: 320)
            .background(
                RoundedRectangle(cornerRadius: Theme.Radius.large, style: .continuous)
                    .fill(Theme.surfaceRaised)
                    .overlay(RoundedRectangle(cornerRadius: Theme.Radius.large).strokeBorder(Theme.surfaceBorder, lineWidth: 1))
            )
            .shadow(color: .black.opacity(0.28), radius: 22, y: 12)
            .padding(.horizontal, 24)
            .scaleEffect(appear ? 1 : 0.97)
            .opacity(appear ? 1 : 0)
        }
        .onAppear { withAnimation(.easeOut(duration: 0.2)) { appear = true } }
    }
}

struct RewardView: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var onContinue: () -> Void
    @State private var stage = 0

    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }
    private var isAssessment: Bool { player.lesson.lessonType == "TEST_OUT" }
    private var passingScore: Int { player.lesson.assessmentOverallMinimum ?? Int(ceil(Double(player.lesson.screens.count) * 0.8)) }
    private var targetCompetencies: Set<String> { Set(player.lesson.assessmentTargetCompetencies ?? []) }
    private var targetCorrect: Int { player.correctCompetencies.filter { targetCompetencies.contains($0.key) }.values.reduce(0, +) }
    private var prerequisiteCorrect: Int { player.correctCompetencies.filter { !targetCompetencies.contains($0.key) }.values.reduce(0, +) }
    private var assessmentPassed: Bool {
        player.correctCount >= passingScore &&
        prerequisiteCorrect >= (player.lesson.assessmentPrerequisiteMinimum ?? 0) &&
        targetCorrect >= (player.lesson.assessmentTargetMinimum ?? 0)
    }
    private func competencyLabel(_ id: String) -> String {
        let name = id.split(separator: ".").last.map(String.init) ?? id
        return name.replacingOccurrences(of: "_", with: " ")
            .split(separator: " ")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: " ")
    }
    private var assessmentSummary: String {
        let isJump = player.lesson.assessmentPrerequisiteMinimum != nil
        if assessmentPassed {
            if isJump { return "Prerequisites \(prerequisiteCorrect) · Target unit \(targetCorrect) · \(player.correctCount)/\(player.answeredCount) overall" }
            return "\(player.correctCount)/\(player.answeredCount) correct · Test Out passed"
        }
        let weak = player.missedCompetencies.sorted { $0.value > $1.value }.prefix(3)
            .map { competencyLabel($0.key) }
        let lessons = player.missedSourceLessons.sorted { $0.value > $1.value }.prefix(3).map(\.key)
        let weakSummary = weak.isEmpty ? "A few skills need work" : "Needs review: " + weak.joined(separator: " · ")
        let review = lessons.isEmpty ? "Complete the highlighted review lessons" : "Recommended lessons: " + lessons.joined(separator: " · ")
        let score = isJump ? "Prerequisites \(prerequisiteCorrect) · Target unit \(targetCorrect) · \(player.correctCount)/\(player.answeredCount) overall" : "\(player.correctCount)/\(player.answeredCount) correct"
        return score + "\n" + weakSummary + "\n" + review + "\nComplete these lessons to unlock retry."
    }

    var body: some View {
        VStack(spacing: 22) {
            Spacer()
            MasteryArtifact(
                accent: assessmentPassed || !isAssessment ? player.unit.main : Theme.warning,
                symbol: isAssessment ? (assessmentPassed ? "scope" : "arrow.clockwise") : (player.isUnitTest ? "waveform.path.ecg" : "checkmark")
            )
            .scaleEffect(stage >= 1 ? 1 : 0.94)
            .opacity(stage >= 1 ? 1 : 0)

            Text(isAssessment ? (assessmentPassed ? "PLACEMENT CLEARED" : "CALIBRATION NEEDED") : (player.isUnitTest ? "UNIT SYNTHESIZED" : "MODULE MASTERED"))
                .font(Theme.font(25, .bold))
                .foregroundColor(ink)
                .opacity(stage >= 2 ? 1 : 0)
                .offset(y: stage >= 2 ? 0 : 12)

            Text(isAssessment ? assessmentSummary : (player.lesson.celebration ?? "\(player.lesson.title) mastered"))
                .font(Theme.font(15, .semibold))
                .foregroundColor(Theme.muted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .opacity(stage >= 2 ? 1 : 0)
                .offset(y: stage >= 2 ? 0 : 10)

            HStack(spacing: 12) {
                if !isAssessment || assessmentPassed { xpPill(text: isAssessment ? "+100 XP" : (player.isReplay ? "+25 XP" : "+100 XP")) }
                if treatsEarned > 0 { treatPill(value: treatsEarned) }
            }
            .opacity(stage >= 3 ? 1 : 0)
            .offset(y: stage >= 3 ? 0 : 14)
            Spacer()

            Button("CONTINUE") { onContinue() }
                .buttonStyle(Chunky3DStyle(fill: player.unit.main, slab: player.unit.dark))
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .opacity(stage >= 4 ? 1 : 0)
                .offset(y: stage >= 4 ? 0 : 18)
        }
        .onAppear {
            runRewardIntro()
        }
    }

    private func runRewardIntro() {
        stage = 0
        withAnimation(.easeOut(duration: 0.38)) { stage = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
            withAnimation(.easeOut(duration: 0.3)) { stage = 2 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            withAnimation(.easeOut(duration: 0.28)) { stage = 3 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) {
            withAnimation(.easeOut(duration: 0.26)) { stage = 4 }
        }
    }

    // Treats earned this completion: 1 per new lesson, +3 more when it finishes
    // the whole unit (any unit size); replays award none.
    private var treatsEarned: Int {
        if isAssessment { return 0 }
        guard !player.isReplay else { return 0 }
        return 1 + (player.unitBonusEligible ? 3 : 0)
    }

    private func xpPill(text: String) -> some View {
        Label(text, systemImage: "bolt.fill")
            .font(Theme.marketFont(14, .semibold))
            .foregroundColor(Theme.progress)
            .padding(.horizontal, 20).padding(.vertical, 11)
            .background(RoundedRectangle(cornerRadius: Theme.Radius.control).fill(Theme.surface)
                .overlay(RoundedRectangle(cornerRadius: Theme.Radius.control).strokeBorder(Theme.progress.opacity(0.35), lineWidth: 1)))
    }

    private func treatPill(value: Int) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "diamond.fill")
            Text("+\(value) CREDITS")
                .font(Theme.marketFont(13, .semibold))
        }
        .foregroundColor(Theme.warning)
        .padding(.horizontal, 20).padding(.vertical, 11)
        .background(RoundedRectangle(cornerRadius: Theme.Radius.control).fill(Theme.surface)
            .overlay(RoundedRectangle(cornerRadius: Theme.Radius.control).strokeBorder(Theme.warning.opacity(0.35), lineWidth: 1)))
    }
}

/// A restrained pseudo-3D mastery object built from market-grid geometry.
private struct MasteryArtifact: View {
    let accent: Color
    let symbol: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(accent.opacity(0.08))
                .frame(width: 132, height: 132)
                .rotationEffect(.degrees(45))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(accent.opacity(0.18), lineWidth: 1)
                        .rotationEffect(.degrees(45))
                )
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(colors: [Theme.surfaceHighlight, Theme.surface], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 104, height: 104)
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(accent.opacity(0.5), lineWidth: 1))
                .shadow(color: accent.opacity(0.2), radius: 16, y: 8)
            Image(systemName: symbol)
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(accent)
        }
        .frame(width: 170, height: 170)
        .rotation3DEffect(.degrees(8), axis: (x: 1, y: -0.4, z: 0))
    }
}

// MARK: - Small helpers

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// Haptics moved to Haptics.swift — same API, custom Core Haptics patterns.
