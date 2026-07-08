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

    var body: some View {
        ZStack {
            ThemedBackground()

            VStack(spacing: 0) {
                if step > 0 {
                    header
                        .padding(.horizontal, 18)
                        .padding(.top, 8)
                }

                Group {
                    switch step {
                    case 0: welcomeScreen
                    case 1: experienceScreen
                    case 2: goalsScreen
                    case 3: dailyGoalScreen
                    case 4: signUpScreen
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
    // Hidden on the welcome screen (full-bleed hero, like the reference).

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
    // A brand lockup + a chart that tells a real story (downtrend → base →
    // breakout → run: "you'll learn to read THIS"), an outcome-led headline,
    // credibility stats, then GET STARTED (into the intake) with a secondary
    // "I already have an account" (skip straight into the app).

    private var welcomeScreen: some View {
        VStack(spacing: 0) {
            // Brand lockup — the mascot + wordmark, so the screen has an identity.
            HStack(spacing: 8) {
                MascotIcon().frame(width: 34, height: 34)
                Text("Moko").font(Theme.font(22, .black)).foregroundColor(theme.palette.ink)
            }
            .padding(.top, 6)

            StoryCandleChart()
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 6)
                .mask(
                    // Fade the chart out toward the bottom so it melts into
                    // the page instead of ending on a hard edge.
                    LinearGradient(
                        colors: [.black, .black, .black.opacity(0.2)],
                        startPoint: .top, endPoint: .bottom)
                )

            VStack(spacing: 12) {
                Text("Read charts, not guesses.")
                    .font(Theme.font(31, .black))
                    .foregroundColor(theme.palette.ink)
                    .multilineTextAlignment(.center)
                Text("Go from confusing candles to confident reads — a few minutes a day.")
                    .font(Theme.font(16, .bold))
                    .foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)

                HStack(spacing: 8) {
                    statChip("📚", "300+ lessons")
                    statChip("📈", "Real charts")
                    statChip("🔥", "Streaks")
                }
                .padding(.top, 2)

                Button("GET STARTED") { advance() }
                    .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
                    .padding(.top, 8)

                Button("I already have an account") {
                    Haptics.selection()
                    withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                }
                .font(Theme.font(15, .black))
                .foregroundColor(theme.palette.muted)
                .padding(.top, 2)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }

    private func statChip(_ emoji: String, _ text: String) -> some View {
        HStack(spacing: 5) {
            Text(emoji).font(.system(size: 13))
            Text(text).font(Theme.font(12.5, .black)).foregroundColor(theme.palette.ink)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.vertical, 8).padding(.horizontal, 11)
        .background(
            Capsule().fill(Color(hex: "#1E293B"))
                .overlay(Capsule().strokeBorder(Color(hex: "#334155"), lineWidth: 1.5))
        )
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

    // MARK: Screen 5 — Sign up
    // Sits right before the commit screen — reached only via GET STARTED on
    // the welcome screen (returning users skip all of this via "I already
    // have an account").

    private var signUpScreen: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(alignment: .center, spacing: 6) {
                Text("Create your account")
                    .font(Theme.font(26, .black))
                    .foregroundColor(theme.palette.ink)
                Text("So your progress and streak are saved.")
                    .font(Theme.font(15, .bold))
                    .foregroundColor(theme.palette.muted)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)

            VStack(spacing: 14) {
                authButton(label: "Continue with Apple",
                          fill: .black, textColor: .white, border: Color.white.opacity(0.18)) {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 18, weight: .medium))
                }
                authButton(label: "Continue with Google",
                          fill: .white, textColor: Color(hex: "#1F1F1F"), border: Color.black.opacity(0.08)) {
                    GoogleGlyph().frame(width: 18, height: 18)
                }
            }
            .padding(.top, 32)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    private func authButton<Glyph: View>(label: String, fill: Color, textColor: Color, border: Color,
                                         @ViewBuilder glyph: () -> Glyph) -> some View {
        Button {
            Haptics.selection()
            advance()   // no real backend — this app is local-first; advances the flow
        } label: {
            HStack(spacing: 10) {
                glyph()
                Text(label).font(Theme.font(16, .black))
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(border, lineWidth: 1.5))
            )
        }
        .buttonStyle(RowPressStyle())
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
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(
            slab: selected ? Theme.answerDark : Color(hex: "#334155"), radius: 16, depth: 4))
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

// MARK: - Story candlestick chart
// A curated hero chart that reads as an actual market rather than random
// wallpaper — a repeating cycle of downtrend → accumulation base under a fixed
// resistance level → breakout → continuation run → roll back down. It scrolls
// left one candle per tick (like a live feed), but because the window always
// holds the same cyclic set the y-axis and resistance line stay put (no jumpy
// rescale) and the structure stays readable as it moves.

struct StoryCandleChart: View {
    @State private var offset = 0
    private let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()

    // One seamless cycle (last close ≈ first open, so it loops cleanly):
    // downtrend → base (< 12.0) → breakout → run up → roll back toward the base.
    private static let cycle: [Candle] = [
        Candle(open: 15.8, high: 16.0, low: 14.6, close: 14.8),
        Candle(open: 14.8, high: 15.0, low: 13.4, close: 13.5),
        Candle(open: 13.5, high: 13.7, low: 12.6, close: 12.7),
        Candle(open: 12.7, high: 12.9, low: 11.7, close: 11.9),
        Candle(open: 11.9, high: 12.0, low: 11.4, close: 11.6),
        Candle(open: 11.6, high: 11.95, low: 11.3, close: 11.8),
        Candle(open: 11.8, high: 12.0, low: 11.35, close: 11.5),
        Candle(open: 11.5, high: 11.9, low: 11.3, close: 11.85),
        Candle(open: 11.85, high: 13.6, low: 11.8, close: 13.5),   // breakout
        Candle(open: 13.5, high: 14.3, low: 13.4, close: 14.1),
        Candle(open: 14.1, high: 14.4, low: 13.6, close: 13.8),
        Candle(open: 13.8, high: 15.2, low: 13.7, close: 15.0),
        Candle(open: 15.0, high: 15.9, low: 15.0, close: 15.8),
    ]

    // The visible window: the cycle rotated by `offset`, so each tick the whole
    // thing shifts one slot to the left and wraps — a continuous scroll.
    private var windowed: [Candle] {
        let n = Self.cycle.count
        return (0..<n).map { Self.cycle[(offset + $0) % n] }
    }

    var body: some View {
        CandlestickChart(candles: windowed, resistanceLevel: 12.0, showsAxes: true)
            .onReceive(timer) { _ in
                offset = (offset + 1) % Self.cycle.count
            }
    }
}

/// A lightweight approximation of the Google "G" mark (four quarter-arcs in
/// Google's brand colors) — used on the "Continue with Google" button since
/// there's no SF Symbol equivalent.
private struct GoogleGlyph: View {
    var body: some View {
        ZStack {
            GoogleArc(start: -45, end: 45).stroke(Color(hex: "#4285F4"), lineWidth: 3.2)
            GoogleArc(start: 45, end: 135).stroke(Color(hex: "#34A853"), lineWidth: 3.2)
            GoogleArc(start: 135, end: 225).stroke(Color(hex: "#FBBC05"), lineWidth: 3.2)
            GoogleArc(start: 225, end: 315).stroke(Color(hex: "#EA4335"), lineWidth: 3.2)
            // The crossbar stub, like the real mark.
            Rectangle()
                .fill(Color(hex: "#4285F4"))
                .frame(width: 7, height: 3.2)
                .offset(x: 2)
        }
    }
}

private struct GoogleArc: Shape {
    let start: Double
    let end: Double
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                 radius: rect.width / 2 - 1.6,
                 startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
        return p
    }
}
