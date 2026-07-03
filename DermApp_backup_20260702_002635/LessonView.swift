import SwiftUI
import Combine

// MARK: - Lesson player (state machine)

final class LessonPlayer: ObservableObject {
    let lesson: Lesson
    let unit: (main: Color, dark: Color)

    @Published var index = 0
    @Published var hearts = 3
    @Published var revealed = false      // an answer has been graded / step resolved
    @Published var lastCorrect = false
    @Published var finished = false      // reward screen

    // Single-choice selection (true_false / multiple_choice / fill_blank / spot_mistake / ingredient_match)
    @Published var selectedIndex: Int? = nil
    // fill_blank_multi
    @Published var multiSelections: [Int?] = []
    // sequence_builder / drag_order
    @Published var builtOrder: [String] = []

    var onFinished: (() -> Void)?

    init(lesson: Lesson) {
        self.lesson = lesson
        self.unit = Theme.unitColor(lesson.node)
    }

    var screen: LessonScreen { lesson.screens[index] }
    var isLastScreen: Bool { index >= lesson.screens.count - 1 }
    var progress: CGFloat { CGFloat(index + 1) / CGFloat(lesson.screens.count + 1) }

    var isIntro: Bool { screen.type == "intro" }
    var isMatching: Bool { screen.type == "matching" }
    var isOrdering: Bool { screen.type == "sequence_builder" || screen.type == "drag_order" }

    var currentOptions: [String] {
        if screen.type == "true_false" { return ["True", "False"] }
        if screen.type == "ingredient_match" { return (screen.ingredientOptions ?? []).map { $0.label } }
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
        case "fill_blank_multi":
            let n = screen.blanks?.count ?? 0
            return multiSelections.count == n && !multiSelections.contains(where: { $0 == nil })
        case "sequence_builder", "drag_order":
            return !builtOrder.isEmpty && builtOrder.count == (screen.items?.count ?? 0)
        default:
            return selectedIndex != nil
        }
    }

    func resetForScreen() {
        selectedIndex = nil
        revealed = false
        lastCorrect = false
        builtOrder = []
        if screen.type == "fill_blank_multi" {
            multiSelections = Array(repeating: nil, count: screen.blanks?.count ?? 0)
        } else {
            multiSelections = []
        }
    }

    func check() {
        guard !revealed else { return }
        var correct = true
        switch screen.type {
        case "fill_blank_multi":
            if let blanks = screen.blanks {
                for (i, b) in blanks.enumerated() {
                    let sel: Int? = multiSelections.indices.contains(i) ? multiSelections[i] : nil
                    if sel != b.correct { correct = false }
                }
            }
        case "sequence_builder", "drag_order":
            correct = (builtOrder == (screen.correctOrder ?? []))
        default:
            correct = (selectedIndex == currentCorrectIndex)
        }
        lastCorrect = correct
        revealed = true
        if !correct { hearts = max(0, hearts - 1) }
        Haptics.impact(correct ? .light : .rigid)
    }

    /// Called by matching once all pairs are solved.
    func markMatchingSolved() {
        guard !revealed else { return }
        lastCorrect = true
        revealed = true
        Haptics.selection()
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
    }
}

// MARK: - Container

struct LessonView: View {
    @StateObject private var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var onClose: () -> Void
    var onComplete: (Int) -> Void   // node number

    init(lesson: Lesson, onClose: @escaping () -> Void, onComplete: @escaping (Int) -> Void) {
        _player = StateObject(wrappedValue: LessonPlayer(lesson: lesson))
        self.onClose = onClose
        self.onComplete = onComplete
    }

    private var bg: Color { scheme == .dark ? Color(hex: "#0F172A") : Color(hex: "#F6F9FE") }
    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }

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
                    ScrollView {
                        LessonScreenRouter(player: player, ink: ink)
                            .id(player.index)   // fresh per-screen @State each step
                            .padding(.horizontal, 20)
                            .padding(.top, 18)
                            .padding(.bottom, 24)
                    }
                    footer
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: player.finished)
    }

    // MARK: Header — close, progress bar, hearts

    private var header: some View {
        HStack(spacing: 14) {
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Theme.muted)
                    .frame(width: 34, height: 34)
                    .background(Circle().fill(scheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06)))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(scheme == .dark ? Color.white.opacity(0.12) : Color.black.opacity(0.10))
                    Capsule().fill(player.unit.main)
                        .frame(width: max(12, geo.size.width * player.progress))
                        .overlay(
                            Capsule().fill(Color.white.opacity(0.35))
                                .frame(height: 3).padding(.horizontal, 4).padding(.top, 3),
                            alignment: .top
                        )
                }
            }
            .frame(height: 16)

            HStack(spacing: 3) {
                ForEach(0..<3, id: \.self) { i in
                    Image(systemName: i < player.hearts ? "heart.fill" : "heart")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(i < player.hearts ? Color(hex: "#FF4D6D") : Theme.muted.opacity(0.4))
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }

    // MARK: Footer — feedback banner + primary button

    private var footer: some View {
        VStack(spacing: 0) {
            if player.revealed && !player.isIntro && !player.isMatching {
                FeedbackBanner(player: player)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            primaryButton
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 8)
        }
        .background(
            (scheme == .dark ? Color(hex: "#0F172A") : Color.white)
                .opacity(player.revealed && !player.isIntro && !player.isMatching ? 1 : 0)
                .ignoresSafeArea(edges: .bottom)
        )
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: player.revealed)
    }

    @ViewBuilder
    private var primaryButton: some View {
        if player.isMatching && !player.revealed {
            EmptyView()  // matching advances itself; no button until solved
        } else if player.isIntro {
            Button("Got It") { withAnimation { player.advance() } }
                .buttonStyle(Chunky3DStyle(fill: player.unit.main, slab: player.unit.dark))
        } else if !player.revealed {
            Button("Check") { withAnimation { player.check() } }
                .buttonStyle(Chunky3DStyle(
                    fill: player.canCheck ? player.unit.main : Color.gray.opacity(0.4),
                    slab: player.canCheck ? player.unit.dark : Color.gray.opacity(0.55)))
                .disabled(!player.canCheck)
        } else {
            Button(player.isLastScreen ? "Finish" : "Continue") { withAnimation { player.advance() } }
                .buttonStyle(Chunky3DStyle(
                    fill: player.lastCorrect || player.isMatching ? Theme.correct : Theme.incorrect,
                    slab: player.lastCorrect || player.isMatching ? Theme.correctDark : Theme.incorrectDark))
        }
    }
}

// MARK: - Feedback banner

struct FeedbackBanner: View {
    @ObservedObject var player: LessonPlayer

    private var correct: Bool { player.lastCorrect }
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

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(correct ? Theme.correctDark : Theme.incorrectDark)
            VStack(alignment: .leading, spacing: 4) {
                Text(correct ? "Nice!" : "Not quite")
                    .font(Theme.font(17, .black))
                    .foregroundColor(correct ? Theme.correctDark : Theme.incorrectDark)
                if let ex = explanationText {
                    Text(RichText.attributed(ex,
                                             base: Theme.font(14, .semibold),
                                             bold: Theme.font(14, .black),
                                             color: (correct ? Theme.correctDark : Theme.incorrectDark).opacity(0.92)))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill((correct ? Theme.correct : Theme.incorrect).opacity(0.14))
        )
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }
}

// MARK: - Reward screen

struct RewardView: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var onContinue: () -> Void
    @State private var pop = false

    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }

    var body: some View {
        VStack(spacing: 22) {
            Spacer()
            ZStack {
                Circle().fill(player.unit.main.opacity(0.15)).frame(width: 150, height: 150)
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 92, weight: .bold))
                    .foregroundColor(player.unit.main)
            }
            .scaleEffect(pop ? 1 : 0.4)
            .opacity(pop ? 1 : 0)

            Text("Lesson Complete!")
                .font(Theme.font(28, .black))
                .foregroundColor(ink)

            Text(player.lesson.celebration ?? "\(player.lesson.title) mastered")
                .font(Theme.font(15, .semibold))
                .foregroundColor(Theme.muted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            HStack(spacing: 12) {
                rewardPill(text: "+100 XP", fill: Color(hex: "#38bdf8"), slab: Color(hex: "#0369a1"))
            }
            Spacer()

            Button("Continue") { onContinue() }
                .buttonStyle(Chunky3DStyle(fill: player.unit.main, slab: player.unit.dark))
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.55)) { pop = true }
        }
    }

    private func rewardPill(text: String, fill: Color, slab: Color) -> some View {
        Text(text)
            .font(Theme.font(15, .black))
            .foregroundColor(.white)
            .padding(.horizontal, 20).padding(.vertical, 11)
            .background(
                Capsule().fill(fill)
                    .background(Capsule().fill(slab).offset(y: 4))
            )
    }
}

// MARK: - Small helpers

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

enum Haptics {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    static func selection() { UISelectionFeedbackGenerator().selectionChanged() }
}
