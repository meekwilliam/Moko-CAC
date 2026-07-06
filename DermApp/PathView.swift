import SwiftUI

// MARK: - Native learning path (learn map)
// A native re-build of the web #screen-progress: a snaking column of 3D node
// pucks grouped into 9 sections, with a dotted trail, a sticky metrics bar +
// floating section banner, a jump-to-section picker, and a home button.

struct PathView: View {
    @ObservedObject var store: PathStore
    @EnvironmentObject var theme: ThemeManager
    var showsHomeButton: Bool = true    // false when it's the home tab
    var onSelectNode: (Int) -> Void
    var onHome: () -> Void
    var onOpenHearts: () -> Void = {}
    var onOpenCourses: () -> Void = {}

    @State private var visibleSection = 0
    @State private var didInitialScroll = false
    @State private var pulse: Bool = false
    @State private var tooltipNode: Int? = nil
    // Stays set through the dismiss animation so the callout keeps its raised
    // z-order while it collapses (otherwise it draws behind the node below).
    @State private var elevatedNode: Int? = nil

    private let nodeSize: CGFloat = 82
    private let vStep: CGFloat = 106          // node center-to-center spacing
    private let bg = Color(hex: "#0A1017")

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let topInset = geo.safeAreaInsets.top
            let headerHeight = topInset + 118

            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    ThemedBackground()

                    // ── Scrolling path ──
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            Color.clear.frame(height: headerHeight - 8)
                            ForEach(0..<store.sectionCount, id: \.self) { s in
                                if s > 0 {
                                    sectionDivider(s)
                                        // Always draw below node content, so an overflowing
                                        // tooltip from the previous section's last node (which
                                        // sits just above this divider) never gets painted over.
                                        .zIndex(-1)
                                }
                                sectionColumn(s, width: width)
                                    .id("sec-\(s)")
                                    .background(sectionAnchor(s))
                                    // Raise the whole section holding the open tooltip so the
                                    // callout draws above nodes in adjacent sections.
                                    .zIndex(elevatedNode.map { ($0 - 1) / 5 } == s ? 100 : 0)
                            }
                            Color.clear.frame(height: 260)
                        }
                    }
                    .coordinateSpace(name: "pathScroll")
                    .onPreferenceChange(SectionOffsetKey.self) { offsets in
                        updateVisibleSection(offsets, headerHeight: headerHeight)
                    }

                    // ── Sticky header ──
                    header(width: width, topInset: topInset)
                }
                .onAppear {
                    guard !didInitialScroll else { return }
                    didInitialScroll = true
                    if let active = store.activeNode {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            proxy.scrollTo("node-\(active)", anchor: UnitPoint(x: 0.5, y: 0.30))
                        }
                    }
                }
            }
        }
    }

    // MARK: Sticky header

    private func header(width: CGFloat, topInset: CGFloat) -> some View {
        VStack(spacing: 8) {
            metricsBar
                .padding(.horizontal, 24)
                .padding(.leading, showsHomeButton ? 44 : 0)   // clear the home button
            floatingBanner
                .frame(width: width * 0.886)  // widened ~3%
                .padding(.top, 5)              // nudge down a few px
        }
        // The VStack already sits below the safe area — just a hair of breathing
        // room so the stats tuck right under the dynamic island.
        .padding(.top, 6)
        .padding(.bottom, 10)
        // Solid header backing (no gradient) so the stats/banner sit on a flat
        // fill that matches the path background.
        .background(
            theme.palette.base.ignoresSafeArea(edges: .top)
        )
        .overlay(alignment: .topLeading) {
            if showsHomeButton {
                homeButton
                    .padding(.leading, 14)
                    .padding(.top, 6)
            }
        }
    }

    private var metricsBar: some View {
        HStack {
            placeholderButton
            Spacer()
            metric(system: "flame.fill", color: Color(hex: "#FF9500"), value: store.streak)
            Spacer()
            HStack(spacing: 6) {
                TreatIcon(height: 24)
                Text("\(store.treats)").font(Theme.font(18, .heavy)).foregroundColor(theme.palette.ink)
            }
            Spacer()
            Button(action: { Haptics.selection(); onOpenHearts() }) {
                HStack(spacing: 6) {
                    HeartBadge(filled: true, size: 22)
                    if store.isUnlimitedHearts {
                        Image(systemName: "infinity")
                            .font(.system(size: 16, weight: .black))
                            .foregroundColor(theme.palette.ink)
                    } else {
                        Text("\(store.hearts)").font(Theme.font(18, .heavy)).foregroundColor(theme.palette.ink)
                    }
                }
            }
            .buttonStyle(RowPressStyle())
        }
    }

    // Top-left slot — opens the course switcher (like Duolingo's flag).
    private var placeholderButton: some View {
        Button(action: { Haptics.selection(); onOpenCourses() }) {
            Image(systemName: "square.grid.2x2.fill")
                .font(.system(size: 16, weight: .black))
                .foregroundColor(theme.palette.ink)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(theme.palette.muted.opacity(0.35), lineWidth: 1.5))
                )
        }
        .buttonStyle(RowPressStyle())
    }

    private func metric(system: String, color: Color, value: Int) -> some View {
        HStack(spacing: 6) {
            if system == "flame.fill" {
                // Custom-drawn flame instead of the SF Symbol — guarantees the
                // inner layer renders as a lighter orange/yellow, rather than
                // relying on SF Symbols' inconsistent multicolor fallback.
                FlameIcon(outer: color, inner: Color(hex: "#FFD166"), size: 22)
            } else {
                Image(systemName: system).font(.system(size: 22)).foregroundColor(color)
            }
            Text("\(value)").font(Theme.font(18, .heavy)).foregroundColor(theme.palette.ink)
        }
    }

    private var homeButton: some View {
        Button(action: { Haptics.selection(); onHome() }) {
            Image(systemName: "house.fill")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color(hex: "#f8fafc"))
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(hex: "#161616"))
                        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.12), lineWidth: 1))
                )
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.black.opacity(0.55)).offset(y: 4)
                )
        }
        .buttonStyle(SinkButtonStyle(depth: 4))
    }

    private var floatingBanner: some View {
        let sec = store.section(visibleSection) ?? store.sections.first
        let bgc = Color(hex: sec?.bg ?? "#2B70C9")
        let slab = Color(hex: sec?.slab ?? "#0369a1")
        // Tapping the banner opens the level picker (Beginner → Expert).
        return Button(action: { Haptics.selection(); onOpenCourses() }) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(sec?.eyebrow ?? "UNIT 1")
                        .font(Theme.font(11, .heavy)).tracking(1.4)
                        .foregroundColor(Color.white.opacity(0.65))
                    Text(sec?.title ?? "")
                        .font(Theme.font(17, .black)).foregroundColor(.white)
                        .lineLimit(1).minimumScaleFactor(0.7)
                }
                Spacer(minLength: 0)
                Image(systemName: "square.stack.3d.up.fill")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white.opacity(0.85))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 18).padding(.horizontal, 20)   // ~12% taller
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(bgc))
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(slab).offset(y: 5))
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
    }

    // MARK: Section divider

    private func sectionDivider(_ s: Int) -> some View {
        let title = store.section(s)?.title ?? ""
        return HStack(spacing: 12) {
            line
            Text(title)
                .font(Theme.font(17, .heavy))
                .foregroundColor(theme.palette.muted)
                .fixedSize()
            line
        }
        .padding(.horizontal, 20)
        .padding(.top, 32).padding(.bottom, 28)
    }

    private var line: some View {
        Rectangle().fill(theme.palette.ink.opacity(0.14)).frame(height: 1.5).cornerRadius(2)
    }

    // MARK: Section column (nodes + trail)

    private func sectionColumn(_ s: Int, width: CGFloat) -> some View {
        let nodes = store.nodes(inSection: s)
        let count = nodes.count
        let height = CGFloat(count) * vStep

        return ZStack(alignment: .top) {
            sideGems(count: count, width: width, sectionIndex: s)

            ForEach(Array(nodes.enumerated()), id: \.element.num) { i, node in
                nodeButton(node)
                    .id("node-\(node.num)")
                    .offset(x: node.xOffset)
                    .padding(.top, CGFloat(i) * vStep + (vStep / 2) - (nodeSize / 2))
                    .zIndex(elevatedNode == node.num ? 50 : 0)
            }
        }
        .frame(width: width, height: height)
    }

    // MARK: Side decorations (Duolingo-style gems along the path)

    /// One decorative gem every 3rd unit, at a random-looking spot within
    /// that unit — purely cosmetic, independent of the actual node curve.
    /// The "random" position is seeded from the section index so it's stable
    /// across re-renders instead of jumping every time the view redraws.
    @ViewBuilder
    private func sideGems(count: Int, width: CGFloat, sectionIndex: Int) -> some View {
        if count > 0 && sectionIndex % 3 == 0 {
            let gemSize: CGFloat = 40
            let xAmplitude = min(width / 2 - 46, 148)
            var rng = SeededRNG(seed: UInt64(sectionIndex &* 2654435761 &+ 12345))
            let slot = Int(rng.next() % UInt64(count))
            let onRight = rng.next() % 2 == 0

            PathGemDecoration(size: gemSize, tiltDegrees: onRight ? -14 : 14)
                .offset(x: onRight ? xAmplitude : -xAmplitude)
                .padding(.top, CGFloat(slot) * vStep + (vStep / 2) - (gemSize / 2))
        }
    }

    // MARK: Node

    /// Open/close the callout, keeping the node's raised z-order through the
    /// close animation so it doesn't clip behind the node below it.
    private func setTooltip(_ node: Int?) {
        if let n = node { elevatedNode = n }
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { tooltipNode = node }
        if node == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if tooltipNode == nil { elevatedNode = nil }
            }
        }
    }

    private func nodeButton(_ node: PathNode) -> some View {
        let state = store.state(for: node.num)
        let c = store.colors(for: node.num, state: state)

        return ZStack {
            // Animated halo around the lesson you're on. Offset down + tilted
            // into the puck's 3D plane so it looks like it emerges from the
            // button's base rather than floating flat in front of it.
            if state == .active {
                PulseRing(color: c.main, size: nodeSize)
                    .offset(y: 5)
                    .allowsHitTesting(false)
            }

            Button(action: {
                // Locked nodes still open a callout — it just says "Locked".
                if state == .locked { Haptics.rigid() } else { Haptics.selection() }
                setTooltip(tooltipNode == node.num ? nil : node.num)
            }) {
                // Just the face (+ icon + badge); the slab is drawn fixed by the
                // button style so the face sinks onto it on press.
                ZStack {
                    Circle().fill(c.main).frame(width: nodeSize, height: nodeSize)
                        // Glossy shine highlight, like the heart / gem.
                        .overlay(
                            Ellipse()
                                .fill(Color.white.opacity(state == .locked ? 0.16 : 0.42))
                                .frame(width: nodeSize * 0.5, height: nodeSize * 0.26)
                                .rotationEffect(.degrees(-28))
                                .offset(x: -nodeSize * 0.14, y: -nodeSize * 0.18)
                                .blur(radius: 2)
                        )
                        .overlay(
                            Circle().stroke(Color.black.opacity(0.18), lineWidth: 3)
                                .padding(1).mask(
                                    LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom))
                        )
                        .clipShape(Circle())
                }
                .contentShape(Circle())
            }
            .buttonStyle(PuckButtonStyle(slab: c.dark, size: nodeSize))

            // START label only for the very first lesson ever (nothing completed yet).
            if state == .active && store.completed.isEmpty {
                startLabel.offset(y: -(nodeSize / 2) - 22)
            }
        }
        .frame(width: nodeSize, height: nodeSize)
        // Tap callout: title + Start / Continue / Replay button, anchored below.
        .overlay(alignment: .top) {
            if tooltipNode == node.num {
                startTooltip(node, state: state, color: c)
                    .fixedSize()
                    .offset(y: nodeSize + 8)
                    .transition(.scale(scale: 0.85, anchor: .top).combined(with: .opacity))
            }
        }
    }

    private func startTooltip(_ node: PathNode, state: NodeState, color: (main: Color, dark: Color)) -> some View {
        let locked = state == .locked
        let label = locked ? "LOCKED"
            : (store.inProgressNode == node.num ? "CONTINUE"
               : (state == .done ? "REPLAY +25 XP" : "START +100 XP"))
        // Locked callout is greyed: slate card + muted title, matching the node.
        let cardFill = locked ? Color(hex: "#26364A") : Color.white
        let cardStroke = locked ? Color.white.opacity(0.08) : Color.black.opacity(0.07)
        let titleColor = locked ? Color.white.opacity(0.55) : Color(hex: "#0D1C3F")
        return VStack(spacing: 0) {
            Triangle().fill(cardFill)
                .frame(width: 20, height: 11)
                .rotationEffect(.degrees(180))   // point up toward the node
            VStack(spacing: 12) {
                Text(node.title)
                    .font(Theme.font(15, .heavy)).foregroundColor(titleColor)
                    .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                Button(action: {
                    if locked {
                        Haptics.rigid()      // can't start a locked lesson
                    } else {
                        Haptics.selection()
                        setTooltip(nil)
                        onSelectNode(node.num)
                    }
                }) {
                    HStack(spacing: 6) {
                        if locked {
                            Image(systemName: "lock.fill").font(.system(size: 12, weight: .black))
                        }
                        Text(label)
                    }
                }
                .buttonStyle(Chunky3DStyle(fill: color.main, slab: color.dark, depth: 4, radius: 12,
                                           font: Theme.font(14, .black)))
            }
            .padding(18)
            .frame(width: 220)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous).fill(cardFill)
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(cardStroke, lineWidth: 2))
            )
        }
        .shadow(color: .black.opacity(0.25), radius: 14, y: 10)
    }

    private var startLabel: some View {
        VStack(spacing: 0) {
            Text("START")
                .font(Theme.font(13, .black)).tracking(1.2)
                .foregroundColor(Color(hex: "#333333"))
                .padding(.vertical, 5).padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(Color(hex: "#e5e7eb"), lineWidth: 2.5))
                )
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(hex: "#d1d5db")).offset(y: 2)
                )
            Triangle().fill(Color.white)
                .frame(width: 12, height: 7)
                .overlay(Triangle().stroke(Color(hex: "#e5e7eb"), lineWidth: 1))
        }
        .fixedSize()
    }

    // Recolor a parsed icon so white/translucent-white parts follow the node state.
    private func recolored(_ img: SVGImage, to color: Color) -> SVGImage {
        var copy = img
        copy.elements = img.elements.map { el in
            var e = el
            if let f = el.fill, isWhitish(f) { e.fill = color }
            if let s = el.stroke, isWhitish(s) { e.stroke = color }
            return e
        }
        return copy
    }
    private func isWhitish(_ c: Color) -> Bool {
        // Heuristic: treat near-white icon fills/strokes as "the icon color".
        UIColor(c).cgColor.components.map { comps in comps.prefix(3).allSatisfy { $0 > 0.6 } } ?? false
    }

    // MARK: Scroll → visible section

    private func sectionAnchor(_ s: Int) -> some View {
        GeometryReader { g in
            Color.clear.preference(
                key: SectionOffsetKey.self,
                value: [s: g.frame(in: .named("pathScroll")).minY])
        }
    }

    private func updateVisibleSection(_ offsets: [Int: CGFloat], headerHeight: CGFloat) {
        // The visible section is the last one whose top has scrolled above the
        // bottom edge of the sticky header.
        let threshold = headerHeight
        var best = 0
        for s in 0..<store.sectionCount {
            if let y = offsets[s], y <= threshold { best = s }
        }
        if best != visibleSection {
            visibleSection = best
            Haptics.light()
        }
    }
}

// MARK: - Supporting shapes / styles

/// A decorative emerald gem planted beside the path (Duolingo-style side
/// clutter): the same GemShape used for the treats currency icon, given a
/// raised 3D slab, a gentle perspective tilt matching the node pucks, and an
/// in-plane rotation so it leans in toward the path's center line.
private struct PathGemDecoration: View {
    var size: CGFloat
    var tiltDegrees: Double
    @State private var breathe = false

    private let emerald = Color(hex: "#10A868")
    private let emeraldDark = Color(hex: "#0B7A4C")

    var body: some View {
        ZStack {
            GemShape().fill(emeraldDark).offset(y: size * 0.10)
            GemShape()
                .fill(emerald)
                .overlay(
                    GemShape().stroke(Color.white.opacity(0.22), lineWidth: 1.5)
                )
                .overlay(
                    Ellipse()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: size * 0.26, height: size * 0.15)
                        .rotationEffect(.degrees(-28))
                        .offset(x: -size * 0.15, y: -size * 0.22)
                        .blur(radius: 0.3)
                )
        }
        .frame(width: size * 0.92, height: size)
        .modifier(TiltModifier(isPressed: false, base: 20))
        .rotationEffect(.degrees(tiltDegrees))
        .scaleEffect(breathe ? 1.05 : 0.96)
        .opacity(0.92)
        .allowsHitTesting(false)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.6).repeatForever(autoreverses: true)) { breathe = true }
        }
    }
}

/// Halo for the active node: a solid, darker enlarged silhouette sitting
/// behind the whole 3D button (face + slab) that gently breathes in and out —
/// the Duolingo-style "you are here" plate.
private struct PulseRing: View {
    var color: Color
    var size: CGFloat
    @State private var breathe = false

    var body: some View {
        Circle()
            .fill(color.opacity(0.28))
            .frame(width: size + 30, height: size + 30)
            .scaleEffect(breathe ? 1.0 : 0.8)
            // Same perspective tilt as the puck so the plate lies flat under it.
            .modifier(TiltModifier(isPressed: false))
            .onAppear {
                withAnimation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true)) {
                    breathe = true
                }
            }
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
}

/// The circular node puck: a fixed dark slab with the face sinking onto it on
/// press (mirrors the web `.learn-node.is-pressed` translateY + shrinking shadow).
private struct PuckButtonStyle: ButtonStyle {
    var slab: Color
    var size: CGFloat
    var depth: CGFloat = 6
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle().fill(slab).frame(width: size, height: size).offset(y: depth)
            configuration.label
                .offset(y: configuration.isPressed ? depth - 1 : 0)
        }
        .frame(width: size, height: size)
        .modifier(TiltModifier(isPressed: configuration.isPressed))
        .animation(configuration.isPressed
                   ? .easeIn(duration: 0.04)
                   : .spring(response: 0.3, dampingFraction: 0.55),
                   value: configuration.isPressed)
    }
}

private struct SectionOffsetKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}
