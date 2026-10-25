import SwiftUI

// MARK: - Main tabbed shell (Duolingo-style)

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
                    onTestOut: { router.onOpenTestOut?($0) },
                    onHome: {},
                    onOpenHearts: { router.onOpenHearts?() },
                    onOpenCourses: { router.onOpenCourses?() }
                )
                .id(router.currentCourseId)
                .transition(.opacity)
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
                    courseName: Game.course(router.currentCourseId).name,
                    showsHomeButton: false,
                    onHome: {},
                    onToggleReminders: { router.onToggleReminders?($0) },
                    onOpenLegal: { router.requestLegalDoc?($0) },
                    onClearData: { router.onClearData?() },
                    onUnlockAll: { router.onUnlockAll?() },
                    onGrantTestTreats: { router.onGrantTestTreats?() },
                    onPreviewStreak: { router.onPreviewStreak?() },
                    onBumpStreak: { router.onBumpStreak?() },
                    onTestOnboarding: {
                        withAnimation(.easeInOut(duration: 0.28)) { router.currentScreen = .onboarding }
                    }
                )
            } else {
                Theme.appBackground.ignoresSafeArea()
            }
        }
    }
}

// MARK: - Bottom navigation bar

private struct BottomNav: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager

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
            icon(tab)
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
        .buttonStyle(TabPopStyle())
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
        withAnimation(.easeInOut(duration: 0.2)) { router.selectedTab = tab }

        if tab == .profile { router.onRequestProfile?() }
    }
}

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

private func unitPath(_ rect: CGRect, _ build: (inout Path, (CGFloat, CGFloat) -> CGPoint) -> Void) -> Path {
    let w = rect.width, h = rect.height
    func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { CGPoint(x: rect.minX + x * w, y: rect.minY + y * h) }
    var path = Path()
    build(&path, p)
    return path
}

private struct RoofChevron: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.12, 0.44))
        pth.addLine(to: p(0.50, 0.15))
        pth.addLine(to: p(0.88, 0.44))
    } }
}

private struct DogDoor: Shape {
    func path(in r: CGRect) -> Path { unitPath(r) { pth, p in
        pth.move(to: p(0.38, 0.905))
        pth.addLine(to: p(0.38, 0.66))
        pth.addQuadCurve(to: p(0.62, 0.66), control: p(0.50, 0.52))
        pth.addLine(to: p(0.62, 0.905))
        pth.closeSubpath()
    } }
}

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

struct DogHouseIcon: View {
    var body: some View {
        GeometryReader { g in
            let w = g.size.width, h = g.size.height
            ZStack {
                HouseBacking().fill(Color(hex: "#FBD24B"))

                RoundedRectangle(cornerRadius: w * 0.16, style: .continuous)
                    .fill(Color(hex: "#FBD24B"))
                    .frame(width: w * 0.66, height: h * 0.5)
                    .position(x: w * 0.5, y: h * 0.66)

                RoofChevron()
                    .stroke(Color(hex: "#EF4444"),
                            style: StrokeStyle(lineWidth: w * 0.17, lineCap: .round, lineJoin: .round))

                DogDoor().fill(Color(hex: "#8A4B23"))
            }
        }
    }
}

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

struct TrophyIcon: View {
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

struct FlameIcon: View {
    var size: CGFloat
    var animated: Bool = true
    var greyed: Bool = false
    var showsGlow: Bool = true
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
            if showsGlow {
                Circle()
                    .fill(Color(hex: "#FF9500"))
                    .opacity(flickerA ? 0.32 : 0.16)
                    .blur(radius: size * 0.22)
                    .scaleEffect(flickerA ? 1.05 : 0.9)
            }

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
