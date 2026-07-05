import SwiftUI

// MARK: - Candlestick chart
// A reusable, data-driven chart for illustrating chart-reading concepts.
// Pass in an array of Candle values (open/high/low/close) plus optional
// support/resistance levels and a highlighted candle, and it draws wicks +
// bodies to scale. Named scenario presets below make it easy to drop a
// specific example (a doji, a rejection wick, an uptrend, etc.) into a lesson.

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
    /// 0-based index of a candle to visually call out (e.g. "look at this one").
    var highlightIndex: Int? = nil

    // Overlay lines (moving averages, VWAP, …): one value per candle, drawn as
    // a connected sloped line rather than a flat support/resistance level.
    var maLine: [Double]? = nil
    var maLineLabel: String = "MA"
    var maLine2: [Double]? = nil
    var maLine2Label: String = "Fast MA"

    // Bollinger-style band: upper/lower lines, one value per candle, with the
    // area between them shaded — unlike the single overlay lines above. Also
    // reused for channels (two parallel boundary lines).
    var bandUpper: [Double]? = nil
    var bandLower: [Double]? = nil
    var bandLabel: String = "BANDS"

    // Interactive "tap a candle" support.
    /// The candle the learner has tapped (draws a selection ring).
    var chosenIndex: Int? = nil
    /// When set (on reveal), the correct candle to outline in green.
    var revealTarget: Int? = nil
    /// Multi-select: the set of candles tapped (blue rings).
    var chosenSet: Set<Int> = []
    /// Multi-select reveal: the correct set (green = right, orange = missed, red = wrong).
    var revealTargets: Set<Int>? = nil
    /// Called with the tapped candle index; when nil the chart is non-interactive.
    var onTapCandle: ((Int) -> Void)? = nil

    private let bullish = Color(hex: "#22C55E")
    private let bearish = Color(hex: "#EF4444")
    private let lineColor = Color(hex: "#8B5CF6")
    private let selectBlue = Color(hex: "#38bdf8")

    /// Maps a price value to a y-coordinate within a given chart height.
    private struct ValueMapper {
        let lo: Double
        let range: Double
        let height: CGFloat
        func y(_ v: Double) -> CGFloat { height * (1 - CGFloat((v - lo) / range)) }
    }

    private func mapper(for geo: GeometryProxy) -> ValueMapper {
        let values = candles.flatMap { [$0.high, $0.low] } + [supportLevel, resistanceLevel].compactMap { $0 }
            + (maLine ?? []) + (maLine2 ?? []) + (bandUpper ?? []) + (bandLower ?? [])
        let maxV = values.max() ?? 1
        let minV = values.min() ?? 0
        // A little vertical breathing room so wicks don't touch the frame edges.
        let pad = max(maxV - minV, 0.0001) * 0.1
        let hi = maxV + pad, lo = minV - pad
        return ValueMapper(lo: lo, range: max(hi - lo, 0.0001), height: geo.size.height)
    }

    var body: some View {
        GeometryReader { geo in
            let m = mapper(for: geo)
            let n = max(candles.count, 1)
            let slot = geo.size.width / CGFloat(n)
            let bodyWidth = slot * 0.55

            ZStack(alignment: .topLeading) {
                if let s = supportLevel { levelLine(y: m.y(s), label: "Support", color: bullish, geo: geo) }
                if let r = resistanceLevel { levelLine(y: m.y(r), label: "Resistance", color: bearish, geo: geo) }
                if let upper = bandUpper, let lower = bandLower { bollingerBand(upper, lower, slot: slot, mapper: m) }
                if let line = maLine { overlayLine(line, slot: slot, mapper: m, color: Color(hex: "#F59E0B"), label: maLineLabel) }
                if let line = maLine2 { overlayLine(line, slot: slot, mapper: m, color: Color(hex: "#38bdf8"), label: maLine2Label) }

                ForEach(Array(candles.enumerated()), id: \.offset) { i, c in
                    let cx = slot * (CGFloat(i) + 0.5)
                    let color = c.isBullish ? bullish : bearish
                    let dimmed = highlightIndex != nil && highlightIndex != i

                    ZStack {
                        // Wick
                        Path { p in
                            p.move(to: CGPoint(x: cx, y: m.y(c.high)))
                            p.addLine(to: CGPoint(x: cx, y: m.y(c.low)))
                        }
                        .stroke(color, lineWidth: 2)

                        // Body
                        let top = m.y(max(c.open, c.close))
                        let bottom = m.y(min(c.open, c.close))
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .fill(color)
                            .frame(width: bodyWidth, height: max(bottom - top, 2.5))
                            .position(x: cx, y: (top + bottom) / 2)
                    }
                    .opacity(dimmed ? 0.3 : 1)
                }

                // Interactive layer: selection / reveal rings + tap targets.
                if onTapCandle != nil || chosenIndex != nil || revealTarget != nil
                    || !chosenSet.isEmpty || revealTargets != nil {
                    ForEach(candles.indices, id: \.self) { i in
                        let cx = slot * (CGFloat(i) + 0.5)
                        ringColor(for: i).map { ring in
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .strokeBorder(ring, lineWidth: 2.5)
                                .frame(width: slot * 0.86, height: geo.size.height - 4)
                                .position(x: cx, y: geo.size.height / 2)
                        }
                        Rectangle()
                            .fill(Color.white.opacity(0.001))
                            .frame(width: slot, height: geo.size.height)
                            .position(x: cx, y: geo.size.height / 2)
                            .onTapGesture { onTapCandle?(i) }
                    }
                }
            }
        }
    }

    private let missOrange = Color(hex: "#F59E0B")

    /// The outline color for candle `i`: green for the revealed answer, red for a
    /// wrong pick after reveal, orange for a missed target, blue for a live pick.
    private func ringColor(for i: Int) -> Color? {
        // Multi-select reveal.
        if let targets = revealTargets {
            let isTarget = targets.contains(i)
            let isChosen = chosenSet.contains(i)
            if isTarget && isChosen { return bullish }   // correct
            if isTarget && !isChosen { return missOrange } // missed
            if !isTarget && isChosen { return bearish }   // wrong pick
            return nil
        }
        // Multi-select live.
        if !chosenSet.isEmpty { return chosenSet.contains(i) ? selectBlue : nil }
        // Single-select reveal / live.
        if let target = revealTarget {
            if i == target { return bullish }
            if i == chosenIndex { return bearish }
            return nil
        }
        return i == chosenIndex ? selectBlue : nil
    }

    private func levelLine(y: CGFloat, label: String, color: Color, geo: GeometryProxy) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                p.move(to: CGPoint(x: 0, y: y))
                p.addLine(to: CGPoint(x: geo.size.width, y: y))
            }
            .stroke(color.opacity(0.55), style: StrokeStyle(lineWidth: 1.5, dash: [5, 4]))

            Text(label.uppercased())
                .font(Theme.font(9, .black))
                .foregroundColor(color)
                .padding(.horizontal, 5).padding(.vertical, 2)
                .background(Capsule().fill(color.opacity(0.16)))
                .offset(y: y - 20)
        }
    }

    /// A sloped overlay line (moving average, VWAP, …), one value per candle,
    /// connected candle-center to candle-center — unlike the flat, dashed
    /// support/resistance line.
    private func overlayLine(_ values: [Double], slot: CGFloat, mapper m: ValueMapper,
                              color: Color, label: String) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                for (i, v) in values.enumerated() {
                    let pt = CGPoint(x: slot * (CGFloat(i) + 0.5), y: m.y(v))
                    if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
                }
            }
            .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

            if let last = values.last {
                Text(label.uppercased())
                    .font(Theme.font(9, .black))
                    .foregroundColor(color)
                    .padding(.horizontal, 5).padding(.vertical, 2)
                    .background(Capsule().fill(color.opacity(0.16)))
                    .offset(x: -4, y: m.y(last) - 20)
            }
        }
    }

    /// A Bollinger-style band: upper/lower lines with the area between shaded,
    /// so widening/narrowing (volatility) reads at a glance.
    private let bandColor = Color(hex: "#A78BFA")
    private func bollingerBand(_ upper: [Double], _ lower: [Double], slot: CGFloat, mapper m: ValueMapper) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in
                guard !upper.isEmpty else { return }
                for (i, v) in upper.enumerated() {
                    let pt = CGPoint(x: slot * (CGFloat(i) + 0.5), y: m.y(v))
                    if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
                }
                for i in stride(from: lower.count - 1, through: 0, by: -1) {
                    p.addLine(to: CGPoint(x: slot * (CGFloat(i) + 0.5), y: m.y(lower[i])))
                }
                p.closeSubpath()
            }
            .fill(bandColor.opacity(0.10))

            overlayLineStroke(upper, slot: slot, mapper: m, color: bandColor.opacity(0.7))
            overlayLineStroke(lower, slot: slot, mapper: m, color: bandColor.opacity(0.7))

            if let last = upper.last {
                Text(bandLabel)
                    .font(Theme.font(9, .black))
                    .foregroundColor(bandColor)
                    .padding(.horizontal, 5).padding(.vertical, 2)
                    .background(Capsule().fill(bandColor.opacity(0.16)))
                    .offset(x: -4, y: m.y(last) - 20)
            }
        }
    }

    private func overlayLineStroke(_ values: [Double], slot: CGFloat, mapper m: ValueMapper, color: Color) -> some View {
        Path { p in
            for (i, v) in values.enumerated() {
                let pt = CGPoint(x: slot * (CGFloat(i) + 0.5), y: m.y(v))
                if i == 0 { p.move(to: pt) } else { p.addLine(to: pt) }
            }
        }
        .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round, dash: [4, 3]))
    }
}

// MARK: - Scenario presets
// Small, illustrative candle sequences for specific lesson concepts.

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

    /// Label for the single overlay line — "MA" for moving-average scenarios,
    /// "VWAP" for the VWAP-specific variants (same underlying geometry).
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
                Candle(open: 12.5, high: 14.5, low: 10.5, close: 12.6),   // the doji: tiny body, long wicks both ways
                Candle(open: 12.3, high: 13, low: 11.5, close: 12.0),
            ]
        case .rejectionWickDown:
            // A long lower wick with a strong close near the high — often read as rejection of the lows.
            return [
                Candle(open: 13, high: 13.3, low: 12.5, close: 13.1),
                Candle(open: 12.9, high: 13.2, low: 9.5, close: 12.8),
                Candle(open: 13, high: 14, low: 12.8, close: 13.8),
            ]
        case .rejectionWickUp:
            // A long upper wick with a weak close near the low — often read as rejection of the highs.
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
                Candle(open: 12.4, high: 14.5, low: 12.2, close: 14.2),   // clears the range on strong momentum
                Candle(open: 14.2, high: 15.2, low: 14.0, close: 15.0),
            ]
        case .hammer:
            // Small body near the top, long lower wick — after a downtrend.
            return [
                Candle(open: 14, high: 14.2, low: 12.5, close: 12.7),
                Candle(open: 12.7, high: 12.9, low: 11.5, close: 11.8),
                Candle(open: 11.8, high: 12.0, low: 9.5, close: 11.6),
            ]
        case .shootingStar:
            // Small body near the bottom, long upper wick — after an uptrend.
            return [
                Candle(open: 10, high: 10.3, low: 9.8, close: 11.2),
                Candle(open: 11.2, high: 11.6, low: 11.0, close: 12.0),
                Candle(open: 12.0, high: 14.5, low: 11.8, close: 12.2),
            ]
        case .bullishEngulfing:
            // A red candle, then a larger green candle whose body fully engulfs it.
            return [
                Candle(open: 12.5, high: 12.7, low: 11.3, close: 11.5),
                Candle(open: 11.3, high: 13.5, low: 11.2, close: 13.3),
            ]
        case .bearishEngulfing:
            // A green candle, then a larger red candle whose body fully engulfs it.
            return [
                Candle(open: 11.0, high: 12.7, low: 10.8, close: 12.5),
                Candle(open: 12.7, high: 12.9, low: 10.5, close: 10.7),
            ]
        case .spinningTop:
            // A small (but not tiny) body with wicks of similar length on both sides.
            return [
                Candle(open: 11, high: 12, low: 10, close: 11.4),
                Candle(open: 11.6, high: 13, low: 10.5, close: 12.0),
                Candle(open: 12.0, high: 12.6, low: 11.6, close: 12.3),
            ]
        case .marubozu:
            // A candle with a large body and almost no wicks either side.
            return [
                Candle(open: 10.5, high: 10.8, low: 10.3, close: 10.6),
                Candle(open: 10.6, high: 13.05, low: 10.55, close: 13.0),
                Candle(open: 13.0, high: 13.3, low: 12.8, close: 13.1),
            ]
        case .breakdown:
            // Price holds a support shelf, then breaks below it and keeps falling.
            return [
                Candle(open: 11.0, high: 11.3, low: 10.2, close: 10.4),
                Candle(open: 10.4, high: 10.7, low: 10.0, close: 10.2),
                Candle(open: 10.2, high: 10.5, low: 9.9, close: 10.1),
                Candle(open: 10.1, high: 10.2, low: 8.6, close: 8.8),   // breaks the support shelf
                Candle(open: 8.8, high: 9.0, low: 7.8, close: 8.0),
            ]
        case .hangingMan:
            // Same shape as a hammer (small body up top, long lower wick) but it
            // shows up after an up-move rather than a down-move.
            return [
                Candle(open: 11.0, high: 11.3, low: 10.8, close: 11.5),
                Candle(open: 11.5, high: 12.0, low: 11.3, close: 11.9),
                Candle(open: 11.9, high: 12.1, low: 10.6, close: 12.0),
            ]
        case .invertedHammer:
            // Small body near the bottom with a long upper wick, after a down-move.
            return [
                Candle(open: 13.0, high: 13.2, low: 12.4, close: 12.5),
                Candle(open: 12.5, high: 12.7, low: 11.6, close: 11.8),
                Candle(open: 11.8, high: 13.3, low: 11.7, close: 11.9),
            ]
        case .doubleTop:
            // Two peaks that stall at the same resistance, then a decline — an "M".
            return [
                Candle(open: 10.0, high: 11.0, low: 9.8, close: 10.8),
                Candle(open: 10.8, high: 13.9, low: 10.6, close: 13.6),   // first peak
                Candle(open: 13.6, high: 13.8, low: 12.0, close: 12.2),   // pull back
                Candle(open: 12.2, high: 13.9, low: 12.0, close: 13.5),   // second peak, same high
                Candle(open: 13.5, high: 13.7, low: 11.5, close: 11.7),   // roll over
            ]
        case .doubleBottom:
            // Two troughs at the same support, then a rise — a "W".
            return [
                Candle(open: 13.0, high: 13.2, low: 11.0, close: 11.2),
                Candle(open: 11.2, high: 11.4, low: 9.6, close: 9.9),    // first trough
                Candle(open: 9.9, high: 11.5, low: 9.8, close: 11.3),    // bounce
                Candle(open: 11.3, high: 11.5, low: 9.7, close: 10.0),   // second trough, same low
                Candle(open: 10.0, high: 12.0, low: 9.9, close: 11.8),   // rise away
            ]
        case .pullbackUptrend:
            // Higher highs and higher lows, with one pullback that still holds
            // above the prior low — a healthy uptrend structure.
            return [
                Candle(open: 10.0, high: 11.0, low: 9.8, close: 10.8),
                Candle(open: 10.8, high: 12.0, low: 10.6, close: 11.8),   // higher high
                Candle(open: 11.8, high: 12.1, low: 10.9, close: 11.0),   // pullback (higher low)
                Candle(open: 11.0, high: 13.0, low: 10.9, close: 12.8),   // new higher high
                Candle(open: 12.8, high: 13.8, low: 12.5, close: 13.5),
            ]
        case .lowerHighsDowntrend:
            // Lower highs and lower lows, with one bounce that still fails lower —
            // a clear downtrend structure.
            return [
                Candle(open: 14.0, high: 14.2, low: 13.0, close: 13.2),
                Candle(open: 13.2, high: 13.4, low: 12.0, close: 12.2),   // lower low
                Candle(open: 12.2, high: 13.1, low: 12.1, close: 13.0),   // bounce (lower high)
                Candle(open: 13.0, high: 13.1, low: 11.0, close: 11.2),   // new lower low
                Candle(open: 11.2, high: 11.4, low: 10.0, close: 10.2),
            ]
        default:
            // Procedural-only scenarios (headShoulders, …) draw via model(seed:).
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

/// Drop-in chart for a named scenario, sized for use inside a lesson card.
/// A `seed` drives procedural variation so the same pattern renders differently
/// each place it appears (different candle heights, wicks, price level) while
/// staying a valid example of the pattern. Pass a stable per-screen seed so a
/// given question always shows the same chart, but different questions differ.
struct ScenarioChartView: View {
    let scenario: ChartScenario
    var height: CGFloat = 160
    var seed: UInt64 = UInt64.random(in: .min ... .max)

    var body: some View {
        let m = scenario.model(seed: seed)
        CandlestickChart(candles: m.candles,
                         supportLevel: m.support,
                         resistanceLevel: m.resistance,
                         highlightIndex: m.highlight,
                         maLine: m.maLine,
                         maLineLabel: scenario.maLabel,
                         maLine2: m.maLine2,
                         bandUpper: m.bandUpper,
                         bandLower: m.bandLower,
                         bandLabel: m.bandLabel)
            .frame(height: height)
            .padding(.horizontal, 10).padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.04))
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.08), lineWidth: 1.5))
            )
    }
}

// MARK: - Procedural chart generation
// Each render produces a fresh variation of the pattern from a seed, so charts
// don't look copy-pasted. The essential shape (which candle is the doji, where
// the breakout happens, etc.) is preserved so tap-the-candle targets stay valid.

/// A resolved, ready-to-draw chart: candles plus optional levels/highlight.
struct ChartModel {
    var candles: [Candle]
    var support: Double? = nil
    var resistance: Double? = nil
    var highlight: Int? = nil
    // Overlay lines (moving average, VWAP, …): one value per candle.
    var maLine: [Double]? = nil
    var maLine2: [Double]? = nil
    // Bollinger-style band / channel: upper/lower lines, one value per candle.
    var bandUpper: [Double]? = nil
    var bandLower: [Double]? = nil
    var bandLabel: String = "BANDS"
}

/// Small, fast, deterministic RNG (xorshift64) so a seed reproduces a chart.
struct SeededRNG: RandomNumberGenerator {
    private var s: UInt64
    init(seed: UInt64) { s = seed == 0 ? 0x9E3779B97F4A7C15 : seed }
    mutating func next() -> UInt64 {
        s ^= s << 13; s ^= s >> 7; s ^= s << 17; return s
    }
}

/// Candle-building helpers over a seeded RNG.
private struct Gen {
    var rng: SeededRNG
    mutating func u(_ a: Double, _ b: Double) -> Double { Double.random(in: a...b, using: &rng) }
    /// A candle from open→close with small random wicks on both ends.
    mutating func c(open: Double, close: Double, wick: Double) -> Candle {
        Candle(open: open, high: max(open, close) + u(0.05, wick),
               low: min(open, close) - u(0.05, wick), close: close)
    }
}

/// A real trailing simple moving average — used so overlay lines (MA, VWAP,
/// Bollinger midline) actually curve with price instead of sitting flat.
/// Expands the window at the start (fewer than `window` prior values available).
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
        let base = g.u(9.0, 12.0)   // random vertical placement each time

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
            // Three peaks: left shoulder, higher head, right shoulder (~= left),
            // with a neckline along the two troughs, then a break below.
            let neck = base + 1.0, sh = base + 2.3, head = base + 3.5
            var out: [Candle] = []
            out.append(g.c(open: neck - g.u(0.2, 0.6), close: sh - g.u(0.2, 0.5), wick: 0.25))   // rise
            out.append(g.c(open: out.last!.close, close: sh - g.u(0.0, 0.25), wick: 0.25))       // 1 left shoulder
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.0, 0.25), wick: 0.25))     // 2 trough
            out.append(g.c(open: out.last!.close, close: head - g.u(0.0, 0.3), wick: 0.25))      // 3 head
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.0, 0.25), wick: 0.25))     // 4 trough
            out.append(g.c(open: out.last!.close, close: sh - g.u(0.0, 0.3), wick: 0.25))        // 5 right shoulder
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.9, 1.5), wick: 0.25))      // 6 break down
            return ChartModel(candles: out, support: neck, highlight: 3)
        case .inverseHeadShoulders:
            // Mirror image: three troughs, lower head, with a neckline along the
            // two peaks, then a break above.
            let neck = base + 2.5, sh = base + 1.2, head = base + 0.0
            var out: [Candle] = []
            out.append(g.c(open: neck + g.u(0.2, 0.6), close: sh + g.u(0.2, 0.5), wick: 0.25))   // drop
            out.append(g.c(open: out.last!.close, close: sh + g.u(0.0, 0.25), wick: 0.25))       // 1 left shoulder
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.0, 0.25), wick: 0.25))     // 2 peak
            out.append(g.c(open: out.last!.close, close: head + g.u(0.0, 0.3), wick: 0.25))      // 3 head
            out.append(g.c(open: out.last!.close, close: neck - g.u(0.0, 0.25), wick: 0.25))     // 4 peak
            out.append(g.c(open: out.last!.close, close: sh + g.u(0.0, 0.3), wick: 0.25))        // 5 right shoulder
            out.append(g.c(open: out.last!.close, close: neck + g.u(0.9, 1.5), wick: 0.25))      // 6 break up
            return ChartModel(candles: out, resistance: neck, highlight: 3)

        case .ascendingTriangle:
            // Flat resistance on top, rising lows underneath, then a break up.
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
            // Flat support on the bottom, falling highs above, then a break down.
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
            // Converging: lower highs and higher lows narrowing toward a point.
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
            // A strong up "pole", a small downward-drifting "flag", then continuation up.
            var out: [Candle] = []; var p = base
            out.append(g.c(open: p, close: p + g.u(1.6, 2.2), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(1.4, 2.0), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(1.4, 2.0), wick: 0.12))
            return ChartModel(candles: out, highlight: 0)
        case .bearFlag:
            // A strong down pole, a small upward-drifting flag, then continuation down.
            var out: [Candle] = []; var p = base + 3
            out.append(g.c(open: p, close: p - g.u(1.6, 2.2), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(1.4, 2.0), wick: 0.12)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(1.4, 2.0), wick: 0.12))
            return ChartModel(candles: out, highlight: 0)
        case .risingWedge:
            // Higher highs and higher lows, but converging (lows rise faster), then break down.
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
            // Lower highs and lower lows, but converging (highs fall faster), then break up.
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
            // Price oscillating between a flat support and a flat resistance.
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
            // Break above resistance, pull back to retest it (now support), continue up.
            let R = base + 1.5
            var out: [Candle] = []
            out.append(g.c(open: R - g.u(1.3, 1.8), close: R - g.u(0.1, 0.4), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R - g.u(0.6, 1.0), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: R + g.u(1.0, 1.5), wick: 0.2))   // breakout
            out.append(g.c(open: out.last!.close, close: R + g.u(0.05, 0.3), wick: 0.2))  // retest
            out.append(g.c(open: out.last!.close, close: R + g.u(1.2, 1.8), wick: 0.2))   // continue
            return ChartModel(candles: out, resistance: R, highlight: 3)
        case .breakdownRetest:
            // Break below support, pull back to retest it (now resistance), continue down.
            let S = base + 1.5
            var out: [Candle] = []
            out.append(g.c(open: S + g.u(1.3, 1.8), close: S + g.u(0.1, 0.4), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S + g.u(0.6, 1.0), wick: 0.2))
            out.append(g.c(open: out.last!.close, close: S - g.u(1.0, 1.5), wick: 0.2))   // breakdown
            out.append(g.c(open: out.last!.close, close: S - g.u(0.05, 0.3), wick: 0.2))  // retest
            out.append(g.c(open: out.last!.close, close: S - g.u(1.2, 1.8), wick: 0.2))   // continue
            return ChartModel(candles: out, support: S, highlight: 3)

        case .gapUp:
            // A jump up: the gap candle opens above the prior candle's high (empty space).
            var out: [Candle] = []; var p = base
            out.append(g.c(open: p, close: p + g.u(0.4, 0.8), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2))
            let go = out.last!.high + g.u(0.9, 1.5)   // open clearly above prior high → gap
            out.append(Candle(open: go, high: go + g.u(0.4, 0.8), low: go - g.u(0.0, 0.12), close: go + g.u(0.3, 0.7)))
            p = out.last!.close
            out.append(g.c(open: p, close: p + g.u(0.3, 0.6), wick: 0.2))
            return ChartModel(candles: out, highlight: 2)
        case .gapDown:
            // A jump down: the gap candle opens below the prior candle's low.
            var out: [Candle] = []; var p = base + 3
            out.append(g.c(open: p, close: p - g.u(0.4, 0.8), wick: 0.2)); p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2))
            let go = out.last!.low - g.u(0.9, 1.5)   // open clearly below prior low → gap
            out.append(Candle(open: go, high: go + g.u(0.0, 0.12), low: go - g.u(0.4, 0.8), close: go - g.u(0.3, 0.7)))
            p = out.last!.close
            out.append(g.c(open: p, close: p - g.u(0.3, 0.6), wick: 0.2))
            return ChartModel(candles: out, highlight: 2)

        case .volatile:
            // Large, erratic swings with long wicks — no clear direction.
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
            // A real trailing moving average computed from these closes: price
            // dips first (so the average lags below), then rallies to reclaim
            // it. The MA curves with price rather than sitting flat — the
            // crossing lands at index 3 as a consequence of the shape, not a
            // hardcoded line position.
            let deltas = [0.0, -0.6, -1.2, -0.5, 0.9, 1.6]
            var out: [Candle] = []; var p = base + deltas[0] - 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let mid = simpleMovingAverage(deltas.map { base + $0 }, window: 3)
            return ChartModel(candles: out, highlight: 3, maLine: mid)
        case .priceBelowMA:
            // Mirror: price rallies first (MA lags above), then sells off to lose it.
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
            // Two real moving averages of the same closes: a fast one (short
            // window, hugs price) and a slow one (long window, lags). The dip-
            // then-rally shape makes the fast line cross up through the slow
            // line at index 3, the same way an actual crossover would form.
            let deltas = [0.0, -0.6, -1.2, -0.5, 0.9, 1.6]
            var out: [Candle] = []; var p = base + deltas[0] - 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let closes = deltas.map { base + $0 }
            let fast = simpleMovingAverage(closes, window: 1)
            let slow = simpleMovingAverage(closes, window: 4)
            return ChartModel(candles: out, highlight: 3, maLine: slow, maLine2: fast)
        case .maCrossDown:
            // Mirror: fast line crosses down through the slow line at index 3.
            let deltas = [0.0, 0.6, 1.2, 0.5, -0.9, -1.6]
            var out: [Candle] = []; var p = base + deltas[0] + 0.3
            for d in deltas { let cl = base + d; out.append(g.c(open: p, close: cl, wick: 0.2)); p = cl }
            let closes = deltas.map { base + $0 }
            let fast = simpleMovingAverage(closes, window: 1)
            let slow = simpleMovingAverage(closes, window: 4)
            return ChartModel(candles: out, highlight: 3, maLine: slow, maLine2: fast)

        case .bandsWidening:
            // Bands widen as candle ranges grow (volatility rising). The
            // middle line is a real moving average of these same closes, so
            // it curves with price instead of sitting flat; band half-width
            // still trends wider but with per-candle jitter, not a ruler edge.
            var out: [Candle] = []; var p = base + 1.0; var closes: [Double] = []
            let wicks = [0.15, 0.2, 0.3, 0.5, 0.7, 0.9]
            for w in wicks { let cl = p + g.u(-0.3, 0.3); out.append(g.c(open: p, close: cl, wick: w)); closes.append(cl); p = cl }
            let mid = simpleMovingAverage(closes, window: 3)
            let halfWidths = [0.3, 0.45, 0.65, 0.95, 1.3, 1.7].map { $0 + g.u(-0.08, 0.08) }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, maLine: mid, bandUpper: upper, bandLower: lower)
        case .bandsNarrowing:
            // Mirror: bands squeeze as candle ranges shrink (calming down).
            var out: [Candle] = []; var p = base + 1.0; var closes: [Double] = []
            let wicks = [0.9, 0.7, 0.5, 0.3, 0.2, 0.15]
            for w in wicks { let cl = p + g.u(-0.3, 0.3); out.append(g.c(open: p, close: cl, wick: w)); closes.append(cl); p = cl }
            let mid = simpleMovingAverage(closes, window: 3)
            let halfWidths = [1.7, 1.3, 0.95, 0.65, 0.45, 0.3].map { $0 + g.u(-0.08, 0.08) }
            let upper = zip(mid, halfWidths).map { $0 + $1 }
            let lower = zip(mid, halfWidths).map { $0 - $1 }
            return ChartModel(candles: out, maLine: mid, bandUpper: upper, bandLower: lower)

        case .touchUpperBand:
            // Price consolidates, then stretches out on a fixed candle (index 4)
            // to touch the upper band. The band's middle is a real moving
            // average of these closes, so it curves with the consolidation
            // rather than being a flat reference the price ignores.
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
            // Mirror: price stretches down to touch the lower band on a fixed candle.
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
            // Price zig-zags UP between two rising, parallel boundaries. Even
            // candles pull back to the lower boundary, odd candles push to the
            // upper one — the two boundary lines stay a fixed distance apart.
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
            // Mirror: price zig-zags DOWN between two falling, parallel boundaries.
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
