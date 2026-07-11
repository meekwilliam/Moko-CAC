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
        if self.index > 0 { resetForScreen() }
    }

    var screen: LessonScreen { screens[min(index, max(0, screens.count - 1))] }
    var isLastScreen: Bool { index >= screens.count - 1 }
    var progress: CGFloat { CGFloat(index + 1) / CGFloat(screens.count + 1) }

    var isIntro: Bool { screen.type == "intro" }
    var isMatching: Bool { screen.type == "matching" }
    var isOrdering: Bool { screen.type == "sequence_builder" || screen.type == "drag_order" }

    var currentOptions: [String] {
        if screen.type == "true_false" { return ["True", "False"] }
        if screen.type == "ingredient_match" { return (screen.ingredientOptions ?? []).map { $0.label } }
        if screen.type == "aggressor" { return ["The buyer", "The seller"] }
        if screen.type == "book_drag" { return ["the bid", "the ask"] }
        return screen.options ?? []
    }
    var currentCorrectIndex: Int {
        if screen.type == "true_false" { return (screen.correctBool ?? false) ? 0 : 1 }
        if screen.type == "ingredient_match" {
            return screen.ingredientOptions?.firstIndex(where: { $0.correct == true }) ?? 0
        }
        return screen.correctIndex ?? 0
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
        matchingSelections = [:]
        revealed = false
        lastCorrect = false
        builtOrder = []
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
        case "tap_candles":
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
        revealed = true
        if !correct {
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
        if isLastScreen {
            finished = true
            Haptics.impact(.medium)
            return
        }
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
    let hearts: Int
    let isUnlimitedHearts: Bool
    var onClose: () -> Void
    var onComplete: (Int) -> Void   // node number

    init(lesson: Lesson, startIndex: Int = 0, isReplay: Bool = false,
         unitColor: (main: Color, dark: Color)? = nil,
         unitBonusEligible: Bool = false,
         isTestLesson: Bool = false,
         isUnitTest: Bool = false,
         hearts: Int = ProgressStore.maxHearts,
         isUnlimitedHearts: Bool = false,
         onClose: @escaping () -> Void,
         onComplete: @escaping (Int) -> Void,
         onSaveProgress: @escaping (Int) -> Void = { _ in },
         onSpendHeart: @escaping () -> Bool = { true }) {
        let p = LessonPlayer(lesson: lesson, startIndex: startIndex, isReplay: isReplay,
                             unitColor: unitColor, unitBonusEligible: unitBonusEligible,
                             isTestLesson: isTestLesson, isUnitTest: isUnitTest)
        p.onAdvance = onSaveProgress
        p.onSpendHeart = onSpendHeart
        _player = StateObject(wrappedValue: p)
        self.hearts = hearts
        self.isUnlimitedHearts = isUnlimitedHearts
        self.onClose = onClose
        self.onComplete = onComplete
    }

    private var bg: Color { theme.palette.base }   // same source as the path background
    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }

    // Answer-interaction accent: a fixed blue for the progress bar, Check /
    // Got It buttons and selected options — consistent regardless of the unit's
    // own (now per-unit) button color on the path.
    private let accent = Theme.answer
    private let accentDark = Theme.answerDark

    var body: some View {
        ZStack {
            bg.ignoresSafeArea()

            if player.finished {
                RewardView(player: player) {
                    onComplete(player.lesson.node)
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
        .animation(.easeInOut(duration: 0.25), value: player.finished)
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
            .clipped()
        }
    }

    private func questionPage(_ pagePlayer: LessonPlayer) -> some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if pagePlayer.isUnitTest { unitTestBadge }
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
        .background(theme.palette.base)
    }

    private func advanceQuestion() {
        guard outgoingPlayer == nil else { return }

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
        .foregroundColor(Color(hex: "#f87171"))
    }

    /// Marks the unit's final lesson as a review test over everything it taught.
    private var unitTestBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "crown.fill")
                .font(.system(size: 11, weight: .black))
            Text("Unit review")
                .font(Theme.font(12, .black)).textCase(.uppercase).tracking(0.6)
        }
        .foregroundColor(Color(hex: "#7a4f00"))
        .padding(.horizontal, 10).padding(.vertical, 6)
        .background(Capsule().fill(Color(hex: "#FFC800")))
    }

    // MARK: Header — close, progress bar, hearts

    private var header: some View {
        HStack(spacing: 14) {
            Button(action: { Haptics.selection(); withAnimation(.easeOut(duration: 0.18)) { showExitConfirm = true } }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(scheme == .dark ? Color(white: 0.78) : Theme.muted)
            }
            .buttonStyle(Circle3DStyle(
                face: scheme == .dark ? Color(white: 0.20) : Color(white: 0.93),
                slab: scheme == .dark ? Color.black.opacity(0.6) : Color.black.opacity(0.20),
                size: 42, depth: 4))

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Brighter, more visible track.
                    Capsule().fill(scheme == .dark ? Color.white.opacity(0.20) : Color.black.opacity(0.12))
                    // Vibrant, glossy blue fill: a top-lit gradient plus a bright
                    // highlight strip along the top edge.
                    Capsule().fill(
                        LinearGradient(colors: [Color(hex: "#4CA9FF"), Color(hex: "#2B70C9")],
                                       startPoint: .top, endPoint: .bottom))
                        .frame(width: max(16, geo.size.width * player.progress))
                        .overlay(
                            Capsule().fill(Color.white.opacity(0.5))
                                .frame(height: 4).padding(.horizontal, 6).padding(.top, 4),
                            alignment: .top
                        )
                }
            }
            .frame(height: 20)
            .animation(.spring(response: 0.36, dampingFraction: 0.82), value: player.progress)

            lessonHeartBadge
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    private var lessonHeartBadge: some View {
        HStack(spacing: 5) {
            HeartBadge(filled: isUnlimitedHearts || hearts > 0, size: 20)
            if isUnlimitedHearts {
                Image(systemName: "infinity")
                    .font(.system(size: 14, weight: .black))
                    .foregroundColor(ink)
            } else {
                Text("\(hearts)")
                    .font(Theme.font(16, .black))
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
            if pagePlayer.isTestLesson {
                Button("Skip →") { advanceQuestion() }
                    .font(Theme.font(13, .black))
                    .foregroundColor(Theme.muted)
                    .padding(.top, 6)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 20)
            }
            if pagePlayer.revealed && !pagePlayer.isIntro {
                // The feedback card carries its own WHY? / Got It / Continue
                // buttons, so it replaces the primary button entirely.
                FeedbackBanner(player: pagePlayer) { advanceQuestion() }
                    .transition(.move(edge: .bottom)
                        .combined(with: .opacity)
                        .combined(with: .scale(scale: 0.9, anchor: .bottom)))
            } else {
                primaryButton(for: pagePlayer)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 8)
            }
        }
        .background(
            theme.palette.base
                .opacity(pagePlayer.revealed && !pagePlayer.isIntro ? 1 : 0)
                .ignoresSafeArea(edges: .bottom)
        )
        // Bouncy overshoot pop, like the web's speechPop.
        .animation(.spring(response: 0.36, dampingFraction: 0.6), value: pagePlayer.revealed)
    }

    @ViewBuilder
    private func primaryButton(for pagePlayer: LessonPlayer) -> some View {
        if pagePlayer.isIntro {
            Button("Got It") { advanceQuestion() }
                .buttonStyle(Chunky3DStyle(fill: accent, slab: accentDark))
        } else if !pagePlayer.revealed {
            // Solid (not translucent) grays when disabled — a translucent fill
            // let the dark background bleed through unevenly at the seam
            // between the top face and the slab, showing as a stray line.
            Button("Check") { withAnimation { pagePlayer.check() } }
                .buttonStyle(Chunky3DStyle(
                    fill: pagePlayer.canCheck ? accent : Color(hex: "#4B5563"),
                    slab: pagePlayer.canCheck ? accentDark : Color(hex: "#333B47")))
                .disabled(!pagePlayer.canCheck)
                .scaleEffect(checkReadyPulse ? 1.025 : 1)
                .animation(.spring(response: 0.22, dampingFraction: 0.52), value: checkReadyPulse)
        } else {
            Button(pagePlayer.isLastScreen ? "Finish" : "Continue") { advanceQuestion() }
                .buttonStyle(Chunky3DStyle(
                    fill: pagePlayer.lastCorrect ? Theme.correct : Theme.incorrect,
                    slab: pagePlayer.lastCorrect ? Theme.correctDark : Theme.incorrectDark))
        }
    }
}

// MARK: - Feedback banner

// Reveal card, styled after the reference: "✨ Correct +10XP" / "💔 Oops!" with
// the right answer called out, a WHY? toggle for the explanation, and the
// Got It / Continue button living inside the card.
struct FeedbackBanner: View {
    @ObservedObject var player: LessonPlayer
    var onContinue: () -> Void
    @State private var showWhy = false

    private var correct: Bool { player.lastCorrect }
    private var tint: Color { correct ? Theme.correct : Theme.incorrect }
    private var tintDark: Color { correct ? Theme.correctDark : Theme.incorrectDark }

    // Vector icons (rendered by SVGIconView) instead of emoji, so they stay
    // crisp and match the banner tints exactly.
    private static let sparklesSVG = SVGParser.parse("""
        <svg viewBox="0 0 24 24" fill="#22c55e">
          <path d="M9 2 L10.9 7.1 L16 9 L10.9 10.9 L9 16 L7.1 10.9 L2 9 L7.1 7.1 Z"/>
          <path d="M18 11.5 L19.1 14.4 L22 15.5 L19.1 16.6 L18 19.5 L16.9 16.6 L14 15.5 L16.9 14.4 Z"/>
          <path d="M17.5 2.5 L18.2 4.3 L20 5 L18.2 5.7 L17.5 7.5 L16.8 5.7 L15 5 L16.8 4.3 Z"/>
        </svg>
        """)
    private static let brokenHeartSVG = SVGParser.parse("""
        <svg viewBox="0 0 24 24" fill="#f43f5e">
          <path d="M12 21 C12 21 3.5 14.6 3.5 8.8 C3.5 5.5 6 3.2 8.8 3.2 C10.1 3.2 11.3 3.8 12 4.8 C12.7 3.8 13.9 3.2 15.2 3.2 C18 3.2 20.5 5.5 20.5 8.8 C20.5 14.6 12 21 12 21 Z"/>
          <path d="M12 4.8 L10.3 8.2 L13.2 10.8 L10.8 14.2 L12 21" fill="none" stroke="#1A2433" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        """)

    private var explanationText: String? {
        let s = player.screen
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
             "aggressor", "book_drag":
            let opts = player.currentOptions
            let i = player.currentCorrectIndex
            return opts.indices.contains(i) ? opts[i] : nil
        case "fill_blank_multi":
            let parts = (s.blanks ?? []).compactMap { $0.options[safe: $0.correct] }
            return parts.isEmpty ? nil : parts.joined(separator: ", ")
        case "sequence_builder", "drag_order":
            return s.correctOrder?.joined(separator: " → ")
        default:
            return nil
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                SVGIconView(svg: correct ? Self.sparklesSVG : Self.brokenHeartSVG)
                    .frame(width: 26, height: 26)
                Text(correct ? "Correct" : "Oops!")
                    .font(Theme.font(24, .black)).foregroundColor(tint)
                // No XP callout when re-doing a missed question.
                if correct && !player.screen.isPreviousMistake {
                    Text("+10 XP")
                        .font(Theme.font(19, .black))
                        .foregroundColor(tint.opacity(0.9))
                        .padding(.top, 3)
                }
                Spacer(minLength: 0)
            }

            if !correct, let ans = correctAnswerText {
                (Text("Correct answer:  ").font(Theme.font(17, .black))
                    + Text(ans).font(Theme.font(17, .bold)))
                    .foregroundColor(tint.opacity(0.95))
                    .fixedSize(horizontal: false, vertical: true)
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
                    Button("WHY ?") {
                        Haptics.selection()
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.8)) { showWhy.toggle() }
                    }
                    .buttonStyle(Chunky3DStyle(fill: Color(hex: "#4B5563"), slab: Color(hex: "#333B47"),
                                               depth: 4, radius: 14, font: Theme.font(16, .black)))
                    .frame(width: 108)
                }
                Button(correct ? (player.isLastScreen ? "Finish" : "Continue") : "Got It") { onContinue() }
                    .buttonStyle(Chunky3DStyle(fill: tint, slab: tintDark, depth: 4, radius: 14,
                                               font: Theme.font(18, .black)))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 14)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 26, bottomLeadingRadius: 0,
                                   bottomTrailingRadius: 0, topTrailingRadius: 26,
                                   style: .continuous)
                .fill(Color(hex: "#1A2433"))
                .ignoresSafeArea(edges: .bottom)
        )
        .onChange(of: player.index) { _ in
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
                Image(systemName: "info.circle")
                    .font(.system(size: 38, weight: .regular))
                    .foregroundColor(Color(hex: "#2B70C9"))
                    .padding(.bottom, 12)
                Text("Quit this lesson?")
                    .font(Theme.font(18, .black)).foregroundColor(.white)
                    .padding(.bottom, 8)
                Text("Your progress so far will be saved and you can pick up where you left off.")
                    .font(Theme.font(14, .bold)).foregroundColor(Color(hex: "#94A3B8"))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 22)
                VStack(spacing: 10) {
                    Button("Keep Going") { onKeepGoing() }
                        .buttonStyle(Chunky3DStyle(fill: Color(hex: "#2B70C9"), slab: Color(hex: "#1C4A85"),
                                                   depth: 4, radius: 14, font: Theme.font(15, .black)))
                    Button("Exit") { onExit() }
                        .buttonStyle(Chunky3DStyle(fill: Theme.surface, slab: Theme.surfaceSlab,
                                                   textColor: Color(hex: "#94A3B8"),
                                                   depth: 4, radius: 14, font: Theme.font(15, .black)))
                }
            }
            .padding(.horizontal, 24).padding(.top, 28).padding(.bottom, 20)
            .frame(maxWidth: 320)
            .background(RoundedRectangle(cornerRadius: 24, style: .continuous).fill(Theme.surfaceRaised))
            .shadow(color: .black.opacity(0.4), radius: 30, y: 16)
            .padding(.horizontal, 24)
            .scaleEffect(appear ? 1 : 0.88)
            .opacity(appear ? 1 : 0)
        }
        .onAppear { withAnimation(.spring(response: 0.3, dampingFraction: 0.82)) { appear = true } }
    }
}

struct RewardView: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var onContinue: () -> Void
    @State private var stage = 0

    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }

    var body: some View {
        VStack(spacing: 22) {
            Spacer()
            ZStack {
                Circle().fill(player.unit.main.opacity(0.15)).frame(width: 150, height: 150)
                    .scaleEffect(stage >= 1 ? 1.08 : 0.65)
                    .opacity(stage >= 1 ? 1 : 0)
                Image(systemName: player.isUnitTest ? "crown.fill" : "checkmark.seal.fill")
                    .font(.system(size: 92, weight: .bold))
                    .foregroundColor(player.unit.main)
                    .rotationEffect(.degrees(stage >= 1 ? 0 : -14))
                    .scaleEffect(stage >= 1 ? 1 : 0.35)
            }
            .opacity(stage >= 1 ? 1 : 0)

            Text(player.isUnitTest ? "Unit Complete!" : "Lesson Complete!")
                .font(Theme.font(28, .black))
                .foregroundColor(ink)
                .opacity(stage >= 2 ? 1 : 0)
                .offset(y: stage >= 2 ? 0 : 12)

            Text(player.lesson.celebration ?? "\(player.lesson.title) mastered")
                .font(Theme.font(15, .semibold))
                .foregroundColor(Theme.muted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .opacity(stage >= 2 ? 1 : 0)
                .offset(y: stage >= 2 ? 0 : 10)

            HStack(spacing: 12) {
                xpPill(text: player.isReplay ? "+25 XP" : "+100 XP")
                if treatsEarned > 0 { treatPill(value: treatsEarned) }
            }
            .opacity(stage >= 3 ? 1 : 0)
            .offset(y: stage >= 3 ? 0 : 14)
            Spacer()

            Button("Continue") { onContinue() }
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
        withAnimation(.spring(response: 0.48, dampingFraction: 0.58)) { stage = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
            withAnimation(.spring(response: 0.38, dampingFraction: 0.86)) { stage = 2 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            withAnimation(.spring(response: 0.34, dampingFraction: 0.78)) { stage = 3 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) {
            withAnimation(.spring(response: 0.34, dampingFraction: 0.84)) { stage = 4 }
        }
    }

    // Treats earned this completion: 1 per new lesson, +3 more when it finishes
    // the whole unit (any unit size); replays award none.
    private var treatsEarned: Int {
        guard !player.isReplay else { return 0 }
        return 1 + (player.unitBonusEligible ? 3 : 0)
    }

    private func xpPill(text: String) -> some View {
        Text(text)
            .font(Theme.font(15, .black))
            .foregroundColor(.white)
            .padding(.horizontal, 20).padding(.vertical, 11)
            .background(
                Capsule().fill(Color(hex: "#38bdf8"))
                    .background(Capsule().fill(Color(hex: "#0369a1")).offset(y: 4))
            )
    }

    private func treatPill(value: Int) -> some View {
        HStack(spacing: 8) {
            Text("+\(value)")
                .font(Theme.font(15, .black))
                .foregroundColor(.white)
            TreatIcon(height: 14)
        }
        .padding(.horizontal, 20).padding(.vertical, 11)
        .background(
            Capsule().fill(Color(hex: "#9A5411"))
                .background(Capsule().fill(Color(hex: "#5B3B2E")).offset(y: 4))
        )
    }
}

// MARK: - Small helpers

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// Haptics moved to Haptics.swift — same API, custom Core Haptics patterns.
