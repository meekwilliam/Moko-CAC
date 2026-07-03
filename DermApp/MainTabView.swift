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
                    onOpenHearts: { router.onOpenHearts?() }
                )
            }
        case .quest:
            PlaceholderTab(title: "Quests", subtitle: "Daily challenges are coming soon.") {
                TargetIcon()
            }
        case .leaderboard:
            PlaceholderTab(title: "Leaderboard", subtitle: "Compete with others — coming soon.") {
                TrophyIcon()
            }
        case .profile:
            if let store = router.profileStore {
                ProfileView(
                    store: store,
                    showsHomeButton: false,
                    onHome: {},
                    onToggleReminders: { router.onToggleReminders?($0) },
                    onOpenLegal: { router.requestLegalDoc?($0) },
                    onClearData: { router.onClearData?() },
                    onUnlockAll: { router.onUnlockAll?() }
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
    private let tabs: [MainTab] = [.home, .quest, .leaderboard, .profile]

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
        case .leaderboard: TrophyIcon().frame(width: 26, height: 26)
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

/// Friendly rounded dog house: soft yellow body, chunky rounded red roof, and a
/// big arched doorway — rounded style, but clearly a dog house.
struct DogHouseIcon: View {
    var body: some View {
        GeometryReader { g in
            let w = g.size.width, h = g.size.height
            ZStack {
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
    var body: some View {
        GeometryReader { g in
            ZStack {
                TrophyHandles().fill(Color(hex: "#E0A93B"))
                TrophyBowl().fill(Color(hex: "#FFC83D"))
                Rectangle().fill(Color(hex: "#E0A93B"))
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
