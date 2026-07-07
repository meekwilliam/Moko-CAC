import SwiftUI

// MARK: - Onboarding flow
// Six-screen Duolingo-style intake: welcome → experience level → goals (pick
// up to 2) → daily goal → journey roadmap → hold-to-commit. Finishing bursts
// the commit color across the screen and launches Lesson 1 directly (never the
// home screen). Answers are stored in UserDefaults under "onboarding.*".

struct OnboardingView: View {
    var onFinish: () -> Void
    var onSkip: () -> Void = {}

    @EnvironmentObject var theme: ThemeManager
    @State private var step = 0

    // Selections
    @State private var experience: Int? = nil
    @State private var goals: Set<Int> = []
    @State private var dailyGoal: Int? = nil

    private let totalSteps = 6

    private let experienceOptions: [(emoji: String, label: String)] = [
        ("🌱", "I'm completely new"),
        ("📈", "I've watched trading videos"),
        ("💻", "I've placed a few trades"),
        ("🧠", "I have trading experience"),
    ]
    private let goalOptions: [(emoji: String, label: String)] = [
        ("📊", "Learn to read charts"),
        ("💼", "Become a better trader"),
        ("🧠", "Understand price action"),
        ("🛡️", "Learn risk management"),
        ("🎯", "Build my own trading strategy"),
        ("📚", "Learn before risking real money"),
    ]
    private let dailyGoalOptions: [(emoji: String, label: String, detail: String)] = [
        ("🐢", "Casual", "5 min/day"),
        ("🚶", "Consistent", "10 min/day"),
        ("🏃", "Dedicated", "20 min/day"),
        ("🔥", "Intensive", "30 min/day"),
    ]
    private let journey: [(emoji: String, label: String)] = [
        ("📖", "Market Basics"),
        ("🕯️", "Candlesticks"),
        ("📈", "Trends & Structure"),
        ("📐", "Chart Patterns"),
        ("⚡", "Momentum"),
        ("🛡️", "Risk Management"),
        ("🧠", "Trading Psychology"),
        ("🏆", "Master Trader"),
    ]

    var body: some View {
        ZStack {
            ThemedBackground()

            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 18)
                    .padding(.top, 8)

                Group {
                    switch step {
                    case 0: welcomeScreen
                    case 1: experienceScreen
                    case 2: goalsScreen
                    case 3: dailyGoalScreen
                    case 4: journeyScreen
                    default: CommitScreen(onFinish: finish)
                    }
                }
                .id(step)
                .transition(.asymmetric(
                    insertion: .offset(x: 40).combined(with: .opacity),
                    removal: .opacity))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.9), value: step)
    }

    // MARK: Header — back + progress

    private var header: some View {
        HStack(spacing: 14) {
            Button(action: { Haptics.selection(); goBack() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 19, weight: .black))
                    .foregroundColor(Theme.muted)
                    .frame(width: 40, height: 40)
            }
            .opacity(step > 0 ? 1 : 0)
            .disabled(step == 0)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.14))
                    Capsule().fill(
                        LinearGradient(colors: [Color(hex: "#4CA9FF"), Color(hex: "#2B70C9")],
                                       startPoint: .top, endPoint: .bottom))
                        .frame(width: max(14, geo.size.width * CGFloat(step + 1) / CGFloat(totalSteps)))
                }
            }
            .frame(height: 14)
        }
    }

    private func goBack() {
        if step > 0 { step -= 1 }
    }

    private func advance() {
        Haptics.selection()
        step += 1
    }

    private func finish() {
        // Persist the intake answers for personalization/analytics.
        let d = UserDefaults.standard
        if let e = experience { d.set(experienceOptions[e].label, forKey: "onboarding.experience") }
        d.set(goals.sorted().map { goalOptions[$0].label }, forKey: "onboarding.goals")
        if let g = dailyGoal { d.set(dailyGoalOptions[g].label, forKey: "onboarding.dailyGoal") }
        d.set(true, forKey: "onboarding.completed")
        onFinish()
    }

    // MARK: Screen 1 — Welcome

    private var welcomeScreen: some View {
        VStack(spacing: 0) {
            Spacer()
            MascotIcon()
                .frame(width: 170, height: 170)
            Text("Learn Day Trading the Right Way.")
                .font(Theme.font(30, .black))
                .foregroundColor(theme.palette.ink)
                .multilineTextAlignment(.center)
                .padding(.top, 26)
            Text("Master chart reading, price action, and risk management through short interactive lessons.")
                .font(Theme.font(16, .bold))
                .foregroundColor(theme.palette.muted)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .padding(.top, 12)
            Spacer()
            Button("GET STARTED") { advance() }
                .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    // MARK: Screen 2 — Experience

    private var experienceScreen: some View {
        chooserScreen(
            title: "What best describes you?",
            subtitle: nil,
            canContinue: experience != nil
        ) {
            ForEach(experienceOptions.indices, id: \.self) { i in
                optionRow(emoji: experienceOptions[i].emoji,
                          label: experienceOptions[i].label,
                          selected: experience == i) {
                    experience = i
                }
            }
        }
    }

    // MARK: Screen 3 — Goals (up to 2)

    private var goalsScreen: some View {
        chooserScreen(
            title: "Why are you here?",
            subtitle: "Choose up to 2.",
            canContinue: !goals.isEmpty
        ) {
            ForEach(goalOptions.indices, id: \.self) { i in
                optionRow(emoji: goalOptions[i].emoji,
                          label: goalOptions[i].label,
                          selected: goals.contains(i)) {
                    if goals.contains(i) {
                        goals.remove(i)
                    } else if goals.count < 2 {
                        goals.insert(i)
                    } else {
                        Haptics.rigid()   // cap reached
                    }
                }
            }
        }
    }

    // MARK: Screen 4 — Daily goal

    private var dailyGoalScreen: some View {
        chooserScreen(
            title: "What's your daily goal?",
            subtitle: nil,
            canContinue: dailyGoal != nil
        ) {
            ForEach(dailyGoalOptions.indices, id: \.self) { i in
                optionRow(emoji: dailyGoalOptions[i].emoji,
                          label: dailyGoalOptions[i].label,
                          detail: dailyGoalOptions[i].detail,
                          selected: dailyGoal == i) {
                    dailyGoal = i
                }
            }
        }
    }

    // MARK: Screen 5 — Journey roadmap

    private var journeyScreen: some View {
        VStack(spacing: 0) {
            Text("Your journey")
                .font(Theme.font(26, .black))
                .foregroundColor(theme.palette.ink)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 18)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 6) {
                    ForEach(journey.indices, id: \.self) { i in
                        HStack(spacing: 12) {
                            Text(journey[i].emoji).font(.system(size: 22))
                            Text(journey[i].label)
                                .font(Theme.font(16, .black))
                                .foregroundColor(theme.palette.ink)
                            Spacer()
                        }
                        .padding(.vertical, 11).padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(hex: "#1E293B"))
                                .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .strokeBorder(Color(hex: "#334155"), lineWidth: 1.5))
                        )

                        if i < journey.count - 1 {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 13, weight: .black))
                                .foregroundColor(theme.palette.muted)
                                .padding(.vertical, 2)
                        }
                    }
                }
                .padding(.top, 14)
                .padding(.bottom, 10)
            }

            Button("CONTINUE") { advance() }
                .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    // MARK: Shared chooser scaffolding

    private func chooserScreen<Rows: View>(title: String, subtitle: String?,
                                           canContinue: Bool,
                                           @ViewBuilder rows: () -> Rows) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
                if let subtitle {
                    Text(subtitle)
                        .font(Theme.font(15, .bold))
                        .foregroundColor(theme.palette.muted)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 18)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) { rows() }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
            }

            Button("CONTINUE") { advance() }
                .buttonStyle(Chunky3DStyle(
                    fill: canContinue ? Theme.answer : Color(hex: "#4B5563"),
                    slab: canContinue ? Theme.answerDark : Color(hex: "#333B47")))
                .disabled(!canContinue)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    private func optionRow(emoji: String, label: String, detail: String? = nil,
                           selected: Bool, action: @escaping () -> Void) -> some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            HStack(spacing: 13) {
                Text(emoji).font(.system(size: 24))
                VStack(alignment: .leading, spacing: 1) {
                    Text(label)
                        .font(Theme.font(16, .black))
                        .foregroundColor(selected ? .white : theme.palette.ink)
                    if let detail {
                        Text(detail)
                            .font(Theme.font(13, .bold))
                            .foregroundColor(selected ? .white.opacity(0.85) : theme.palette.muted)
                    }
                }
                Spacer()
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical, 15).padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(selected ? Theme.answer : Color(hex: "#1E293B"))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(selected ? Theme.answerDark : Color(hex: "#334155"), lineWidth: 2))
            )
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(selected ? Theme.answerDark : Color(hex: "#334155"))
                    .offset(y: 4)
            )
        }
        .buttonStyle(SinkButtonStyle(depth: 4))
    }
}

// MARK: - Screen 6 — Hold-to-commit
// "Make yourself a promise": press and hold the button; it charges up with a
// pulse + progress ring, then the commit color bursts outward, covers the
// screen, and the flow finishes (straight into Lesson 1).

private struct CommitScreen: View {
    var onFinish: () -> Void

    @EnvironmentObject var theme: ThemeManager
    @State private var holding = false
    @State private var holdProgress: CGFloat = 0   // 0…1 while charging
    @State private var burst = false               // color expands to fill screen
    @State private var generation = 0              // cancels stale hold timers
    @State private var pulse = false

    private let holdDuration: Double = 1.5
    private let commit = Theme.correct
    private let commitDark = Theme.correctDark

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                Text("Make yourself a promise")
                    .font(Theme.font(28, .black))
                    .foregroundColor(theme.palette.ink)
                    .multilineTextAlignment(.center)
                Text("I will spend a few minutes a day learning to trade with discipline.")
                    .font(Theme.font(16, .bold))
                    .foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.top, 12)

                Spacer()

                holdButton

                Text("Press and hold")
                    .font(Theme.font(13, .black))
                    .textCase(.uppercase).tracking(1)
                    .foregroundColor(theme.palette.muted)
                    .padding(.top, 18)
                    .opacity(burst ? 0 : 1)

                Spacer()
            }
            .padding(.horizontal, 28)

            // The expanding commit-color wash. Scaled from the button's spot;
            // 30x the 120pt ring covers any phone screen.
            Circle()
                .fill(commit)
                .frame(width: 120, height: 120)
                .scaleEffect(burst ? 30 : 0.0001)
                .opacity(burst ? 1 : 0)
                .animation(.easeIn(duration: 0.55), value: burst)
                .allowsHitTesting(false)
        }
    }

    private var holdButton: some View {
        ZStack {
            // Soft breathing halo, stronger while charging (and while charging,
            // it also grows with hold progress so you still feel the charge-up
            // without a separate ring).
            Circle()
                .fill(commit.opacity(holding ? 0.28 : 0.14))
                .frame(width: 168, height: 168)
                .scaleEffect((pulse ? 1.08 : 0.92) + holdProgress * 0.12)

            // The button face itself.
            Text("I'M\nCOMMITTED")
                .font(Theme.font(16, .black))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: 120, height: 120)
                .background(Circle().fill(commit).overlay(Circle().strokeBorder(commitDark, lineWidth: 2)))
                .background(Circle().fill(commitDark).offset(y: 5))
                .offset(y: holding ? 4 : 0)
                .scaleEffect(1 + holdProgress * 0.10)
        }
        .contentShape(Circle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in if !holding && !burst { beginHold() } }
                .onEnded { _ in cancelHold() }
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }

    private func beginHold() {
        holding = true
        generation += 1
        let gen = generation
        Haptics.light()
        withAnimation(.linear(duration: holdDuration)) { holdProgress = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + holdDuration) {
            guard gen == generation, holding, !burst else { return }
            completeHold()
        }
    }

    private func cancelHold() {
        guard !burst else { return }
        holding = false
        generation += 1
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { holdProgress = 0 }
    }

    private func completeHold() {
        Haptics.success()
        burst = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            onFinish()
        }
    }
}
