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
    // Nodes keep their raised z-order until each callout has fully collapsed.
    // When switching menus, this temporarily contains both nodes so the old
    // callout cannot slide underneath its neighbours on the way out.
    @State private var elevatedNodes: Set<Int> = []
    @State private var tooltipRequest = 0

    private let nodeSize: CGFloat = 82
    private let ovalRatio: CGFloat = 0.78     // puck height / width — a wide coin
    private let vStep: CGFloat = 106          // node center-to-center spacing

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
                                    .zIndex(elevatedSections.contains(s) ? 100 : 0)
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
                .modifier(StatPulse(value: store.streak))
            Spacer()
            HStack(spacing: 6) {
                TreatIcon(height: 24)
                Text("\(store.treats)")
                    .font(Theme.font(18, .heavy))
                    .foregroundColor(theme.palette.ink)
                    .monospacedDigit()
                    .contentTransition(.numericText())
            }
            .modifier(StatPulse(value: store.treats))
            Spacer()
            Button(action: { Haptics.selection(); onOpenHearts() }) {
                HStack(spacing: 6) {
                    HeartBadge(filled: true, size: 22)
                    if store.isUnlimitedHearts {
                        Image(systemName: "infinity")
                            .font(.system(size: 16, weight: .black))
                            .foregroundColor(theme.palette.ink)
                    } else {
                        Text("\(store.hearts)")
                            .font(Theme.font(18, .heavy))
                            .foregroundColor(theme.palette.ink)
                            .monospacedDigit()
                            .contentTransition(.numericText())
                    }
                }
            }
            .buttonStyle(RowPressStyle())
            .modifier(StatPulse(value: store.isUnlimitedHearts ? -1 : store.hearts))
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
                        .fill(Theme.surface)
                        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
                )
        }
        .buttonStyle(RowPressStyle())
    }

    private func metric(system: String, color: Color, value: Int) -> some View {
        // A 0 streak reads as inactive: greyed flame + muted count. No flicker
        // animation on the home screen (only the streak celebration animates).
        let inactive = system == "flame.fill" && value == 0
        return HStack(spacing: 6) {
            if system == "flame.fill" {
                // Custom-drawn flame instead of the SF Symbol — guarantees the
                // inner layer renders as a lighter orange/yellow, rather than
                // relying on SF Symbols' inconsistent multicolor fallback.
                FlameIcon(size: 34, animated: false, greyed: inactive, showsGlow: false)
            } else {
                Image(systemName: system).font(.system(size: 22)).foregroundColor(color)
            }
            Text("\(value)").font(Theme.font(18, .heavy))
                .foregroundColor(inactive ? theme.palette.muted : theme.palette.ink)
                .monospacedDigit()
                .contentTransition(.numericText())
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
                        .fill(Theme.surface)
                        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
                )
        }
        .buttonStyle(SinkButtonStyle(slab: Theme.surfaceSlab, radius: 12, depth: 4))
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
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 18, depth: 5))
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
            ForEach(Array(nodes.enumerated()), id: \.element.num) { i, node in
                nodeButton(node)
                    .id("node-\(node.num)")
                    .offset(x: node.xOffset)
                    .padding(.top, CGFloat(i) * vStep + (vStep / 2) - (nodeSize / 2))
                    .zIndex(tooltipNode == node.num ? 1_000 : (elevatedNodes.contains(node.num) ? 999 : 0))
            }
        }
        .frame(width: width, height: height)
    }

    // MARK: Node

    private var elevatedSections: Set<Int> {
        Set(elevatedNodes.compactMap { node in
            store.nodes.first { $0.num == node }?.sectionIndex
        })
    }

    /// Open or close a callout while preserving every closing card's z-order.
    private func setTooltip(_ node: Int?) {
        let previous = tooltipNode
        tooltipRequest += 1
        let request = tooltipRequest

        guard let node else {
            revealTooltip(nil, replacing: previous)
            return
        }

        if previous != nil {
            // Do not insert one card while another is still crossing nearby
            // nodes. Close the old card, then open the next one above the path.
            revealTooltip(nil, replacing: previous)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.26) {
                guard request == tooltipRequest else { return }
                prepareAndRevealTooltip(node, request: request)
            }
        } else {
            prepareAndRevealTooltip(node, request: request)
        }
    }

    private func prepareAndRevealTooltip(_ node: Int, request: Int) {
        var transaction = Transaction(animation: nil)
        transaction.disablesAnimations = true
        withTransaction(transaction) { elevatedNodes.insert(node) }
        DispatchQueue.main.async {
            guard request == tooltipRequest else { return }
            revealTooltip(node, replacing: nil)
        }
    }

    private func revealTooltip(_ node: Int?, replacing previous: Int?) {
        withAnimation(.spring(response: 0.26, dampingFraction: 0.74)) { tooltipNode = node }
        if let previous, previous != node {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
                if tooltipNode != previous { elevatedNodes.remove(previous) }
            }
        }
    }

    /// Gold crown on the unit's final node. Muted while the node is locked so
    /// it reads as "there's a test here", not "this is available".
    /// Crown sitting on the face of a unit's review-test node. Muted while the
    /// node is locked, so it reads as "there's a test here", not "available".
    private func bossCrown(locked: Bool) -> some View {
        Image(systemName: "crown.fill")
            .font(.system(size: 30, weight: .black))
            .foregroundColor(locked ? Color(hex: "#5c7d96") : Color(hex: "#FFC800"))
    }

    private func nodeButton(_ node: PathNode) -> some View {
        let state = store.state(for: node.num)
        let c = store.colors(for: node.num, state: state)
        // A unit's final lesson is its review test — a hexagon instead of the
        // usual coin, so it reads as a different kind of node at a glance.
        let silhouette: AnyShape = node.isBoss ? AnyShape(Hexagon()) : AnyShape(Ellipse())

        return ZStack {
            // Animated halo around the lesson you're on. Offset down + tilted
            // into the puck's 3D plane so it looks like it emerges from the
            // button's base rather than floating flat in front of it.
            if state == .active {
                PulseRing(color: c.main, size: nodeSize, shape: silhouette)
                    .offset(y: 5)
                    .allowsHitTesting(false)
            }

            Button(action: {
                // Locked nodes still open a callout — it just says "Locked".
                if state == .locked { Haptics.play(.locked) } else { Haptics.play(.puckPress) }
                setTooltip(tooltipNode == node.num ? nil : node.num)
            }) {
                // Just the face (+ icon + badge); the slab is drawn fixed by the
                // button style so the face sinks onto it on press.
                ZStack {
                    // Wide oval (not a perfect circle) so it reads as a coin
                    // facing up, like other gamified apps. Plain fill — no
                    // icon, no shine/gloss.
                    silhouette.fill(c.main).frame(width: nodeSize, height: nodeSize * ovalRatio)
                        // Inner bottom shading for a rounded, puffed look.
                        .overlay(
                            silhouette.stroke(Color.black.opacity(0.20), lineWidth: 4)
                                .padding(1).mask(
                                    LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom))
                        )
                        .clipShape(silhouette)

                    tradingNodeIcon(for: node, state: state)

                    // A unit's review test keeps its crown as a badge, so the
                    // trading icon remains readable on every lesson puck.
                    if node.isBoss {
                        bossCrown(locked: state == .locked)
                            .scaleEffect(0.62)
                            .offset(x: 23, y: -20)
                    }
                }
                .frame(width: nodeSize, height: nodeSize)
                .contentShape(silhouette)
            }
            .buttonStyle(PuckButtonStyle(slab: c.dark, size: nodeSize, ovalRatio: ovalRatio,
                                         shape: silhouette))
        }
        .frame(width: nodeSize, height: nodeSize)
        // Tap callout: title + Start / Continue / Replay button, anchored below.
        .overlay(alignment: .top) {
            if tooltipNode == node.num {
                startTooltip(node, state: state, color: c)
                    .fixedSize()
                    .offset(y: nodeSize + 8)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.78, anchor: .top)
                            .combined(with: .offset(y: -10))
                            .combined(with: .opacity),
                        removal: .scale(scale: 0.92, anchor: .top)
                            .combined(with: .offset(y: -6))
                            .combined(with: .opacity)
                    ))
            }
        }
    }

    private func tradingNodeIcon(for node: PathNode, state: NodeState) -> some View {
        let symbols = [
            "chart.line.uptrend.xyaxis", "chart.bar.xaxis", "arrow.up.right",
            "arrow.down.right", "arrow.left.and.right", "dollarsign.circle",
            "target", "percent", "briefcase.fill", "banknote.fill",
            "arrow.triangle.2.circlepath", "scope", "chart.pie.fill",
            "line.diagonal", "checkmark.seal.fill"
        ]
        let symbol = symbols[(node.num - 1) % symbols.count]
        let color = state == .locked ? Color.white.opacity(0.40) : Color.white.opacity(0.94)

        return Image(systemName: symbol)
            .font(.system(size: 27, weight: .black))
            .foregroundColor(color)
            .frame(width: 40, height: 40)
            .accessibilityHidden(true)
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
                        Haptics.play(.locked)      // can't start a locked lesson
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
        .shadow(color: .black.opacity(0.28), radius: 16, y: 10)
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

/// Halo for the active node: a solid, darker enlarged silhouette sitting
/// behind the whole 3D button (face + slab) that gently breathes in and out —
/// the Duolingo-style "you are here" plate.
/// Flat-topped hexagon with points at the left and right. The flat bottom edge
/// gives the 3D slab a clean seam, the way the ellipse's bottom arc does.
/// Corners are rounded so it sits with the app's soft, chunky geometry rather
/// than reading as a spiky badge.
struct Hexagon: Shape {
    var cornerRadius: CGFloat = 9

    func path(in rect: CGRect) -> Path {
        let inset = rect.width * 0.25   // how far the top/bottom edges pull in
        let pts = [
            CGPoint(x: rect.minX, y: rect.midY),
            CGPoint(x: rect.minX + inset, y: rect.minY),
            CGPoint(x: rect.maxX - inset, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.midY),
            CGPoint(x: rect.maxX - inset, y: rect.maxY),
            CGPoint(x: rect.minX + inset, y: rect.maxY),
        ]
        var p = Path()
        // Walk the corners, arcing between each pair of edges.
        for i in pts.indices {
            let prev = pts[(i + pts.count - 1) % pts.count]
            let corner = pts[i]
            let next = pts[(i + 1) % pts.count]
            if i == 0 {
                p.move(to: CGPoint(x: (prev.x + corner.x) / 2, y: (prev.y + corner.y) / 2))
            }
            p.addArc(tangent1End: corner, tangent2End: next, radius: cornerRadius)
        }
        p.closeSubpath()
        return p
    }
}

private struct PulseRing: View {
    var color: Color
    var size: CGFloat
    var shape: AnyShape = AnyShape(Ellipse())
    @State private var breathe = false

    var body: some View {
        shape
            .fill(color.opacity(0.28))
            .frame(width: size + 30, height: size * 0.78 + 30)
            .scaleEffect(breathe ? 1.0 : 0.8)
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

private struct StatPulse<Value: Equatable>: ViewModifier {
    let value: Value
    @State private var popped = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(popped ? 1.16 : 1.0)
            .animation(.spring(response: 0.24, dampingFraction: 0.62), value: popped)
            .onChange(of: value) { _ in
                popped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                    popped = false
                }
            }
    }
}

/// The circular node puck: a fixed dark slab with the face sinking onto it on
/// press (mirrors the web `.learn-node.is-pressed` translateY + shrinking shadow).
private struct PuckButtonStyle: ButtonStyle {
    var slab: Color
    var size: CGFloat
    var ovalRatio: CGFloat = 0.78
    var depth: CGFloat = 10
    var shape: AnyShape = AnyShape(Ellipse())
    func makeBody(configuration: Configuration) -> some View {
        let h = size * ovalRatio
        return PressSink(isPressed: configuration.isPressed) { down in
            ZStack {
                // Darker base offset straight down — the coin's chunky side
                // (the raised "facing up" look), no perspective tilt needed.
                shape.fill(slab).frame(width: size, height: h).offset(y: depth)
                configuration.label
                    // Full depth on press — the face lands flush on the slab so
                    // there's no visible lip (fully flat/2D). PressSink holds the
                    // down state a minimum time so even an instant tap shows it.
                    .offset(y: down ? depth : 0)
            }
            .frame(width: size, height: size)
        }
    }
}

private struct SectionOffsetKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}
