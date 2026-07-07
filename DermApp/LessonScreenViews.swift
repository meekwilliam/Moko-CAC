import SwiftUI
import Combine

// MARK: - Mascot speech-bubble prompt
// Renders the Moko mascot (buisness.svg) beside a speech bubble holding the
// question — a Duolingo-style character prompt. Currently wired to the very
// first question only (see ChoiceView.isFirstEverQuestion) as a preview.

struct MascotIcon: View {
    // The pupils (iris + highlight) are split into their own layer so they can
    // be offset independently — the eyes randomly dart around while the rest of
    // the face stays put. NOTE: if the mascot art is swapped, re-split the new
    // pupil paths here (there's no generic "find the eyes" for arbitrary SVGs).
    @State private var eye: CGSize = .zero
    private let lookTimer = Timer.publish(every: 1.7, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            SVGIconView(svg: Self.base)
            SVGIconView(svg: Self.pupils)
                .offset(eye)
        }
        .onReceive(lookTimer) { _ in
            withAnimation(.easeInOut(duration: 0.32)) { eye = Self.randomLook() }
        }
    }

    // Small offset in points; kept inside the eye whites. ~1-in-4 recenters.
    private static func randomLook() -> CGSize {
        if Int.random(in: 0..<4) == 0 { return .zero }
        return CGSize(width: .random(in: -2.5...2.5), height: .random(in: -1...1))
    }

    // Polar-bear mascot (polar.svg). Face minus pupils; the SVG's opaque
    // background <rect> is dropped so it reads as a cutout. The art fills the
    // full 179×260 viewBox (frame aspect matched in MascotPrompt).
    private static let base = SVGParser.parse("""
    <svg viewBox="0 0 179 260" fill="none">
    <path d="M30.4786 37.4317C32.1752 25.052 42.7517 15.8262 55.2471 15.8262H117.918C130.17 15.8262 140.617 24.7059 142.591 36.7983L179 259.826H0L30.4786 37.4317Z" fill="#E7DFD4"/>
    <rect x="72" y="60.8262" width="30" height="60" rx="15" fill="#F1EBE4"/>
    <path d="M82 62.8262C82 61.1693 83.3431 59.8262 85 59.8262H89C90.6569 59.8262 92 61.1693 92 62.8262C92 64.483 90.6569 65.8262 89 65.8262H85C83.3431 65.8262 82 64.483 82 62.8262Z" fill="#211F1F"/>
    <path d="M86 49.3262C86 50.3111 85.7155 51.2864 85.1627 52.1963C84.6099 53.1062 83.7996 53.933 82.7782 54.6295C81.7567 55.3259 80.5441 55.8784 79.2095 56.2553C77.8749 56.6322 76.4445 56.8262 75 56.8262C73.5555 56.8262 72.1251 56.6322 70.7905 56.2553C69.4559 55.8784 68.2433 55.3259 67.2218 54.6295C66.2004 53.933 65.3901 53.1062 64.8373 52.1963C64.2845 51.2864 64 50.3111 64 49.3262L75 49.3262H86Z" fill="#FEFAFA"/>
    <path d="M88 49.3262C88 50.3111 88.2845 51.2864 88.8373 52.1963C89.3901 53.1062 90.2004 53.933 91.2218 54.6295C92.2433 55.3259 93.4559 55.8784 94.7905 56.2553C96.1251 56.6322 97.5555 56.8262 99 56.8262C100.445 56.8262 101.875 56.6322 103.21 56.2553C104.544 55.8784 105.757 55.3259 106.778 54.6295C107.8 53.933 108.61 53.1062 109.163 52.1963C109.715 51.2864 110 50.3111 110 49.3262L99 49.3262H88Z" fill="#FEFAFA"/>
    <rect x="62" y="46.8262" width="50" height="3" rx="1.5" fill="#CDC4B7"/>
    <rect x="20" y="6.23047" width="16" height="19" rx="8" transform="rotate(-36 20 6.23047)" fill="#E7DFD4"/>
    <rect width="16" height="19" rx="8" transform="matrix(-0.809017 -0.587785 -0.587785 0.809017 154.112 6.23047)" fill="#E7DFD4"/>
    </svg>
    """)

    private static let pupils = SVGParser.parse("""
    <svg viewBox="0 0 179 260" fill="none">
    <path d="M82 49.8262C82 50.3515 81.8965 50.8716 81.6955 51.3569C81.4945 51.8422 81.1999 52.2832 80.8284 52.6546C80.457 53.026 80.016 53.3207 79.5307 53.5217C79.0454 53.7227 78.5253 53.8262 78 53.8262C77.4747 53.8262 76.9546 53.7227 76.4693 53.5217C75.984 53.3207 75.543 53.026 75.1716 52.6546C74.8001 52.2832 74.5055 51.8422 74.3045 51.3569C74.1035 50.8716 74 50.3515 74 49.8262L78 49.8262H82Z" fill="#211F1F"/>
    <path d="M92 49.8262C92 50.3515 92.1035 50.8716 92.3045 51.3569C92.5055 51.8422 92.8001 52.2832 93.1716 52.6546C93.543 53.026 93.984 53.3207 94.4693 53.5217C94.9546 53.7227 95.4747 53.8262 96 53.8262C96.5253 53.8262 97.0454 53.7227 97.5307 53.5217C98.016 53.3207 98.457 53.026 98.8284 52.6546C99.1999 52.2832 99.4945 51.8422 99.6955 51.3569C99.8965 50.8716 100 50.3515 100 49.8262L96 49.8262H92Z" fill="#211F1F"/>
    </svg>
    """)
}

/// The mascot beside the question in a 3D speech bubble, tucked so its bottom
/// sits behind whatever follows (answer buttons / chart / etc). Used as the
/// prompt for every question mechanic.
struct MascotPrompt: View {
    let text: String
    var ink: Color
    // Choice questions (MC/TF/…) leave this false: the mascot tucks behind the
    // first answer button. Every other mechanic sets it true: a full-width line
    // runs under the mascot (he "comes out" of it) with the content below.
    var divider: Bool = false
    @Environment(\.colorScheme) private var scheme

    // Shrink the bubble text for longer questions so tall bubbles don't overlap
    // the content/answers below.
    private var fontSize: CGFloat {
        switch text.count {
        case ..<38:  return 19
        case ..<66:  return 17
        case ..<100: return 15
        default:     return 13.5
        }
    }

    var body: some View {
        let face = scheme == .dark ? Color(hex: "#2A2E37") : Color(hex: "#EEF1F6")
        let slab = scheme == .dark ? Color(hex: "#181B21") : Color(hex: "#C7D0DE")
        let line = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#CBD5E1")

        let row = HStack(alignment: .center, spacing: 4) {
            // Frame aspect ≈ the polar-bear viewBox (179×260) so the art fills
            // the width and sits flush-left.
            MascotIcon()
                .frame(width: 92, height: 134)
            Text(RichText.attributed(text,
                                     base: Theme.font(fontSize, .heavy),
                                     bold: Theme.font(fontSize, .black),
                                     color: ink))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 14)
                .padding(.leading, 22)
                .padding(.trailing, 16)
                .background(
                    SpeechBubbleShape()
                        .fill(face)
                        .overlay(SpeechBubbleShape().stroke(slab, lineWidth: 2))
                        .background(SpeechBubbleShape().fill(slab).offset(y: 5))
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        return Group {
            if divider {
                VStack(alignment: .leading, spacing: 0) {
                    row
                    // Full-width baseline; nudged up a hair so the mascot's base
                    // reads as emerging from it. Drawn after → sits on top.
                    Rectangle().fill(line).frame(height: 2)
                        .padding(.top, -3)
                }
            } else {
                // Pull the answer buttons up so the character tucks behind the
                // first one (drawn after the mascot, so it covers the overlap).
                row.padding(.bottom, -48).zIndex(-1)
            }
        }
    }
}

/// A rounded speech bubble with a small tail on its left edge pointing at the
/// mascot. The tail sits `tail` points left of the rounded body.
struct SpeechBubbleShape: Shape {
    var corner: CGFloat = 20
    var tail: CGFloat = 12
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let body = CGRect(x: rect.minX + tail, y: rect.minY,
                          width: rect.width - tail, height: rect.height)
        p.addRoundedRect(in: body, cornerSize: CGSize(width: corner, height: corner))
        let cy = rect.midY
        p.move(to: CGPoint(x: body.minX + 2, y: cy - 12))
        p.addLine(to: CGPoint(x: rect.minX, y: cy))
        p.addLine(to: CGPoint(x: body.minX + 2, y: cy + 12))
        p.closeSubpath()
        return p
    }
}

// MARK: - Router

struct LessonScreenRouter: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        switch player.screen.type {
        case "intro":
            IntroView(player: player, ink: ink)
        case "matching":
            MatchingView(player: player, ink: ink)
        case "fill_blank_multi":
            FillBlankMultiView(player: player, ink: ink)
        case "ingredient_match":
            IngredientMatchView(player: player, ink: ink)
        case "sequence_builder", "drag_order":
            OrderBuilderView(player: player, ink: ink)
        case "tap_candle":
            TapCandleView(player: player, ink: ink)
        case "tap_candles":
            TapCandlesView(player: player, ink: ink)
        case "mark_level":
            MarkLevelView(player: player, ink: ink)
        case "draw_trendline":
            TrendlineView(player: player, ink: ink)
        case "mark_consolidation":
            ConsolidationView(player: player, ink: ink)
        case "ohlc_label":
            OHLCLabelView(player: player, ink: ink)
        case "number_slider":
            NumberSliderView(player: player, ink: ink)
        default:
            // true_false / multiple_choice / fill_blank / spot_mistake
            ChoiceView(player: player, ink: ink)
        }
        // Re-key so per-screen @State resets when the step changes.
        // (id applied by parent via player.index)
    }
}

// A stable, per-screen seed so each question's chart is its own variation of the
// pattern (different from the intro's and from other questions), but consistent
// across redraws of the same screen. Derived from the screen's UUID (FNV-1a).
func chartSeed(_ screen: LessonScreen) -> UInt64 {
    let u = screen.id.uuid
    let bytes = [u.0, u.1, u.2, u.3, u.4, u.5, u.6, u.7, u.8, u.9, u.10, u.11, u.12, u.13, u.14, u.15]
    var seed: UInt64 = 0xcbf29ce484222325
    for b in bytes { seed = (seed ^ UInt64(b)) &* 0x100000001b3 }
    return seed
}

// MARK: - Shared question chart
// Any question type can attach a `CHART: <scenario>` line; this renders it above
// the prompt so the learner reads the chart to answer (used by every view below).
struct QuestionChart: View {
    let key: String?
    var height: CGFloat = 150
    var seed: UInt64 = UInt64.random(in: .min ... .max)
    var body: some View {
        if let key, let scenario = ChartScenario(rawValue: key) {
            ScenarioChartView(scenario: scenario, height: height, seed: seed)
        }
    }
}

// MARK: - Intro

struct IntroView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(player.screen.screenTitle ?? player.lesson.title)
                .font(Theme.font(30, .black))
                .foregroundColor(ink)
                .fixedSize(horizontal: false, vertical: true)

            if let text = player.screen.text {
                Text(RichText.attributed(text,
                                         base: Theme.font(17, .medium),
                                         bold: Theme.font(17, .black),
                                         color: ink.opacity(0.85)))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let key = player.screen.chart, let scenario = ChartScenario(rawValue: key) {
                ScenarioChartView(scenario: scenario, seed: chartSeed(player.screen))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
    }
}

// MARK: - Tap the candle (interactive)
// Shows a chart and asks the learner to tap a specific candle. The tapped candle
// gets a blue ring; on reveal the correct candle rings green (and a wrong pick red).

struct TapCandleView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var s: LessonScreen { player.screen }
    private var scenario: ChartScenario? { s.chart.flatMap { ChartScenario(rawValue: $0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MascotPrompt(text: s.question ?? "Tap the candle.", ink: ink, divider: true)

            if let sc = scenario {
                let m = sc.model(seed: chartSeed(s))
                CandlestickChart(
                    candles: m.candles,
                    supportLevel: m.support,
                    resistanceLevel: m.resistance,
                    highlightIndex: nil,   // never pre-highlight — that's the answer
                    maLine: m.maLine,
                    maLineLabel: sc.maLabel,
                    maLine2: m.maLine2,
                    bandUpper: m.bandUpper,
                    bandLower: m.bandLower,
                    bandLabel: m.bandLabel,
                    chosenIndex: player.selectedIndex,
                    revealTarget: player.revealed ? s.target : nil,
                    onTapCandle: { i in
                        guard !player.revealed else { return }
                        Haptics.selection()
                        player.selectedIndex = i
                    },
                    showsAxes: true
                )
                .frame(height: 210)
                .modifier(ChartCard())

                if player.selectedIndex == nil {
                    Label("Tap a candle on the chart", systemImage: "hand.tap.fill")
                        .font(Theme.font(13, .bold))
                        .foregroundColor(Theme.muted)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Tap multiple candles (interactive multi-select)
// "Tap every bearish candle / both peaks." Tapping toggles a candle in/out of the
// selection; Check compares the set to the targets (green = right, orange = missed,
// red = wrong).

struct TapCandlesView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var s: LessonScreen { player.screen }
    private var scenario: ChartScenario? { s.chart.flatMap { ChartScenario(rawValue: $0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MascotPrompt(text: s.question ?? "Tap the candles.", ink: ink, divider: true)

            if let sc = scenario {
                let m = sc.model(seed: chartSeed(s))
                CandlestickChart(
                    candles: m.candles,
                    supportLevel: m.support, resistanceLevel: m.resistance,
                    highlightIndex: nil,
                    maLine: m.maLine,
                    maLine2: m.maLine2,
                    bandUpper: m.bandUpper,
                    bandLower: m.bandLower,
                    bandLabel: m.bandLabel,
                    chosenSet: player.selectedSet,
                    revealTargets: player.revealed ? Set(s.targets ?? []) : nil,
                    onTapCandle: { i in
                        guard !player.revealed else { return }
                        Haptics.selection()
                        if player.selectedSet.contains(i) { player.selectedSet.remove(i) }
                        else { player.selectedSet.insert(i) }
                    },
                    showsAxes: true
                )
                .frame(height: 210)
                .modifier(ChartCard())

                Label(player.selectedSet.isEmpty ? "Tap all the candles that match" : "\(player.selectedSet.count) selected — tap Check when done",
                      systemImage: "hand.tap.fill")
                    .font(Theme.font(13, .bold))
                    .foregroundColor(Theme.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Mark the level (interactive) — drag a horizontal line to support/resistance

struct MarkLevelView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @State private var lineY: CGFloat = 105   // starts mid-chart
    @State private var didInit = false

    private let chartHeight: CGFloat = 210
    private var s: LessonScreen { player.screen }
    private var scenario: ChartScenario? { s.chart.flatMap { ChartScenario(rawValue: $0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MascotPrompt(text: s.question ?? "Drag the line to the level.", ink: ink, divider: true)

            if let sc = scenario {
                let m = sc.model(seed: chartSeed(s))
                let (lo, range) = priceRange(m.candles)
                let isResistance = (s.levelKind == "resistance")
                let truth = (isResistance ? m.resistance : m.support) ?? (lo + range / 2)
                let tol = range * 0.06

                ZStack(alignment: .topLeading) {
                    // Chart WITHOUT the level drawn (that's the answer).
                    CandlestickChart(candles: m.candles, highlightIndex: nil)
                        .frame(height: chartHeight)

                    // The user's draggable line.
                    let userColor = player.revealed
                        ? (abs(price(lineY, lo, range) - truth) <= tol ? Color(hex: "#22C55E") : Color(hex: "#EF4444"))
                        : Theme.answer
                    levelLine(y: lineY, color: userColor, label: player.revealed ? "You" : "Drag me")

                    // On reveal, show the true level too.
                    if player.revealed {
                        let ty = yFor(truth, lo, range)
                        levelLine(y: ty, color: Color(hex: "#22C55E"),
                                  label: isResistance ? "Resistance" : "Support", dashed: true)
                    }
                }
                .frame(height: chartHeight)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0).onChanged { g in
                        guard !player.revealed else { return }
                        lineY = min(max(g.location.y, 0), chartHeight)
                        player.markedLevel = price(lineY, lo, range)
                    }
                )
                .modifier(ChartCard())
                .onAppear {
                    player.markTrueLevel = truth
                    player.markTolerance = tol
                    if !didInit { player.markedLevel = price(lineY, lo, range); didInit = true }
                }

                Label("Drag the blue line onto the level, then Check",
                      systemImage: "hand.draw.fill")
                    .font(Theme.font(13, .bold))
                    .foregroundColor(Theme.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // Chart's exact price↔y mapping (candles only, matching CandlestickChart).
    private func priceRange(_ candles: [Candle]) -> (lo: Double, range: Double) {
        let values = candles.flatMap { [$0.high, $0.low] }
        let maxV = values.max() ?? 1, minV = values.min() ?? 0
        let pad = max(maxV - minV, 0.0001) * 0.1
        let lo = minV - pad, hi = maxV + pad
        return (lo, max(hi - lo, 0.0001))
    }
    private func price(_ y: CGFloat, _ lo: Double, _ range: Double) -> Double {
        lo + (1 - Double(y / chartHeight)) * range
    }
    private func yFor(_ v: Double, _ lo: Double, _ range: Double) -> CGFloat {
        chartHeight * CGFloat(1 - (v - lo) / range)
    }

    private func levelLine(y: CGFloat, color: Color, label: String, dashed: Bool = false) -> some View {
        ZStack(alignment: .topTrailing) {
            Path { p in p.move(to: CGPoint(x: 0, y: y)); p.addLine(to: CGPoint(x: 5000, y: y)) }
                .stroke(color, style: StrokeStyle(lineWidth: 2.5, dash: dashed ? [5, 4] : []))
            Text(label.uppercased())
                .font(Theme.font(9, .black)).foregroundColor(.white)
                .padding(.horizontal, 5).padding(.vertical, 2)
                .background(
                    Capsule().fill(color)
                        .background(Capsule().fill(Color.black.opacity(0.4)).offset(y: 2.5))
                )
                .offset(y: y - 18)
        }
    }
}

// MARK: - Draw a trendline (interactive) — drag between two candles to connect them

struct TrendlineView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @State private var dragActive = false

    private let chartHeight: CGFloat = 210
    private var s: LessonScreen { player.screen }
    private var scenario: ChartScenario? { s.chart.flatMap { ChartScenario(rawValue: $0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MascotPrompt(text: s.question ?? "Drag to connect the two points on the chart.", ink: ink, divider: true)

            if let sc = scenario {
                let m = sc.model(seed: chartSeed(s))
                let (lo, range) = priceRange(m.candles)
                let n = max(m.candles.count, 1)

                GeometryReader { geo in
                    let slot = geo.size.width / CGFloat(n)
                    let correct = isCorrect

                    ZStack(alignment: .topLeading) {
                        CandlestickChart(candles: m.candles, highlightIndex: nil)
                            .frame(width: geo.size.width, height: chartHeight)

                        if let a = player.trendStart, let b = player.trendEnd {
                            let color: Color = player.revealed
                                ? (correct ? Color(hex: "#22C55E") : Color(hex: "#EF4444"))
                                : Theme.answer
                            trendLine(a, b, m.candles, slot, lo, range, color: color)
                        }

                        if player.revealed, let ts = s.targetStart, let te = s.targetEnd, !correct {
                            trendLine(ts, te, m.candles, slot, lo, range, color: Color(hex: "#22C55E"), dashed: true)
                        }

                        Rectangle().fill(Color.white.opacity(0.001))
                            .frame(width: geo.size.width, height: chartHeight)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { g in
                                        guard !player.revealed else { return }
                                        if !dragActive {
                                            dragActive = true
                                            player.trendStart = indexFor(g.startLocation.x, slot, n)
                                        }
                                        player.trendEnd = indexFor(g.location.x, slot, n)
                                    }
                                    .onEnded { _ in dragActive = false }
                            )
                    }
                }
                .frame(height: chartHeight)
                .modifier(ChartCard())

                Label(player.trendStart == nil ? "Drag from one point to the other" : "Adjust or tap Check",
                      systemImage: "hand.draw.fill")
                    .font(Theme.font(13, .bold))
                    .foregroundColor(Theme.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var isCorrect: Bool {
        guard let a = player.trendStart, let b = player.trendEnd,
              let ts = s.targetStart, let te = s.targetEnd else { return false }
        let chosen = Set([a, b]), target = Set([ts, te])
        return chosen.count == 2 && target.count == 2 &&
            abs(chosen.min()! - target.min()!) <= 1 && abs(chosen.max()! - target.max()!) <= 1
    }

    private func indexFor(_ x: CGFloat, _ slot: CGFloat, _ n: Int) -> Int {
        min(max(Int(x / max(slot, 1)), 0), n - 1)
    }

    private func priceRange(_ candles: [Candle]) -> (lo: Double, range: Double) {
        let values = candles.flatMap { [$0.high, $0.low] }
        let maxV = values.max() ?? 1, minV = values.min() ?? 0
        let pad = max(maxV - minV, 0.0001) * 0.1
        let lo = minV - pad, hi = maxV + pad
        return (lo, max(hi - lo, 0.0001))
    }

    private func yFor(_ v: Double, _ lo: Double, _ range: Double) -> CGFloat {
        chartHeight * CGFloat(1 - (v - lo) / range)
    }

    @ViewBuilder
    private func trendLine(_ a: Int, _ b: Int, _ candles: [Candle], _ slot: CGFloat,
                            _ lo: Double, _ range: Double, color: Color, dashed: Bool = false) -> some View {
        if candles.indices.contains(a) && candles.indices.contains(b) {
            let ax = slot * (CGFloat(a) + 0.5), bx = slot * (CGFloat(b) + 0.5)
            let av = (candles[a].open + candles[a].close) / 2
            let bv = (candles[b].open + candles[b].close) / 2
            Path { p in
                p.move(to: CGPoint(x: ax, y: yFor(av, lo, range)))
                p.addLine(to: CGPoint(x: bx, y: yFor(bv, lo, range)))
            }
            .stroke(color, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, dash: dashed ? [5, 4] : []))
        }
    }
}

// MARK: - Mark a consolidation area (interactive) — drag across candles to select a range

struct ConsolidationView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private let chartHeight: CGFloat = 210
    private var s: LessonScreen { player.screen }
    private var scenario: ChartScenario? { s.chart.flatMap { ChartScenario(rawValue: $0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MascotPrompt(text: s.question ?? "Drag across the consolidation area.", ink: ink, divider: true)

            if let sc = scenario {
                let m = sc.model(seed: chartSeed(s))
                let n = max(m.candles.count, 1)

                GeometryReader { geo in
                    let slot = geo.size.width / CGFloat(n)
                    let correct = isCorrect

                    ZStack(alignment: .topLeading) {
                        CandlestickChart(candles: m.candles, highlightIndex: nil)
                            .frame(width: geo.size.width, height: chartHeight)

                        if let lo = player.consolidationLo, let hi = player.consolidationHi {
                            let color: Color = player.revealed
                                ? (correct ? Color(hex: "#22C55E") : Color(hex: "#EF4444"))
                                : Theme.answer
                            areaRect(lo, hi, slot, geo.size.height, color: color)
                        }

                        if player.revealed, let tlo = s.targetLo, let thi = s.targetHi, !correct {
                            areaRect(tlo, thi, slot, geo.size.height, color: Color(hex: "#22C55E"), dashed: true)
                        }

                        Rectangle().fill(Color.white.opacity(0.001))
                            .frame(width: geo.size.width, height: chartHeight)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { g in
                                        guard !player.revealed else { return }
                                        let a = indexFor(g.startLocation.x, slot, n)
                                        let b = indexFor(g.location.x, slot, n)
                                        player.consolidationLo = min(a, b)
                                        player.consolidationHi = max(a, b)
                                    }
                            )
                    }
                }
                .frame(height: chartHeight)
                .modifier(ChartCard())

                Label(player.consolidationLo == nil ? "Drag across the candles that fit" : "Adjust or tap Check",
                      systemImage: "hand.draw.fill")
                    .font(Theme.font(13, .bold))
                    .foregroundColor(Theme.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var isCorrect: Bool {
        guard let lo = player.consolidationLo, let hi = player.consolidationHi,
              let tlo = s.targetLo, let thi = s.targetHi else { return false }
        return abs(lo - tlo) <= 1 && abs(hi - thi) <= 1
    }

    private func indexFor(_ x: CGFloat, _ slot: CGFloat, _ n: Int) -> Int {
        min(max(Int(x / max(slot, 1)), 0), n - 1)
    }

    private func areaRect(_ lo: Int, _ hi: Int, _ slot: CGFloat, _ height: CGFloat,
                           color: Color, dashed: Bool = false) -> some View {
        let x = slot * CGFloat(lo)
        let width = slot * CGFloat(hi - lo + 1)
        return RoundedRectangle(cornerRadius: 6, style: .continuous)
            .strokeBorder(color, style: StrokeStyle(lineWidth: 2, dash: dashed ? [5, 4] : []))
            .background(RoundedRectangle(cornerRadius: 6, style: .continuous).fill(color.opacity(dashed ? 0 : 0.14)))
            .frame(width: width, height: height - 4)
            .position(x: x + width / 2, y: height / 2)
    }
}

// MARK: - Label the candle (interactive) — drag Open/High/Low/Close onto a candle
// Four draggable chips, four slots at the candle's key levels (top wick, body
// top, body bottom, bottom wick). Which label belongs to which body edge depends
// on whether the candle is bullish or bearish (chosen by the screen's seed).

struct OHLCLabelView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var s: LessonScreen { player.screen }
    private let areaH: CGFloat = 250
    // Label ids: 0 = Open, 1 = High, 2 = Low, 3 = Close.
    private let labelNames = ["Open", "High", "Low", "Close"]
    // Slots: 0 = top wick, 1 = body top, 2 = body bottom, 3 = bottom wick.

    @State private var slotFrames: [Int: CGRect] = [:]
    @State private var dragging: Int? = nil
    @State private var dragPoint: CGPoint = .zero
    @State private var didInit = false

    /// Bullish (green) candle chosen by the stable per-screen seed. On a bullish
    /// candle the close is the body top and the open is the body bottom; bearish
    /// is the reverse. High is always the top wick, Low always the bottom wick.
    private var bullish: Bool { chartSeed(s) % 2 == 0 }
    private var expected: [Int: Int] {
        bullish ? [0: 1, 1: 3, 2: 0, 3: 2]    // top=High, bodyTop=Close, bodyBot=Open, bottom=Low
                : [0: 1, 1: 0, 2: 3, 3: 2]    // top=High, bodyTop=Open,  bodyBot=Close, bottom=Low
    }
    private var trayLabels: [Int] {
        (0..<4).filter { lbl in !player.ohlcPlacement.values.contains(lbl) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            MascotPrompt(text: s.question ?? "Drag each label onto the matching part of the candle.", ink: ink, divider: true)

            candleArea
            tray
        }
        .coordinateSpace(name: "ohlc")
        .frame(maxWidth: .infinity, alignment: .leading)
        .onPreferenceChange(OHLCSlotKey.self) { slotFrames = $0 }
        .onAppear { if !didInit { player.ohlcExpected = expected; didInit = true } }
        .overlay(alignment: .topLeading) {
            if let d = dragging {
                chip(label: d, tint: Theme.answer)
                    .position(dragPoint)
                    .allowsHitTesting(false)
            }
        }
    }

    // MARK: Candle + slots

    private var candleArea: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let cx = w * 0.26
            let ys: [CGFloat] = [areaH * 0.08, areaH * 0.34, areaH * 0.66, areaH * 0.92]
            let slotX = w * 0.66
            let candleColor = bullish ? Color(hex: "#22C55E") : Color(hex: "#EF4444")

            ZStack(alignment: .topLeading) {
                // Wick
                Path { p in p.move(to: CGPoint(x: cx, y: ys[0])); p.addLine(to: CGPoint(x: cx, y: ys[3])) }
                    .stroke(candleColor, lineWidth: 3)
                // Body
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .fill(candleColor)
                    .frame(width: 48, height: ys[2] - ys[1])
                    .position(x: cx, y: (ys[1] + ys[2]) / 2)

                ForEach(0..<4, id: \.self) { i in
                    // Dashed connector from the candle level to its slot.
                    Path { p in p.move(to: CGPoint(x: cx + 26, y: ys[i])); p.addLine(to: CGPoint(x: slotX - 42, y: ys[i])) }
                        .stroke(Color.white.opacity(0.25), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                    slotBox(i).position(x: slotX, y: ys[i])
                }
            }
            .frame(width: w, height: areaH)
        }
        .frame(height: areaH)
    }

    private func slotBox(_ i: Int) -> some View {
        let placed = player.ohlcPlacement[i]
        let tint: Color = {
            guard player.revealed else { return Theme.answer }
            return player.ohlcPlacement[i] == expected[i] ? Color(hex: "#22C55E") : Color(hex: "#EF4444")
        }()
        return ZStack {
            if let label = placed {
                chip(label: label, tint: tint)
                    .opacity(dragging == label ? 0 : 1)
                    .gesture(dragGesture(for: label))
            } else {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                    .frame(width: 84, height: 34)
                    .overlay(Text("?").font(Theme.font(15, .black)).foregroundColor(Color.white.opacity(0.35)))
            }
        }
        .frame(width: 88, height: 38)
        .background(GeometryReader { g in
            Color.clear.preference(key: OHLCSlotKey.self, value: [i: g.frame(in: .named("ohlc"))])
        })
    }

    // MARK: Tray

    private var tray: some View {
        HStack(spacing: 10) {
            ForEach(trayLabels, id: \.self) { label in
                chip(label: label, tint: Color(hex: "#1E293B"))
                    .opacity(dragging == label ? 0 : 1)
                    .gesture(dragGesture(for: label))
            }
            if trayLabels.isEmpty {
                Text("Drag a label back here to move it")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 44, alignment: .center)
    }

    private func chip(label: Int, tint: Color) -> some View {
        Text(labelNames[label])
            .font(Theme.font(14, .black)).foregroundColor(.white)
            .padding(.horizontal, 14).padding(.vertical, 9)
            .background(
                Capsule().fill(tint)
                    .overlay(Capsule().strokeBorder(Color.white.opacity(0.18), lineWidth: 1))
            )
            .background(Capsule().fill(Color.black.opacity(0.35)).offset(y: 3))
    }

    // MARK: Drag handling

    private func dragGesture(for label: Int) -> some Gesture {
        DragGesture(coordinateSpace: .named("ohlc"))
            .onChanged { g in
                guard !player.revealed else { return }
                if dragging == nil { Haptics.selection() }
                dragging = label
                dragPoint = g.location
            }
            .onEnded { g in
                guard !player.revealed else { return }
                drop(label: label, at: g.location)
                dragging = nil
            }
    }

    private func drop(label: Int, at pt: CGPoint) {
        // Lift the label out of any slot it currently occupies.
        var placement = player.ohlcPlacement.filter { $0.value != label }
        // Snap to the nearest slot within range; otherwise it returns to the tray.
        if let nearest = slotFrames.min(by: { dist($0.value, pt) < dist($1.value, pt) }),
           dist(nearest.value, pt) < 64 {
            placement[nearest.key] = label   // any displaced label falls back to the tray
        }
        player.ohlcPlacement = placement
    }

    private func dist(_ rect: CGRect, _ pt: CGPoint) -> CGFloat {
        let dx = rect.midX - pt.x, dy = rect.midY - pt.y
        return (dx * dx + dy * dy).squareRoot()
    }
}

private struct OHLCSlotKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]
    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}

// MARK: - Number slider (interactive) — drag to the calculated answer
// Used for the quantitative units (position sizing, expectancy, drawdowns, …)
// where the question has one correct number rather than a chart target.

struct NumberSliderView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @State private var didInit = false

    private var s: LessonScreen { player.screen }
    private var lo: Double { s.numberMin ?? 0 }
    private var hi: Double { max(s.numberMax ?? 100, lo + 1) }
    private var step: Double { max(s.numberStep ?? 1, 0.0001) }
    private var unit: String { s.numberUnit ?? "" }

    private func format(_ v: Double) -> String {
        let rounded = (v / step).rounded() * step
        if step.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(rounded))"
        }
        return String(format: "%.2f", rounded)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            MascotPrompt(text: s.question ?? "Drag the slider to the correct value.", ink: ink, divider: true)

            VStack(spacing: 14) {
                let value = player.numberValue ?? (lo + hi) / 2
                let correct = player.revealed && s.numberCorrect != nil
                    && abs(value - s.numberCorrect!) <= (s.numberTolerance ?? 0)
                let tint: Color = player.revealed ? (correct ? Theme.correct : Theme.incorrect) : Theme.answer

                Text("\(format(value))\(unit.isEmpty ? "" : " \(unit)")")
                    .font(Theme.font(34, .black))
                    .foregroundColor(tint)
                    .frame(maxWidth: .infinity, alignment: .center)

                ChunkySlider(
                    value: Binding(
                        get: { player.numberValue ?? (lo + hi) / 2 },
                        set: { newValue in
                            guard !player.revealed else { return }
                            let snapped = (newValue / step).rounded() * step
                            player.numberValue = min(max(snapped, lo), hi)
                        }
                    ),
                    range: lo...hi,
                    tint: tint,
                    disabled: player.revealed
                )
                .onAppear {
                    guard !didInit else { return }
                    didInit = true
                    if player.numberValue == nil { player.numberValue = (lo + hi) / 2 }
                }

                HStack {
                    Text("\(format(lo))\(unit.isEmpty ? "" : " \(unit)")")
                    Spacer()
                    Text("\(format(hi))\(unit.isEmpty ? "" : " \(unit)")")
                }
                .font(Theme.font(12, .bold))
                .foregroundColor(Theme.muted)

                if player.revealed, !correct, let truth = s.numberCorrect {
                    Text("Correct: \(format(truth))\(unit.isEmpty ? "" : " \(unit)")")
                        .font(Theme.font(14, .black))
                        .foregroundColor(Theme.correct)
                }
            }
            .padding(18)
            .modifier(ChartCard())

            Label("Drag the slider, then tap Check", systemImage: "hand.draw.fill")
                .font(Theme.font(13, .bold))
                .foregroundColor(Theme.muted)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// A chunky, 3D-styled slider matching the app's slab button language: a
/// raised capsule track with a filled portion up to a raised circular thumb.
/// Replaces the native SwiftUI Slider, which renders flat.
private struct ChunkySlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var tint: Color
    var disabled: Bool

    private let trackHeight: CGFloat = 14
    private let thumbSize: CGFloat = 32
    @State private var dragActive = false

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let frac = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
            let thumbX = min(max(frac, 0), 1) * w

            ZStack(alignment: .leading) {
                // Track base (slab beneath, like every other chunky control).
                Capsule().fill(Color.black.opacity(0.35)).offset(y: 3)
                Capsule().fill(Color.white.opacity(0.10))
                    .overlay(Capsule().strokeBorder(Color.white.opacity(0.12), lineWidth: 1))

                // Filled portion up to the thumb.
                Capsule().fill(tint)
                    .frame(width: thumbX)

                // Thumb.
                Circle().fill(Color.black.opacity(0.4))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: thumbX - thumbSize / 2, y: 3)
                Circle().fill(tint)
                    .overlay(Circle().strokeBorder(Color.white.opacity(0.35), lineWidth: 1.5))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: thumbX - thumbSize / 2)
            }
            .frame(height: trackHeight)
            .contentShape(Rectangle().inset(by: -14))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { g in
                        guard !disabled else { return }
                        if !dragActive { dragActive = true; Haptics.selection() }
                        let f = min(max(g.location.x / w, 0), 1)
                        value = range.lowerBound + Double(f) * (range.upperBound - range.lowerBound)
                    }
                    .onEnded { _ in dragActive = false }
            )
        }
        .frame(height: thumbSize)
    }
}

// MARK: - Choice (true_false / multiple_choice / fill_blank / spot_mistake)

struct ChoiceView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var s: LessonScreen { player.screen }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // A question can attach a chart (e.g. "what's the trend here?")
            // regardless of its underlying type (MC / TF / etc).
            if let key = s.chart, let scenario = ChartScenario(rawValue: key) {
                ScenarioChartView(scenario: scenario, height: 130, seed: chartSeed(player.screen))
            }

            if s.type == "spot_mistake", let scenario = s.scenario {
                scenarioCard(scenario)
            }

            // Chart-analysis questions (read the chart, then answer) keep the
            // old plain-text prompt so the chart stays the focus; questions
            // without a chart get the mascot prompt.
            if s.chart != nil {
                plainPrompt
            } else {
                MascotPrompt(text: displayQuestion(), ink: ink, divider: true)
            }

            VStack(spacing: 14) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { idx, opt in
                    optionButton(idx: idx, label: opt)
                }
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // Old-style prompt: plain question text above the answers (used for
    // chart-analysis questions where the chart is the focus).
    private var plainPrompt: some View {
        Text(RichText.attributed(displayQuestion(),
                                 base: Theme.font(21, .heavy),
                                 bold: Theme.font(21, .black),
                                 color: ink))
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// For fill_blank, fill the [___] with the chosen option (or a blank).
    private func displayQuestion() -> String {
        var q = s.question ?? ""
        if s.type == "fill_blank" {
            let fill: String
            if let sel = player.selectedIndex, let opts = s.options, opts.indices.contains(sel) {
                fill = "<b>\(opts[sel])</b>"
            } else {
                fill = "______"
            }
            q = q.replacingOccurrences(of: "[___]", with: fill)
        }
        return q
    }

    private func scenarioCard(_ scenario: String) -> some View {
        Text(RichText.attributed(scenario,
                                 base: Theme.font(15.5, .semibold),
                                 bold: Theme.font(15.5, .black),
                                 color: .white))
            .lineSpacing(3)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(hex: "#F59E0B"))
                    .background(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(hex: "#B45309")).offset(y: 5))
            )
    }

    private func optionButton(idx: Int, label: String) -> some View {
        let selected = player.selectedIndex == idx
        let revealed = player.revealed
        let isCorrect = idx == player.currentCorrectIndex

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#B8C4D8")
        var textColor = ink

        if revealed {
            if isCorrect {
                fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white
            } else if selected {
                fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white
            }
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.selectedIndex = idx
        } label: {
            HStack {
                Text(label).font(Theme.font(16, .bold))
                Spacer(minLength: 0)
                if revealed && isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                } else if revealed && selected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .modifier(OptionSurface(fill: fill, border: border, slab: slab, textColor: textColor, pressed: false))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(revealed)
        .modifier(AnswerFeedbackFX(pop: revealed && isCorrect,
                                   shake: revealed && selected && !isCorrect))
    }
}

// MARK: - Matching

struct MatchingView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    // Snapshot the pairs/question locally so they can't change out from under
    // `rightOrder` when the player advances to the next (non-matching) screen.
    @State private var pairs: [[String]] = []
    @State private var question: String = ""
    @State private var rightOrder: [Int] = []
    @State private var matchedLeft: Set<Int> = []
    @State private var matchedRight: Set<Int> = []
    @State private var selLeft: Int? = nil
    @State private var selRight: Int? = nil
    @State private var wrongPair: (Int, Int)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            QuestionChart(key: player.screen.chart, height: 130, seed: chartSeed(player.screen))
            MascotPrompt(text: question.isEmpty ? "Match the pairs:" : question, ink: ink, divider: true)

            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 12) {
                    ForEach(pairs.indices, id: \.self) { i in
                        chip(text: pairs[i][safe: 0] ?? "", isLeft: true, index: i)
                    }
                }
                VStack(spacing: 12) {
                    ForEach(rightOrder.indices, id: \.self) { slot in
                        let p = rightOrder[slot]
                        chip(text: (pairs[safe: p]?[safe: 1]) ?? "", isLeft: false, index: slot)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            if pairs.isEmpty {
                pairs = player.screen.pairs ?? []
                question = player.screen.question ?? ""
                rightOrder = Array(pairs.indices).shuffled()
            }
        }
    }

    private func chip(text: String, isLeft: Bool, index: Int) -> some View {
        let matched = isLeft ? matchedLeft.contains(index) : matchedRight.contains(index)
        let selected = isLeft ? (selLeft == index) : (selRight == index)
        let isWrong = wrongPair != nil && ((isLeft && wrongPair!.0 == index) || (!isLeft && wrongPair!.1 == index))

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#B8C4D8")
        var textColor = ink

        if matched {
            fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white
        } else if isWrong {
            fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }

        return Button {
            tap(isLeft: isLeft, index: index)
        } label: {
            Text(text).font(Theme.font(13.5, .bold))
                .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .modifier(OptionSurface(fill: fill, border: border, slab: slab, textColor: textColor, pressed: false))
                .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(matched)
    }

    private func tap(isLeft: Bool, index: Int) {
        guard wrongPair == nil else { return }
        Haptics.selection()
        if isLeft { selLeft = index } else { selRight = index }
        guard let l = selLeft, let r = selRight else { return }

        // rightOrder[r] is the original pair index for the chosen right chip.
        if rightOrder[r] == l {
            matchedLeft.insert(l); matchedRight.insert(r)
            selLeft = nil; selRight = nil
            Haptics.impact(.light)
            if matchedLeft.count == pairs.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation { player.markMatchingSolved() }
                }
            }
        } else {
            wrongPair = (l, r)
            Haptics.impact(.rigid)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation { wrongPair = nil; selLeft = nil; selRight = nil }
            }
        }
    }
}

// MARK: - Fill blank (multi)

struct FillBlankMultiView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var blanks: [Blank] { player.screen.blanks ?? [] }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            QuestionChart(key: player.screen.chart, height: 130, seed: chartSeed(player.screen))
            MascotPrompt(text: filledTemplate(), ink: ink, divider: true)

            ForEach(blanks.indices, id: \.self) { bi in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Blank \(bi + 1)")
                        .font(Theme.font(12, .black))
                        .foregroundColor(Theme.muted)
                    FlowChips(options: blanks[bi].options,
                              selected: player.multiSelections[safe: bi] ?? nil,
                              revealed: player.revealed,
                              correctIndex: blanks[bi].correct,
                              ink: ink,
                              scheme: scheme) { idx in
                        guard !player.revealed else { return }
                        Haptics.selection()
                        if player.multiSelections.count == blanks.count {
                            player.multiSelections[bi] = idx
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func filledTemplate() -> String {
        var t = player.screen.template ?? ""
        for (i, b) in blanks.enumerated() {
            let token = "[__\(i + 1)__]"
            let fill: String
            if let sel = player.multiSelections[safe: i] ?? nil, b.options.indices.contains(sel) {
                fill = "<b>\(b.options[sel])</b>"
            } else {
                fill = "______"
            }
            t = t.replacingOccurrences(of: token, with: fill)
        }
        return t
    }
}

struct FlowChips: View {
    var options: [String]
    var selected: Int?
    var revealed: Bool
    var correctIndex: Int
    var ink: Color
    var scheme: ColorScheme
    var onTap: (Int) -> Void

    var body: some View {
        HStack(spacing: 10) {
            ForEach(Array(options.enumerated()), id: \.offset) { idx, opt in
                chip(idx: idx, label: opt)
            }
        }
    }

    private func chip(idx: Int, label: String) -> some View {
        let isSel = selected == idx
        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#B8C4D8")
        var textColor = ink
        if revealed && idx == correctIndex {
            fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white
        } else if revealed && isSel {
            fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white
        } else if isSel {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }
        return Button { onTap(idx) } label: {
            Text(label).font(Theme.font(14, .bold)).foregroundColor(textColor)
                .padding(.vertical, 10).padding(.horizontal, 14)
        }
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(fill)
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).strokeBorder(border, lineWidth: 2))
        )
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(slab).offset(y: 4)
        )
        .buttonStyle(SinkButtonStyle(depth: 4))
        .modifier(AnswerFeedbackFX(pop: revealed && idx == correctIndex,
                                   shake: revealed && isSel && idx != correctIndex))
    }
}

// MARK: - Ingredient match (single choice with label + detail)

struct IngredientMatchView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var s: LessonScreen { player.screen }
    private var options: [IngredientOption] { s.ingredientOptions ?? [] }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            QuestionChart(key: s.chart, height: 130, seed: chartSeed(player.screen))

            MascotPrompt(text: s.question ?? "", ink: ink, divider: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 14) {
                ForEach(Array(options.enumerated()), id: \.offset) { idx, opt in
                    optionButton(idx: idx, opt: opt)
                }
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func optionButton(idx: Int, opt: IngredientOption) -> some View {
        let selected = player.selectedIndex == idx
        let revealed = player.revealed
        let isCorrect = (opt.correct == true)

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#B8C4D8")
        var textColor = ink
        var subColor = Theme.muted

        if revealed {
            if isCorrect { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white; subColor = .white.opacity(0.85) }
            else if selected { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white; subColor = .white.opacity(0.85) }
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white; subColor = .white.opacity(0.85)
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.selectedIndex = idx
        } label: {
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(opt.label).font(Theme.font(16, .black)).foregroundColor(textColor)
                    // Only reveal the detail subtitle after checking — showing it up
                    // front (e.g. "Overstates certainty" on a wrong option) gives
                    // away the answer before the learner picks.
                    if revealed, let detail = opt.detail {
                        Text(detail).font(Theme.font(13, .semibold)).foregroundColor(subColor)
                    }
                }
                Spacer(minLength: 0)
                if revealed && isCorrect { Image(systemName: "checkmark.circle.fill").foregroundColor(.white) }
                else if revealed && selected { Image(systemName: "xmark.circle.fill").foregroundColor(.white) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15).padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(border, lineWidth: 2))
            )
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(slab).offset(y: 5))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(revealed)
        .modifier(AnswerFeedbackFX(pop: revealed && isCorrect,
                                   shake: revealed && selected && !isCorrect))
    }
}

// MARK: - Order builder (sequence_builder / drag_order)

struct OrderBuilderView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    @State private var items: [String] = []
    @State private var correctOrder: [String] = []
    @State private var question: String = ""

    private var pool: [String] { items.filter { !player.builtOrder.contains($0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            QuestionChart(key: player.screen.chart, height: 130, seed: chartSeed(player.screen))
            MascotPrompt(text: question, ink: ink, divider: true)

            // Built sequence
            VStack(spacing: 10) {
                ForEach(Array(player.builtOrder.enumerated()), id: \.offset) { i, item in
                    builtRow(i: i, item: item)
                }
                if player.builtOrder.count < items.count {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6, 5]))
                        .foregroundColor(Theme.muted.opacity(0.4))
                        .frame(height: 52)
                        .overlay(Text("Tap an item below").font(Theme.font(13, .bold)).foregroundColor(Theme.muted.opacity(0.7)))
                }
            }

            // Pool
            if !pool.isEmpty {
                VStack(spacing: 10) {
                    ForEach(pool, id: \.self) { item in
                        Button {
                            guard !player.revealed else { return }
                            Haptics.selection()
                            player.builtOrder.append(item)
                        } label: {
                            HStack {
                                Text(item).font(Theme.font(15, .bold)).foregroundColor(ink)
                                Spacer(minLength: 0)
                                Image(systemName: "plus.circle.fill").foregroundColor(player.unit.main)
                            }
                            .padding(.vertical, 15).padding(.horizontal, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(scheme == .dark ? Color(hex: "#1E293B") : Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .strokeBorder(scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED"), lineWidth: 2))
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(scheme == .dark ? Color(hex: "#334155") : Color(hex: "#B8C4D8"))
                                    .offset(y: 4)
                            )
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(SinkButtonStyle(depth: 4))
                    }
                }
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            if items.isEmpty {
                items = player.screen.items ?? []
                correctOrder = player.screen.correctOrder ?? []
                question = player.screen.question ?? ""
            }
        }
    }

    private func builtRow(i: Int, item: String) -> some View {
        let revealed = player.revealed
        let rightPlace = revealed && (correctOrder[safe: i] == item)

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = player.unit.main
        var slab = border
        var textColor = ink
        if revealed {
            if rightPlace { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white }
            else { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white }
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.builtOrder.removeAll { $0 == item }
        } label: {
            HStack(spacing: 12) {
                Text("\(i + 1)")
                    .font(Theme.font(15, .black))
                    .foregroundColor(revealed ? .white : player.unit.main)
                    .frame(width: 26, height: 26)
                    .background(Circle().fill((revealed ? Color.white : player.unit.main).opacity(revealed ? 0.25 : 0.15)))
                Text(item).font(Theme.font(15, .bold)).foregroundColor(textColor)
                Spacer(minLength: 0)
                if !revealed { Image(systemName: "xmark.circle.fill").foregroundColor(Theme.muted.opacity(0.5)) }
            }
            .padding(.vertical, 13).padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous).fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(border, lineWidth: 2))
            )
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous).fill(slab).offset(y: 4)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 4))
        .disabled(revealed)
    }
}
