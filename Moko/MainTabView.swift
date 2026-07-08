import SwiftUI

// MARK: - Main tabbed shell (Duolingo-style)
// The learning path is now the home screen; a persistent bottom bar switches
// between Home (path), Quests, Leaderboard and Profile. Lessons/legal present
// over this from the AppRouter.

struct MainTabView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        ZStack(alignment: .bottom) {
            theme.palette.base.ignoresSafeArea()
            content
            BottomNav(router: router)
        }
    }

    @ViewBuilder private var content: some View {
        switch router.selectedTab {
        case .home:
            if let store = router.pathStore {
                PathView(
                    store: store,
                    showsHomeButton: false,
                    onSelectNode: { router.onOpenLesson?($0) },
                    onHome: {},
                    onOpenHearts: { router.onOpenHearts?() },
                    onOpenCourses: { router.onOpenCourses?() }
                )
                .id(router.currentCourseId)
                .transition(.asymmetric(
                    insertion: .offset(x: 34).combined(with: .opacity),
                    removal: .offset(x: -24).combined(with: .opacity)
                ))
            }
        case .quest:
            PlaceholderTab(title: "Quests", subtitle: "Daily challenges are coming soon.") {
                TargetIcon()
            }
        case .simulation:
            SimulationComingSoonView()
        case .leaderboard:
            PlaceholderTab(title: "Leaderboard", subtitle: "Compete with others — coming soon.") {
                TrophyIcon()
            }
        case .premium:
            SuperView(router: router)
        case .profile:
            if let store = router.profileStore {
                ProfileView(
                    store: store,
                    showsHomeButton: false,
                    onHome: {},
                    onToggleReminders: { router.onToggleReminders?($0) },
                    onOpenLegal: { router.requestLegalDoc?($0) },
                    onClearData: { router.onClearData?() },
                    onUnlockAll: { router.onUnlockAll?() },
                    onGrantTestTreats: { router.onGrantTestTreats?() },
                    onTestMechanics: { router.onOpenMechanicsTest?() },
                    onPreviewStreak: { router.onPreviewStreak?() },
                    onBumpStreak: { router.onBumpStreak?() },
                    onTestOnboarding: {
                        withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .onboarding }
                    }
                )
            } else {
                Color(hex: "#0E161A").ignoresSafeArea()
            }
        }
    }
}

// MARK: - Bottom navigation bar

private struct BottomNav: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager

    // Every tab highlights in the same blue when selected; the icons themselves
    // are multi-color drawings.
    private let accent = Color(hex: "#38bdf8")
    private let tabs: [MainTab] = [.home, .quest, .simulation, .leaderboard, .premium, .profile]

    var body: some View {
        HStack(spacing: 6) {
            ForEach(tabs, id: \.self) { tab in
                tabButton(tab)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 6)
        .background(
            theme.palette.base
                .overlay(Rectangle().fill(theme.palette.ink.opacity(0.08)).frame(height: 1), alignment: .top)
                .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabButton(_ tab: MainTab) -> some View {
        let selected = router.selectedTab == tab
        return Button(action: { select(tab) }) {
            icon(tab)   // icons stay full color; only the blue pill marks the active tab
                .frame(maxWidth: .infinity)
                .frame(height: 46)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(accent.opacity(selected ? 0.16 : 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(accent.opacity(selected ? 0.55 : 0), lineWidth: 1.5)
                        )
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(TabPopStyle())   // icon shrinks slightly on press → a tactile "pop"
    }

    @ViewBuilder
    private func icon(_ tab: MainTab) -> some View {
        switch tab {
        case .home:        DogHouseIcon().frame(width: 28, height: 26)
        case .quest:       TargetIcon().frame(width: 26, height: 26)
        case .simulation:  CandlesTabIcon().frame(width: 27, height: 26)
        case .leaderboard: TrophyIcon().frame(width: 26, height: 26)
        case .premium:     SuperHeartIcon(size: 26, showInfinity: false)
        case .profile:     PersonIcon().frame(width: 25, height: 26)
        }
    }

    private func select(_ tab: MainTab) {
        Haptics.selection()
        withAnimation(.easeInOut(duration: 0.2)) { router.selectedTab = tab }   // animates only the pill

        if tab == .profile { router.onRequestProfile?() }   // refresh stats
    }
}

// Scales the icon down slightly on press/hold for a tactile "pop" (like the
// path node pucks). No opacity dim, so the always-on colored tab icons don't
// flicker — only the springy shrink.
private struct TabPopStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.84 : 1.0)
            .animation(configuration.isPressed
                       ? .easeIn(duration: 0.06)
                       : .spring(response: 0.3, dampingFraction: 0.55),
                       value: configuration.isPressed)
    }
}

// MARK: - Multi-color tab icons (custom drawings)

/// Maps unit (0…1) coordinates into a Shape's rect.
private func unitPath(_ rect: CGRect, _ build: (inout Path, (CGFloat, CGFloat) -> CGPoint) -> Void) -> Path {
    let w = rect.width, h = rect.height
    func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { CGPoint(x: rect.minX + x * w, y: rect.minY + y * h) }
    var path = Path()
    build(&path, p)
    return path
}

/// The roofline: a rounded peak (caret) stroked thick with round caps.
private struct RoofChevron: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.12, 0.44))
        pth.addLine(to: p(0.50, 0.15))
        pth.addLine(to: p(0.88, 0.44))
    } }
}

/// A big arched dog-house doorway, open at the body base.
private struct DogDoor: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.38, 0.905))
        pth.addLine(to: p(0.38, 0.66))
        pth.addQuadCurve(to: p(0.62, 0.66), control: p(0.50, 0.52))
        pth.addLine(to: p(0.62, 0.905))
        pth.closeSubpath()
    } }
}

/// Fills the full silhouette under the roofline (peak down to the base, at the
/// eave width) so no background shows through between the roof stroke and the
/// narrower body block underneath — sits behind both.
private struct HouseBacking: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.12, 0.44))
        pth.addLine(to: p(0.50, 0.15))
        pth.addLine(to: p(0.88, 0.44))
        pth.addLine(to: p(0.88, 0.98))
        pth.addLine(to: p(0.12, 0.98))
        pth.closeSubpath()
    } }
}

/// Friendly rounded dog house: soft yellow body, chunky rounded red roof, and a
/// big arched doorway — rounded style, but clearly a dog house.
struct DogHouseIcon: View {
    var body: some View {
        GeometryReader { g in
            let w = g.size.width, h = g.size.height
            ZStack {
                // Backing — fills the whole under-roof silhouette so no gap
                // shows at the peak or eaves before the body/roof are drawn.
                HouseBacking().fill(Color(hex: "#FBD24B"))

                // Body — rounded yellow block
                RoundedRectangle(cornerRadius: w * 0.16, style: .continuous)
                    .fill(Color(hex: "#FBD24B"))
                    .frame(width: w * 0.66, height: h * 0.5)
                    .position(x: w * 0.5, y: h * 0.66)

                // Roof — thick rounded red chevron, overhanging the body
                RoofChevron()
                    .stroke(Color(hex: "#EF4444"),
                            style: StrokeStyle(lineWidth: w * 0.17, lineCap: .round, lineJoin: .round))

                // Arched doorway
                DogDoor().fill(Color(hex: "#8A4B23"))
            }
        }
    }
}

/// Concentric target: alternating red / white rings with a red bullseye.
struct TargetIcon: View {
    var body: some View {
        ZStack {
            Circle().fill(Color(hex: "#EF4444"))
            Circle().fill(Color.white).scaleEffect(0.72)
            Circle().fill(Color(hex: "#EF4444")).scaleEffect(0.46)
            Circle().fill(Color.white).scaleEffect(0.20)
        }
    }
}

private struct TrophyHandles: Shape {
    func path(in r: CGRect) -> Path {
        let w = r.width, h = r.height
        var pth = Path()
        pth.addEllipse(in: CGRect(x: r.minX + 0.02 * w, y: r.minY + 0.10 * h, width: 0.26 * w, height: 0.40 * h))
        pth.addEllipse(in: CGRect(x: r.minX + 0.72 * w, y: r.minY + 0.10 * h, width: 0.26 * w, height: 0.40 * h))
        return pth
    }
}
private struct TrophyBowl: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.18, 0.10)); pth.addLine(to: p(0.82, 0.10))
        pth.addLine(to: p(0.74, 0.46))
        pth.addQuadCurve(to: p(0.50, 0.60), control: p(0.62, 0.60))
        pth.addQuadCurve(to: p(0.26, 0.46), control: p(0.38, 0.60))
        pth.closeSubpath()
    } }
}
private struct TrophyBase: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.30, 0.98)); pth.addLine(to: p(0.70, 0.98))
        pth.addLine(to: p(0.64, 0.80)); pth.addLine(to: p(0.36, 0.80)); pth.closeSubpath()
    } }
}

/// Gold trophy cup on a dark base.
struct TrophyIcon: View {
    // One gold tone for the trophy itself (handles, bowl, stem) — the base
    // stays its original brown/wood tone, not gold.
    private let gold = Color(hex: "#FFC83D")

    var body: some View {
        GeometryReader { g in
            ZStack {
                TrophyHandles().fill(gold)
                TrophyBowl().fill(gold)
                Rectangle().fill(gold)
                    .frame(width: 0.12 * g.size.width, height: 0.20 * g.size.height)
                    .position(x: 0.50 * g.size.width, y: 0.68 * g.size.height)
                TrophyBase().fill(Color(hex: "#8A6D3B"))
            }
        }
    }
}

/// Simple person: head + shoulders in two greens.
struct PersonIcon: View {
    var body: some View {
        GeometryReader { g in
            let w = g.size.width, h = g.size.height
            ZStack {
                Circle().fill(Color(hex: "#34D399"))
                    .frame(width: 0.5 * w, height: 0.5 * w)
                    .position(x: 0.5 * w, y: 0.26 * h)
                PersonShoulders().fill(Color(hex: "#22C55E"))
            }
        }
    }
}
private struct PersonShoulders: Shape {
    func path(in r: CGRect) -> Path {
        var pth = Path()
        pth.addArc(center: CGPoint(x: r.midX, y: r.maxY + 0.02 * r.height),
                   radius: 0.44 * r.width, startAngle: .degrees(180), endAngle: .degrees(360), clockwise: false)
        pth.closeSubpath()
        return pth
    }
}

// MARK: - Flame (streak icon)
// Rendered from the provided streak.svg (three layered flame paths, deep
// orange body with a brighter yellow core) via the shared SVG renderer.
// Each path is parsed as its own layer (rather than one flattened SVGIconView)
// so it can flicker independently — different scale/tilt/timing per layer,
// like Duolingo's animated streak flame — plus a soft pulsing glow behind it.

struct FlameIcon: View {
    var size: CGFloat
    // Home screen passes animated: false (no flicker) and greyed: true when the
    // streak is 0. The streak-celebration keeps the defaults (animated, lit).
    var animated: Bool = true
    var greyed: Bool = false
    @State private var flickerA = false
    @State private var flickerB = false
    @State private var flickerCore = false

    private static let bodyOuter = SVGParser.parse("""
        <svg viewBox="0 0 200 200">
        <path d="M107.619 30.1449C103.798 24.9107 96.2019 24.9107 92.3809 30.1449C77.2805 50.8305 45 98.1863 45 125C45 155.5 69.5 180 100 180C130.5 180 155 155.5 155 125C155 98.1863 122.72 50.8305 107.619 30.1449Z" fill="#E77100"/>
        </svg>
        """)
    private static let bodyLick = SVGParser.parse("""
        <svg viewBox="0 0 200 200">
        <path d="M55.5884 54.2185C49.5488 51.3043 42.6828 55.2684 42.1868 61.9559C40.5271 84.3307 38.8691 128.735 49.7251 147.538C62.6321 169.893 89.9741 178.051 111.105 165.851C132.236 153.651 138.842 125.893 125.935 103.538C115.079 84.7347 75.7954 63.9686 55.5884 54.2185Z" fill="#E77100"/>
        </svg>
        """)
    private static let core = SVGParser.parse("""
        <svg viewBox="0 0 200 200">
        <path d="M108.13 78.9635C104.451 73.3933 96.5494 73.3933 92.8698 78.9635C84.7316 91.283 73 111.123 73 123.125C73 139.137 85.25 152 100.5 152C115.75 152 128 139.137 128 123.125C128 111.123 116.268 91.283 108.13 78.9635Z" fill="#FFC225"/>
        </svg>
        """)

    var body: some View {
        ZStack {
            // Soft warm glow pulsing behind the flame.
            Circle()
                .fill(Color(hex: "#FF9500"))
                .opacity(flickerA ? 0.32 : 0.16)
                .blur(radius: size * 0.22)
                .scaleEffect(flickerA ? 1.05 : 0.9)

            SVGIconView(svg: Self.bodyOuter)
                .scaleEffect(flickerA ? 1.025 : 0.985, anchor: .bottom)
                .rotationEffect(.degrees(flickerA ? 1.4 : -1.4), anchor: .bottom)

            SVGIconView(svg: Self.bodyLick)
                .scaleEffect(flickerB ? 1.02 : 0.99, anchor: .bottom)
                .rotationEffect(.degrees(flickerB ? -1.6 : 1.1), anchor: .bottom)

            SVGIconView(svg: Self.core)
                .scaleEffect(flickerCore ? 1.05 : 0.93, anchor: .bottom)
        }
        .frame(width: size * 0.86, height: size)
        // Greyed (streak == 0): desaturate to grey and dim.
        .grayscale(greyed ? 1 : 0)
        .opacity(greyed ? 0.4 : 1)
        .onAppear {
            guard animated else { return }
            withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) { flickerA = true }
            withAnimation(.easeInOut(duration: 0.85).repeatForever(autoreverses: true).delay(0.12)) { flickerB = true }
            withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true).delay(0.05)) { flickerCore = true }
        }
    }
}

/// The same flame artwork rendered blank/white — used ONLY for the very first
/// streak day ("a streak is born"), which fast-spins and reveals the real
/// animated FlameIcon underneath. Every day after the first is already lit
/// from the start (see StreakCelebrationView.isFirstDay).
struct UnlitFlameIcon: View {
    var size: CGFloat

    private static let silhouette = SVGParser.parse("""
        <svg viewBox="0 0 200 200">
        <path d="M107.619 30.1449C103.798 24.9107 96.2019 24.9107 92.3809 30.1449C77.2805 50.8305 45 98.1863 45 125C45 155.5 69.5 180 100 180C130.5 180 155 155.5 155 125C155 98.1863 122.72 50.8305 107.619 30.1449Z" fill="#FFFFFF"/>
        <path d="M55.5884 54.2185C49.5488 51.3043 42.6828 55.2684 42.1868 61.9559C40.5271 84.3307 38.8691 128.735 49.7251 147.538C62.6321 169.893 89.9741 178.051 111.105 165.851C132.236 153.651 138.842 125.893 125.935 103.538C115.079 84.7347 75.7954 63.9686 55.5884 54.2185Z" fill="#FFFFFF"/>
        <path d="M108.13 78.9635C104.451 73.3933 96.5494 73.3933 92.8698 78.9635C84.7316 91.283 73 111.123 73 123.125C73 139.137 85.25 152 100.5 152C115.75 152 128 139.137 128 123.125C128 111.123 116.268 91.283 108.13 78.9635Z" fill="#E5E9F0"/>
        </svg>
        """)

    var body: some View {
        SVGIconView(svg: Self.silhouette)
            .frame(width: size * 0.86, height: size)
    }
}

// MARK: - Candlestick tab icon (Simulation)

struct CandlesTabIcon: View {
    private let up = Color(hex: "#22C55E")
    private let down = Color(hex: "#EF4444")

    var body: some View {
        GeometryReader { g in
            let w = g.size.width, h = g.size.height
            // Three little candles with wicks.
            candle(x: 0.16 * w, bodyTop: 0.30, bodyBot: 0.66, wickTop: 0.14, wickBot: 0.80, color: up, w: w, h: h)
            candle(x: 0.50 * w, bodyTop: 0.44, bodyBot: 0.86, wickTop: 0.24, wickBot: 0.96, color: down, w: w, h: h)
            candle(x: 0.84 * w, bodyTop: 0.10, bodyBot: 0.50, wickTop: 0.02, wickBot: 0.64, color: up, w: w, h: h)
        }
    }

    private func candle(x: CGFloat, bodyTop: CGFloat, bodyBot: CGFloat,
                        wickTop: CGFloat, wickBot: CGFloat, color: Color, w: CGFloat, h: CGFloat) -> some View {
        ZStack {
            Path { p in
                p.move(to: CGPoint(x: x, y: wickTop * h)); p.addLine(to: CGPoint(x: x, y: wickBot * h))
            }.stroke(color, lineWidth: max(w * 0.05, 1.4))
            RoundedRectangle(cornerRadius: w * 0.05, style: .continuous)
                .fill(color)
                .frame(width: w * 0.22, height: (bodyBot - bodyTop) * h)
                .position(x: x, y: (bodyTop + bodyBot) / 2 * h)
        }
    }
}

// MARK: - Simulation mode (coming soon)

struct SimulationComingSoonView: View {
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        ZStack {
            ThemedBackground()
            VStack(spacing: 20) {
                Text("COMING SOON")
                    .font(Theme.font(12, .black)).tracking(2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 14).padding(.vertical, 7)
                    .background(Capsule().fill(Color(hex: "#F59E0B")))

                Text("Simulation Mode")
                    .font(Theme.font(30, .black)).foregroundColor(theme.palette.ink)

                Text("Practice reading real, moving charts — spot the setups you've learned, hands-on.")
                    .font(Theme.font(15, .semibold)).foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 34)

                ScenarioChartView(scenario: .breakout, height: 210, seed: 42)
                    .padding(.horizontal, 22)
                    .padding(.top, 6)
                    .overlay(
                        // Subtle "locked" hint over the preview chart.
                        Image(systemName: "lock.fill")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white.opacity(0.85))
                            .padding(12)
                            .background(Circle().fill(Color.black.opacity(0.35)))
                    )
            }
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Placeholder tab

private struct PlaceholderTab<Icon: View>: View {
    @EnvironmentObject var theme: ThemeManager
    let title: String
    let subtitle: String
    @ViewBuilder let icon: () -> Icon

    var body: some View {
        ZStack {
            ThemedBackground()
            VStack(spacing: 14) {
                icon()
                    .frame(width: 62, height: 62)
                Text(title).font(Theme.font(28, .black)).foregroundColor(theme.palette.ink)
                Text(subtitle)
                    .font(Theme.font(15, .bold)).foregroundColor(theme.palette.muted)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
        }
    }
}
