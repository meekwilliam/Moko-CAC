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
                    onTestMechanics: { router.onOpenMechanicsTest?() }
                )
            } else {
                Color(hex: "#0F172A").ignoresSafeArea()
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
        .buttonStyle(NoFadeButtonStyle())   // plain style dims the label on press → icons flicker
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

// A button style that renders its label unchanged — no press opacity/scale — so
// the always-on colored tab icons never flicker on tap.
private struct NoFadeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View { configuration.label }
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
// Custom-drawn instead of the SF Symbol so the inner layer is a guaranteed
// lighter orange/yellow, independent of SF Symbols' multicolor fallback.

private struct FlameShape: Shape {
    func path(in r: CGRect) -> Path {
        let w = r.width, h = r.height
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint { CGPoint(x: r.minX + x * w, y: r.minY + y * h) }
        var p = Path()
        p.move(to: pt(0.5, 0.0))
        p.addCurve(to: pt(0.84, 0.55), control1: pt(0.78, 0.14), control2: pt(0.98, 0.34))
        p.addCurve(to: pt(0.5, 1.0), control1: pt(0.98, 0.82), control2: pt(0.74, 1.0))
        p.addCurve(to: pt(0.16, 0.55), control1: pt(0.26, 1.0), control2: pt(0.02, 0.82))
        p.addCurve(to: pt(0.38, 0.34), control1: pt(0.02, 0.34), control2: pt(0.20, 0.46))
        p.addCurve(to: pt(0.5, 0.0), control1: pt(0.46, 0.24), control2: pt(0.40, 0.14))
        p.closeSubpath()
        return p
    }
}

struct FlameIcon: View {
    var outer: Color
    var inner: Color
    var size: CGFloat

    var body: some View {
        ZStack {
            FlameShape().fill(outer)
            FlameShape().fill(inner)
                .scaleEffect(0.5, anchor: .bottom)
                .offset(y: size * 0.02)
        }
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
