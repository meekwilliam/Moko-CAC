import SwiftUI
import UIKit

extension Color {
    private static var shiftCache: [String: Color] = [:]

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

struct PathView: View {
    @ObservedObject var store: PathStore
    @EnvironmentObject var theme: ThemeManager
    var showsHomeButton: Bool = true
    var onSelectNode: (Int) -> Void
    var onTestOut: (Int) -> Void = { _ in }
    var onHome: () -> Void
    var onOpenHearts: () -> Void = {}
    var onOpenCourses: () -> Void = {}

    @State private var visibleSection = 0
    @State private var didInitialScroll = false
    @State private var pulse: Bool = false
    @State private var tooltipNode: Int? = nil
    @State private var elevatedNodes: Set<Int> = []
    @State private var tooltipRequest = 0
    @State private var testOutBob = false

    private let nodeSize: CGFloat = 82
    private let ovalRatio: CGFloat = 0.9
    private let vStep: CGFloat = 106

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let topInset = geo.safeAreaInsets.top
            let headerHeight = topInset + 118

            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    ThemedBackground()

                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            Color.clear.frame(height: headerHeight - 8)
                            ForEach(0..<store.sectionCount, id: \.self) { s in
                                if s > 0 {
                                    sectionDivider(s)
                                        .zIndex(-1)
                                }
                                sectionColumn(s, width: width)
                                    .id("sec-\(s)")
                                    .background(sectionAnchor(s))
                                    .zIndex(elevatedSections.contains(s) ? 100 : 0)
                            }
                            Color.clear.frame(height: 260)
                        }
                    }
                    .coordinateSpace(name: "pathScroll")
                    .onPreferenceChange(SectionOffsetKey.self) { offsets in
                        updateVisibleSection(offsets, headerHeight: headerHeight)
                    }

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
                .padding(.leading, showsHomeButton ? 44 : 0)
            floatingBanner
                .frame(width: width * 0.886)
                .padding(.top, 5)
        }
        .padding(.top, 6)
        .padding(.bottom, 10)
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
                    Text("\(store.hearts)")
                        .font(Theme.font(18, .heavy))
                        .foregroundColor(theme.palette.ink)
                        .monospacedDigit()
                        .contentTransition(.numericText())
                }
            }
            .buttonStyle(RowPressStyle())
            .modifier(StatPulse(value: store.hearts))
        }
    }

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
        let inactive = system == "flame.fill" && value == 0
        return HStack(spacing: 6) {
            if system == "flame.fill" {
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
            .padding(.vertical, 18).padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(bgc))
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 18, depth: 5))
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

    private func setTooltip(_ node: Int?) {
        let previous = tooltipNode
        tooltipRequest += 1
        let request = tooltipRequest

        guard let node else {
            revealTooltip(nil, replacing: previous)
            return
        }

        if previous != nil {
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

    private func bossCrown(locked: Bool) -> some View {
        Image(systemName: "crown.fill")
            .font(.system(size: 30, weight: .black))
            .foregroundColor(.white.opacity(locked ? 0.55 : 1))
    }

    private func nodeButton(_ node: PathNode) -> some View {
        let state = store.state(for: node.num)
        let testOutAvailable = shouldShowTestOut(for: node)
        let visualState: NodeState = testOutAvailable ? .active : state
        let c = store.colors(for: node.num, state: visualState)
        let silhouette = AnyShape(BigButtonBack())
        let faceSilhouette = AnyShape(BigButtonFace())
        let face = c.main
        let wall = c.dark
        let buttonHeightRatio: CGFloat = 331.0 / 317.0
        let faceCenterY: CGFloat = (4.82798 + 284.484) / 2
        let iconCenterOffset = (faceCenterY - 331.0 / 2) * (nodeSize / 317.0)

        return ZStack {
            if testOutAvailable {
                Button {
                    Haptics.selection()
                    setTooltip(tooltipNode == node.num ? nil : node.num)
                } label: {
                    Text("TEST OUT?")
                        .font(Theme.font(14, .black))
                        .foregroundColor(.white)
                        .fixedSize()
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
                if state == .locked { Haptics.play(.locked) } else { Haptics.play(.puckPress) }
                setTooltip(tooltipNode == node.num ? nil : node.num)
            }) {
                ZStack {
                    faceSilhouette
                        .fill(face)
                        .frame(width: nodeSize, height: nodeSize * buttonHeightRatio)
                        .clipShape(faceSilhouette)

                    Group {
                        if node.isBoss {
                            bossCrown(locked: visualState == .locked)
                        } else {
                            tradingNodeIcon(for: node, state: visualState)
                        }
                    }
                    .frame(width: 40, height: 40, alignment: .center)
                    .offset(y: iconCenterOffset)
                }
                .frame(width: nodeSize, height: nodeSize)
                .contentShape(silhouette)
            }
            .buttonStyle(PuckButtonStyle(
                slab: wall, size: nodeSize, ovalRatio: buttonHeightRatio,
                depth: nodeSize * (41.0 / 331.0),
                shape: silhouette,
                exactBackShape: AnyShape(BigButtonBack())
            ))
        }
        .frame(width: nodeSize, height: nodeSize)
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
        let symbol = node.symbol ?? symbols[(node.num - 1) % symbols.count]
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
                        Haptics.play(.locked)
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
        return VStack(spacing: 0) {
            if flipped {
                card
                pointer
            } else {
                pointer.rotationEffect(.degrees(180))
                card
            }
        }
        .shadow(color: .black.opacity(0.28), radius: 16, y: flipped ? -10 : 10)
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
        let threshold = headerHeight
        var best = 0
        for s in 0..<store.sectionCount {
            if let y = offsets[s], y <= threshold { best = s }
        }
        if best != visibleSection {
            var transaction = Transaction(animation: nil)
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                visibleSection = best
            }
        }
    }
}

// MARK: - Supporting shapes / styles

struct BigButtonFace: Shape {
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

struct BigButtonBack: Shape {
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
