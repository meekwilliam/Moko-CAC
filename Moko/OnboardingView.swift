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
    @State private var stepDirection: CGFloat = 1

    // Selections
    @State private var experience: Int? = nil
    @State private var goals: Set<Int> = []
    @State private var dailyGoal: Int? = nil
    @State private var authInFlight = false
    @State private var showingSignIn = false   // returning-user login overlay

    private let totalSteps = 6
    private var stepSlideDistance: CGFloat { UIScreen.main.bounds.width + 64 }
    private var showsChoiceFooter: Bool { (1...3).contains(step) }
    private var currentStepCanContinue: Bool {
        switch step {
        case 1: return experience != nil
        case 2: return !goals.isEmpty
        case 3: return dailyGoal != nil
        default: return true
        }
    }

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

                ZStack(alignment: .topLeading) {
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
                        insertion: .offset(x: stepDirection * stepSlideDistance),
                        removal: .offset(x: -stepDirection * stepSlideDistance)))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

                if showsChoiceFooter {
                    choiceFooter
                }
            }

            // Returning-user login, slides over the welcome screen.
            if showingSignIn {
                signInScreen
                    .transition(.move(edge: .trailing))
                    .zIndex(5)
            }
        }
        .animation(.easeOut(duration: 0.24), value: step)
        .animation(.easeInOut(duration: 0.3), value: showingSignIn)
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
        if step > 0 {
            stepDirection = -1
            step -= 1
        }
    }

    private func advance() {
        Haptics.selection()
        stepDirection = 1
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
    // Finelo-style landing, Moko'd: a live candlestick chart fills the hero (in
    // place of orbiting company logos), then a headline, a primary GET STARTED
    // (-> goes into the intake, ending at sign-up right before the commit
    // screen) and a secondary "I already have an account" (-> skips straight
    // into the app for a returning user).

    private var welcomeScreen: some View {
        VStack(spacing: 0) {
            LiveCandleChart()
                .opacity(0.85)
                .mask(
                    // Fade the chart out toward the bottom so it melts into
                    // the page instead of ending on a hard edge.
                    LinearGradient(
                        colors: [.black, .black, .black.opacity(0.15)],
                        startPoint: .top, endPoint: .bottom)
                )
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

                Button("I already have an account") {
                    Haptics.selection()
                    withAnimation(.easeInOut(duration: 0.3)) { showingSignIn = true }
                }
                .font(Theme.font(15, .black))
                .foregroundColor(theme.palette.muted)
                .padding(.top, 4)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 26)
        }
    }

    // MARK: Screen 2 — Experience

    private var experienceScreen: some View {
        chooserScreen(
            title: "What best describes you?",
            subtitle: nil
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
            subtitle: "Choose all that apply."
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
            subtitle: nil
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

            authProviderButtons(proceed: { advance() })
                .padding(.top, 32)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 26)
    }

    // MARK: Returning-user sign in
    // Reached from "I already have an account". Same providers, but a successful
    // sign-in pulls the user's cloud progress and drops straight into the app
    // (no intake). Backed by its own full-bleed layer over the welcome screen.

    private var signInScreen: some View {
        ZStack {
            ThemedBackground()
            VStack(spacing: 0) {
                HStack {
                    Button(action: { Haptics.selection(); withAnimation(.easeInOut(duration: 0.3)) { showingSignIn = false } }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 19, weight: .black))
                            .foregroundColor(Theme.muted)
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                }
                .padding(.horizontal, 14).padding(.top, 8)

                Spacer()

                VStack(alignment: .center, spacing: 6) {
                    Text("Welcome back")
                        .font(Theme.font(26, .black))
                        .foregroundColor(theme.palette.ink)
                    Text("Sign in to pick up where you left off.")
                        .font(Theme.font(15, .bold))
                        .foregroundColor(theme.palette.muted)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

                authProviderButtons(proceed: {
                    withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .main }
                })
                .padding(.top, 32)
                .padding(.horizontal, 24)

                Spacer()
                Spacer()
            }
            .padding(.bottom, 26)
        }
    }

    // Apple + Google buttons. `proceed` is what happens after a successful
    // sign-in (or the local-first fallback when no backend is configured):
    // the sign-UP screen continues the intake; the sign-IN screen jumps to the app.
    private func authProviderButtons(proceed: @escaping () -> Void) -> some View {
        VStack(spacing: 14) {
            authButton(label: "Continue with Apple",
                      fill: .black, textColor: .white, border: Color.white.opacity(0.18),
                      action: { try await Backend.auth.signInWithApple() }, proceed: proceed) {
                Image(systemName: "apple.logo").font(.system(size: 18, weight: .medium))
            }
            authButton(label: "Continue with Google",
                      fill: .white, textColor: Color(hex: "#1F1F1F"), border: Color.black.opacity(0.08),
                      action: { try await Backend.auth.signInWithGoogle() }, proceed: proceed) {
                GoogleGlyph().frame(width: 18, height: 18)
            }
        }
        .disabled(authInFlight)
    }

    private func authButton<Glyph: View>(label: String, fill: Color, textColor: Color, border: Color,
                                         action: @escaping () async throws -> BackendUser,
                                         proceed: @escaping () -> Void,
                                         @ViewBuilder glyph: () -> Glyph) -> some View {
        Button {
            Haptics.selection()
            guard !authInFlight else { return }
            // Real sign-in when a backend is configured; until then it throws
            // .notConfigured and we just proceed (local-first, unchanged).
            Task {
                authInFlight = true
                defer { authInFlight = false }
                do {
                    let user = try await action()
                    SyncService.shared.userDidSignIn(user)   // pull cloud progress
                    proceed()
                }
                catch BackendError.cancelled { /* user backed out — stay put */ }
                catch { proceed() }   // not configured yet → proceed
            }
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

        }
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
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
    // A quick highlight flash over the newest (rightmost) candle only — the
    // rolling window itself updates instantly with no animation, since
    // animating the whole array made every bar visibly reshape/resize each
    // tick (all 16 indices change value when the window shifts).
    @State private var popID = 0
    private let count = 16
    private let timer = Timer.publish(every: 0.85, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                CandlestickChart(candles: candles, showsAxes: true)
                if !candles.isEmpty {
                    let slot = geo.size.width / CGFloat(count)
                    NewCandlePop(key: popID)
                        .frame(width: slot, height: geo.size.height)
                        .position(x: geo.size.width - slot / 2, y: geo.size.height / 2)
                }
            }
        }
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
        candles = Array(candles.dropFirst()) + [fresh]   // instant, no animation
        popID += 1                                        // re-trigger the flash
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

/// A soft vertical highlight that pops in and fades over the newest candle's
/// slot. Re-fires whenever `key` changes (a new tick), independent of the
/// chart's own candle views, so only the incoming bar visibly announces
/// itself — the rest of the chart never re-animates.
private struct NewCandlePop: View {
    let key: Int
    @State private var visible = false

    var body: some View {
        LinearGradient(colors: [Color.white.opacity(0.28), .clear],
                       startPoint: .top, endPoint: .bottom)
            .opacity(visible ? 0 : 1)
            .scaleEffect(x: 1, y: visible ? 1.15 : 0.85, anchor: .bottom)
            .onAppear { flash() }
            .onChange(of: key) { _, _ in visible = false; flash() }
    }

    private func flash() {
        withAnimation(.easeOut(duration: 0.5)) { visible = true }
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
