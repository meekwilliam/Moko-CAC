import SwiftUI
import Combine
import UserNotifications

// MARK: - Onboarding flow
// Seven-screen Duolingo-style intake: welcome (live-chart hero) → course →
// goals (choose any) → daily goal → notifications → course build → commit.
// No account: progress is saved on this device. Finishing bursts
// the commit color across the screen and launches Lesson 1 directly (never the
// home screen). Answers are stored in UserDefaults under "onboarding.*".

struct OnboardingView: View {
    @ObservedObject var router: AppRouter

    @EnvironmentObject var theme: ThemeManager
    @State private var step = 0
    @State private var stepDirection: CGFloat = 1
    @State private var hasPresentedInitialStep = false

    // Selections
    @State private var strategy: Int? = nil
    @State private var goals: Set<Int> = []
    @State private var dailyGoal: Int? = nil

    private let totalSteps = 7
    private var stepSlideDistance: CGFloat { UIScreen.main.bounds.width + 64 }
    private var showsChoiceFooter: Bool { (1...3).contains(step) }
    private var currentStepCanContinue: Bool {
        switch step {
        case 1: return strategy != nil
        case 2: return !goals.isEmpty
        case 3: return dailyGoal != nil
        default: return true
        }
    }

    // Money Basics is where everyone starts; Order Flow lives in the course menu.
    private let strategyOptions: [(label: String, detail: String)] = [
        ("Money Basics", "Budgeting, saving, credit, investing & avoiding hype"),
    ]

    private let goalOptions: [String] = [
        "Stop overspending",
        "Save for something big",
        "Understand credit before I get a card",
        "Start investing the smart way",
        "Spot scams and hype",
        "Learn before risking real money",
    ]
    private let dailyGoalOptions: [(label: String, detail: String)] = [
        ("Casual", "1 lesson a day · about 3 min"),
        ("Regular", "2 lessons a day · about 6 min"),
        ("Serious", "3 lessons a day · about 10 min"),
        ("Intense", "5 lessons a day · about 15 min"),
    ]

    var body: some View {
        ZStack {
            ThemedBackground()

            VStack(spacing: 0) {
                if step > 0 {
                    header
                        .padding(.horizontal, 18)
                        .padding(.top, 0)
                }

                ZStack(alignment: .topLeading) {
                    Group {
                        switch step {
                        case 0: welcomeScreen
                        case 1: strategyScreen
                        case 2: goalsScreen
                        case 3: dailyGoalScreen
                        case 4: notificationsScreen
                        case 5: CourseBuildView(onComplete: advance)
                        default: CommitScreen(router: router, onCommitted: persistAnswers)
                        }
                    }
                    .id(step)
                    .transition(stepTransition)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

                if showsChoiceFooter {
                    choiceFooter
                }
            }
        }
        .onAppear { hasPresentedInitialStep = true }
    }

    private var choiceFooter: some View {
        Button("CONTINUE") { advance() }
            .buttonStyle(Chunky3DStyle(
                fill: currentStepCanContinue ? Theme.answer : Color(hex: "#4B5563"),
                slab: currentStepCanContinue ? Theme.answerDark : Color(hex: "#333B47")))
            .disabled(!currentStepCanContinue)
            .padding(.horizontal, 24)
            .padding(.bottom, 26)
            .transition(.opacity)
    }

    // MARK: Header — back above full-width progress
    // Hidden on the welcome screen (full-bleed hero, like the reference).

    private var header: some View {
        VStack(spacing: 2) {
            HStack {
                Button(action: { Haptics.selection(); goBack() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 19, weight: .black))
                        .foregroundColor(Theme.muted)
                        .frame(width: 32, height: 32)
                }
                .opacity(step > 0 ? 1 : 0)
                .disabled(step == 0)

                Spacer()
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.20))
                    Capsule().fill(
                        LinearGradient(colors: [Color(hex: "#4CA9FF"), Color(hex: "#2B70C9")],
                                       startPoint: .top, endPoint: .bottom))
                        .frame(width: max(14, geo.size.width * CGFloat(step + 1) / CGFloat(totalSteps)))
                        .overlay(
                            Capsule().fill(Color.white.opacity(0.5))
                                .frame(height: 4)
                                .padding(.horizontal, 6)
                                .padding(.top, 4),
                            alignment: .top
                        )
                }
            }
            .frame(height: 20)
        }
    }

    private var stepTransition: AnyTransition {
        // The welcome screen is a stable reset point. Animating it back in
        // after step one leaves two full-screen scenes in the transition tree,
        // so a following Get Started tap can inherit the stale direction.
        guard hasPresentedInitialStep, step > 0 else { return .identity }
        return .asymmetric(
            insertion: .offset(x: stepDirection * stepSlideDistance),
            removal: .offset(x: -stepDirection * stepSlideDistance)
        )
    }

    private func goBack() {
        guard step > 0 else { return }
        setStepDirection(-1)
        withAnimation(.easeOut(duration: 0.24)) { step -= 1 }
    }

    private func advance() {
        Haptics.selection()
        setStepDirection(1)
        withAnimation(.easeOut(duration: 0.24)) { step += 1 }
    }

    private func setStepDirection(_ direction: CGFloat) {
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            stepDirection = direction
        }
    }

    private func persistAnswers() {
        // Persist the intake answers for personalization/analytics. The actual
        // screen swap to the lesson is driven by CommitScreen, timed with the
        // curtain animation (see AppRouter.curtainColor).
        let d = UserDefaults.standard
        if let s = strategy { d.set(strategyOptions[s].label, forKey: "onboarding.strategy") }
        d.set(goals.sorted().map { goalOptions[$0] }, forKey: "onboarding.goals")
        if let g = dailyGoal { d.set(dailyGoalOptions[g].label, forKey: "onboarding.dailyGoal") }
        d.set(true, forKey: "onboarding.completed")
    }

    // MARK: Screen 1 — Welcome
    // Finelo-style landing, Moko'd: a live candlestick chart fills the hero (in
    // place of orbiting company logos), then a headline and GET STARTED, which
    // goes into the intake.

    private var welcomeScreen: some View {
        VStack(spacing: 0) {
            LiveChart(direction: .up, committedCount: 15, ticksPerCandle: 14,
                      paused: step != 0, showsAxes: false)   // hero: a steady climb (long-term growth); freeze while sliding away
                .opacity(0.85)
                .mask(
                    // Fade the grid-and-candles hero out at both ends so it
                    // melts into the page instead of ending on a hard edge.
                    LinearGradient(stops: [
                        .init(color: .black.opacity(0), location: 0.0),
                        .init(color: .black, location: 0.14),
                        .init(color: .black, location: 0.72),
                        .init(color: .black.opacity(0.15), location: 1.0),
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(maxHeight: .infinity)

            VStack(spacing: 14) {
                Text("Master your money")
                    .font(Theme.font(34, .black))
                    .foregroundColor(theme.palette.ink)
                    .multilineTextAlignment(.center)
                Text("Budgeting, saving, credit, investing, and spotting hype, in short game-like lessons.")
                    .font(Theme.bodyFont(16))
                    .foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(16 * 0.32)

                Button("GET STARTED") { advance() }
                    .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
                    .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 26)
        }
    }

    // MARK: Screen 2 — Strategy
    // Which course to start with. Money Basics is the starting course; the list
    // is built to grow as more courses ship.

    private var strategyScreen: some View {
        chooserScreen(
            title: "What do you want to learn first?",
            subtitle: "More courses in the course menu."
        ) {
            ForEach(strategyOptions.indices, id: \.self) { i in
                optionRow(label: strategyOptions[i].label,
                          detail: strategyOptions[i].detail,
                          selected: strategy == i) {
                    strategy = i
                }
            }
        }
    }

    // MARK: Screen 3 — Goals (choose any)

    private var goalsScreen: some View {
        chooserScreen(
            title: "Why are you here?",
            subtitle: "Choose all that apply."
        ) {
            ForEach(goalOptions.indices, id: \.self) { i in
                optionRow(label: goalOptions[i],
                          selected: goals.contains(i)) {
                    if goals.contains(i) { goals.remove(i) } else { goals.insert(i) }
                }
            }
        }
    }

    // MARK: Screen 4 — Daily goal

    private var dailyGoalScreen: some View {
        chooserScreen(
            title: "What's your daily goal?",
            subtitle: nil
        ) {
            ForEach(dailyGoalOptions.indices, id: \.self) { i in
                optionRow(label: dailyGoalOptions[i].label,
                          detail: dailyGoalOptions[i].detail,
                          selected: dailyGoal == i) {
                    dailyGoal = i
                }
            }
        }
    }

    // MARK: Screen 5 — Notifications
    // Ask to enable reminders so learners come back and keep their streak.

    private var notificationsScreen: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(systemName: "bell.badge.fill")
                .font(.system(size: 60, weight: .black))
                .foregroundColor(Theme.answer)

            VStack(alignment: .center, spacing: 8) {
                Text("Turn on reminders")
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
                Text("A daily nudge keeps your streak alive and your practice on track.")
                    .font(Theme.bodyFont(15))
                    .foregroundColor(theme.palette.muted)
                    .lineSpacing(15 * 0.32)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.top, 24)

            Spacer()

            VStack(spacing: 14) {
                Button("TURN ON REMINDERS") { requestNotifications() }
                    .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))

                Button("Maybe later") {
                    Haptics.selection()
                    advance()
                }
                .font(Theme.font(15, .black))
                .foregroundColor(theme.palette.muted)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    private func requestNotifications() {
        Haptics.selection()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            DispatchQueue.main.async { advance() }
        }
    }

    // MARK: Shared chooser scaffolding

    private func chooserScreen<Rows: View>(title: String, subtitle: String?,
                                           @ViewBuilder rows: () -> Rows) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
                if let subtitle {
                    Text(subtitle)
                        .font(Theme.bodyFont(15))
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

        }
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
    }

    private func optionRow(label: String, detail: String? = nil,
                           selected: Bool, action: @escaping () -> Void) -> some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            HStack(spacing: 13) {
                VStack(alignment: .leading, spacing: 1) {
                    Text(label)
                        .font(Theme.questionFont(16, .semibold))
                        .foregroundColor(selected ? .white : theme.palette.ink)
                    if let detail {
                        Text(detail)
                            .font(Theme.bodyFont(13))
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
                    .fill(selected ? Theme.answer : Theme.surface)
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(selected ? Theme.answerDark : Theme.surfaceBorder, lineWidth: 2))
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(
            slab: selected ? Theme.answerDark : Theme.surfaceSlab, radius: 16, depth: 4))
    }
}

// MARK: - Screen 6 — Course build

/// Plain `Text` only reads `progress` once per state change — the number
/// would jump straight to 100% while the ring animates smoothly. Conforming
/// to `Animatable` makes SwiftUI interpolate `progress` frame-by-frame through
/// the same `withAnimation` block driving the ring's `trim`, so the two stay
/// in sync.
private struct AnimatedPercentText: View, Animatable {
    var progress: CGFloat
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    var body: some View {
        Text("\(Int((progress * 100).rounded()))%")
    }
}

private struct CourseBuildView: View {
    var onComplete: () -> Void

    @EnvironmentObject private var theme: ThemeManager
    @State private var progress: CGFloat = 0
    @State private var generation = 0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            ZStack {
                Circle()
                    .stroke(Theme.surfaceBorder.opacity(0.45), lineWidth: 12)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Theme.answer, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                AnimatedPercentText(progress: progress)
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
            }
            .frame(width: 148, height: 148)

            Text("Building your course")
                .font(Theme.font(28, .black))
                .foregroundColor(theme.palette.ink)
                .padding(.top, 30)

            Text("Personalizing your learning path")
                .font(Theme.bodyFont(16))
                .foregroundColor(theme.palette.muted)
                .padding(.top, 8)

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 28)
        .onAppear { startBuilding() }
        .onDisappear { generation += 1 }
    }

    private func startBuilding() {
        generation += 1
        let currentGeneration = generation
        withAnimation(.easeOut(duration: 2.5)) { progress = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.58) {
            guard currentGeneration == generation else { return }
            Haptics.success()
            onComplete()
        }
    }
}

// MARK: - Screen 7 — Hold-to-commit
// "Make yourself a promise": press and hold the button; it charges up with a
// pulse, then the commit color bursts outward FROM THE BUTTON'S OWN SCREEN
// POSITION (via the router-level curtain, not a locally-centered circle),
// covers the screen, swaps in the already-loaded lesson underneath, and fades
// away to reveal it — seamless, no flash/jump to a blank or home screen.

private struct CommitScreen: View {
    @ObservedObject var router: AppRouter
    var onCommitted: () -> Void

    @EnvironmentObject var theme: ThemeManager
    @State private var holding = false
    @State private var holdProgress: CGFloat = 0   // 0…1 while charging
    @State private var burst = false               // curtain has been launched
    @State private var generation = 0              // cancels stale hold timers
    @State private var pulse = false
    @State private var buttonCenter: CGPoint = .zero

    private let holdDuration: Double = 1.5
    private let commit = Theme.correct
    private let commitDark = Theme.correctDark

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Make yourself a promise")
                .font(Theme.font(28, .black))
                .foregroundColor(theme.palette.ink)
                .multilineTextAlignment(.center)
            Text("I will spend a few minutes a day building smart money habits.")
                .font(Theme.bodyFont(16))
                .foregroundColor(theme.palette.muted)
                .multilineTextAlignment(.center)
                .lineSpacing(16 * 0.32)
                .padding(.top, 12)

            Spacer()

            holdButton
                .background(
                    // Track the button's actual on-screen position (global
                    // coordinates match the router-level curtain's coordinate
                    // space), so the burst can originate exactly from it.
                    GeometryReader { g in
                        Color.clear
                            .onAppear { buttonCenter = CGPoint(x: g.frame(in: .global).midX,
                                                               y: g.frame(in: .global).midY) }
                    }
                )

            Text("Press and hold")
                .font(Theme.font(13, .black))
                .textCase(.uppercase).tracking(1)
                .foregroundColor(theme.palette.muted)
                .padding(.top, 18)
                .opacity(burst ? 0 : 1)

            Spacer()
        }
        .padding(.horizontal, 28)
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
        Haptics.beginHold(duration: holdDuration)   // buzz climbs as the ring fills
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
        Haptics.endHold()
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { holdProgress = 0 }
    }

    private func completeHold() {
        Haptics.endHold()
        Haptics.play(.celebrate)
        burst = true
        onCommitted()   // persist onboarding answers

        // Launch the curtain from the button's own position and expand it to
        // cover the whole screen.
        router.curtainColor = commit
        router.curtainOrigin = buttonCenter
        router.curtainOpacity = 1
        router.curtainScale = 0.0001
        withAnimation(.easeIn(duration: 0.5)) {
            router.curtainScale = 34
        }

        // Once fully covered, swap in the lesson UNDERNEATH the still-opaque
        // curtain — invisible to the user — then fade the curtain away to
        // reveal it already loaded.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            router.onOnboardingFinished?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeOut(duration: 0.35)) {
                    router.curtainOpacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    router.curtainColor = nil
                }
            }
        }
    }
}
