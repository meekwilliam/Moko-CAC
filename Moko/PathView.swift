import SwiftUI
import UIKit

extension Color {
    // Memoize: the node gradients call this 5× per puck, every render, and a
    // section change re-renders the whole path. The UIColor↔Color bridge + HSB
    // extraction is surprisingly costly to repeat per frame; the inputs are a
    // handful of fixed unit colors, so a tiny cache makes it free.
    private static var shiftCache: [String: Color] = [:]

    /// Same hue, shifted brightness — for deriving the lighter top / darker
    /// bottom of a 3D surface from one base color.
    func brightnessShifted(_ delta: CGFloat) -> Color {
        let key = "\(self.hashValue):\(delta)"
        if let cached = Color.shiftCache[key] { return cached }
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        UIColor(self).getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        let out = Color(hue: Double(h), saturation: Double(s),
                        brightness: Double(min(1, max(0, b + delta))), opacity: Double(a))
        Color.shiftCache[key] = out
        return out
    }
}

// MARK: - Native learning path (learn map)
// A native re-build of the web #screen-progress: a snaking column of 3D node
// pucks grouped into 9 sections, with a dotted trail, a sticky metrics bar +
// floating section banner, a jump-to-section picker, and a home button.

struct PathView: View {
    @ObservedObject var store: PathStore
    @EnvironmentObject var theme: ThemeManager
    var showsHomeButton: Bool = true    // false when it's the home tab
    var onSelectNode: (Int) -> Void
    var onTestOut: (Int) -> Void = { _ in }
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
    @State private var testOutBob = false

    private let nodeSize: CGFloat = 82
    private let ovalRatio: CGFloat = 0.9      // puck height / width (badge is near-square)
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
                        // Lazy so only on-screen sections build their nodes. A
                        // plain VStack rebuilds every node (54–145 of them) on
                        // any state change — banner recolor, node tap, button
                        // press — which drops frames and reads as lag.
                        LazyVStack(spacing: 0) {
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
        Button(action: {
            guard Game.courses.count > 1 else { return }
            Haptics.selection(); onOpenCourses()
        }) {
            Image(systemName: Game.courses.count > 1 ? "square.grid.2x2.fill" : "chart.xyaxis.line")
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
        return Button(action: {
            guard Game.courses.count > 1 else { return }
            Haptics.selection(); onOpenCourses()
        }) {
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
                if Game.courses.count > 1 {
                    Image(systemName: "square.stack.3d.up.fill")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white.opacity(0.85))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 18).padding(.horizontal, 20)   // ~12% taller
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(bgc))
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 18, depth: 5))
        // Section changes are driven by a scroll preference callback. Never
        // inherit the scroll view's continuous transaction here: interpolating
        // both the face and 3D slab colors forces extra compositing work while
        // the path is already moving. A crisp swap is visually cleaner and
        // keeps the scroll frame lightweight.
        .transaction { transaction in
            transaction.animation = nil
            transaction.disablesAnimations = true
        }
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
        // Extra bottom room: the floating "TEST OUT?" callout on a section's
        // first node reaches ~90pt above the node (card + pointer + bob), and
        // was colliding with this divider's title text — the old 32pt wasn't
        // enough clearance.
        .padding(.top, 44).padding(.bottom, 70)
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
                    .zIndex(tooltipNode == node.num ? 1_000 : (elevatedNodes.contains(node.num) ? 999 : (shouldShowTestOut(for: node) ? 50 : 0)))
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
            // White like every other node symbol; dimmed on a locked node.
            .foregroundColor(.white.opacity(locked ? 0.55 : 1))
    }

    private func nodeButton(_ node: PathNode) -> some View {
        let state = store.state(for: node.num)
        let testOutAvailable = shouldShowTestOut(for: node)
        let visualState: NodeState = testOutAvailable ? .active : state
        let c = store.colors(for: node.num, state: visualState)
        // Every node is a hexagon now (boss included); the boss still reads apart
        // via its crown. The 3D wall uses a shade close to the face color rather
        // than the much-darker unit `dark`, so the lip reads as the same button.
        // Unit 1 uses the bigbutton.svg badge shape and its own blue palette; every
        // other unit keeps the shared badge in its unit color.
        let isUnit1 = node.sectionIndex == 0
        let silhouette = isUnit1 ? AnyShape(Unit1BigButtonBack()) : AnyShape(ButtonBadge())
        let faceSilhouette = isUnit1 ? AnyShape(Unit1BigButtonFace()) : silhouette
        let face = isUnit1 ? Color(hex: "#0091E7") : c.main
        let wall = isUnit1 ? Color(hex: "#007CBF") : c.main.brightnessShifted(-0.15)
        // bigbutton.svg is nearly square (317×331). Do not squash it into the
        // shared puck's 0.78 height ratio—the shared viewBox is part of the
        // supplied silhouette.
        let buttonHeightRatio: CGFloat = isUnit1 ? 331.0 / 317.0 : ovalRatio

        return ZStack {
            if testOutAvailable {
                Button {
                    Haptics.selection()
                    setTooltip(tooltipNode == node.num ? nil : node.num)
                } label: {
                    // Speech-bubble callout in the app's own colors (dark slate
                    // + blue accent), not the unit color: solid fills, a crisp
                    // edge, and a downward pointer to the node. The card and
                    // its pointer share one continuous outline (the pointer
                    // tucks up under the card far enough to hide its own top
                    // edge, so only the seamless V of its two outer sides
                    // shows, unbroken from the card's corners).
                    Text("TEST OUT?")
                        .font(Theme.font(14, .black))
                        .foregroundColor(.white)
                        .fixedSize()          // keep it on one line
                        .padding(.horizontal, 18).padding(.top, 11).padding(.bottom, 20)
                        .background(SpeechBubbleDown().fill(Theme.surfaceRaised))
                        .overlay(SpeechBubbleDown().stroke(Theme.surfaceBorder, lineWidth: 2))
                }
                .buttonStyle(RowPressStyle(scale: 0.94))
                .offset(y: -64 + (testOutBob ? -6 : 6))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
                        testOutBob = true
                    }
                }
                .zIndex(20)
            }
            // Animated halo around the lesson you're on. Offset down + tilted
            // into the puck's 3D plane so it looks like it emerges from the
            // button's base rather than floating flat in front of it.
            if state == .active && !testOutAvailable {
                PulseRing(color: face, size: nodeSize, heightRatio: buttonHeightRatio, shape: silhouette)
                    .offset(y: 5)
                    .allowsHitTesting(false)
            }

            Button(action: {
                if testOutAvailable {
                    Haptics.selection()
                    setTooltip(tooltipNode == node.num ? nil : node.num)
                    return
                }
                // Locked nodes still open a callout — it just says "Locked".
                if state == .locked { Haptics.play(.locked) } else { Haptics.play(.puckPress) }
                setTooltip(tooltipNode == node.num ? nil : node.num)
            }) {
                // Just the face (+ icon + badge); the slab is drawn fixed by the
                // button style so the face sinks onto it on press.
                ZStack {
                    // A coin facing up. The face carries a gentle top-lit
                    // gradient (brighter top, base at the bottom) so it reads as
                    // a domed surface rather than a flat fill — the wall shading
                    // lives in PuckButtonStyle's slab.
                    faceSilhouette
                        .fill(isUnit1 ? AnyShapeStyle(face) : AnyShapeStyle(LinearGradient(
                            colors: [face.brightnessShifted(0.07), face,
                                     face.brightnessShifted(-0.05)],
                            startPoint: .top, endPoint: .bottom)))
                        .frame(width: nodeSize, height: nodeSize * buttonHeightRatio)
                        // Inner bottom shading for a rounded, puffed look.
                        .overlay(
                            faceSilhouette.stroke(Color.black.opacity(isUnit1 ? 0 : 0.20), lineWidth: 4)
                                .padding(1).mask(
                                    LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom))
                        )
                        .clipShape(faceSilhouette)

                    // Completed lessons get a glossy sheen across the top, like
                    // a polished glass badge (reference).
                    if visualState == .done && !isUnit1 {
                        Ellipse()
                            .fill(LinearGradient(
                                colors: [Color.white.opacity(0.55), Color.white.opacity(0.0)],
                                startPoint: .top, endPoint: .bottom))
                            .frame(width: nodeSize * 0.72, height: nodeSize * 0.40)
                            .offset(y: -nodeSize * 0.16)
                            .blur(radius: 3)
                            .clipShape(faceSilhouette)
                            .allowsHitTesting(false)
                    }

                    if node.isBoss {
                        bossCrown(locked: visualState == .locked)
                    } else {
                        tradingNodeIcon(for: node, state: visualState)
                    }
                }
                .frame(width: nodeSize, height: nodeSize)
                .contentShape(silhouette)
            }
            .buttonStyle(PuckButtonStyle(
                slab: wall, size: nodeSize, ovalRatio: buttonHeightRatio,
                depth: isUnit1 ? nodeSize * (41.0 / 331.0) : 10,
                shape: silhouette,
                exactBackShape: isUnit1 ? AnyShape(Unit1BigButtonBack()) : nil
            ))
        }
        .frame(width: nodeSize, height: nodeSize)
        // Tap callout: title + Start / Continue / Replay button, anchored below.
        // Boss (last node of a unit) shows its callout ABOVE, so it stays inside
        // its own section instead of spilling down into the next unit's nodes.
        .overlay(alignment: node.isBoss ? .bottom : .top) {
            if tooltipNode == node.num {
                let anchor: UnitPoint = node.isBoss ? .bottom : .top
                startTooltip(node, state: state, color: c, flipped: node.isBoss)
                    .fixedSize()
                    .offset(y: node.isBoss ? -(nodeSize + 8) : (nodeSize + 8))
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.78, anchor: anchor)
                            .combined(with: .offset(y: node.isBoss ? 10 : -10))
                            .combined(with: .opacity),
                        removal: .scale(scale: 0.92, anchor: anchor)
                            .combined(with: .offset(y: node.isBoss ? 6 : -6))
                            .combined(with: .opacity)
                    ))
            }
        }
    }

    private func shouldShowTestOut(for node: PathNode) -> Bool {
        guard node.sectionIndex > 0,
              store.section(node.sectionIndex)?.testOutEnabled == true,
              let first = store.nodes(inSection: node.sectionIndex).first,
              first.num == node.num else { return false }
        if store.testOutBlockedUnits.contains(node.sectionIndex) { return false }
        if store.testOutRetryUnits.contains(node.sectionIndex) { return true }
        let unitNodes = store.nodes(inSection: node.sectionIndex).map(\.num)
        return unitNodes.allSatisfy { !store.completed.contains($0) }
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

    private func startTooltip(_ node: PathNode, state: NodeState, color: (main: Color, dark: Color),
                              flipped: Bool = false) -> some View {
        let testOut = shouldShowTestOut(for: node)
        let locked = state == .locked && !testOut
        let isRecommendedReview = store.recommendedReviewNodes.contains(node.num)
        let label = testOut ? "SKIP TO UNIT \(node.sectionIndex + 1)"
            : (locked ? "LOCKED"
            : (store.inProgressNode == node.num ? "CONTINUE"
               : (state == .done ? (store.testedOutUnits.contains(node.sectionIndex) ? "TESTED OUT · REPLAY" : "REPLAY +25 XP")
                  : (isRecommendedReview ? "RECOMMENDED REVIEW" : "START +100 XP"))))
        // Locked callout is greyed: slate card + muted title, matching the node.
        let cardFill = locked ? Color(hex: "#26364A") : Color.white
        let cardStroke = locked ? Color.white.opacity(0.08) : Color.black.opacity(0.07)
        let titleColor = locked ? Color.white.opacity(0.55) : Color(hex: "#0D1C3F")
        let pointer = Triangle().fill(cardFill).frame(width: 20, height: 11)
        let card = VStack(spacing: 12) {
                Text(testOut ? "Test out \(store.section(node.sectionIndex)?.title ?? "this unit")" : node.title)
                    .font(Theme.font(15, .heavy)).foregroundColor(titleColor)
                    .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                Button(action: {
                    if testOut {
                        Haptics.selection()
                        setTooltip(nil)
                        onTestOut(node.sectionIndex)
                    } else if locked {
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
        // `flipped` = callout sits ABOVE the node (a unit's last / boss node,
        // so it doesn't spill down into the next unit); pointer faces down.
        return VStack(spacing: 0) {
            if flipped {
                card
                pointer
            } else {
                pointer.rotationEffect(.degrees(180))   // point up toward the node
                card
            }
        }
        .shadow(color: .black.opacity(0.28), radius: 16, y: flipped ? -10 : 10)
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
            // This callback runs during scrolling. Starting the custom haptic
            // engine here can block the same main-thread frame in which the
            // banner colors update, which presents as a small hitch. Section
            // changes are passive scroll feedback, so update state only.
            var transaction = Transaction(animation: nil)
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                visibleSection = best
            }
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
/// The node button silhouette, traced from `button.svg` — a rounded shield /
/// badge (peaked top, tapering to a flat bottom). Drawn in the SVG's 266×266
/// space, then scaled to fill whatever rect it's given.
struct ButtonBadge: Shape {
    func path(in rect: CGRect) -> Path {
        // Bounding box of the SVG face path (the lighter inner shape).
        let box = CGRect(x: -1.18241, y: 5.89519, width: 267.874, height: 238.971)
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: rect.minX + (x - box.minX) / box.width * rect.width,
                    y: rect.minY + (y - box.minY) / box.height * rect.height)
        }
        var p = Path()
        p.move(to: pt(121.512, 10.5072))
        p.addCurve(to: pt(143.997, 10.5071), control1: pt(128.298, 5.89519), control2: pt(137.212, 5.89519))
        p.addLine(to: pt(256.074, 86.6827))
        p.addCurve(to: pt(263.724, 109.786), control1: pt(263.555, 91.7675), control2: pt(266.692, 101.241))
        p.addLine(to: pt(221.475, 231.428))
        p.addCurve(to: pt(202.582, 244.866), control1: pt(218.681, 239.473), control2: pt(211.098, 244.866))
        p.addLine(to: pt(62.9277, 244.866))
        p.addCurve(to: pt(44.0348, 231.428), control1: pt(54.4113, 244.866), control2: pt(46.829, 239.473))
        p.addLine(to: pt(1.78546, 109.786))
        p.addCurve(to: pt(9.43581, 86.6827), control1: pt(-1.18241, 101.241), control2: pt(1.95457, 91.7675))
        p.closeSubpath()
        return p
    }
}

/// The lighter face from bigbutton.svg, mapped in its original shared 317×331
/// viewBox so its position remains exact relative to the darker rear layer.
struct Unit1BigButtonFace: Shape {
    func path(in rect: CGRect) -> Path {
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: rect.minX + x / 317.0 * rect.width,
                    y: rect.minY + y / 331.0 * rect.height)
        }
        var p = Path()
        p.move(to: pt(136.614, 4.82798))
        p.addCurve(to: pt(179.485, 4.82798), control1: pt(150.179, -1.60932), control2: pt(165.92, -1.60933))
        p.addLine(to: pt(287.535, 56.1012))
        p.addCurve(to: pt(316.099, 101.273), control1: pt(304.98, 64.3796), control2: pt(316.099, 81.9635))
        p.addLine(to: pt(316.099, 188.039))
        p.addCurve(to: pt(287.535, 233.211), control1: pt(316.099, 207.349), control2: pt(304.98, 224.932))
        p.addLine(to: pt(179.485, 284.484))
        p.addCurve(to: pt(136.614, 284.484), control1: pt(165.92, 290.921), control2: pt(150.179, 290.921))
        p.addLine(to: pt(28.5643, 233.211))
        p.addCurve(to: pt(-0.0000152588, 188.039), control1: pt(11.119, 224.932), control2: pt(-0.0000152588, 207.349))
        p.addLine(to: pt(-0.0000152588, 101.273))
        p.addCurve(to: pt(28.5643, 56.1013), control1: pt(-0.0000152588, 81.9635), control2: pt(11.119, 64.3796))
        p.closeSubpath()
        return p
    }
}

/// The darker rear path from bigbutton.svg.
struct Unit1BigButtonBack: Shape {
    func path(in rect: CGRect) -> Path {
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: rect.minX + x / 317.0 * rect.width,
                    y: rect.minY + y / 331.0 * rect.height)
        }
        var p = Path()
        p.move(to: pt(136.614, 45.828))
        p.addCurve(to: pt(179.485, 45.828), control1: pt(150.179, 39.3907), control2: pt(165.92, 39.3907))
        p.addLine(to: pt(287.535, 97.1012))
        p.addCurve(to: pt(316.099, 142.273), control1: pt(304.98, 105.38), control2: pt(316.099, 122.963))
        p.addLine(to: pt(316.099, 229.039))
        p.addCurve(to: pt(287.535, 274.211), control1: pt(316.099, 248.349), control2: pt(304.98, 265.932))
        p.addLine(to: pt(179.485, 325.484))
        p.addCurve(to: pt(136.614, 325.484), control1: pt(165.92, 331.921), control2: pt(150.179, 331.921))
        p.addLine(to: pt(28.5643, 274.211))
        p.addCurve(to: pt(-0.0000152588, 229.039), control1: pt(11.119, 265.932), control2: pt(-0.0000152588, 248.349))
        p.addLine(to: pt(-0.0000152588, 142.273))
        p.addCurve(to: pt(28.5643, 97.1013), control1: pt(-0.0000152588, 122.963), control2: pt(11.119, 105.38))
        p.closeSubpath()
        return p
    }
}

struct Hexagon: Shape {
    // Generously rounded: the sharp side points otherwise leave a hard vertical
    // step where the offset-down slab peeks out, reading as a doubled outline.
    // Rounding them makes the side rim taper to nothing like the ellipse coin.
    var cornerRadius: CGFloat = 15

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
    var heightRatio: CGFloat = 0.78
    var shape: AnyShape = AnyShape(Ellipse())
    @State private var breathe = false

    var body: some View {
        shape
            .fill(color.opacity(0.28))
            .frame(width: size + 30, height: size * heightRatio + 30)
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

/// A rounded card with a downward pointer traced as ONE continuous path, so the
/// card and its tail share a single unbroken outline (the tail is cut into the
/// bottom edge rather than stroked as a separate shape). The tail occupies the
/// bottom `tailH` of the frame — give the content that much extra bottom padding.
private struct SpeechBubbleDown: Shape {
    var corner: CGFloat = 15
    var tailW: CGFloat = 18
    var tailH: CGFloat = 9

    func path(in rect: CGRect) -> Path {
        let r = min(corner, (rect.height - tailH) / 2, rect.width / 2)
        let bottom = rect.maxY - tailH
        let midX = rect.midX
        var p = Path()
        p.move(to: CGPoint(x: rect.minX + r, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - r, y: rect.minY))
        p.addArc(center: CGPoint(x: rect.maxX - r, y: rect.minY + r), radius: r,
                 startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        p.addLine(to: CGPoint(x: rect.maxX, y: bottom - r))
        p.addArc(center: CGPoint(x: rect.maxX - r, y: bottom - r), radius: r,
                 startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        p.addLine(to: CGPoint(x: midX + tailW / 2, y: bottom))
        p.addLine(to: CGPoint(x: midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: midX - tailW / 2, y: bottom))
        p.addLine(to: CGPoint(x: rect.minX + r, y: bottom))
        p.addArc(center: CGPoint(x: rect.minX + r, y: bottom - r), radius: r,
                 startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + r))
        p.addArc(center: CGPoint(x: rect.minX + r, y: rect.minY + r), radius: r,
                 startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
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
    var exactBackShape: AnyShape? = nil
    func makeBody(configuration: Configuration) -> some View {
        let h = size * ovalRatio
        return PressSink(isPressed: configuration.isPressed, minDown: 0.05, releaseResponse: 0.2) { down in
            ZStack {
                // The coin's chunky side, offset straight down. Gradient-shaded
                // (lit at the top of the wall, shadowed at the bottom) so the
                // exposed rim reads as a real vertical surface instead of a
                // flat block of colour sitting under the face.
                if let exactBackShape {
                    exactBackShape
                        .fill(slab)
                        .frame(width: size, height: h)
                } else {
                    shape
                        .fill(LinearGradient(
                            colors: [slab.brightnessShifted(0.05), slab.brightnessShifted(-0.08)],
                            startPoint: .top, endPoint: .bottom))
                        .frame(width: size, height: h).offset(y: depth)
                }
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
