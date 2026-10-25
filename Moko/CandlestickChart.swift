import SwiftUI
import Combine

// MARK: - Candlestick chart

struct Candle: Equatable {
    var open: Double
    var high: Double
    var low: Double
    var close: Double

    var isBullish: Bool { close >= open }
}

struct CandlestickChart: View {
    var candles: [Candle]
    var supportLevel: Double? = nil
    var resistanceLevel: Double? = nil
    var highlightIndex: Int? = nil

    var maLine: [Double]? = nil
    var maLineLabel: String = "MA"
    var maLine2: [Double]? = nil
    var maLine2Label: String = "Fast MA"

    var bandUpper: [Double]? = nil
    var bandLower: [Double]? = nil
    var bandLabel: String = "BANDS"

    var chosenIndex: Int? = nil
    var revealTarget: Int? = nil
    var chosenSet: Set<Int> = []
    var revealTargets: Set<Int>? = nil
    var onTapCandle: ((Int) -> Void)? = nil
    var showsAxes: Bool = false
    var showsGrid: Bool = false

    var fixedRange: (lo: Double, hi: Double)? = nil

    var xLabels: [String]? = nil

    private let bullish = Color(hex: "#3FB77E")
    private let bearish = Color(hex: "#E15C5C")
    private let selectBlue = Theme.answer
    private let gridColor = Color(hex: "#2A3649")
    private let axisText = Color(hex: "#7C8AA0")

    private struct ValueMapper {
        let lo: Double
        let range: Double
        let height: CGFloat
        func y(_ v: Double) -> CGFloat { height * (1 - CGFloat((v - lo) / range)) }
        func value(_ y: CGFloat) -> Double { lo + Double(1 - y / height) * range }
    }

    private func mapper(height: CGFloat) -> ValueMapper {
        if let r = fixedRange {
            return ValueMapper(lo: r.lo, range: max(r.hi - r.lo, 0.0001), height: height)
        }
        let values = candles.flatMap { [$0.high, $0.low] } + [supportLevel, resistanceLevel].compactMap { $0 }
            + (maLine ?? []) + (maLine2 ?? []) + (bandUpper ?? []) + (bandLower ?? [])
        let maxV = values.max() ?? 1
        let minV = values.min() ?? 0
        let pad = max(maxV - minV, 0.0001) * 0.1
        let hi = maxV + pad, lo = minV - pad
        return ValueMapper(lo: lo, range: max(hi - lo, 0.0001), height: height)
    }

    var body: some View {
        GeometryReader { geo in
            let leftG: CGFloat = showsAxes ? 34 : 0
            let botG: CGFloat = showsAxes ? 15 : 0
            let plotW = geo.size.width - leftG
            let plotH = geo.size.height - botG
            let m = mapper(height: plotH)
            let n = max(candles.count, 1)
            let slot = plotW / CGFloat(n)
            let bodyWidth = slot * 0.55

            ZStack(alignment: .topLeading) {
                if showsAxes || showsGrid {
                    gridAndAxes(m: m, n: n, leftG: leftG, plotW: plotW, plotH: plotH)
                }

                ForEach(Array(candles.enumerated()), id: \.offset) { i, c in
                    let cx = leftG + slot * (CGFloat(i) + 0.5)
                    let color = c.isBullish ? bullish : bearish
                    let dimmed = highlightIndex != nil && highlightIndex != i

                    let top = m.y(max(c.open, c.close))
                    let bottom = m.y(min(c.open, c.close))
                    Path { p in
                        p.addRect(CGRect(x: cx - 0.75, y: m.y(c.high),
                                         width: 1.5, height: max(m.y(c.low) - m.y(c.high), 0)))
                        p.addRoundedRect(
                            in: CGRect(x: cx - bodyWidth / 2, y: top,
                                      width: bodyWidth, height: max(bottom - top, 2)),
                            cornerSize: CGSize(width: 3.5, height: 3.5))
                    }
                    .fill(color)
                    .opacity(dimmed ? 0.3 : 1)
                }

                if let s = supportLevel { levelLine(y: m.y(s), label: "Support", color: bullish, x0: leftG, x1: geo.size.width) }
                if let r = resistanceLevel { levelLine(y: m.y(r), label: "Resistance", color: bearish, x0: leftG, x1: geo.size.width) }
                if let upper = bandUpper, let lower = bandLower { bollingerBand(upper, lower, slot: slot, x0: leftG, mapper: m) }
                if let line = maLine { overlayLine(line, slot: slot, x0: leftG, mapper: m, color: Color(hex: "#F59E0B"), label: maLineLabel) }
                if let line = maLine2 { overlayLine(line, slot: slot, x0: leftG, mapper: m, color: Color(hex: "#38bdf8"), label: maLine2Label) }

                if onTapCandle != nil || chosenIndex != nil || revealTarget != nil
                    || !chosenSet.isEmpty || revealTargets != nil {
                    ForEach(candles.indices, id: \.self) { i in
                        let cx = leftG + slot * (CGFloat(i) + 0.5)
                        ringColor(for: i).map { ring in
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .strokeBorder(ring, lineWidth: 2.5)
                                .frame(width: slot * 0.86, height: plotH - 4)
                                .position(x: cx, y: plotH / 2)
                        }
                        Rectangle()
                            .fill(Color.white.opacity(0.001))
                            .frame(width: slot, height: plotH)
                            .position(x: cx, y: plotH / 2)
                            .onTapGesture { onTapCandle?(i) }
                    }
                }
            }
        }
    }

    // MARK: Grid + axes (display charts only)

    private func gridAndAxes(m: ValueMapper, n: Int, leftG: CGFloat, plotW: CGFloat, plotH: CGFloat) -> some View {
        let rows = 4
        return ZStack(alignment: .topLeading) {
            ForEach(0...rows, id: \.self) { r in
                let y = plotH * CGFloat(r) / CGFloat(rows)
                Path { p in p.move(to: CGPoint(x: leftG, y: y)); p.addLine(to: CGPoint(x: leftG + plotW, y: y)) }
                    .stroke(gridColor.opacity(0.4), lineWidth: 1)
                if showsAxes {
                    Text(String(format: "%.1f", m.value(y)))
                        .font(Theme.font(8, .bold)).foregroundColor(axisText)
                        .frame(width: leftG - 5, alignment: .trailing)
                        .position(x: (leftG - 5) / 2, y: y)
                }
            }
            ForEach(0..<n, id: \.self) { i in
                let cx = leftG + plotW * (CGFloat(i) + 0.5) / CGFloat(n)
                Path { p in p.move(to: CGPoint(x: cx, y: 0)); p.addLine(to: CGPoint(x: cx, y: plotH)) }
                    .stroke(gridColor.opacity(0.4), lineWidth: 1)
                let label = xLabels.flatMap { $0.indices.contains(i) ? $0[i] : nil } ?? "\(i + 1)"
                if showsAxes && !label.isEmpty {
                    Text(label)
                        .font(Theme.font(8, .bold)).foregroundColor(axisText)
                        .fixedSize()
                        .position(x: cx, y: plotH + 8)
                }
            }
        }
    }

    private let missOrange = Color(hex: "#F59E0B")

    private func ringColor(for i: Int) -> Color? {
        if let targets = revealTargets {
            let isTarget = targets.contains(i)
            let isChosen = chosenSet.contains(i)
            if isTarget && isChosen { return bullish }
            if isTarget && !isChosen { return missOrange }
            if !isTarget && isChosen { return bearish }
            return nil
        }
        if !chosenSet.isEmpty { return chosenSet.contains(i) ? selectBlue : nil }
        if let target = revealTarget {
            if i == target { return bullish }
            if i == chosenIndex { return bearish }
            return nil
        }
        return i == chosenIndex ? selectBlue : nil
    }

    private func pill(_ label: String, color: Color) -> some View {
        Text(label.uppercased())
            .font(Theme.font(9, .black))
            .foregroundColor(.white)
            .padding(.horizontal, 6).padding(.vertical, 3)
            .background(
                Capsule().fill(color)
                    .overlay(Capsule().strokeBorder(Color.white.opacity(0.25), lineWidth: 1))
                    .background(Capsule().fill(Color.black.opacity(0.45)).offset(y: 2.5))
            )
    }

    private func levelLine(y: CGFloat, label: String, color: Color, x0: CGFloat, x1: CGFloat) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                p.move(to: CGPoint(x: x0, y: y))
                p.addLine(to: CGPoint(x: x1, y: y))
            }
            .stroke(color.opacity(0.6), style: StrokeStyle(lineWidth: 1.5, dash: [5, 4]))

            pill(label, color: color).offset(x: -4, y: y - 20)
        }
    }

    private func overlayLine(_ values: [Double], slot: CGFloat, x0: CGFloat, mapper m: ValueMapper,
                              color: Color, label: String) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                for (i, v) in values.enumerated() {
                    let pt = CGPoint(x: x0 + slot * (CGFloat(i) + 0.5), y: m.y(v))
                    if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
                }
            }
            .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

            if let last = values.last {
                pill(label, color: color).offset(x: -4, y: m.y(last) - 20)
            }
        }
    }

    private let bandColor = Color(hex: "#A78BFA")
    private func bollingerBand(_ upper: [Double], _ lower: [Double], slot: CGFloat, x0: CGFloat, mapper m: ValueMapper) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                guard !upper.isEmpty else { return }
                for (i, v) in upper.enumerated() {
                    let pt = CGPoint(x: x0 + slot * (CGFloat(i) + 0.5), y: m.y(v))
                    if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
                }
                for i in stride(from: lower.count - 1, through: 0, by: -1) {
                    p.addLine(to: CGPoint(x: x0 + slot * (CGFloat(i) + 0.5), y: m.y(lower[i])))
                }
                p.closeSubpath()
            }
            .fill(bandColor.opacity(0.10))

            overlayLineStroke(upper, slot: slot, x0: x0, mapper: m, color: bandColor.opacity(0.7))
            overlayLineStroke(lower, slot: slot, x0: x0, mapper: m, color: bandColor.opacity(0.7))

            if let last = upper.last {
                pill(bandLabel, color: bandColor).offset(x: -4, y: m.y(last) - 20)
            }
        }
    }

    private func overlayLineStroke(_ values: [Double], slot: CGFloat, x0: CGFloat, mapper m: ValueMapper, color: Color) -> some View {
        Path { p in
            for (i, v) in values.enumerated() {
                let pt = CGPoint(x: x0 + slot * (CGFloat(i) + 0.5), y: m.y(v))
                if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
            }
        }
        .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round, dash: [4, 3]))
    }
}

// MARK: - Scenario presets

enum ChartScenario: String {
    case uptrend, downtrend, sideways
    case doji, rejectionWickDown, rejectionWickUp
    case supportBounce, resistanceRejection, breakout, breakdown
    case hammer, shootingStar, bullishEngulfing, bearishEngulfing, spinningTop, marubozu
    case hangingMan, invertedHammer
    case doubleTop, doubleBottom, pullbackUptrend, lowerHighsDowntrend
    case headShoulders, inverseHeadShoulders
    case ascendingTriangle, descendingTriangle, symmetricalTriangle
    case bullFlag, bearFlag
    case risingWedge, fallingWedge
    case range, breakoutRetest, breakdownRetest
    case gapUp, gapDown
    case volatile
    case priceAboveMA, priceBelowMA
    case priceAboveVWAP, priceBelowVWAP
    case maCrossUp, maCrossDown
    case bandsWidening, bandsNarrowing
    case touchUpperBand, touchLowerBand
    case ascendingChannel, descendingChannel

    var maLabel: String {
        switch self {
        case .priceAboveVWAP, .priceBelowVWAP: return "VWAP"
        default: return "MA"
        }
    }

    var candles: [Candle] {
        switch self {
        case .uptrend:
            return [
                Candle(open: 10, high: 12, low: 9.5, close: 11.5),
                Candle(open: 11.5, high: 13, low: 11, close: 12.5),
                Candle(open: 12.5, high: 13.5, low: 12, close: 13),
                Candle(open: 13, high: 15, low: 12.8, close: 14.5),
                Candle(open: 14.5, high: 16, low: 14, close: 15.5),
            ]
        case .downtrend:
            return [
                Candle(open: 16, high: 16.5, low: 14, close: 14.5),
                Candle(open: 14.5, high: 15, low: 13, close: 13.3),
                Candle(open: 13.3, high: 13.6, low: 12, close: 12.2),
                Candle(open: 12.2, high: 12.5, low: 10.5, close: 11),
                Candle(open: 11, high: 11.3, low: 9.5, close: 9.8),
            ]
        case .sideways:
            return [
                Candle(open: 12, high: 13, low: 11.5, close: 12.4),
                Candle(open: 12.4, high: 13.1, low: 11.7, close: 12.0),
                Candle(open: 12.0, high: 12.9, low: 11.4, close: 12.6),
                Candle(open: 12.6, high: 13.0, low: 11.6, close: 12.1),
                Candle(open: 12.1, high: 12.8, low: 11.5, close: 12.3),
            ]
        case .doji:
            return [
                Candle(open: 11, high: 12, low: 10, close: 11.5),
                Candle(open: 12.5, high: 14.5, low: 10.5, close: 12.6),
                Candle(open: 12.3, high: 13, low: 11.5, close: 12.0),
            ]
        case .rejectionWickDown:
            return [
                Candle(open: 13, high: 13.3, low: 12.5, close: 13.1),
                Candle(open: 12.9, high: 13.2, low: 9.5, close: 12.8),
                Candle(open: 13, high: 14, low: 12.8, close: 13.8),
            ]
        case .rejectionWickUp:
            return [
                Candle(open: 12, high: 12.3, low: 11.5, close: 11.9),
                Candle(open: 12.1, high: 15.5, low: 11.9, close: 12.2),
                Candle(open: 12, high: 12.2, low: 10.8, close: 11.0),
            ]
        case .supportBounce:
            return [
                Candle(open: 13, high: 13.2, low: 11.2, close: 11.5),
                Candle(open: 11.5, high: 11.8, low: 10.1, close: 10.3),
                Candle(open: 10.3, high: 10.6, low: 10.0, close: 10.5),
                Candle(open: 10.5, high: 11.8, low: 10.3, close: 11.6),
                Candle(open: 11.6, high: 13, low: 11.4, close: 12.7),
            ]
        case .resistanceRejection:
            return [
                Candle(open: 9, high: 11, low: 8.8, close: 10.7),
                Candle(open: 10.7, high: 13.9, low: 10.5, close: 13.5),
                Candle(open: 13.5, high: 14.0, low: 13.0, close: 13.3),
                Candle(open: 13.3, high: 13.6, low: 11.5, close: 11.8),
                Candle(open: 11.8, high: 12, low: 10.2, close: 10.5),
            ]
        case .breakout:
            return [
                Candle(open: 11, high: 12.9, low: 10.8, close: 12.5),
                Candle(open: 12.5, high: 12.8, low: 12.0, close: 12.3),
                Candle(open: 12.3, high: 12.7, low: 11.9, close: 12.4),
                Candle(open: 12.4, high: 14.5, low: 12.2, close: 14.2),
                Candle(open: 14.2, high: 15.2, low: 14.0, close: 15.0),
            ]
        case .hammer:
            return [
                Candle(open: 14, high: 14.2, low: 12.5, close: 12.7),
                Candle(open: 12.7, high: 12.9, low: 11.5, close: 11.8),
                Candle(open: 11.8, high: 12.0, low: 9.5, close: 11.6),
            ]
        case .shootingStar:
            return [
                Candle(open: 10, high: 10.3, low: 9.8, close: 11.2),
                Candle(open: 11.2, high: 11.6, low: 11.0, close: 12.0),
                Candle(open: 12.0, high: 14.5, low: 11.8, close: 12.2),
            ]
        case .bullishEngulfing:
            return [
                Candle(open: 12.5, high: 12.7, low: 11.3, close: 11.5),
                Candle(open: 11.3, high: 13.5, low: 11.2, close: 13.3),
            ]
        case .bearishEngulfing:
            return [
                Candle(open: 11.0, high: 12.7, low: 10.8, close: 12.5),
                Candle(open: 12.7, high: 12.9, low: 10.5, close: 10.7),
            ]
        case .spinningTop:
            return [
                Candle(open: 11, high: 12, low: 10, close: 11.4),
                Candle(open: 11.6, high: 13, low: 10.5, close: 12.0),
                Candle(open: 12.0, high: 12.6, low: 11.6, close: 12.3),
            ]
        case .marubozu:
            return [
                Candle(open: 10.5, high: 10.8, low: 10.3, close: 10.6),
                Candle(open: 10.6, high: 13.05, low: 10.55, close: 13.0),
                Candle(open: 13.0, high: 13.3, low: 12.8, close: 13.1),
            ]
        case .breakdown:
            return [
                Candle(open: 11.0, high: 11.3, low: 10.2, close: 10.4),
                Candle(open: 10.4, high: 10.7, low: 10.0, close: 10.2),
                Candle(open: 10.2, high: 10.5, low: 9.9, close: 10.1),
                Candle(open: 10.1, high: 10.2, low: 8.6, close: 8.8),
                Candle(open: 8.8, high: 9.0, low: 7.8, close: 8.0),
            ]
        case .hangingMan:
            return [
                Candle(open: 11.0, high: 11.3, low: 10.8, close: 11.5),
                Candle(open: 11.5, high: 12.0, low: 11.3, close: 11.9),
                Candle(open: 11.9, high: 12.1, low: 10.6, close: 12.0),
            ]
        case .invertedHammer:
            return [
                Candle(open: 13.0, high: 13.2, low: 12.4, close: 12.5),
                Candle(open: 12.5, high: 12.7, low: 11.6, close: 11.8),
                Candle(open: 11.8, high: 13.3, low: 11.7, close: 11.9),
            ]
        case .doubleTop:
            return [
                Candle(open: 10.0, high: 11.0, low: 9.8, close: 10.8),
                Candle(open: 10.8, high: 13.9, low: 10.6, close: 13.6),
                Candle(open: 13.6, high: 13.8, low: 12.0, close: 12.2),
                Candle(open: 12.2, high: 13.9, low: 12.0, close: 13.5),
                Candle(open: 13.5, high: 13.7, low: 11.5, close: 11.7),
            ]
        case .doubleBottom:
            return [
                Candle(open: 13.0, high: 13.2, low: 11.0, close: 11.2),
                Candle(open: 11.2, high: 11.4, low: 9.6, close: 9.9),
                Candle(open: 9.9, high: 11.5, low: 9.8, close: 11.3),
                Candle(open: 11.3, high: 11.5, low: 9.7, close: 10.0),
                Candle(open: 10.0, high: 12.0, low: 9.9, close: 11.8),
            ]
        case .pullbackUptrend:
            return [
                Candle(open: 10.0, high: 11.0, low: 9.8, close: 10.8),
                Candle(open: 10.8, high: 12.0, low: 10.6, close: 11.8),
                Candle(open: 11.8, high: 12.1, low: 10.9, close: 11.0),
                Candle(open: 11.0, high: 13.0, low: 10.9, close: 12.8),
                Candle(open: 12.8, high: 13.8, low: 12.5, close: 13.5),
            ]
        case .lowerHighsDowntrend:
            return [
                Candle(open: 14.0, high: 14.2, low: 13.0, close: 13.2),
                Candle(open: 13.2, high: 13.4, low: 12.0, close: 12.2),
                Candle(open: 12.2, high: 13.1, low: 12.1, close: 13.0),
                Candle(open: 13.0, high: 13.1, low: 11.0, close: 11.2),
                Candle(open: 11.2, high: 11.4, low: 10.0, close: 10.2),
            ]
        default:
            return model(seed: 1).candles
        }
    }

    var supportLevel: Double? {
        switch self {
        case .supportBounce: return 10.1
        case .breakout: return 11.9
        case .breakdown: return 9.9
        case .doubleBottom: return 9.7
        default: return nil
        }
    }

    var resistanceLevel: Double? {
        switch self {
        case .resistanceRejection: return 13.7
        case .breakout: return 12.9
        case .doubleTop: return 13.9
        default: return nil
        }
    }

    var highlightIndex: Int? {
        switch self {
        case .doji: return 1
        case .rejectionWickDown, .rejectionWickUp: return 1
        case .hammer, .shootingStar: return 2
        case .bullishEngulfing, .bearishEngulfing: return 1
        case .spinningTop: return 1
        case .marubozu: return 1
        case .hangingMan, .invertedHammer: return 2
        case .breakdown: return 3
        case .pullbackUptrend, .lowerHighsDowntrend: return 2
        default: return nil
        }
    }
}

struct ScenarioChartView: View {
    let scenario: ChartScenario
    var height: CGFloat = 160
    var seed: UInt64 = UInt64.random(in: .min ... .max)
    var showsHighlight = true

    var body: some View {
        let m = scenario.model(seed: seed)
        CandlestickChart(candles: m.candles,
                         supportLevel: m.support,
                         resistanceLevel: m.resistance,
                         highlightIndex: showsHighlight ? m.highlight : nil,
                         maLine: m.maLine,
                         maLineLabel: scenario.maLabel,
                         maLine2: m.maLine2,
                         bandUpper: m.bandUpper,
                         bandLower: m.bandLower,
                         bandLabel: m.bandLabel,
                         showsAxes: true)
            .frame(height: height)
            .modifier(ChartCard())
    }
}

// MARK: - Procedural chart generation

struct ChartModel {
    var candles: [Candle]
    var support: Double? = nil
    var resistance: Double? = nil
    var highlight: Int? = nil
    var maLine: [Double]? = nil
    var maLine2: [Double]? = nil
    var bandUpper: [Double]? = nil
    var bandLower: [Double]? = nil
    var bandLabel: String = "BANDS"
}

struct SeededRNG: RandomNumberGenerator {
    private var s: UInt64
    init(seed: UInt64) { s = seed == 0 ? 0x9E3779B97F4A7C15 : seed }
    mutating func next() -> UInt64 {
        s ^= s << 13; s ^= s >> 7; s ^= s << 17; return s
    }
}

private struct Gen {
    var rng: SeededRNG
    mutating func u(_ a: Double, _ b: Double) -> Double { Double.random(in: a...b, using: &rng) }
    mutating func c(open: Double, close: Double, wick: Double) -> Candle {
        Candle(open: open, high: max(open, close) + u(0.05, wick),
               low: min(open, close) - u(0.05, wick), close: close)
    }
}

private func simpleMovingAverage(_ values: [Double], window: Int) -> [Double] {
    var out: [Double] = []
    for i in values.indices {
        let start = max(0, i - window + 1)
        let slice = values[start...i]
        out.append(slice.reduce(0, +) / Double(slice.count))
    }
    return out
}

extension ChartScenario {
    func model(seed: UInt64) -> ChartModel {
        var g = Gen(rng: SeededRNG(seed: seed))
        let base = g.u(9.0, 12.0)

        switch self {
        case .uptrend:
            var out: [Candle] = []; var p = base
            for _ in 0..<5 { let o = p; let cl = o + g.u(0.7, 1.7); out.append(g.c(open: o, close: cl, wick: 0.6)); p = cl - g.u(0.0, 0.45) }
            return ChartModel(candles: out)
        case .downtrend:
            var out: [Candle] = []; var p = base + 3
            for _ in 0..<5 { let o = p; let cl = o - g.u(0.7, 1.7); out.append(g.c(open: o, close: cl, wick: 0.6)); p = cl + g.u(0.0, 0.45) }
            return ChartModel(candles: out)
        case .sideways:
            let mid = base + 1; var out: [Candle] = []; var p = mid
            for _ in 0..<5 { let o = p; let cl = mid + g.u(-0.9, 0.9); out.append(g.c(open: o, close: cl, wick: 0.6)); p = cl + g.u(-0.3, 0.3) }
            return ChartModel(candles: out)

        case .doji:
            var out: [Candle] = []
            out.append(g.c(open: base, close: base + g.u(-0.6, 0.6), wick: 0.4))
            let d = out.last!.close, o = d, cl = d + g.u(-0.1, 0.1), w = g.u(0.9, 1.7)
            out.append(Candle(open: o, high: max(o, cl) + w, low: min(o, cl) - w, close: cl))
            out.append(g.c(open: cl, close: cl + g.u(-0.6, 0.6), wick: 0.4))
            return ChartModel(candles: out, highlight: 1)
        case .spinningTop:
            var out: [Candle] = []
            out.append(g.c(open: base, close: base + g.u(-0.7, 0.7), wick: 0.4))
            let s = out.last!.close, o = s, cl = s + g.u(-0.5, 0.5), w = g.u(0.5, 1.0)
            out.append(Candle(open: o, high: max(o, cl) + w, low: min(o, cl) - w, close: cl))
            out.append(g.c(open: cl, close: cl + g.u(-0.7, 0.7), wick: 0.4))
            return ChartModel(candles: out, highlight: 1)
        case .marubozu:
            var out: [Candle] = []
            out.append(g.c(open: base, close: base + g.u(-0.4, 0.4), wick: 0.3))
            let s = out.last!.close, o = s, cl = o + g.u(2.0, 3.0)
            out.append(Candle(open: o, high: cl + g.u(0.02, 0.12), low: o - g.u(0.02, 0.12), close: cl))
            out.append(g.c(open: cl, close: cl + g.u(-0.3, 0.5), wick: 0.3))
            return ChartModel(candles: out, highlight: 1)
        case .rejectionWickDown:
            var out: [Candle] = []
            out.append(g.c(open: base, close: base + g.u(-0.4, 0.4), wick: 0.3))
            let s = out.last!.close, o = s, cl = o + g.u(0.0, 0.4)
            out.append(Candle(open: o, high: max(o, cl) + g.u(0.05, 0.25), low: min(o, cl) - g.u(1.6, 2.6), close: cl))
            out.append(g.c(open: cl, close: cl + g.u(0.2, 0.9), wick: 0.3))
            return ChartModel(candles: out, highlight: 1)
        case .rejectionWickUp:
            var out: [Candle] = []
            out.append(g.c(open: base, close: base + g.u(-0.4, 0.4), wick: 0.3))
            let s = out.last!.close, o = s, cl = o - g.u(0.0, 0.4)
            out.append(Candle(open: o, high: max(o, cl) + g.u(1.6, 2.6), low: min(o, cl) - g.u(0.05, 0.25), close: cl))
            out.append(g.c(open: cl, close: cl - g.u(0.2, 0.9), wick: 0.3))
            return ChartModel(candles: out, highlight: 1)

        case .hammer:
            var out: [Candle] = []; var p = base + 3
            for _ in 0..<2 { let o = p; let cl = o - g.u(0.8, 1.4); out.append(g.c(open: o, close: cl, wick: 0.4)); p = cl }
            let o = p, cl = o + g.u(-0.15, 0.25)
            out.append(Candle(open: o, high: max(o, cl) + g.u(0.03, 0.2), low: min(o, cl) - g.u(1.4, 2.4), close: cl))
            return ChartModel(candles: out, highlight: 2)
        case .hangingMan:
            var out: [Candle] = []; var p = base
            for _ in 0..<2 { let o = p; let cl = o + g.u(0.6, 1.2); out.append(g.c(open: o, close: cl, wick: 0.4)); p = cl }
            let o = p, cl = o + g.u(-0.15, 0.2)
            out.append(Candle(open: o, high: max(o, cl) + g.u(0.03, 0.2), low: min(o, cl) - g.u(1.3, 2.2), close: cl))
            return ChartModel(candles: out, highlight: 2)
        case .shootingStar:
            var out: [Candle] = []; var p = base
            for _ in 0..<2 { let o = p; let cl = o + g.u(0.8, 1.4); out.append(g.c(open: o, close: cl, wick: 0.4)); p = cl }
            let o = p, cl = o + g.u(-0.15, 0.2)
            out.append(Candle(open: o, high: max(o, cl) + g.u(1.4, 2.4), low: min(o, cl) - g.u(0.03, 0.2), close: cl))
            return ChartModel(candles: out, highlight: 2)
        case .invertedHammer:
            var out: [Candle] = []; var p = base + 3
            for _ in 0..<2 { let o = p; let cl = o - g.u(0.6, 1.2); out.append(g.c(open: o, close: cl, wick: 0.4)); p = cl }
            let o = p, cl = o + g.u(-0.15, 0.2)
            out.append(Candle(open: o, high: max(o, cl) + g.u(1.3, 2.2), low: min(o, cl) - g.u(0.03, 0.2), close: cl))
            return ChartModel(candles: out, highlight: 2)

        case .bullishEngulfing:
            let o0 = base + 1, c0 = o0 - g.u(0.6, 1.0)
            let a = Candle(open: o0, high: o0 + g.u(0.05, 0.3), low: c0 - g.u(0.05, 0.3), close: c0)
            let o1 = c0 - g.u(0.05, 0.25), c1 = o0 + g.u(0.6, 1.4)
            let b = Candle(open: o1, high: c1 + g.u(0.02, 0.2), low: o1 - g.u(0.02, 0.2), close: c1)
            return ChartModel(candles: [a, b], highlight: 1)
        case .bearishEngulfing:
            let o0 = base, c0 = o0 + g.u(0.6, 1.0)
            let a = Candle(open: o0, high: c0 + g.u(0.05, 0.3), low: o0 - g.u(0.05, 0.3), close: c0)
            let o1 = c0 + g.u(0.05, 0.25), c1 = o0 - g.u(0.6, 1.4)
            let b = Candle(open: o1, high: o1 + g.u(0.02, 0.2), low: c1 - g.u(0.02, 0.2), close: c1)
            return ChartModel(candles: [a, b], highlight: 1)

        case .supportBounce:
            let L = base; var out: [Candle] = []
            out.append(g.c(open: L + g.u(2.4, 3.0), close: L + g.u(1.4, 2.0), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: L + g.u(0.3, 0.7), wick: 0.4))
            let o = out.last!.close, cl = L + g.u(0.2, 0.5)
            out.append(Candle(open: o, high: o + g.u(0.1, 0.4), low: L - g.u(0.0, 0.15), close: cl))
            out.append(g.c(open: cl, close: L + g.u(1.0, 1.6), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: L + g.u(1.8, 2.6), wick: 0.4))
            return ChartModel(candles: out, support: L)
        case .resistanceRejection:
            let R = base + 3; var out: [Candle] = []
            out.append(g.c(open: R - g.u(2.4, 3.0), close: R - g.u(1.4, 2.0), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.3, 0.7), wick: 0.4))
            let o = out.last!.close, cl = R - g.u(0.2, 0.5)
            out.append(Candle(open: o, high: R + g.u(0.0, 0.15), low: o - g.u(0.1, 0.4), close: cl))
            out.append(g.c(open: cl, close: R - g.u(1.0, 1.6), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: R - g.u(1.8, 2.6), wick: 0.4))
            return ChartModel(candles: out, resistance: R)
        case .breakout:
            let S = base, R = base + 2; var out: [Candle] = []
            out.append(g.c(open: S + g.u(0.2, 0.6), close: R - g.u(0.2, 0.5), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.4, 0.9), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.2, 0.5), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: R + g.u(1.2, 1.9), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: R + g.u(2.0, 2.8), wick: 0.3))
            return ChartModel(candles: out, support: S, resistance: R)
        case .breakdown:
            let S = base + 1; var out: [Candle] = []
            out.append(g.c(open: S + g.u(0.6, 1.0), close: S + g.u(0.2, 0.5), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.1, 0.4), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.3), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S - g.u(1.2, 1.9), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S - g.u(2.0, 2.8), wick: 0.3))
            return ChartModel(candles: out, support: S, highlight: 3)
        case .doubleTop:
            let R = base + 3; var out: [Candle] = []
            out.append(g.c(open: R - g.u(3.0, 3.6), close: R - g.u(2.0, 2.6), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.1, 0.4), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: R - g.u(1.4, 2.0), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.1, 0.4), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: R - g.u(1.8, 2.6), wick: 0.4))
            return ChartModel(candles: out, resistance: R)
        case .doubleBottom:
            let S = base; var out: [Candle] = []
            out.append(g.c(open: S + g.u(3.0, 3.6), close: S + g.u(2.0, 2.6), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.1, 0.4), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S + g.u(1.4, 2.0), wick: 0.4))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.1, 0.4), wick: 0.3))
            out.append(g.c(open: out.last!.close, close: S + g.u(1.8, 2.6), wick: 0.4))
            return ChartModel(candles: out, support: S)
        case .pullbackUptrend:
            var out: [Candle] = []; var p = base
            out.append(g.c(open: p, close: p + g.u(0.8, 1.2), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.9, 1.3), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.6, 1.0), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(1.4, 2.0), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.6, 1.0), wick: 0.4))
            return ChartModel(candles: out, highlight: 2)
        case .lowerHighsDowntrend:
            var out: [Candle] = []; var p = base + 3
            out.append(g.c(open: p, close: p - g.u(0.8, 1.2), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.9, 1.3), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.6, 1.0), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(1.4, 2.0), wick: 0.4)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.6, 1.0), wick: 0.4))
            return ChartModel(candles: out, highlight: 2)

        case .headShoulders:
            let neck = base + 1.0, sh = base + 2.3, head = base + 3.5
            var out: [Candle] = []
            out.append(g.c(open: neck - g.u(0.2, 0.6), close: sh - g.u(0.2, 0.5), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: sh - g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: head - g.u(0.0, 0.3), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: sh - g.u(0.0, 0.3), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.9, 1.5), wick: 0.25))
            return ChartModel(candles: out, support: neck, highlight: 3)
        case .inverseHeadShoulders:
            let neck = base + 2.5, sh = base + 1.2, head = base + 0.0
            var out: [Candle] = []
            out.append(g.c(open: neck + g.u(0.2, 0.6), close: sh + g.u(0.2, 0.5), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: sh + g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: head + g.u(0.0, 0.3), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.0, 0.25), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: sh + g.u(0.0, 0.3), wick: 0.25))
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.9, 1.5), wick: 0.25))
            return ChartModel(candles: out, resistance: neck, highlight: 3)

        case .ascendingTriangle:
            let R = base + 2.6
            let lows = [base + 0.2, base + 0.9, base + 1.6]
            var out: [Candle] = []
            out.append(g.c(open: lows[0], close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: lows[1], wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: lows[2], wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R + g.u(0.9, 1.6), wick: 0.2))
            return ChartModel(candles: out, resistance: R)
        case .descendingTriangle:
            let S = base + 0.4
            let highs = [base + 2.6, base + 1.9, base + 1.2]
            var out: [Candle] = []
            out.append(g.c(open: highs[0], close: S + g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: highs[1], wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: highs[2], wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S - g.u(0.9, 1.6), wick: 0.2))
            return ChartModel(candles: out, support: S)
        case .symmetricalTriangle:
            let highs = [base + 2.6, base + 2.1, base + 1.7]
            let lows = [base + 0.4, base + 0.9, base + 1.3]
            var out: [Candle] = []
            out.append(g.c(open: base + 1.0, close: highs[0], wick: 0.15))
            out.append(g.c(open: out.last!.close, close: lows[0], wick: 0.15))
            out.append(g.c(open: out.last!.close, close: highs[1], wick: 0.15))
            out.append(g.c(open: out.last!.close, close: lows[1], wick: 0.15))
            out.append(g.c(open: out.last!.close, close: highs[2], wick: 0.15))
            out.append(g.c(open: out.last!.close, close: lows[2], wick: 0.15))
            return ChartModel(candles: out)
        case .bullFlag:
            var out: [Candle] = []; var p = base
            out.append(g.c(open: p, close: p + g.u(1.6, 2.2), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(1.4, 2.0), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(1.4, 2.0), wick: 0.12))
            return ChartModel(candles: out, highlight: 0)
        case .bearFlag:
            var out: [Candle] = []; var p = base + 3
            out.append(g.c(open: p, close: p - g.u(1.6, 2.2), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(1.4, 2.0), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(1.4, 2.0), wick: 0.12))
            return ChartModel(candles: out, highlight: 0)
        case .risingWedge:
            let highs = [base + 1.5, base + 2.1, base + 2.5]
            let lows = [base + 0.5, base + 1.3, base + 1.9]
            var out: [Candle] = []
            out.append(g.c(open: lows[0], close: highs[0], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: lows[1], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: highs[1], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: lows[2], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: highs[2], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: lows[2] - g.u(1.0, 1.6), wick: 0.12))
            return ChartModel(candles: out)
        case .fallingWedge:
            let highs = [base + 2.5, base + 1.9, base + 1.5]
            let lows = [base + 1.5, base + 1.0, base + 0.7]
            var out: [Candle] = []
            out.append(g.c(open: highs[0], close: lows[0], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: highs[1], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: lows[1], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: highs[2], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: lows[2], wick: 0.12))
            out.append(g.c(open: out.last!.close, close: highs[2] + g.u(1.0, 1.6), wick: 0.12))
            return ChartModel(candles: out)

        case .range:
            let S = base, R = base + 2.0
            var out: [Candle] = []
            out.append(g.c(open: S + g.u(0.1, 0.4), close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.05, 0.25), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.05, 0.25), wick: 0.2))
            return ChartModel(candles: out, support: S, resistance: R)
        case .breakoutRetest:
            let R = base + 1.5
            var out: [Candle] = []
            out.append(g.c(open: R - g.u(1.3, 1.8), close: R - g.u(0.1, 0.4), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.6, 1.0), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R + g.u(1.0, 1.5), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R + g.u(0.05, 0.3), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R + g.u(1.2, 1.8), wick: 0.2))
            return ChartModel(candles: out, resistance: R, highlight: 3)
        case .breakdownRetest:
            let S = base + 1.5
            var out: [Candle] = []
            out.append(g.c(open: S + g.u(1.3, 1.8), close: S + g.u(0.1, 0.4), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.6, 1.0), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S - g.u(1.0, 1.5), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S - g.u(0.05, 0.3), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S - g.u(1.2, 1.8), wick: 0.2))
            return ChartModel(candles: out, support: S, highlight: 3)

        case .gapUp:
            var out: [Candle] = []; var p = base
            out.append(g.c(open: p, close: p + g.u(0.4, 0.8), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2))
            let go = out.last!.high + g.u(0.9, 1.5)
            out.append(Candle(open: go, high: go + g.u(0.4, 0.8), low: go - g.u(0.0, 0.12), close: go + g.u(0.3, 0.7)))
            p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2))
            return ChartModel(candles: out, highlight: 2)
        case .gapDown:
            var out: [Candle] = []; var p = base + 3
            out.append(g.c(open: p, close: p - g.u(0.4, 0.8), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2))
            let go = out.last!.low - g.u(0.9, 1.5)
            out.append(Candle(open: go, high: go + g.u(0.0, 0.12), low: go - g.u(0.4, 0.8), close: go - g.u(0.3, 0.7)))
            p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2))
            return ChartModel(candles: out, highlight: 2)

        case .volatile:
            var out: [Candle] = []; var p = base + 1.5
            for i in 0..<6 {
                let dir = (i % 2 == 0) ? 1.0 : -1.0
                let close = p + g.u(1.4, 2.4) * dir
                out.append(Candle(open: p, high: max(p, close) + g.u(0.4, 0.9),
                                  low: min(p, close) - g.u(0.4, 0.9), close: close))
                p = close + g.u(-0.4, 0.4)
            }
            return ChartModel(candles: out)

        case .priceAboveMA:
            let deltas = [0.0, -0.6, -1.2, -0.5, 0.9, 1.6]
            var out: [Candle] = []; var p = base + deltas[0] - 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let mid = simpleMovingAverage(deltas.map { base + $0 }, window: 3)
            return ChartModel(candles: out, highlight: 3, maLine: mid)
        case .priceBelowMA:
            let deltas = [0.0, 0.6, 1.2, 0.5, -0.9, -1.6]
            var out: [Candle] = []; var p = base + deltas[0] + 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let mid = simpleMovingAverage(deltas.map { base + $0 }, window: 3)
            return ChartModel(candles: out, highlight: 3, maLine: mid)

        case .priceAboveVWAP:
            return ChartScenario.priceAboveMA.model(seed: seed)
        case .priceBelowVWAP:
            return ChartScenario.priceBelowMA.model(seed: seed)

        case .maCrossUp:
            let deltas = [0.0, -0.6, -1.2, -0.5, 0.9, 1.6]
            var out: [Candle] = []; var p = base + deltas[0] - 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let closes = deltas.map { base + $0 }
            let fast = simpleMovingAverage(closes, window: 1)
            let slow = simpleMovingAverage(closes, window: 4)
            return ChartModel(candles: out, highlight: 3, maLine: slow, maLine2: fast)
        case .maCrossDown:
            let deltas = [0.0, 0.6, 1.2, 0.5, -0.9, -1.6]
            var out: [Candle] = []; var p = base + deltas[0] + 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let closes = deltas.map { base + $0 }
            let fast = simpleMovingAverage(closes, window: 1)
            let slow = simpleMovingAverage(closes, window: 4)
            return ChartModel(candles: out, highlight: 3, maLine: slow, maLine2: fast)

        case .bandsWidening:
            var out: [Candle] = []; var p = base + 1.0; var closes: [Double] = []
            let wicks = [0.15, 0.2, 0.3, 0.5, 0.7, 0.9]
            for w in wicks { let cl = p + g.u(-0.3, 0.3); out.append(g.c(open: p, close: cl, wick: w)); closes.append(cl); p = cl }
            let mid = simpleMovingAverage(closes, window: 3)
            let halfWidths = [0.3, 0.45, 0.65, 0.95, 1.3, 1.7].map { $0 + g.u(-0.08, 0.08) }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, maLine: mid, bandUpper: upper, bandLower: lower)
        case .bandsNarrowing:
            var out: [Candle] = []; var p = base + 1.0; var closes: [Double] = []
            let wicks = [0.9, 0.7, 0.5, 0.3, 0.2, 0.15]
            for w in wicks { let cl = p + g.u(-0.3, 0.3); out.append(g.c(open: p, close: cl, wick: w)); closes.append(cl); p = cl }
            let mid = simpleMovingAverage(closes, window: 3)
            let halfWidths = [1.7, 1.3, 0.95, 0.65, 0.45, 0.3].map { $0 + g.u(-0.08, 0.08) }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, maLine: mid, bandUpper: upper, bandLower: lower)

        case .touchUpperBand:
            let deltas = [0.0, 0.3, 0.6, 0.9, 1.9, 1.3]
            let mid = simpleMovingAverage(deltas.map { base + $0 }, window: 3)
            let halfWidths = (0..<6).map { _ in 0.85 + g.u(-0.05, 0.05) }
            var out: [Candle] = []; var p = base + deltas[0] - 0.2
            for i in 0..<6 {
                let close = base + deltas[i]
                if i == 4 {
                    let upperHere = mid[i] + halfWidths[i]
                    out.append(Candle(open: p, high: upperHere + g.u(0.05, 0.15),
                                      low: min(p, close) - g.u(0.05, 0.15), close: close))
                } else {
                    out.append(g.c(open: p, close: close, wick: 0.2))
                }
                p = close
            }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, highlight: 4, maLine: mid, bandUpper: upper, bandLower: lower)
        case .touchLowerBand:
            let deltas = [0.0, -0.3, -0.6, -0.9, -1.9, -1.3]
            let mid = simpleMovingAverage(deltas.map { base + $0 }, window: 3)
            let halfWidths = (0..<6).map { _ in 0.85 + g.u(-0.05, 0.05) }
            var out: [Candle] = []; var p = base + deltas[0] + 0.2
            for i in 0..<6 {
                let close = base + deltas[i]
                if i == 4 {
                    let lowerHere = mid[i] - halfWidths[i]
                    out.append(Candle(open: p, high: max(p, close) + g.u(0.05, 0.15),
                                      low: lowerHere - g.u(0.05, 0.15), close: close))
                } else {
                    out.append(g.c(open: p, close: close, wick: 0.2))
                }
                p = close
            }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, highlight: 4, maLine: mid, bandUpper: upper, bandLower: lower)

        case .ascendingChannel:
            let slope = 0.45
            func lowerAt(_ i: Int) -> Double { base + slope * Double(i) }
            func upperAt(_ i: Int) -> Double { base + 2.0 + slope * Double(i) }
            var out: [Candle] = []; var p = lowerAt(0)
            for i in 0..<6 {
                let tgt = (i % 2 == 0) ? lowerAt(i) + g.u(0.0, 0.15) : upperAt(i) - g.u(0.0, 0.15)
                out.append(g.c(open: p, close: tgt, wick: 0.12)); p = tgt
            }
            let lower = (0..<6).map { lowerAt($0) }
            let upper = (0..<6).map { upperAt($0) }
            return ChartModel(candles: out, bandUpper: upper, bandLower: lower, bandLabel: "CHANNEL")
        case .descendingChannel:
            let slope = -0.45
            func lowerAt(_ i: Int) -> Double { base + slope * Double(i) }
            func upperAt(_ i: Int) -> Double { base + 2.0 + slope * Double(i) }
            var out: [Candle] = []; var p = upperAt(0)
            for i in 0..<6 {
                let tgt = (i % 2 == 0) ? upperAt(i) - g.u(0.0, 0.15) : lowerAt(i) + g.u(0.0, 0.15)
                out.append(g.c(open: p, close: tgt, wick: 0.12)); p = tgt
            }
            let lower = (0..<6).map { lowerAt($0) }
            let upper = (0..<6).map { upperAt($0) }
            return ChartModel(candles: out, bandUpper: upper, bandLower: lower, bandLabel: "CHANNEL")
        }
    }
}

// MARK: - Live (forming) chart

enum LiveDirection: String {
    case up, down, sideways, volatile

    var drift: Double {
        switch self {
        case .up: return 0.55
        case .down: return -0.55
        case .sideways, .volatile: return 0
        }
    }
    var jitter: Double {
        switch self {
        case .volatile: return 2.6
        case .sideways: return 0.9
        default: return 1.3
        }
    }
    init(_ raw: String?) { self = LiveDirection(rawValue: raw ?? "up") ?? .up }
}

struct LiveChart: View {
    var direction: LiveDirection = .up
    var height: CGFloat? = nil
    var committedCount = 10
    var ticksPerCandle = 45
    var paused = false
    var showsAxes = true

    private let tick = Timer.publish(every: 0.11, on: .main, in: .common).autoconnect()

    @State private var committed: [Candle] = []
    @State private var forming = Candle(open: 100, high: 100, low: 100, close: 100)
    @State private var ticks = 0
    @State private var range: (lo: Double, hi: Double) = (90, 110)
    @State private var popID = 0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                CandlestickChart(candles: committed + [forming], showsAxes: showsAxes,
                                 showsGrid: true,
                                 fixedRange: range, xLabels: timeLabels(committed.count + 1))
                let slotW = geo.size.width / CGFloat(committedCount + 1)
                NewCandleFlash(key: popID)
                    .frame(width: slotW, height: geo.size.height)
                    .position(x: geo.size.width - slotW / 2, y: geo.size.height / 2)
                    .allowsHitTesting(false)
            }
        }
        .frame(height: height)
        .onAppear { if committed.isEmpty { seed() } }
        .onReceive(tick) { _ in if !paused { step() } }
    }

    private func timeLabels(_ n: Int) -> [String] {
        let interval = Double(ticksPerCandle) * 0.11
        let now = Date()
        let cal = Calendar.current
        return (0..<n).map { i in
            let back = n - 1 - i
            guard back % 5 == 0 else { return "" }
            let t = now.addingTimeInterval(-Double(back) * interval)
            var h = cal.component(.hour, from: t) % 12
            if h == 0 { h = 12 }
            return String(format: "%d:%02d:%02d", h,
                          cal.component(.minute, from: t), cal.component(.second, from: t))
        }
    }

    private func seed() {
        var arr: [Candle] = []
        var price = 100.0
        for _ in 0..<committedCount {
            let c = grow(from: price)
            arr.append(c); price = c.close
        }
        committed = arr
        forming = Candle(open: price, high: price, low: price, close: price)
        ticks = 0
        reframe()
    }

    private func grow(from close: Double) -> Candle {
        let open = close
        let move = direction.drift + Double.random(in: -direction.jitter...direction.jitter)
        let c = max(20, open + move)
        return Candle(open: open, high: max(open, c) + Double.random(in: 0.2...1.4),
                      low: min(open, c) - Double.random(in: 0.2...1.4), close: c)
    }

    private func step() {
        ticks += 1

        if ticks >= ticksPerCandle {
            committed = Array((committed + [forming]).suffix(committedCount))
            forming = Candle(open: forming.close, high: forming.close,
                             low: forming.close, close: forming.close)
            ticks = 0
            popID += 1
            reframe()
            return
        }

        let scale = 13.0 / Double(ticksPerCandle)
        let move = (direction.drift * 0.6 + Double.random(in: -direction.jitter...direction.jitter)) * scale
        var f = forming
        f.close = min(range.hi - 0.5, max(range.lo + 0.5, f.close + move))
        f.high = max(f.high, f.close)
        f.low = min(f.low, f.close)
        withAnimation(.linear(duration: 0.11)) { forming = f }
    }

    private func reframe() {
        let vals = (committed + [forming]).flatMap { [$0.high, $0.low] }
        let hi = vals.max() ?? 110, lo = vals.min() ?? 90
        let pad = max(hi - lo, 4) * 0.35
        range = (lo - pad, hi + pad)
    }
}

private struct NewCandleFlash: View {
    let key: Int
    @State private var visible = false

    var body: some View {
        LinearGradient(colors: [Color.white.opacity(0.22), .clear],
                       startPoint: .top, endPoint: .bottom)
            .opacity(visible ? 0 : 1)
            .onAppear { flash() }
            .onChange(of: key) { _, _ in visible = false; flash() }
    }

    private func flash() { withAnimation(.easeOut(duration: 0.55)) { visible = true } }
}
