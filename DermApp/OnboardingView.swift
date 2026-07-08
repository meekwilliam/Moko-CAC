import SwiftUI
import Combine

// MARK: - Onboarding flow
// Five-screen Duolingo-style intake: welcome (live-chart hero) → experience
// level → goals (choose any) → daily goal → hold-to-commit. Finishing bursts
// the commit color across the screen and launches Lesson 1 directly (never the
// home screen). Answers are stored in UserDefaults under "onboarding.*".

struct OnboardingView: View {
    @ObservedObject var router: AppRouter

    @EnvironmentObject var theme: ThemeManager
    @State private var step = 0

    // Selections
    @State private var experience: Int? = nil
    @State private var goals: Set<Int> = []
    @State private var dailyGoal: Int? = nil

    private let totalSteps = 5

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
                    default: CommitScreen(router: router, onCommitted: persistAnswers)
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

    private func persistAnswers() {
        // Persist the intake answers for personalization/analytics. The actual
        // screen swap to the lesson is driven by CommitScreen, timed with the
        // curtain animation (see AppRouter.curtainColor).
        let d = UserDefaults.standard
        if let e = experience { d.set(experienceOptions[e].label, forKey: "onboarding.experience") }
        d.set(goals.sorted().map { goalOptions[$0].label }, forKey: "onboarding.goals")
        if let g = dailyGoal { d.set(dailyGoalOptions[g].label, forKey: "onboarding.dailyGoal") }
        d.set(true, forKey: "onboarding.completed")
    }

    // MARK: Screen 1 — Welcome
    // Finelo-style landing, Moko'd: a live candlestick chart fills the hero
    // (in place of orbiting company logos) with the mascot centered on top as
    // the "brand", then a headline + Get Started button below.

    private var welcomeScreen: some View {
        VStack(spacing: 0) {
            ZStack {
                LiveCandleChart()
                    .opacity(0.85)
                    .mask(
                        // Fade the chart out toward the bottom so it melts into
                        // the page instead of ending on a hard edge.
                        LinearGradient(
                            colors: [.black, .black, .black.opacity(0.15)],
                            startPoint: .top, endPoint: .bottom)
                    )
                MascotIcon()
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.5), radius: 20, y: 6)
            }
            .frame(maxHeight: .infinity)

            VStack(spacing: 14) {
                Text("Learn to trade")
                    .font(Theme.font(34, .black))
                    .foregroundColor(theme.palette.ink)
                    .multilineTextAlignment(.center)
                Text("Master charts, price action, and risk management through short interactive lessons.")
                    .font(Theme.font(16, .bold))
                    .foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                Button("GET STARTED") { advance() }
                    .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
                    .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 26)
        }
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

    // MARK: Screen 3 — Goals (choose any)

    private var goalsScreen: some View {
        chooserScreen(
            title: "Why are you here?",
            subtitle: "Choose all that apply.",
            canContinue: !goals.isEmpty
        ) {
            ForEach(goalOptions.indices, id: \.self) { i in
                optionRow(emoji: goalOptions[i].emoji,
                          label: goalOptions[i].label,
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
            Text("I will spend a few minutes a day learning to trade with discipline.")
                .font(Theme.font(16, .bold))
                .foregroundColor(theme.palette.muted)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
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

// MARK: - Live candlestick chart
// A decorative "live market" backdrop: reuses the app's CandlestickChart but
// rolls a fixed-width window forward on a timer — every tick a new random
// candle appears on the right and the oldest drops off the left, animated so
// it reads as a live-updating chart.

struct LiveCandleChart: View {
    @State private var candles: [Candle] = []
    private let count = 16
    private let timer = Timer.publish(every: 0.85, on: .main, in: .common).autoconnect()

    var body: some View {
        CandlestickChart(candles: candles, showsAxes: true)
            .onAppear { if candles.isEmpty { seed() } }
            .onReceive(timer) { _ in tick() }
    }

    private func seed() {
        var arr: [Candle] = []
        var price = 100.0
        for _ in 0..<count {
            let c = Self.next(from: price)
            arr.append(c); price = c.close
        }
        candles = arr
    }

    private func tick() {
        let last = candles.last?.close ?? 100
        let fresh = Self.next(from: last)
        withAnimation(.easeInOut(duration: 0.55)) {
            candles = Array(candles.dropFirst()) + [fresh]
        }
    }

    /// A believable next candle: a random walk from the prior close with wicks.
    private static func next(from close: Double) -> Candle {
        let open = close
        let drift = Double.random(in: -3.4...3.4)
        let newClose = max(20, open + drift)
        let hi = max(open, newClose) + Double.random(in: 0.3...2.0)
        let lo = min(open, newClose) - Double.random(in: 0.3...2.0)
        return Candle(open: open, high: hi, low: lo, close: newClose)
    }
}
