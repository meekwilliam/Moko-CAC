import SwiftUI

// MARK: - Lesson chart
//
// The course progression is presented as one continuous market chart. Every
// candle is still backed by the existing PathStore, so changing the visual map
// does not change unlocks, replay, boss lessons, test-out, or lesson routing.

struct LessonChartView: View {
    @ObservedObject var store: PathStore
    @EnvironmentObject var theme: ThemeManager

    var showsHomeButton: Bool = true
    var onSelectNode: (Int) -> Void
    var onTestOut: (Int) -> Void = { _ in }
    var onHome: () -> Void
    var onOpenHearts: () -> Void = {}
    var onOpenCourses: () -> Void = {}

    @State private var selectedNode: Int?
    @State private var didInitialScroll = false

    private let candleSlotWidth: CGFloat = 38
    private let canvasHeight: CGFloat = 438
    private let plotTop: CGFloat = 54
    private let plotBottom: CGFloat = 310
    private let volumeTop: CGFloat = 330
    private let volumeBottom: CGFloat = 382

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ThemedBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        header
                            .padding(.top, geometry.safeAreaInsets.top + 6)

                        courseSummary
                        lessonMarket

                        if let selectedNode,
                           let node = store.nodes.first(where: { $0.num == selectedNode }) {
                            unavailableLessonCard(node)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }

                        chartLegend
                        Color.clear.frame(height: 86)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }

    // MARK: Header

    private var header: some View {
        HStack {
            courseButton
            Spacer()
            metric(system: "flame.fill", color: Color(hex: "#FF9500"), value: store.streak)
            Spacer()
            HStack(spacing: 6) {
                TreatIcon(height: 24)
                Text("\(store.treats)")
                    .font(Theme.font(18, .heavy))
                    .foregroundColor(theme.palette.ink)
                    .monospacedDigit()
                    .contentTransition(.numericText())
            }
            Spacer()
            Button {
                Haptics.selection()
                onOpenHearts()
            } label: {
                HStack(spacing: 6) {
                    HeartBadge(filled: true, size: 22)
                    if store.isUnlimitedHearts {
                        Image(systemName: "infinity")
                            .font(.system(size: 16, weight: .black))
                    } else {
                        Text("\(store.hearts)")
                            .font(Theme.font(18, .heavy))
                            .monospacedDigit()
                            .contentTransition(.numericText())
                    }
                }
                .foregroundColor(theme.palette.ink)
            }
            .buttonStyle(RowPressStyle())
        }
        .padding(.horizontal, showsHomeButton ? 44 : 8)
        .overlay(alignment: .leading) {
            if showsHomeButton {
                Button {
                    Haptics.selection()
                    onHome()
                } label: {
                    Image(systemName: "house.fill")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 38, height: 38)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Theme.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .strokeBorder(Theme.surfaceBorder, lineWidth: 1.5)
                                )
                        )
                }
                .buttonStyle(RowPressStyle())
            }
        }
    }

    private var courseButton: some View {
        Button {
            guard Game.courses.count > 1 else { return }
            Haptics.selection()
            onOpenCourses()
        } label: {
            Image(systemName: Game.courses.count > 1 ? "square.grid.2x2.fill" : "chart.xyaxis.line")
                .font(.system(size: 16, weight: .black))
                .foregroundColor(theme.palette.ink)
                .frame(width: 38, height: 38)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Theme.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(Theme.surfaceBorder, lineWidth: 1.5)
                        )
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
                Image(systemName: system)
                    .font(.system(size: 22))
                    .foregroundColor(color)
            }
            Text("\(value)")
                .font(Theme.font(18, .heavy))
                .foregroundColor(inactive ? theme.palette.muted : theme.palette.ink)
                .monospacedDigit()
                .contentTransition(.numericText())
        }
    }

    // MARK: Course summary

    private var courseSummary: some View {
        let completedCount = store.nodes.filter { store.completed.contains($0.num) }.count
        let progress = store.totalNodes == 0 ? 0 : Double(completedCount) / Double(store.totalNodes)
        let focusNode = selectedNode.flatMap { number in store.nodes.first { $0.num == number } }
            ?? store.nodes.first { $0.num == store.activeNode }
            ?? store.nodes.last
        let section = focusNode.flatMap { store.section($0.sectionIndex) }

        return VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("LESSON MARKET")
                        .font(Theme.font(11, .heavy))
                        .tracking(1.5)
                        .foregroundColor(Color(hex: section?.bg ?? "#38BDF8"))
                    Text("Order Flow")
                        .font(Theme.font(26, .black))
                        .foregroundColor(theme.palette.ink)
                    Text("Each candle is one lesson. Tap the current candle to continue.")
                        .font(Theme.bodyFont(14))
                        .foregroundColor(theme.palette.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 8)
                Text("\(completedCount)/\(store.totalNodes)")
                    .font(Theme.font(18, .black))
                    .foregroundColor(theme.palette.ink)
                    .monospacedDigit()
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule().fill(Theme.slotFill)
                    Capsule()
                        .fill(Color(hex: section?.bg ?? "#38BDF8"))
                        .frame(width: max(8, geometry.size.width * progress))
                }
            }
            .frame(height: 8)

            HStack(spacing: 8) {
                Text(section?.eyebrow ?? "UNIT 1")
                    .font(Theme.font(11, .heavy))
                    .tracking(1)
                Text(section?.title ?? "Foundations")
                    .font(Theme.questionFont(13))
                    .lineLimit(1)
            }
            .foregroundColor(theme.palette.muted)
        }
        .padding(18)
        .background(chartCardBackground)
    }

    // MARK: Interactive chart

    private var lessonMarket: some View {
        let candles = marketCandles
        let bounds = priceBounds(for: candles)

        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("COURSE CHART")
                        .font(Theme.font(12, .heavy))
                        .tracking(1.2)
                        .foregroundColor(theme.palette.muted)
                    Text("Swipe to explore all \(store.totalNodes) lessons")
                        .font(Theme.bodyFont(13))
                        .foregroundColor(theme.palette.muted)
                }
                Spacer()
                HStack(spacing: 5) {
                    Circle().fill(Color(hex: "#22C55E")).frame(width: 7, height: 7)
                    Text("LIVE")
                        .font(Theme.font(10, .heavy))
                        .tracking(1)
                        .foregroundColor(Color(hex: "#22C55E"))
                }
            }

            ScrollViewReader { proxy in
                ZStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        chartCanvas(candles: candles, bounds: bounds)
                    }
                    .scrollClipDisabled()

                    priceAxis(bounds: bounds)
                        .allowsHitTesting(false)
                }
                .frame(height: canvasHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .onAppear {
                    guard !didInitialScroll else { return }
                    didInitialScroll = true
                    let resumableNode = store.inProgressNode.flatMap { number in
                        store.completed.contains(number) ? nil : number
                    }
                    let target = resumableNode ?? store.activeNode ?? store.nodes.last?.num
                    guard let target else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        proxy.scrollTo("lesson-candle-\(target)", anchor: .center)
                    }
                }
                .onChange(of: store.activeNode) { active in
                    guard let active else { return }
                    withAnimation(.easeInOut(duration: 0.28)) {
                        proxy.scrollTo("lesson-candle-\(active)", anchor: .center)
                    }
                }
            }
        }
        .padding(14)
        .background(chartCardBackground)
    }

    private func chartCanvas(candles: [LessonMarketCandle], bounds: PriceBounds) -> some View {
        let contentWidth = max(candleSlotWidth * CGFloat(candles.count), 320)
        return ZStack(alignment: .topLeading) {
            chartGrid(width: contentWidth, bounds: bounds)

            HStack(spacing: 0) {
                ForEach(candles) { candle in
                    candleColumn(candle, bounds: bounds)
                        .frame(width: candleSlotWidth, height: canvasHeight)
                        .id("lesson-candle-\(candle.node.num)")
                }
            }
        }
        .frame(width: contentWidth, height: canvasHeight)
        .background(Color(hex: "#101B22"))
    }

    private func chartGrid(width: CGFloat, bounds: PriceBounds) -> some View {
        ZStack(alignment: .topLeading) {
            ForEach(0..<5, id: \.self) { index in
                let y = plotTop + (plotBottom - plotTop) * CGFloat(index) / 4
                Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
                .stroke(Color.white.opacity(0.075), style: StrokeStyle(lineWidth: 1, dash: [4, 5]))
            }

            ForEach(Array(stride(from: 0, to: store.totalNodes, by: 5)), id: \.self) { index in
                let x = CGFloat(index) * candleSlotWidth
                Path { path in
                    path.move(to: CGPoint(x: x, y: plotTop))
                    path.addLine(to: CGPoint(x: x, y: volumeBottom))
                }
                .stroke(Color.white.opacity(0.045), lineWidth: 1)
            }

            Rectangle()
                .fill(Color.white.opacity(0.08))
                .frame(width: width, height: 1)
                .offset(y: volumeTop - 10)

            if let last = marketCandles.last {
                let y = priceY(last.close, bounds: bounds)
                Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
                .stroke(Color(hex: "#38BDF8").opacity(0.34), style: StrokeStyle(lineWidth: 1, dash: [3, 4]))
            }
        }
        .frame(width: width, height: canvasHeight)
    }

    private func candleColumn(_ candle: LessonMarketCandle, bounds: PriceBounds) -> some View {
        let node = candle.node
        let state = store.state(for: node.num)
        let testOut = shouldShowTestOut(for: node)
        let isCurrent = state == .active && !testOut
        let isLocked = state == .locked && !testOut
        let marketColor = candle.isBullish ? Color(hex: "#22C55E") : Color(hex: "#F43F5E")
        let stateOpacity: Double = isLocked ? 0.24 : (state == .done ? 0.72 : 1)
        let highY = priceY(candle.high, bounds: bounds)
        let lowY = priceY(candle.low, bounds: bounds)
        let openY = priceY(candle.open, bounds: bounds)
        let closeY = priceY(candle.close, bounds: bounds)
        let bodyTop = min(openY, closeY)
        let bodyHeight = max(5, abs(closeY - openY))
        let volumeHeight = (volumeBottom - volumeTop) * CGFloat(candle.volume / 1_000)
        let isUnitStart = store.nodes(inSection: node.sectionIndex).first?.num == node.num

        return Button {
            handleTap(node)
        } label: {
            ZStack(alignment: .top) {
                if isUnitStart {
                    Rectangle()
                        .fill(Color.white.opacity(node.sectionIndex == 0 ? 0 : 0.13))
                        .frame(width: 1, height: volumeBottom - 8)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("U\(node.sectionIndex + 1)")
                        .font(Theme.font(10, .black))
                        .foregroundColor(Color(hex: store.section(node.sectionIndex)?.bg ?? "#38BDF8"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                        .offset(y: 12)
                }

                if isCurrent || testOut {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(hex: "#38BDF8").opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .strokeBorder(Color(hex: "#38BDF8").opacity(0.72), lineWidth: 1.5)
                        )
                        .padding(.horizontal, 3)
                        .padding(.vertical, 42)
                }

                Rectangle()
                    .fill(marketColor.opacity(stateOpacity))
                    .frame(width: 2, height: max(2, lowY - highY))
                    .position(x: candleSlotWidth / 2, y: (highY + lowY) / 2)

                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(marketColor.opacity(stateOpacity))
                    .overlay(
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .strokeBorder(Color.white.opacity(isCurrent ? 0.72 : 0), lineWidth: 1)
                    )
                    .frame(width: 18, height: bodyHeight)
                    .position(x: candleSlotWidth / 2, y: bodyTop + bodyHeight / 2)

                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(marketColor.opacity(isLocked ? 0.12 : 0.30))
                    .frame(width: 18, height: max(2, volumeHeight))
                    .position(x: candleSlotWidth / 2, y: volumeBottom - volumeHeight / 2)

                if node.isBoss {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 10, weight: .black))
                        .foregroundColor(isLocked ? Color.white.opacity(0.24) : Color(hex: "#FBBF24"))
                        .position(x: candleSlotWidth / 2, y: max(plotTop + 5, highY - 10))
                }

                statusMarker(for: candle, state: state, testOut: testOut)
                    .position(x: candleSlotWidth / 2, y: 413)
            }
            .frame(width: candleSlotWidth, height: canvasHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(RowPressStyle(scale: 0.92))
        .accessibilityLabel(accessibilityLabel(for: node, state: state, testOut: testOut))
        .accessibilityHint(isLocked ? "Complete the earlier lessons to unlock it." : "Opens this lesson.")
    }

    @ViewBuilder
    private func statusMarker(for candle: LessonMarketCandle, state: NodeState, testOut: Bool) -> some View {
        if testOut {
            Text("TEST")
                .font(Theme.font(8, .black))
                .tracking(0.4)
                .foregroundColor(Color(hex: "#38BDF8"))
        } else if store.completed.contains(candle.node.num) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color(hex: "#38BDF8"))
        } else if state == .active {
            Image(systemName: "play.circle.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#38BDF8"))
        } else {
            Image(systemName: "lock.fill")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.white.opacity(0.22))
        }
    }

    private func priceAxis(bounds: PriceBounds) -> some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                colors: [Color(hex: "#101B22"), Color(hex: "#101B22").opacity(0)],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: 47, height: canvasHeight)

            ForEach(0..<5, id: \.self) { index in
                let ratio = Double(index) / 4
                let value = bounds.maximum - ((bounds.maximum - bounds.minimum) * ratio)
                Text(value.formatted(.number.precision(.fractionLength(1))))
                    .font(.system(size: 9, weight: .semibold, design: .monospaced))
                    .foregroundColor(Color.white.opacity(0.48))
                    .offset(x: 5, y: plotTop + (plotBottom - plotTop) * CGFloat(index) / 4 - 6)
            }
        }
        .frame(width: 47, height: canvasHeight, alignment: .leading)
    }

    // MARK: Selection and test-out

    private func handleTap(_ node: PathNode) {
        let state = store.state(for: node.num)
        if shouldShowTestOut(for: node) {
            Haptics.selection()
            withAnimation(.easeInOut(duration: 0.2)) { selectedNode = node.num }
            return
        }

        if state == .locked {
            Haptics.play(.locked)
            withAnimation(.easeInOut(duration: 0.2)) { selectedNode = node.num }
        } else {
            Haptics.play(.puckPress)
            selectedNode = nil
            onSelectNode(node.num)
        }
    }

    private func unavailableLessonCard(_ node: PathNode) -> some View {
        let testOut = shouldShowTestOut(for: node)
        let sectionTitle = store.section(node.sectionIndex)?.title ?? "Unit \(node.sectionIndex + 1)"
        let colors = store.colors(for: node.num, state: testOut ? .active : .locked)

        return VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: testOut ? "forward.end.fill" : "lock.fill")
                    .font(.system(size: 17, weight: .black))
                    .foregroundColor(testOut ? colors.main : theme.palette.muted)
                    .frame(width: 38, height: 38)
                    .background(Circle().fill((testOut ? colors.main : Theme.surfaceMuted).opacity(0.18)))
                VStack(alignment: .leading, spacing: 4) {
                    Text(testOut ? "Test out \(sectionTitle)" : node.title)
                        .font(Theme.font(16, .black))
                        .foregroundColor(theme.palette.ink)
                    Text(testOut
                         ? "Pass the challenge to skip to Unit \(node.sectionIndex + 1)."
                         : "Complete the earlier candles to unlock this lesson.")
                        .font(Theme.bodyFont(13))
                        .foregroundColor(theme.palette.muted)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation(.easeInOut(duration: 0.18)) { selectedNode = nil }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(theme.palette.muted)
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(RowPressStyle())
            }

            if testOut {
                Button {
                    Haptics.selection()
                    selectedNode = nil
                    onTestOut(node.sectionIndex)
                } label: {
                    Text("SKIP TO UNIT \(node.sectionIndex + 1)")
                        .font(Theme.font(13, .black))
                        .tracking(0.5)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(colors.main)
                        )
                }
                .buttonStyle(RowPressStyle())
            }
        }
        .padding(16)
        .background(chartCardBackground)
    }

    private var chartLegend: some View {
        HStack(spacing: 18) {
            legendItem(icon: "checkmark.circle.fill", color: Color(hex: "#38BDF8"), label: "Complete")
            legendItem(icon: "play.circle.fill", color: Color(hex: "#38BDF8"), label: "Current")
            legendItem(icon: "lock.fill", color: Color.white.opacity(0.32), label: "Locked")
            legendItem(icon: "crown.fill", color: Color(hex: "#FBBF24"), label: "Boss")
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
    }

    private func legendItem(icon: String, color: Color, label: String) -> some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(Theme.bodyFont(10))
                .foregroundColor(theme.palette.muted)
        }
    }

    private var chartCardBackground: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(Theme.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(Theme.surfaceBorder.opacity(0.72), lineWidth: 1)
            )
    }

    // MARK: Chart data

    private var marketCandles: [LessonMarketCandle] {
        var priorClose = 100.0
        return store.nodes.enumerated().map { index, node in
            let i = Double(index)
            let gap = sin(i * 0.61) * 0.13
            let regime = [0.14, 0.06, -0.08, 0.16, -0.04, 0.10, -0.02, 0.13, -0.07, 0.08][node.sectionIndex % 10]
            let change = sin(i * 1.17) * 0.62 + cos(i * 0.43) * 0.31 + regime
            let open = priorClose + gap
            let close = open + change
            let wickTop = 0.28 + Double((index * 7) % 5) * 0.07
            let wickBottom = 0.24 + Double((index * 3) % 4) * 0.08
            let high = max(open, close) + wickTop
            let low = min(open, close) - wickBottom
            let volume = min(1_000, 330 + abs(change) * 390 + Double((index * 83) % 230))
            priorClose = close
            return LessonMarketCandle(node: node, open: open, high: high, low: low,
                                      close: close, volume: volume)
        }
    }

    private func priceBounds(for candles: [LessonMarketCandle]) -> PriceBounds {
        guard let low = candles.map(\.low).min(), let high = candles.map(\.high).max() else {
            return PriceBounds(minimum: 95, maximum: 105)
        }
        let padding = max(0.8, (high - low) * 0.08)
        return PriceBounds(minimum: low - padding, maximum: high + padding)
    }

    private func priceY(_ value: Double, bounds: PriceBounds) -> CGFloat {
        let range = max(0.001, bounds.maximum - bounds.minimum)
        let normalized = (bounds.maximum - value) / range
        return plotTop + CGFloat(normalized) * (plotBottom - plotTop)
    }

    private func shouldShowTestOut(for node: PathNode) -> Bool {
        guard node.sectionIndex > 0,
              store.section(node.sectionIndex)?.testOutEnabled == true,
              store.nodes(inSection: node.sectionIndex).first?.num == node.num else { return false }
        if store.testOutBlockedUnits.contains(node.sectionIndex) { return false }
        if store.testOutRetryUnits.contains(node.sectionIndex) { return true }
        return store.nodes(inSection: node.sectionIndex)
            .allSatisfy { !store.completed.contains($0.num) }
    }

    private func accessibilityLabel(for node: PathNode, state: NodeState, testOut: Bool) -> String {
        if testOut { return "Test out Unit \(node.sectionIndex + 1), \(node.title)" }
        if state == .locked { return "Locked lesson \(node.num), \(node.title)" }
        if state == .done { return "Completed lesson \(node.num), \(node.title)" }
        return "Current lesson \(node.num), \(node.title)"
    }
}

private struct LessonMarketCandle: Identifiable {
    let node: PathNode
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double

    var id: Int { node.num }
    var isBullish: Bool { close >= open }
}

private struct PriceBounds {
    let minimum: Double
    let maximum: Double
}
