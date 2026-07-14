import SwiftUI
import Combine

// MARK: - Order-flow interactive mechanics
// Two question types that teach how orders move price, both graded through the
// standard selectedIndex path (0/1):
//   • aggressor  — watch a live order-book ladder get consumed, tap whether the
//                  aggressor is the buyer or the seller.
//   • book_drag  — drag a MARKET order onto the side it fills against (bid/ask).

private let askColor = Theme.seller
private let bidColor = Theme.buyer

/// One resting price level in the book.
private struct BookLevel: Identifiable {
    let id = UUID()
    let price: Double
    var size: Int
    let isAsk: Bool
}

/// Deterministic little book around a mid price: `depth` asks above, `depth`
/// bids below, sizes seeded so the same screen always looks the same.
private func makeBook(seed: UInt64, depth: Int = 5) -> [BookLevel] {
    var rng = SplitMix(seed: seed)
    let mid = 100.0 + Double(rng.next() % 400) / 10.0   // 100.0–140.0
    let tick = 0.05
    var asks: [BookLevel] = [], bids: [BookLevel] = []
    for i in 0..<depth {
        let sz = 2 + Int(rng.next() % 18)
        asks.append(BookLevel(price: mid + tick * Double(i + 1), size: sz, isAsk: true))
        let sz2 = 2 + Int(rng.next() % 18)
        bids.append(BookLevel(price: mid - tick * Double(i + 1), size: sz2, isAsk: false))
    }
    // asks displayed high→low (best ask nearest the spread), bids high→low.
    return asks.reversed() + bids
}

private struct SplitMix {
    var state: UInt64
    init(seed: UInt64) { state = seed == 0 ? 0x9E3779B97F4A7C15 : seed }
    mutating func next() -> UInt64 {
        state = state &+ 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}

// MARK: - Shared 3D option buttons

/// The app's standard chunky option button (sinks onto a slab on press, reveals
/// green/red) — shared by every order-flow single-select question so their
/// answers match the multiple-choice look instead of a flat card.
struct OFOption: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    let index: Int
    let label: String
    var ink: Color
    var dense: Bool = false   // tighter vertical padding for content-dense screens

    var body: some View {
        let selected = player.selectedIndex == index
        let revealed = player.revealed
        let isCorrect = index == player.currentCorrectIndex
        var fill = Theme.optionFill(scheme)
        var border = Theme.optionBorder(scheme)
        var slab = Theme.optionSlab(scheme)
        var textColor = ink
        if revealed {
            if isCorrect { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white }
            else if selected { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white }
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }
        return Button {
            guard !revealed else { return }
            Haptics.selection(); player.selectedIndex = index
        } label: {
            HStack(spacing: 8) {
                Text(label).font(Theme.questionFont(15, .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                if revealed && isCorrect { Image(systemName: "checkmark.circle.fill") }
                else if revealed && selected { Image(systemName: "xmark.circle.fill") }
            }
            .modifier(OptionSurface(fill: fill, border: border, textColor: textColor, vpad: dense ? 11 : 16))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 16, depth: 5))
        .disabled(revealed)
    }
}

/// Multi-select 3D option (evidence_select): toggles selectedSet, capped at the
/// required number of picks.
struct OFMultiOption: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    let index: Int
    let label: String
    var ink: Color

    var body: some View {
        let selected = player.selectedSet.contains(index)
        let revealed = player.revealed
        let isCorrect = Set(player.screen.targets ?? []).contains(index)
        let needed = player.screen.targets?.count ?? 2
        var fill = Theme.optionFill(scheme)
        var border = Theme.optionBorder(scheme)
        var slab = Theme.optionSlab(scheme)
        var textColor = ink
        if revealed {
            if isCorrect { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white }
            else if selected { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white }
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }
        return Button {
            guard !revealed else { return }
            Haptics.selection()
            if selected { player.selectedSet.remove(index) }
            else if player.selectedSet.count < needed { player.selectedSet.insert(index) }
        } label: {
            HStack(spacing: 11) {
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .bold))
                Text(label).font(Theme.questionFont(15, .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .modifier(OptionSurface(fill: fill, border: border, textColor: textColor))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 16, depth: 5))
        .disabled(revealed)
    }
}

// MARK: - Ladder view

/// A compact depth-of-market ladder. `consumedAsks` / `consumedBids` fade the
/// N front-of-book levels on that side, so an aggressive order visibly eats
/// through resting liquidity without resetting the same book in a loop.
private struct OrderBookLadder: View {
    let levels: [BookLevel]
    var consumedAsks: Int = 0
    var consumedBids: Int = 0

    private var asks: [BookLevel] { levels.filter { $0.isAsk } }       // high → low
    private var bids: [BookLevel] { levels.filter { !$0.isAsk } }      // high → low
    private var maxSize: Int { max(levels.map { $0.size }.max() ?? 1, 1) }

    var body: some View {
        VStack(spacing: 3) {
            ForEach(Array(asks.enumerated()), id: \.element.id) { i, lv in
                // Best ask is the LAST ask row (nearest the spread); consume from there up.
                row(lv, eaten: i >= asks.count - consumedAsks)
            }
            spread
            ForEach(Array(bids.enumerated()), id: \.element.id) { i, lv in
                // Best bid is the FIRST bid row; consume from the top down.
                row(lv, eaten: i < consumedBids)
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 14, style: .continuous).fill(Color.black.opacity(0.22)))
    }

    private var spread: some View {
        HStack {
            Text("SPREAD").font(Theme.font(9, .black)).tracking(1)
                .foregroundColor(Theme.muted)
            Spacer()
        }
        .padding(.vertical, 2)
    }

    private func row(_ lv: BookLevel, eaten: Bool) -> some View {
        let c = lv.isAsk ? askColor : bidColor
        return ZStack(alignment: lv.isAsk ? .trailing : .leading) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 4)
                    .fill(c.opacity(0.28))
                    .frame(width: geo.size.width * CGFloat(lv.size) / CGFloat(maxSize))
                    .frame(maxWidth: .infinity, alignment: lv.isAsk ? .trailing : .leading)
            }
            HStack {
                Text(String(format: "%.2f", lv.price))
                    .font(Theme.marketFont(12, .semibold)).foregroundColor(c)
                Spacer()
                Text("\(lv.size)")
                    .font(Theme.marketFont(12, .medium)).foregroundColor(Theme.muted)
            }
            .padding(.horizontal, 8)
        }
        .frame(height: 22)
        .opacity(eaten ? 0.12 : 1)
        .animation(.easeOut(duration: 0.35), value: eaten)
    }
}

// MARK: - Aggressor (tap buyer / seller)

struct AggressorView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var s: LessonScreen { player.screen }
    private var lift: Bool { s.event != "hit" }   // default: buyers lifting the offer
    private let ticker = Timer.publish(every: 0.85, on: .main, in: .common).autoconnect()
    @State private var levels: [BookLevel] = []
    @State private var eaten = 0

    init(player: LessonPlayer, ink: Color) {
        self.player = player
        self.ink = ink
        _levels = State(initialValue: makeBook(seed: chartSeed(player.screen)))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            plainPrompt

            OrderBookLadder(levels: levels,
                            consumedAsks: lift ? eaten : 0,
                            consumedBids: lift ? 0 : eaten)
                .onReceive(ticker) { _ in
                    guard !player.revealed else { return }
                    guard eaten < 4 else { return }
                    eaten += 1
                }

            HStack(spacing: 12) {
                choice(index: 0, label: "The buyer", tint: bidColor)
                choice(index: 1, label: "The seller", tint: askColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var plainPrompt: some View {
        Text(RichText.attributed(s.question ?? "Who is the aggressor?",
                                 base: Theme.font(20, .heavy), bold: Theme.font(20, .black), color: ink))
            .fixedSize(horizontal: false, vertical: true)
    }

    private func choice(index: Int, label: String, tint: Color) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}

// MARK: - Book drag (route a market order to bid / ask)

struct BookDragView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var s: LessonScreen { player.screen }
    private var isBuy: Bool { s.order != "market_sell" }   // default: market buy
    @State private var levels: [BookLevel] = []

    init(player: LessonPlayer, ink: Color) {
        self.player = player
        self.ink = ink
        _levels = State(initialValue: makeBook(seed: chartSeed(player.screen)))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(RichText.attributed(s.question ?? "Tap the side of the book it fills against.",
                                     base: Theme.font(20, .heavy), bold: Theme.font(20, .black), color: ink))
                .fixedSize(horizontal: false, vertical: true)

            // A badge showing the order being routed.
            HStack { Spacer(); orderChip; Spacer() }

            // Tap a side of the real book: the asks (top) or the bids (bottom).
            OrderBookLadder(levels: levels)
                .overlay {
                    VStack(spacing: 6) {
                        sideButton(index: 1, label: "ASK", tint: askColor)   // top — sellers
                        sideButton(index: 0, label: "BID", tint: bidColor)   // bottom — buyers
                    }
                    .padding(6)
                }

            if player.selectedIndex == nil {
                Label("Tap the side of the book it fills against", systemImage: "hand.tap.fill")
                    .font(Theme.font(13, .bold)).foregroundColor(Theme.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var orderChip: some View {
        Text(isBuy ? "MARKET BUY" : "MARKET SELL")
            .font(Theme.font(15, .black)).foregroundColor(.white)
            .padding(.horizontal, 20).padding(.vertical, 12)
            .background(Capsule().fill(isBuy ? bidColor : askColor))
            .overlay(Capsule().strokeBorder(Color.white.opacity(0.25), lineWidth: 1.5))
    }

    /// A tappable half of the ladder (asks or bids), with a side label.
    private func sideButton(index: Int, label: String, tint: Color) -> some View {
        let chosen = player.selectedIndex == index
        let correct = player.currentCorrectIndex == index
        let revealed = player.revealed
        // Neutral until tapped; green for the correct side on reveal, red for a
        // wrong pick.
        let signal: Color? = revealed ? (correct ? bidColor : (chosen ? askColor : nil)) : (chosen ? Theme.answer : nil)
        return ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill((signal ?? .white).opacity(signal == nil ? 0.0 : 0.16))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(signal ?? Color.white.opacity(0.10),
                                  lineWidth: signal == nil ? 1 : 2.5))
            Text(label)
                .font(Theme.font(11, .black)).foregroundColor(.white)
                .padding(.horizontal, 9).padding(.vertical, 4)
                .background(Capsule().fill(tint.opacity(0.92)))
                .padding(8)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard !player.revealed else { return }
            Haptics.selection(); player.selectedIndex = index
        }
    }
}

// MARK: - Interactive DOM ladder

struct DOMTapView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private let prices = [101.15, 101.10, 101.05, 101.00, 100.95, 100.90]
    private let sizes = [180, 420, 95, 140, 310, 205]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Read the DOM.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            VStack(spacing: 4) {
                HStack {
                    Text("BID SIZE").frame(maxWidth: .infinity)
                    Text("PRICE").frame(width: 82)
                    Text("ASK SIZE").frame(maxWidth: .infinity)
                }
                .font(Theme.font(9, .black)).foregroundColor(Theme.muted)

                ForEach(prices.indices, id: \.self) { index in
                    let isAsk = index < 3
                    HStack(spacing: 8) {
                        Text(isAsk ? "" : "\(sizes[index])")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(bidColor)
                        Text(String(format: "%.2f", prices[index]))
                            .frame(width: 82).foregroundColor(ink)
                        Text(isAsk ? "\(sizes[index])" : "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(askColor)
                    }
                    .font(Theme.marketFont(13, .semibold)).padding(.vertical, 8).padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 9).fill(index == player.selectedIndex ? Theme.answer.opacity(0.14) : (isAsk ? askColor : bidColor).opacity(0.06)))
                    .overlay(RoundedRectangle(cornerRadius: 9).strokeBorder(rowColor(index), lineWidth: rowWidth(index)))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard !player.revealed else { return }
                        Haptics.selection()
                        player.selectedIndex = index
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))

            Label("Tap the price row that answers the question", systemImage: "hand.tap.fill")
                .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
        }
    }

    private func rowColor(_ index: Int) -> Color {
        if player.revealed && index == player.screen.target { return bidColor }
        if player.revealed && index == player.selectedIndex { return askColor }
        if index == player.selectedIndex { return Theme.answer }
        return .clear
    }

    private func rowWidth(_ index: Int) -> CGFloat {
        index == player.selectedIndex || (player.revealed && index == player.screen.target) ? 2 : 0
    }
}

// MARK: - Book depth comparison

/// Side by side ladders make depth tangible: the thick book has large nearby
/// resting size, while the thin book has small size and gaps between levels.
struct BookDepthCompareView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private let prices = [101.10, 101.05, 101.00, 100.95, 100.90]
    private var bookSizes: (a: [Int], b: [Int]) {
        switch player.screen.event {
        case "wall":
            return ([80, 95, 1500, 110, 90], [75, 90, 105, 100, 85])
        case "pool":
            return ([70, 940, 1180, 860, 65], [55, 80, 72, 60, 48])
        case "thin_variant":
            return ([610, 480, 720, 540, 430], [18, 42, 0, 27, 11])
        default:
            return ([920, 760, 1100, 840, 690], [45, 0, 72, 18, 0])
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Which book should move more easily?")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            HStack(spacing: 10) {
                ladder(title: "BOOK A", sizes: bookSizes.a, tint: Theme.progress)
                ladder(title: "BOOK B", sizes: bookSizes.b, tint: Theme.expert)
            }

            VStack(spacing: 9) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                    choice(index: index, label: label)
                }
            }
        }
    }

    private func ladder(title: String, sizes: [Int], tint: Color) -> some View {
        VStack(spacing: 5) {
            Text(title).font(Theme.font(10, .black)).foregroundColor(tint)
            ForEach(prices.indices, id: \.self) { index in
                HStack(spacing: 5) {
                    Text(String(format: "%.2f", prices[index]))
                        .font(Theme.marketFont(9, .medium)).foregroundColor(Theme.muted)
                    Spacer(minLength: 2)
                    Text(sizes[index] == 0 ? "GAP" : "\(sizes[index])")
                        .font(Theme.marketFont(10, .semibold)).foregroundColor(ink)
                }
                .padding(.horizontal, 7).padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 7).fill(tint.opacity(sizes[index] == 0 ? 0.04 : 0.10 + min(0.35, Double(sizes[index]) / 3000))))
            }
        }
        .padding(9).frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Theme.surfaceRaised)
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .strokeBorder(Theme.optionBorder(scheme), lineWidth: 1)
                )
        )
    }

    private func choice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}

// MARK: - Evidence selection

/// Learners separate aggression, liquidity, and response instead of recalling
/// a missing word. The required number of cards comes from `targets`.
struct EvidenceSelectView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Select the strongest evidence.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)
            Text("SELECT \(player.screen.targets?.count ?? 2)")
                .font(Theme.font(10, .black)).foregroundColor(.white)

            ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                OFMultiOption(player: player, index: index, label: label, ink: ink)
            }
        }
    }
}

// MARK: - Replay comparison

/// Two similar breakout replays with different underlying order flow. The
/// learner must choose acceptance versus replenishment and rejection.
struct ReplayCompareView: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Which replay shows acceptance?")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)
            HStack(spacing: 10) {
                // Neutral tints (not bid/ask green/red) — A vs. B isn't a
                // buy/sell choice, so it shouldn't borrow that color meaning.
                replay(title: "REPLAY A", rows: replayRows.a, tint: Theme.progress)
                replay(title: "REPLAY B", rows: replayRows.b, tint: Theme.expert)
            }
            VStack(spacing: 9) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                    replayChoice(index: index, label: label)
                }
            }
        }
    }

    private var replayRows: (a: [String], b: [String]) {
        switch player.screen.event {
        case "cvd_divergence":
            return (["Price makes new high", "CVD makes lower high", "Pressure disagrees"], ["Price advances", "CVD advances", "Pressure agrees"])
        case "cvd_agreement":
            return (["Price rises", "CVD rises", "Pressure agrees"], ["Price rises", "CVD falls", "Pressure disagrees"])
        case "pulled_vs_consumed":
            return (["Ask disappears", "No trade prints", "Liquidity was pulled"], ["Trades hit the ask", "Displayed size declines", "Liquidity was consumed"])
        case "profile_concentration":
            return (["One dominant bulge", "Clear central POC", "Concentrated acceptance"], ["Bars stay similar", "No dominant bulge", "Volume is distributed"])
        case "wall":
            return (["Large bid is hit", "Bid replenishes", "Price holds"], ["Large bid appears", "Bid gets pulled", "Price falls through"])
        case "sweep":
            return (["Level trades through", "Price rejects quickly", "No acceptance"], ["Level trades through", "Execution persists", "Price holds beyond"])
        case "trap":
            return (["Break holds above", "Buying persists", "Retest succeeds"], ["Break fails quickly", "Sellers take control", "Price falls inside"])
        case "absorption":
            return (["Buying stays fast", "Offer replenishes", "Price stalls"], ["Buying pace fades", "Offer stays stable", "Price stalls"])
        case "wall_challenge":
            return (["Several sell waves hit", "Bid returns unevenly", "Price still holds"], ["Bid depth keeps thinning", "Selling persists", "Price slips through"])
        case "sweep_challenge":
            return (["Prior extreme trades", "Price snaps inside", "Range is reclaimed"], ["Level trades through", "Deeper retest holds", "Price continues beyond"])
        case "trap_challenge":
            return (["Break pauses above", "Deeper retest holds", "Buying resumes"], ["Strong burst loses level", "Sellers take control", "Price returns inside"])
        case "absorption_challenge":
            return (["Buy size varies", "Offer keeps returning", "Price stays pinned"], ["Buy size and pace fade", "Offer stays stable", "Price stalls"])
        case "acceptance_challenge":
            return (["Staggered offers clear", "Retest survives", "Trade builds above"], ["Offers renew", "Buying loses progress", "Price returns inside"])
        case "double_top_flow":
            return (["First test: buys stay strong", "Resistance contains price", "Price rotates lower"], ["Second test: buying weakens", "Seller response strengthens", "Price loses resistance"])
        case "double_bottom_flow":
            return (["First test: sells stay strong", "Support contains price", "Price rotates higher"], ["Second test: selling weakens", "Buyer response strengthens", "Price reclaims support"])
        default:
            return (["Offers clear", "Buy tape persists", "Price holds above"], ["Offer refreshes", "Buy tape stalls", "Price falls inside"])
        }
    }

    private func replay(title: String, rows: [String], tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(Theme.font(10, .black)).foregroundColor(.white)
            if player.screen.event == "profile_concentration" {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(Array((title == "REPLAY A" ? [18, 28, 64, 112, 58, 25] : [48, 55, 51, 59, 46, 53]).enumerated()), id: \.offset) { _, width in
                        RoundedRectangle(cornerRadius: 2).fill(tint.opacity(0.75))
                            .frame(width: CGFloat(width) / 2.2, height: 3)
                    }
                }
                .frame(height: 28)
            }
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    Circle().fill(.white).frame(width: 6, height: 6)
                    Text(row).font(Theme.font(11, .bold)).foregroundColor(ink)
                }
            }
        }
        .padding(11).frame(maxWidth: .infinity, minHeight: 118, alignment: .topLeading)
        // Match the lesson's answer-choice face exactly; A/B's color lives in
        // the title, bullets, and outline rather than a tinted background.
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Theme.optionFill(scheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .strokeBorder(tint.opacity(0.55), lineWidth: 1)
                )
        )
    }

    private func replayChoice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}

// MARK: - Time and Sales

private struct TapePrint: Identifiable {
    let id = UUID()
    let time: String
    let price: Double
    let size: Int
    let buyerInitiated: Bool
}

private func makeTape(seed: UInt64, event: String, target: Int? = nil) -> [TapePrint] {
    var rng = SplitMix(seed: seed)
    var price = 100.0 + Double(rng.next() % 300) / 10.0
    return (0..<9).map { index in
        let buyerInitiated: Bool
        switch event {
        case "buyer_target":
            buyerInitiated = index == target ? true : index % 3 != 0
        case "seller_target":
            buyerInitiated = index == target ? false : index % 3 == 0
        case "sequence_break":
            buyerInitiated = index != target
        case "buyer_sequence_break":
            buyerInitiated = index == target
        case "buyer_fading":
            buyerInitiated = index % 5 != 0
        case "balanced", "large_print", "accelerating", "stall":
            buyerInitiated = index % 2 == 0
        default:
            let favoredBuy = event == "lift"
            buyerInitiated = index % 4 != 0 ? favoredBuy : !favoredBuy
        }
        price += buyerInitiated ? 0.02 : -0.02
        let fading = (event == "stall" || event == "buyer_fading") && index >= (target ?? 4)
        let ordinarySize = 20 + Int(rng.next() % (fading ? 80 : 480))
        return TapePrint(
            time: String(format: "10:04:%02d", 12 + index),
            price: price,
            size: event == "large_print" && target == index ? 980 : ordinarySize,
            buyerInitiated: buyerInitiated
        )
    }
}

/// A compact Time and Sales feed. Green prints trade at the ask, red prints at
/// the bid, and size varies so learners must combine direction, pace, and size.
struct TimeSalesView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var screen: LessonScreen { player.screen }
    @State private var prints: [TapePrint]
    @State private var visibleRows = 3
    @State private var tapeTick = 0
    private let ticker = Timer.publish(every: 0.16, on: .main, in: .common).autoconnect()

    init(player: LessonPlayer, ink: Color) {
        self.player = player
        self.ink = ink
        _prints = State(initialValue: makeTape(seed: chartSeed(player.screen), event: player.screen.event ?? "balanced", target: player.screen.target))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(screen.question ?? "Read the tape.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            VStack(spacing: 0) {
                HStack {
                    Text("TIME"); Spacer(); Text("PRICE"); Spacer(); Text("SIZE")
                }
                .font(Theme.font(10, .black)).foregroundColor(Theme.muted)
                .padding(.horizontal, 12).padding(.vertical, 9)

                // Render every row so the tape's height is fixed from the
                // start; unrevealed rows are just transparent. Otherwise the box
                // grows as prints reveal and shoves the answer choices down.
                ForEach(Array(prints.enumerated()), id: \.element.id) { index, print in
                    // Reveal from the top down (newest prints fill downward) rather
                    // than lighting up the bottom rows and growing upward.
                    let shown = index < visibleRows
                    HStack {
                        Text(print.time).frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.2f", print.price)).frame(maxWidth: .infinity)
                        Text("\(print.size)").frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(Theme.marketFont(13, .medium))
                    .foregroundColor(print.buyerInitiated ? bidColor : askColor)
                    .padding(.horizontal, 12).padding(.vertical, 7)
                    .background((print.buyerInitiated ? bidColor : askColor).opacity(0.08))
                    .overlay(RoundedRectangle(cornerRadius: 5).strokeBorder(tapeRowColor(index), lineWidth: tapeRowWidth(index)))
                    .contentShape(Rectangle())
                    .opacity(shown ? 1 : 0)
                    .allowsHitTesting(shown)
                    .onTapGesture {
                        guard screen.type == "time_sales_tap", !player.revealed else { return }
                        Haptics.selection(); player.selectedIndex = index
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onReceive(ticker) { _ in
                guard !player.revealed, visibleRows < prints.count else { return }
                tapeTick += 1
                let event = screen.event ?? "balanced"
                let cadence: Int
                if event == "accelerating" {
                    let change = screen.target ?? 5
                    cadence = visibleRows < change ? 4 : (visibleRows < change + 2 ? 2 : 1)
                } else if event == "stall" || event == "buyer_fading" {
                    cadence = visibleRows < (screen.target ?? 6) ? 1 : 4
                } else {
                    cadence = 2
                }
                guard tapeTick.isMultiple(of: cadence) else { return }
                withAnimation(.easeOut(duration: 0.2)) { visibleRows += 1 }
            }

            if screen.type == "time_sales_tap" {
                Label("Tap the print that answers the question", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else {
                choices
            }
        }
    }

    private func tapeRowColor(_ index: Int) -> Color {
        if player.revealed && index == screen.target { return bidColor }
        if player.revealed && index == player.selectedIndex { return askColor }
        if index == player.selectedIndex { return Theme.answer }
        return .clear
    }

    private func tapeRowWidth(_ index: Int) -> CGFloat {
        index == player.selectedIndex || (player.revealed && index == screen.target) ? 2 : 0
    }

    private var choices: some View {
        VStack(spacing: 10) {
            ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                flowChoice(index: index, label: label)
            }
        }
    }

    private func flowChoice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}

// MARK: - Footprint chart

private struct FootprintLevel: Identifiable {
    let id = UUID()
    let price: Double
    let bidVolume: Int
    let askVolume: Int
}

private func makeFootprint(seed: UInt64, event: String, target: Int? = nil) -> [FootprintLevel] {
    var rng = SplitMix(seed: seed)
    let base = 99.8 + Double(rng.next() % 200) / 100.0
    return Array((0..<7).reversed()).enumerated().map { index, row in
        let baseVolume = 20 + Int(rng.next() % 90)
        let bid: Int
        let ask: Int
        switch event {
        case "lift", "delta_positive", "stacked_ask":
            bid = baseVolume
            ask = baseVolume + 60 + Int(rng.next() % 120)
        case "hit", "delta_negative", "delta_negative_rising":
            bid = baseVolume + 60 + Int(rng.next() % 120)
            ask = baseVolume
        case "balanced_target":
            bid = baseVolume + 10
            ask = baseVolume + 40 + Int(rng.next() % 30)
        case "diagonal_ask":
            bid = baseVolume + (index == (target ?? -2) + 1 ? 5 : 55)
            ask = baseVolume + 55
        default:
            bid = baseVolume + Int(rng.next() % 45)
            ask = baseVolume + Int(rng.next() % 45)
        }
        let highlightedBid: Int
        let highlightedAsk: Int
        if event == "stacked_ask", let target, (target...target + 2).contains(index) {
            highlightedBid = bid
            highlightedAsk = ask + 220
        } else if target == index && event == "delta_positive" {
            highlightedBid = bid
            highlightedAsk = ask + 300
        } else if target == index && (event == "delta_negative" || event == "delta_negative_rising") {
            highlightedBid = bid + 300
            highlightedAsk = ask
        } else if target == index && event == "diagonal_ask" {
            highlightedBid = bid
            highlightedAsk = ask + 280
        } else if target == index && event == "balanced_target" {
            highlightedBid = baseVolume + 30
            highlightedAsk = baseVolume + 31
        } else if target == index && (event == "total_target" || event == "vwap_target") {
            highlightedBid = bid + 220
            highlightedAsk = ask + 220
        } else {
            highlightedBid = target == index && event == "hit" ? bid + 260 : bid
            highlightedAsk = target == index && event == "lift" ? ask + 260 : ask
        }
        return FootprintLevel(price: base + Double(row) * 0.05, bidVolume: highlightedBid, askVolume: highlightedAsk)
    }
}

/// Display-only footprint (Panel 3): the same bid/ask ladder, center candle,
/// heatmap POC, totals, CANDLE DELTA and CVD as `FootprintQuestionView`, but
/// with no tap grading. Used inside the combined `OrderFlowSimulationView`
/// panels so the synthesis boss shows a real footprint alongside price and DOM.
struct FootprintPanel: View {
    var seed: UInt64
    var event: String = "balanced"
    private let levels: [FootprintLevel]

    init(seed: UInt64, event: String = "balanced") {
        self.seed = seed
        self.event = event
        self.levels = makeFootprint(seed: seed, event: event)
    }

    private var maxBidIdx: Int { levels.indices.max(by: { levels[$0].bidVolume < levels[$1].bidVolume }) ?? -1 }
    private var maxAskIdx: Int { levels.indices.max(by: { levels[$0].askVolume < levels[$1].askVolume }) ?? -1 }
    private var bidTotal: Int { levels.reduce(0) { $0 + $1.bidVolume } }
    private var askTotal: Int { levels.reduce(0) { $0 + $1.askVolume } }
    private var delta: Int { askTotal - bidTotal }

    private func fmtVol(_ v: Int) -> String {
        let scaled = Double(abs(v)) * 42_000
        let sign = v < 0 ? "-" : ""
        if scaled >= 1_000_000 { return sign + String(format: "%.2fM", scaled / 1_000_000) }
        return sign + String(format: "%.0fK", scaled / 1_000)
    }

    private func fpCell(_ v: Int, tint: Color, poc: Bool) -> some View {
        Text(fmtVol(v))
            .font(Theme.marketFont(12, .bold))
            .lineLimit(1).minimumScaleFactor(0.6)
            .foregroundColor(poc ? .black : .white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(poc ? Color(hex: "#E8ECEF") : tint.opacity(min(0.85, 0.14 + Double(v) / 360)))
    }

    private var candleOverlay: some View {
        let color = delta >= 0 ? bidColor : askColor
        return ZStack {
            Rectangle().fill(color.opacity(0.5)).frame(width: 3)
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 3, style: .continuous).fill(color)
                    .frame(width: 22, height: geo.size.height * 0.6)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.46)
            }
        }
        .frame(width: 44)
    }

    private var cvdSeries: [Double] {
        var rng = SplitMix(seed: seed &+ 7919)
        let bias = delta >= 0 ? 1.0 : -1.0
        var v = 0.0
        return (0..<14).map { _ in
            v += bias * Double(rng.next() % 26) / 10.0 + (Double(Int(rng.next() % 20)) - 10) / 10.0
            return v
        }
    }

    private var cvdSparkline: some View {
        let pts = cvdSeries
        let lo = pts.min() ?? 0, hi = pts.max() ?? 1
        let range = max(hi - lo, 0.0001)
        let up = (pts.last ?? 0) >= (pts.first ?? 0)
        return GeometryReader { geo in
            Path { p in
                for (i, v) in pts.enumerated() {
                    let x = geo.size.width * CGFloat(i) / CGFloat(max(pts.count - 1, 1))
                    let y = geo.size.height * (1 - CGFloat((v - lo) / range))
                    if i == 0 { p.move(to: CGPoint(x: x, y: y)) } else { p.addLine(to: CGPoint(x: x, y: y)) }
                }
            }
            .stroke(up ? bidColor : askColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .frame(height: 18)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("FOOTPRINT + DELTA").font(Theme.font(10, .black)).foregroundColor(Theme.muted)
                .padding(.bottom, 6)
            VStack(spacing: 3) {
                ForEach(Array(levels.enumerated()), id: \.element.id) { index, level in
                    HStack(spacing: 0) {
                        fpCell(level.bidVolume, tint: askColor, poc: index == maxBidIdx)
                        Color.clear.frame(width: 44)
                        fpCell(level.askVolume, tint: bidColor, poc: index == maxAskIdx)
                    }
                    .frame(height: 20)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .overlay(candleOverlay.allowsHitTesting(false))

            HStack(spacing: 0) {
                Text(fmtVol(bidTotal)).foregroundColor(askColor)
                    .frame(maxWidth: .infinity).lineLimit(1).minimumScaleFactor(0.6)
                Color.clear.frame(width: 44)
                Text(fmtVol(askTotal)).foregroundColor(bidColor)
                    .frame(maxWidth: .infinity).lineLimit(1).minimumScaleFactor(0.6)
            }
            .font(Theme.marketFont(15, .bold)).padding(.top, 5).padding(.bottom, 6)

            // Δ and CVD share one row to keep the panel short under the board.
            HStack(spacing: 8) {
                Text("Δ " + (delta >= 0 ? "+" : "") + fmtVol(delta))
                    .font(Theme.marketFont(13, .bold))
                    .foregroundColor(delta >= 0 ? bidColor : askColor)
                    .lineLimit(1).fixedSize()
                Text("CVD").font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                cvdSparkline
            }
            .padding(.horizontal, 10).padding(.vertical, 7)
            .background(RoundedRectangle(cornerRadius: 9).fill(Color.black.opacity(0.55)))

            Spacer(minLength: 0)   // pack content to top when the row equalizes height
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.28)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
    }
}

/// Bid volume prints on the left and ask volume on the right at each price,
/// giving late course lessons a real footprint style comparison mechanic.
struct FootprintQuestionView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var screen: LessonScreen { player.screen }
    @State private var levels: [FootprintLevel]

    init(player: LessonPlayer, ink: Color) {
        self.player = player
        self.ink = ink
        _levels = State(initialValue: makeFootprint(seed: chartSeed(player.screen), event: player.screen.event ?? "balanced", target: player.screen.target))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(screen.question ?? "Read the footprint.")
                .font(Theme.questionFont(20, .heavy)).foregroundColor(ink)

            footprintChart

            if screen.type == "footprint_tap" {
                Label("Tap the price row that answers the question", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else {
                VStack(spacing: 8) {
                    ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                        footprintChoice(index: index, label: label)
                    }
                }
            }
        }
    }

    // Footprint chart styled after a real bid/ask volume footprint: red bid
    // column (left), teal ask column (right), a candle body down the middle,
    // heatmap-shaded cells with the point-of-control (max) cell in white, and a
    // bid/ask total row + Delta/Total footer.
    private var footprintChart: some View {
        VStack(spacing: 0) {
            VStack(spacing: 3) {
                ForEach(Array(levels.enumerated()), id: \.element.id) { index, level in
                    HStack(spacing: 0) {
                        fpCell(level.bidVolume, tint: askColor, poc: index == maxBidIdx)
                        Color.clear.frame(width: 46)
                        fpCell(level.askVolume, tint: bidColor, poc: index == maxAskIdx)
                    }
                    .frame(height: 22)
                    .overlay(RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .strokeBorder(footprintRowColor(index), lineWidth: footprintRowWidth(index)))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard screen.type == "footprint_tap", !player.revealed else { return }
                        Haptics.selection(); player.selectedIndex = index
                    }
                }
            }
            .overlay(candleOverlay.allowsHitTesting(false))

            HStack(spacing: 0) {
                Text(fmtVol(bidTotal)).foregroundColor(askColor).frame(maxWidth: .infinity)
                Color.clear.frame(width: 46)
                Text(fmtVol(askTotal)).foregroundColor(bidColor).frame(maxWidth: .infinity)
            }
            .font(Theme.font(15, .black)).padding(.top, 5).padding(.bottom, 6)

            // CANDLE DELTA and CVD share one row so the choices stay above the fold.
            HStack(spacing: 8) {
                Text("CANDLE DELTA").font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                Text((delta >= 0 ? "+" : "") + fmtVol(delta))
                    .font(Theme.font(14, .black)).lineLimit(1).fixedSize()
                    .foregroundColor(delta >= 0 ? bidColor : askColor)
                Spacer(minLength: 6)
                Text("CVD").font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                cvdSparkline.frame(width: 96)
            }
            .padding(.horizontal, 11).padding(.vertical, 7)
            .background(RoundedRectangle(cornerRadius: 9).fill(Color.black.opacity(0.55)))
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.28)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
    }

    private var maxBidIdx: Int { levels.indices.max(by: { levels[$0].bidVolume < levels[$1].bidVolume }) ?? -1 }
    private var maxAskIdx: Int { levels.indices.max(by: { levels[$0].askVolume < levels[$1].askVolume }) ?? -1 }
    private var bidTotal: Int { levels.reduce(0) { $0 + $1.bidVolume } }
    private var askTotal: Int { levels.reduce(0) { $0 + $1.askVolume } }
    private var delta: Int { askTotal - bidTotal }

    /// Scale the small internal volumes into the K/M range for a real-tape look.
    private func fmtVol(_ v: Int) -> String {
        let scaled = Double(abs(v)) * 42_000
        let sign = v < 0 ? "-" : ""
        if scaled >= 1_000_000 { return sign + String(format: "%.2fM", scaled / 1_000_000) }
        return sign + String(format: "%.0fK", scaled / 1_000)
    }

    private func fpCell(_ v: Int, tint: Color, poc: Bool) -> some View {
        Text(fmtVol(v))
            .font(Theme.font(13, .black))
            .foregroundColor(poc ? .black : .white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(poc ? Color(hex: "#E8ECEF") : tint.opacity(min(0.85, 0.14 + Double(v) / 360)))
    }

    /// Cumulative delta: accumulates per-bar delta, biased toward this candle's
    /// direction so the trend agrees with the footprint.
    private var cvdSeries: [Double] {
        var rng = SplitMix(seed: chartSeed(screen) &+ 7919)
        let bias = delta >= 0 ? 1.0 : -1.0
        var v = 0.0
        return (0..<14).map { _ in
            v += bias * Double(rng.next() % 26) / 10.0 + (Double(Int(rng.next() % 20)) - 10) / 10.0
            return v
        }
    }

    private var cvdSparkline: some View {
        let pts = cvdSeries
        let lo = pts.min() ?? 0, hi = pts.max() ?? 1
        let range = max(hi - lo, 0.0001)
        let up = (pts.last ?? 0) >= (pts.first ?? 0)
        return GeometryReader { geo in
            Path { p in
                for (i, v) in pts.enumerated() {
                    let x = geo.size.width * CGFloat(i) / CGFloat(max(pts.count - 1, 1))
                    let y = geo.size.height * (1 - CGFloat((v - lo) / range))
                    if i == 0 { p.move(to: CGPoint(x: x, y: y)) }
                    else { p.addLine(to: CGPoint(x: x, y: y)) }
                }
            }
            .stroke(up ? bidColor : askColor,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .frame(height: 26)
    }

    private var candleOverlay: some View {
        let color = delta >= 0 ? bidColor : askColor
        return ZStack {
            Rectangle().fill(color.opacity(0.5)).frame(width: 3)   // wick, full height
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 3, style: .continuous).fill(color)
                    .frame(width: 24, height: geo.size.height * 0.6)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.46)
            }
        }
        .frame(width: 46)
    }

    private func footprintRowColor(_ index: Int) -> Color {
        if player.revealed && index == screen.target { return bidColor }
        if player.revealed && index == player.selectedIndex { return askColor }
        if index == player.selectedIndex { return Theme.answer }
        return .clear
    }

    private func footprintRowWidth(_ index: Int) -> CGFloat {
        index == player.selectedIndex || (player.revealed && index == screen.target) ? 2 : 0
    }

    private func volumeCell(_ volume: Int, color: Color) -> some View {
        Text("\(volume)").font(Theme.font(13, .black)).foregroundColor(.white)
            .frame(maxWidth: .infinity).padding(.vertical, 7)
            .background(RoundedRectangle(cornerRadius: 7).fill(color.opacity(min(0.75, 0.16 + Double(volume) / 360.0))))
    }

    private func footprintChoice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink, dense: true)
    }

    private var risingPriceChart: some View {
        VStack(spacing: 6) {
            Text("PRICE").font(Theme.font(8, .black)).foregroundColor(Theme.muted)
            HStack(alignment: .bottom, spacing: 3) {
                ForEach(Array([12.0, 18.0, 16.0, 25.0, 32.0].enumerated()), id: \.offset) { _, height in
                    RoundedRectangle(cornerRadius: 2).fill(bidColor.opacity(0.85))
                        .frame(width: 7, height: height)
                }
            }
            .frame(height: 36, alignment: .bottom)
            Image(systemName: "arrow.up.right")
                .font(.system(size: 11, weight: .black)).foregroundColor(bidColor)
            Text("RISING").font(Theme.font(7, .black)).foregroundColor(bidColor)
        }
        .frame(width: 58)
        .padding(.vertical, 9)
        .background(RoundedRectangle(cornerRadius: 10).fill(bidColor.opacity(0.09)))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(bidColor.opacity(0.35), lineWidth: 1))
    }
}

// MARK: - Cumulative Volume Delta

struct CVDChartQuestionView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Read price and CVD.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            VStack(alignment: .leading, spacing: 8) {
                linePanel(title: "PRICE", values: priceValues, color: bidColor, interactive: false)
                Divider().overlay(Theme.surfaceBorder)
                linePanel(title: "CUMULATIVE VOLUME DELTA", values: cvdValues, color: Theme.progress, interactive: player.screen.type == "cvd_tap")
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: Theme.Radius.card).fill(Theme.chartBackground))
            .overlay(RoundedRectangle(cornerRadius: Theme.Radius.card).strokeBorder(Theme.progress.opacity(0.42), lineWidth: 1))

            if player.screen.type == "cvd_tap" {
                Label("Tap the CVD pivot that answers the question", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else {
                VStack(spacing: 9) {
                    ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                        OFOption(player: player, index: index, label: label, ink: ink)
                    }
                }
            }
        }
    }

    private var isBullish: Bool { player.screen.event == "bullish_divergence" }
    private var priceValues: [CGFloat] {
        isBullish ? [0.20, 0.38, 0.72, 0.44, 0.34, 0.55, 0.86, 0.58]
                  : [0.82, 0.56, 0.28, 0.52, 0.64, 0.38, 0.13, 0.35]
    }
    private var cvdValues: [CGFloat] {
        isBullish ? [0.18, 0.45, 0.82, 0.58, 0.48, 0.52, 0.64, 0.43]
                  : [0.80, 0.50, 0.16, 0.39, 0.46, 0.42, 0.31, 0.47]
    }

    private func linePanel(title: String, values: [CGFloat], color: Color, interactive: Bool) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(Theme.font(9, .black)).foregroundColor(Theme.muted)
            GeometryReader { proxy in
                ZStack {
                    Path { path in
                        for (index, value) in values.enumerated() {
                            let x = proxy.size.width * CGFloat(index) / CGFloat(values.count - 1)
                            let y = proxy.size.height * value
                            if index == 0 { path.move(to: CGPoint(x: x, y: y)) }
                            else { path.addLine(to: CGPoint(x: x, y: y)) }
                        }
                    }
                    .stroke(color, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))

                    if interactive {
                        ForEach(0..<2, id: \.self) { pivot in
                            let pointIndex = pivot == 0 ? 2 : 6
                            Circle()
                                .fill(pivotFill(pivot))
                                .overlay(Circle().strokeBorder(pivotBorder(pivot), lineWidth: pivotWidth(pivot)))
                                .frame(width: 34, height: 34)
                                .contentShape(Circle())
                                .position(x: proxy.size.width * CGFloat(pointIndex) / CGFloat(values.count - 1),
                                          y: proxy.size.height * values[pointIndex])
                                .onTapGesture {
                                    guard !player.revealed else { return }
                                    Haptics.selection()
                                    player.selectedIndex = pivot
                                }
                        }
                    }
                }
            }
            .frame(height: 78)
        }
    }

    private func pivotFill(_ pivot: Int) -> Color {
        pivot == player.selectedIndex ? Theme.answer.opacity(0.28) : Color.black.opacity(0.08)
    }

    private func pivotBorder(_ pivot: Int) -> Color {
        if player.revealed && pivot == player.screen.target { return bidColor }
        if player.revealed && pivot == player.selectedIndex { return askColor }
        if pivot == player.selectedIndex { return Theme.answer }
        return Color.white.opacity(0.38)
    }

    private func pivotWidth(_ pivot: Int) -> CGFloat {
        pivot == player.selectedIndex || (player.revealed && pivot == player.screen.target) ? 3 : 1.5
    }
}

// MARK: - Volume Profile

struct VolumeProfileQuestionView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    private let prices = [101.50, 101.25, 101.00, 100.75, 100.50, 100.25, 100.00]

    private var screen: LessonScreen { player.screen }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(screen.question ?? "Read the Volume Profile.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            VStack(spacing: 5) {
                HStack {
                    Text("PRICE").frame(width: 64, alignment: .leading)
                    Text("EXECUTED VOLUME").frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(Theme.font(9, .black)).foregroundColor(Theme.muted)

                ForEach(volumes.indices, id: \.self) { index in
                    HStack(spacing: 8) {
                        Text(String(format: "%.2f", prices[index]))
                            .font(Theme.marketFont(11, .semibold)).foregroundColor(ink).frame(width: 64, alignment: .leading)
                        GeometryReader { proxy in
                            RoundedRectangle(cornerRadius: 5)
                                .fill(barColor(index))
                                .frame(width: max(12, proxy.size.width * CGFloat(volumes[index]) / 160))
                        }
                        .frame(height: 23)
                        if index == 3 && player.revealed && screen.event == "poc" {
                            Text("POC").font(Theme.font(8, .black)).foregroundColor(Theme.progress).frame(width: 28)
                        } else {
                            Color.clear.frame(width: 28, height: 1)
                        }
                    }
                    .padding(.vertical, 3).padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 8).fill(rowBackground(index)))
                    .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(rowBorder(index), lineWidth: rowBorderWidth(index)))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard !player.revealed, screen.type == "volume_profile_tap" || screen.type == "mark_level" else { return }
                        Haptics.selection()
                        if screen.type == "mark_level" {
                            player.markedLevel = prices[index]
                            player.markTrueLevel = screen.level
                            player.markTolerance = 0.01
                        } else {
                            player.selectedIndex = index
                        }
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: Theme.Radius.card).fill(Theme.chartBackground))
            .overlay(RoundedRectangle(cornerRadius: Theme.Radius.card).strokeBorder(Theme.progress.opacity(0.42), lineWidth: 1))

            if screen.type == "volume_profile_tap" || screen.type == "mark_level" {
                Label("Tap the price row that answers the question", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else {
                VStack(spacing: 9) {
                    ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                        OFOption(player: player, index: index, label: label, ink: ink)
                    }
                }
            }
        }
    }

    private var volumes: [Int] {
        switch screen.event {
        case "hvn": return [30, 150, 118, 62, 103, 126, 28]
        case "lvn": return [34, 136, 112, 18, 106, 129, 26]
        default: return [34, 58, 92, 160, 124, 68, 25]
        }
    }

    private func barColor(_ index: Int) -> Color {
        if screen.event == "lvn" && index == 3 { return Theme.expert.opacity(0.28) }
        if screen.event == "hvn" && index == 1 { return Theme.progress.opacity(0.85) }
        return index == 3 && screen.event == "poc" ? Theme.progress.opacity(0.85) : Theme.expert.opacity(0.62)
    }

    private func rowBackground(_ index: Int) -> Color {
        if index == player.selectedIndex || (screen.type == "mark_level" && player.markedLevel == prices[index]) { return Theme.answer.opacity(0.14) }
        if screen.event == "profile_vah" || screen.event == "profile_val", (2...4).contains(index) { return Theme.progress.opacity(0.08) }
        return .clear
    }

    private func rowBorder(_ index: Int) -> Color {
        if player.revealed && index == correctIndex { return bidColor }
        if player.revealed && (index == player.selectedIndex || player.markedLevel == prices[index]) { return askColor }
        if index == player.selectedIndex { return Theme.answer }
        if screen.type == "mark_level" && player.markedLevel == prices[index] { return Theme.answer }
        return .clear
    }

    private func rowBorderWidth(_ index: Int) -> CGFloat {
        index == player.selectedIndex || player.markedLevel == prices[index] || (player.revealed && index == correctIndex) ? 2 : 0
    }

    private var correctIndex: Int? {
        if let target = screen.target { return target }
        guard let level = screen.level else { return nil }
        return prices.enumerated().min(by: { abs($0.element - level) < abs($1.element - level) })?.offset
    }
}

// MARK: - Comprehensive order flow simulation

/// A compact boss screen that puts several sources of evidence in one market
/// moment. The evidence intentionally conflicts so the learner must weigh the
/// full response instead of recognizing one isolated pattern.
struct OrderFlowSimulationView: View {
    @ObservedObject var player: LessonPlayer
    @Environment(\.colorScheme) private var scheme
    var ink: Color

    private var screen: LessonScreen { player.screen }
    @State private var stages = [0, 0, 0, 0]
    @State private var sequenceFinished = false
    @State private var replayID = 0
    @State private var expandedCard: Int?
    @State private var inspectedStages: [Int: Int] = [:]
    @State private var simulationTick = 0
    @State private var simulationPaused = false
    @State private var loopVariant = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // The rich-panel board is the whole read — no "MULTI SIGNAL READ"
            // heading, difficulty chip, or pause/replay chrome. Legacy evidence
            // card modes keep their header.
            if !useRichPanels {
                HStack {
                    Text("MULTI SIGNAL READ").font(Theme.font(10, .black)).foregroundColor(Theme.muted)
                    Spacer()
                    if renderMode == .summary && sequenceFinished {
                        Button(action: restartEvidence) {
                            Label("Replay evidence", systemImage: "arrow.counterclockwise")
                                .font(Theme.font(10, .black)).foregroundColor(Theme.expert)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Replay evidence sequence")
                    }
                }
            }

            // Decision scenarios get a compact prompt above the live board; other
            // sim questions keep their full question text.
            if isDecisionMechanic {
                VStack(alignment: .leading, spacing: 2) {
                    Text("TRADE DECISION").font(Theme.font(10, .black)).tracking(1.2).foregroundColor(Theme.expert)
                    Text("What's your move?").font(Theme.questionFont(20, .heavy)).foregroundColor(ink)
                }
            } else {
                Text(displayQuestion)
                    .font(Theme.questionFont(20, .heavy)).foregroundColor(ink)
            }

            if screen.type == "trade_scenario", let stages = screen.tradeStages {
                HStack(spacing: 6) {
                    Text("DECISION \(player.scenarioStage + 1) OF \(stages.count)")
                        .font(Theme.marketFont(9, .semibold)).foregroundColor(Theme.expert)
                    ForEach(stages.indices, id: \.self) { index in
                        Capsule().fill(index <= player.scenarioStage ? Theme.expert : Theme.expert.opacity(0.18))
                            .frame(maxWidth: .infinity).frame(height: 4)
                    }
                }
            }

            if useRichPanels {
                VStack(spacing: 8) {
                    PriceContextPanel(seed: panelSeed, bullish: panelBullish)
                    HStack(alignment: .top, spacing: 8) {
                        DOMTapePanel(seed: panelSeed &+ 101, bullish: panelBullish)
                        FootprintPanel(seed: panelSeed &+ 202, event: eventKey)
                    }
                    if screen.footprintPreview == true {
                        Text("EXTRA PREVIEW  Delta compares aggressive buying with selling. This clue is supplemental and is taught in Unit 5.")
                            .font(Theme.font(9, .bold)).foregroundColor(Theme.warning)
                            .multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 5)
                    }
                }
            } else {
                VStack(spacing: 7) {
                    if renderMode == .rawFull {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 7) {
                            ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                                evidenceCard(index: index, track: track)
                            }
                        }
                    } else {
                        ForEach(Array(tracks.enumerated()), id: \.offset) { index, track in
                            evidenceCard(index: index, track: track)
                        }
                    }
                    if screen.footprintPreview == true {
                        Text("EXTRA PREVIEW  Delta compares aggressive buying with selling. This clue is supplemental and is taught in Unit 5.")
                            .font(Theme.font(9, .bold)).foregroundColor(Theme.warning)
                            .multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 5).padding(.top, 3)
                    }
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: Theme.Radius.card).fill(Theme.chartBackground))
                .overlay(RoundedRectangle(cornerRadius: Theme.Radius.card).strokeBorder(Theme.expert.opacity(0.45), lineWidth: 1))
            }

            if screen.type == "orderflow_sim_tap" {
                Label(evidenceReady ? "Tap the evidence card that answers the question" : "Watch the evidence develop", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else if screen.type == "orderflow_sim_select" {
                Label(evidenceReady ? "Select \(screen.targets?.count ?? 2) evidence cards" : "Watch the evidence develop", systemImage: "checklist")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else if isDecisionMechanic {
                if useCompactDecisionRow {
                    HStack(spacing: 8) {
                        ForEach(compactDecisionOrder, id: \.index) { item in
                            compactTradeChoice(index: item.index, label: item.label)
                        }
                    }
                } else {
                    VStack(spacing: 8) {
                        ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                            tradeChoice(index: index, label: label)
                        }
                    }
                }
            } else {
                VStack(spacing: 8) {
                    ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                        choice(index: index, label: label)
                    }
                }
                .allowsHitTesting(evidenceReady || player.revealed)
                .opacity(evidenceReady || player.revealed ? 1 : 0.55)
            }
        }
        .task(id: replayID) {
            if renderMode == .summary { await playEvidence() }
            else { await playRawEvidence() }
        }
    }

    private var tracks: [MultiSignalTrack] {
        let auxiliaryTitle: String
        let auxiliaryIcon: String
        if eventKey == "cvd_warning" {
            auxiliaryTitle = "CVD"
            auxiliaryIcon = "waveform.path.ecg"
        } else if eventKey == "volume_profile_context" {
            auxiliaryTitle = "VOLUME PROFILE"
            auxiliaryIcon = "chart.bar.fill"
        } else {
            auxiliaryTitle = "FOOTPRINT"
            auxiliaryIcon = "square.grid.3x3.fill"
        }
        return [
            MultiSignalTrack(icon: "chart.xyaxis.line", title: "PRICE + VWAP", states: evidence.price, tint: Theme.progress),
            MultiSignalTrack(icon: "list.bullet.rectangle", title: "LEVEL II", states: evidence.book, tint: askColor),
            MultiSignalTrack(icon: "bolt.fill", title: "TIME & SALES", states: evidence.tape, tint: bidColor),
            MultiSignalTrack(icon: auxiliaryIcon, title: auxiliaryTitle, states: evidence.footprint, tint: Theme.warning),
        ]
    }

    private var renderMode: MultiSignalRenderMode {
        if isDecisionMechanic { return .rawFull }
        if let explicit = screen.renderMode.flatMap(MultiSignalRenderMode.init(rawValue:)) { return explicit }
        let sourceNode = screen.sourceNode ?? player.lesson.node
        if sourceNode <= 12 { return .summary }
        if sourceNode <= 27 { return .rawSimplified }
        return .rawFull
    }

    private func evidenceCard(index: Int, track: MultiSignalTrack) -> some View {
        MultiSignalEvidenceCard(
            track: track,
            panelIndex: index,
            event: eventKey,
            renderMode: renderMode,
            simulationTick: simulationTick,
            loopVariant: loopVariant,
            scenarioPhase: player.scenarioStage,
            currentStage: stages[index],
            inspectedStage: inspectedStages[index],
            expanded: expandedCard == index,
            selected: isCardSelected(index),
            revealed: player.revealed,
            isCorrect: isCorrectCard(index),
            replayID: replayID,
            ink: ink,
            onTap: { cardTapped(index) },
            onToggleHistory: { toggleHistory(index) },
            onInspect: { inspectedStages[index] = $0 }
        )
    }

    /// Advanced and expert scenarios should make the evidence carry the read
    /// instead of restating most of it in the prompt. Specific tasks such as
    /// identifying an aggressor or invalidation keep their authored wording.
    private var displayQuestion: String {
        if let stage = player.activeTradeStage { return stage.prompt }
        let authored = screen.question ?? "What is the strongest current observation?"
        guard player.lesson.node >= 28,
              authored.localizedCaseInsensitiveContains("what's strongest") else { return authored }
        return "What's strongest?"
    }

    @MainActor private func playEvidence() async {
        stages = [0, 0, 0, 0]
        sequenceFinished = false
        expandedCard = nil
        inspectedStages = [:]
        do {
            try await Task.sleep(nanoseconds: 1_800_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.22)) { stages[2] = min(1, tracks[2].states.count - 1) }
            try await Task.sleep(nanoseconds: 220_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.22)) { stages[3] = min(1, tracks[3].states.count - 1) }
            try await Task.sleep(nanoseconds: 1_280_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.22)) { stages[0] = min(1, tracks[0].states.count - 1) }
            try await Task.sleep(nanoseconds: 220_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.22)) { stages[1] = min(1, tracks[1].states.count - 1) }
            sequenceFinished = true
        } catch { }
    }

    @MainActor private func playRawEvidence() async {
        simulationTick = 0
        sequenceFinished = false
        expandedCard = nil
        inspectedStages = [:]
        let finalTick = renderMode == .rawFull ? 16 : 12
        do {
            while !Task.isCancelled && (isDecisionMechanic || !player.revealed) {
                if simulationPaused {
                    try await Task.sleep(nanoseconds: 120_000_000)
                    continue
                }
                try await Task.sleep(nanoseconds: 750_000_000)
                guard !Task.isCancelled, isDecisionMechanic || !player.revealed else { return }
                if simulationTick >= finalTick {
                    try await Task.sleep(nanoseconds: 300_000_000)
                    guard !Task.isCancelled else { return }
                    loopVariant = (loopVariant + 1) % 2
                    withAnimation(.easeInOut(duration: 0.30)) { simulationTick = 0 }
                } else {
                    withAnimation(.linear(duration: 0.22)) { simulationTick += 1 }
                }
            }
        } catch { }
    }

    private var evidenceReady: Bool {
        isDecisionMechanic || (renderMode == .summary ? sequenceFinished : simulationTick >= 3)
    }

    private var isDecisionMechanic: Bool {
        ["trade_decision", "trade_scenario", "trade_manage", "entry_select", "invalidation_mark"].contains(screen.type)
    }

    private var eventKey: String { screen.scenarioId ?? screen.event ?? "seller_absorption" }

    /// The synthesis boss shows the real market via the three combined panels
    /// (Price+Context / DOM+Tape / Footprint+Delta) whenever the learner answers
    /// through options. The card-tap/select modes keep the abstract evidence
    /// cards because those cards are themselves the tappable answer surface.
    private var useRichPanels: Bool {
        screen.type != "orderflow_sim_tap" && screen.type != "orderflow_sim_select"
    }

    private var panelSeed: UInt64 { chartSeed(screen) }

    /// The rich panels show raw candles/DOM/tape/footprint, so the difficulty
    /// chip must never read "BEGINNER SUMMARY" here — that label belongs to the
    /// old pre-digested evidence cards, not a raw multi-signal board.
    private var difficultyLabel: String {
        if useRichPanels {
            return renderMode == .rawFull ? "ADVANCED FULL RAW" : "INTERMEDIATE RAW"
        }
        return renderMode.label
    }

    private var panelBullish: Bool {
        let e = eventKey.lowercased()
        if e.contains("lift") || e.contains("positive") || e.contains("bull") || e.contains("bid") || e.contains("stacked_bid") { return true }
        if e.contains("hit") || e.contains("negative") || e.contains("bear") || e.contains("ask") { return false }
        return true
    }

    private func restartEvidence() {
        Haptics.selection()
        replayID += 1
    }

    private func restartDecisionReplay() {
        Haptics.selection()
        simulationPaused = false
        simulationTick = 0
        loopVariant = 0
        replayID += 1
    }

    private func togglePause() {
        Haptics.selection()
        simulationPaused.toggle()
    }

    private func cardTapped(_ index: Int) {
        guard !player.revealed else { return }
        switch screen.type {
        case "orderflow_sim_tap":
            guard evidenceReady else { return }
            Haptics.selection()
            player.selectedIndex = index
        case "orderflow_sim_select":
            guard evidenceReady else { return }
            Haptics.selection()
            if player.selectedSet.contains(index) { player.selectedSet.remove(index) }
            else if player.selectedSet.count < (screen.targets?.count ?? 2) { player.selectedSet.insert(index) }
        default:
            if renderMode == .summary { toggleHistory(index) }
            else { expandedCard = expandedCard == index ? nil : index }
        }
    }

    private func tradeChoice(index: Int, label: String) -> some View {
        Button {
            guard !player.revealed else { return }
            Haptics.selection()
            player.selectedIndex = index
            player.decisionTick = simulationTick
        } label: {
            HStack(spacing: 12) {
                Image(systemName: decisionIcon(label))
                    .font(.system(size: 15, weight: .black)).frame(width: 24)
                Text(label).font(Theme.questionFont(16, .heavy))
                Spacer()
                if player.selectedIndex == index { Image(systemName: "checkmark.circle.fill") }
            }
            .foregroundColor(ink)
            .padding(.horizontal, 16).frame(maxWidth: .infinity, minHeight: 50)
            .background(RoundedRectangle(cornerRadius: Theme.Radius.control).fill(Theme.expert.opacity(player.selectedIndex == index ? 0.18 : 0.07)))
            .overlay(RoundedRectangle(cornerRadius: Theme.Radius.control).strokeBorder(player.selectedIndex == index ? Theme.expert : Theme.expert.opacity(0.28), lineWidth: player.selectedIndex == index ? 2 : 1))
        }
        .buttonStyle(.plain)
    }

    /// Short decision sets (LONG / WAIT / SHORT) fit on one row, which keeps the
    /// buttons above the fold under the live board instead of stacking three tall
    /// rows that push them off-screen.
    private var useCompactDecisionRow: Bool {
        let opts = player.currentOptions
        return opts.count <= 3 && opts.allSatisfy { $0.count <= 6 }
    }

    /// Display the decision buttons in a fixed, intuitive order (LONG, WAIT,
    /// SHORT) regardless of how the options are stored/shuffled — the underlying
    /// index is preserved so grading is unaffected. Any unrecognized options
    /// keep their original order after these.
    private var compactDecisionOrder: [(index: Int, label: String)] {
        let preferred = ["LONG", "WAIT", "SHORT"]
        let items = player.currentOptions.enumerated().map { (index: $0.offset, label: $0.element) }
        return items.sorted { a, b in
            let ra = preferred.firstIndex(of: a.label) ?? preferred.count + a.index
            let rb = preferred.firstIndex(of: b.label) ?? preferred.count + b.index
            return ra < rb
        }
    }

    private func compactTradeChoice(index: Int, label: String) -> some View {
        // Same chunky 3D slab + MCQ color language as OFOption, just a vertical
        // icon+label face so three fit on one row.
        let selected = player.selectedIndex == index
        let revealed = player.revealed
        let isCorrect = index == player.currentCorrectIndex
        var fill = Theme.optionFill(scheme)
        var border = Theme.optionBorder(scheme)
        var slab = Theme.optionSlab(scheme)
        var textColor = ink
        if revealed {
            if isCorrect { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white }
            else if selected { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white }
        } else if selected {
            fill = Theme.answer; border = Theme.answerDark; slab = Theme.answerDark; textColor = .white
        }
        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.selectedIndex = index
            player.decisionTick = simulationTick
        } label: {
            VStack(spacing: 3) {
                Image(systemName: decisionIcon(label)).font(.system(size: 15, weight: .black))
                Text(label).font(Theme.questionFont(14, .bold)).lineLimit(1).minimumScaleFactor(0.7)
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity).padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(border, lineWidth: 2))
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(slab: slab, radius: 16, depth: 5))
        .disabled(revealed)
    }

    private func decisionIcon(_ label: String) -> String {
        switch label {
        case "LONG": return "arrow.up.right"
        case "SHORT": return "arrow.down.right"
        case "WAIT", "WAIT FOR MORE EVIDENCE", "NO ENTRY": return "hourglass"
        case "EXIT": return "rectangle.portrait.and.arrow.right"
        case "REDUCE": return "minus.circle"
        case "MARKET": return "bolt.fill"
        case "LIMIT": return "scope"
        default: return "checkmark.shield"
        }
    }

    private func toggleHistory(_ index: Int) {
        Haptics.selection()
        expandedCard = expandedCard == index ? nil : index
        if expandedCard == index { inspectedStages[index] = stages[index] }
    }

    private func isCardSelected(_ index: Int) -> Bool {
        screen.type == "orderflow_sim_select" ? player.selectedSet.contains(index) : player.selectedIndex == index
    }

    private func isCorrectCard(_ index: Int) -> Bool {
        if screen.type == "orderflow_sim_select" { return Set(screen.targets ?? []).contains(index) }
        return screen.target == index
    }

    private var evidence: (price: [String], book: [String], tape: [String], footprint: [String]) {
        switch eventKey {
        case "breakout_acceptance_sequence":
            return (["Approaching resistance", "Holding above resistance after a retest"], ["Normal offer depth", "Offers thin and stay thin"], ["Buyer activity increases", "Buying resumes after the pullback"], ["Small positive imbalance", "Directional ask execution returns"])
        case "seller_absorption_developing":
            return (["Testing resistance", "Buyer aggression makes little progress"], ["Large offer appears", "Offer repeatedly replenishes"], ["Buyer prints accelerate", "Buyers remain aggressive"], ["Positive delta builds", "Price response stays weak"])
        case "cvd_warning":
            return (["Price makes a new high", "Price holds above resistance"], ["Offers thin into the break", "No large offer rebuilds"], ["Buyer prints continue", "Buying remains effective"], ["CVD makes a lower high", "Cumulative pressure disagrees"])
        case "volume_profile_context":
            return (["Price reaches the profile POC", "Upward progress stalls"], ["Offers sit near the POC", "Nearby offers replenish"], ["Buyer prints increase", "Buying stays active at the level"], ["POC provides location", "Buying no longer moves price efficiently"])
        case "iceberg":
            return (["Price tests 101.25", "Price remains pinned at 101.25"], ["100 shown at the offer", "100 trades, then 100 reappears"], ["Buyer prints hit 101.25", "Repeated buys execute at one price"], ["Ask executions accumulate", "Large volume with little progress"])
        case "chop":
            return (["Price rotates inside a range", "Little net progress"], ["Bid and offer both replenish", "Depth stays two sided"], ["Buy and sell prints alternate", "Execution remains fast"], ["Heavy volume on both sides", "Delta stays near balanced"])
        case "low_volume_trend":
            return (["Price advances steadily", "Pullbacks stay shallow"], ["Opposing offers are sparse", "Few levels block progress"], ["Print pace stays measured", "Buyer prints remain persistent"], ["Modest positive delta", "Price responds efficiently"])
        case "thin_risk":
            return (["Quote starts at 101.20", "Fill lands at 101.35"], ["Small size near price", "Gaps between ask levels"], ["Spread widens", "Prints jump across prices"], ["Depth changes quickly", "Execution cost increases"])
        case "downside_sweep":
            return (["Prior low trades", "Price immediately reclaims it"], ["Bids vanish briefly", "Bid liquidity rebuilds"], ["Sell prints surge", "Buying responds after breach"], ["Negative delta spikes", "Selling fails to hold price lower"])
        case "breakdown_pressure":
            return (["Support trades", "Price holds below support"], ["Bids are consumed", "Remaining bids withdraw"], ["Seller prints persist", "Selling continues after break"], ["Bid execution dominates", "Negative delta supports downside progress"])
        case "seller_loses_control":
            return (["Sellers press into support", "Price stops falling, then lifts"], ["Bid absorbs repeated trades", "Offers begin clearing above"], ["Seller prints dominate", "Seller pace fades; buyers respond"], ["Negative delta stops moving price", "Opposing ask execution strengthens"])
        case "exit_liquidity":
            return (["Price approaches resistance", "Planned exit area is tested"], ["Ask depth clusters near 101.25", "Displayed depth remains changeable"], ["Buyer prints approach the level", "Counterparties trade near the exit"], ["Execution stays active", "Liquidity quality must be monitored"])
        case "buyer_absorption":
            return (["Testing support below VWAP", "Holding support despite selling"], ["Large bid at 99.40", "Bid refreshes after repeated fills"], ["Selling pace increasing", "Fast seller initiated prints"], ["Bid volume dominates", "Negative delta with little decline"])
        case "sweep":
            return (["Trading above resistance", "Immediate return below the level"], ["Offers briefly disappear", "Sell liquidity rebuilds above"], ["Buy prints surge", "Buying fades after the breach"], ["Ask volume spikes", "Positive delta fails to hold price"])
        case "breakout":
            return (["Testing resistance", "Holding above resistance and VWAP"], ["Offers begin thinning", "Offers consumed across levels"], ["Buying pace increases", "Buyer prints persist after the break"], ["Ask volume dominates", "Stacked ask imbalances continue"])
        case "conflict":
            return (["Price rises above VWAP", "Price loses momentum near resistance"], ["Offers thin briefly", "A large offer begins refreshing"], ["Buyer prints accelerate", "Large sell prints interrupt the run"], ["Positive delta builds", "Delta and price response diverge"])
        case "thin_liquidity":
            return (["Testing resistance", "Price gaps between prints"], ["Depth thins near price", "Spread widens after each fill"], ["Prints arrive faster", "Fills land at worse prices"], ["Volume light at each level", "Delta swings on little size"])
        default:
            return (["Approaching resistance above VWAP", "Stalling at resistance above VWAP"], ["Large offer appears", "Offer refreshes after repeated fills"], ["Buyer initiated prints begin", "Buying pace increasing"], ["Execution is near balanced", "Ask volume begins dominating"])
        }
    }

    private func choice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}

private enum MultiSignalRenderMode: String {
    case summary
    case rawSimplified = "raw_simplified"
    case rawFull = "raw_full"

    var label: String {
        switch self {
        case .summary: return "BEGINNER SUMMARY"
        case .rawSimplified: return "INTERMEDIATE RAW"
        case .rawFull: return "ADVANCED FULL RAW"
        }
    }
}

private struct MultiSignalTrack {
    let icon: String
    let title: String
    let states: [String]
    let tint: Color
}

private struct MultiSignalEvidenceCard: View {
    let track: MultiSignalTrack
    let panelIndex: Int
    let event: String
    let renderMode: MultiSignalRenderMode
    let simulationTick: Int
    let loopVariant: Int
    let scenarioPhase: Int
    let currentStage: Int
    let inspectedStage: Int?
    let expanded: Bool
    let selected: Bool
    let revealed: Bool
    let isCorrect: Bool
    let replayID: Int
    let ink: Color
    let onTap: () -> Void
    let onToggleHistory: () -> Void
    let onInspect: (Int) -> Void

    @State private var displayedValue: String
    @State private var textOpacity = 1.0
    @State private var textOffset: CGFloat = 0
    @State private var pulse = false

    init(track: MultiSignalTrack, panelIndex: Int, event: String, renderMode: MultiSignalRenderMode,
         simulationTick: Int, loopVariant: Int, scenarioPhase: Int,
         currentStage: Int, inspectedStage: Int?, expanded: Bool,
         selected: Bool, revealed: Bool, isCorrect: Bool, replayID: Int, ink: Color,
         onTap: @escaping () -> Void, onToggleHistory: @escaping () -> Void,
         onInspect: @escaping (Int) -> Void) {
        self.track = track
        self.panelIndex = panelIndex
        self.event = event
        self.renderMode = renderMode
        self.simulationTick = simulationTick
        self.loopVariant = loopVariant
        self.scenarioPhase = scenarioPhase
        self.currentStage = currentStage
        self.inspectedStage = inspectedStage
        self.expanded = expanded
        self.selected = selected
        self.revealed = revealed
        self.isCorrect = isCorrect
        self.replayID = replayID
        self.ink = ink
        self.onTap = onTap
        self.onToggleHistory = onToggleHistory
        self.onInspect = onInspect
        _displayedValue = State(initialValue: track.states[min(inspectedStage ?? currentStage, track.states.count - 1)])
    }

    private var effectiveStage: Int { min(inspectedStage ?? currentStage, track.states.count - 1) }
    private var effectiveValue: String { track.states[effectiveStage] }

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(spacing: 10) {
                Image(systemName: track.icon)
                    .font(.system(size: 14, weight: .black)).foregroundColor(track.tint).frame(width: 22)
                    .scaleEffect(pulse ? 1.08 : 1)
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 7) {
                        Text(track.title).font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                        Spacer()
                        if renderMode == .summary && track.states.count > 1 {
                            HStack(spacing: 4) {
                                ForEach(track.states.indices, id: \.self) { index in
                                    Circle().fill(index == currentStage ? track.tint : track.tint.opacity(0.22))
                                        .frame(width: 6, height: 6)
                                }
                            }
                        }
                        if renderMode == .summary {
                            Image(systemName: expanded ? "chevron.up" : "clock.arrow.circlepath")
                                .font(.system(size: 10, weight: .bold)).foregroundColor(Theme.muted)
                                .frame(width: 22, height: 22).contentShape(Rectangle())
                                .highPriorityGesture(TapGesture().onEnded { onToggleHistory() })
                        } else {
                            Image(systemName: expanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                .font(.system(size: 9, weight: .bold)).foregroundColor(Theme.muted)
                        }
                    }
                    if renderMode == .summary {
                        Text(displayedValue)
                            .font(Theme.font(12, .bold)).foregroundColor(ink)
                            .lineLimit(2).fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, minHeight: 32, alignment: .topLeading)
                            .opacity(textOpacity).offset(y: textOffset)
                    } else {
                        RawMarketEvidencePanel(panelIndex: panelIndex, event: event,
                                               tick: simulationTick, loopVariant: loopVariant,
                                               scenarioPhase: scenarioPhase,
                                               full: renderMode == .rawFull || expanded,
                                               tint: track.tint, ink: ink)
                            .frame(height: expanded ? 126 : (renderMode == .rawFull ? 76 : 58))
                    }
                }
            }

            if expanded && renderMode == .summary {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(Array(track.states.indices.prefix(currentStage + 1)), id: \.self) { index in
                        Button(action: { onInspect(index) }) {
                            HStack(alignment: .top, spacing: 7) {
                                Circle().fill(index == currentStage ? track.tint : track.tint.opacity(0.22))
                                    .frame(width: 7, height: 7).padding(.top, 4)
                                Text("\(index + 1). \(track.states[index])")
                                    .font(Theme.font(10, index == currentStage ? .black : .bold))
                                    .foregroundColor(index == effectiveStage ? ink : Theme.muted)
                                    .multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.leading, 32).padding(.top, 2)
            }
        }
        .padding(.horizontal, 9).padding(.vertical, 7)
        .background(RoundedRectangle(cornerRadius: 10).fill(track.tint.opacity(selected ? 0.16 : 0.09)))
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(borderColor, lineWidth: selected || (revealed && isCorrect) ? 2 : 1))
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
        .onChange(of: effectiveValue) { _, newValue in transition(to: newValue) }
        .onChange(of: currentStage) { _, _ in pulseChange() }
    }

    private var borderColor: Color {
        if revealed && isCorrect { return bidColor }
        if revealed && selected && !isCorrect { return askColor }
        return selected ? Theme.answer : track.tint.opacity(0.28)
    }

    private func transition(to newValue: String) {
        withAnimation(.easeOut(duration: 0.10)) { textOpacity = 0; textOffset = -4 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
            displayedValue = newValue
            textOffset = 4
            withAnimation(.easeIn(duration: 0.12)) { textOpacity = 1; textOffset = 0 }
        }
    }

    private func pulseChange() {
        withAnimation(.easeOut(duration: 0.10)) { pulse = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
            withAnimation(.easeIn(duration: 0.12)) { pulse = false }
        }
    }
}

/// Compact raw market data used after the beginner tier. Intermediate keeps
/// the rows sparse and readable; advanced/expert increases density and places
/// the four panels in a synchronized board without adding conclusions.
private struct RawMarketEvidencePanel: View {
    let panelIndex: Int
    let event: String
    let tick: Int
    let loopVariant: Int
    let scenarioPhase: Int
    let full: Bool
    let tint: Color
    let ink: Color

    /// Every panel reads the same deterministic clock. Scenario stages move
    /// that shared clock forward, so price, DOM, tape, footprint and CVD all
    /// tell one event rather than running unrelated animations.
    private var marketTick: Int {
        tick + (event == "breakout_acceptance_sequence" ? scenarioPhase * 6 : 0)
    }

    private var sellerDriven: Bool {
        ["buyer_absorption", "downside_sweep", "breakdown_pressure", "seller_loses_control"].contains(event)
    }

    @ViewBuilder var body: some View {
        switch panelIndex {
        case 0: pricePanel
        case 1: domPanel
        case 2: tapePanel
        default:
            if event == "cvd_warning" { cvdPanel }
            else if event == "volume_profile_context" { profilePanel }
            else { footprintPanel }
        }
    }

    private var pricePanel: some View {
        GeometryReader { proxy in
            let count = full ? 9 : 6
            let pulse = CGFloat((marketTick + loopVariant) % 4)
            let upwardMomentum = event == "breakout" || event == "low_volume_trend" || event == "breakout_acceptance_sequence"
            let downwardMomentum = event == "breakdown_pressure"
            let sideways = event == "chop"
            let upsideRejection = event == "sweep"
            let downsideRejection = event == "downside_sweep"
            let heights: [CGFloat] = (0..<count).map { index in
                let position = CGFloat(index) / CGFloat(max(1, count - 1))
                if sideways { return 34 + CGFloat((marketTick + index * 2) % 5) * 2 }
                if upsideRejection {
                    let turn = marketTick < 7 ? CGFloat(marketTick) * 1.5 : CGFloat(14 - min(marketTick, 14)) * 1.5
                    return 20 + position * 25 + (index == count - 1 ? turn : 0)
                }
                if downsideRejection {
                    let turn = marketTick < 7 ? CGFloat(marketTick) * 1.5 : CGFloat(14 - min(marketTick, 14)) * 1.5
                    return 52 - position * 26 - (index == count - 1 ? turn : 0)
                }
                if upwardMomentum { return 18 + position * 35 + (index == count - 1 ? CGFloat(min(marketTick, 14)) * 1.2 : 0) }
                if downwardMomentum { return 54 - position * 33 - (index == count - 1 ? CGFloat(min(marketTick, 14)) * 1.0 : 0) }
                if sellerDriven { return 50 - position * 29 + (index >= count - 2 ? pulse : 0) }
                return 18 + position * 38 + (index >= count - 2 ? pulse * (index == count - 1 ? 0.35 : 0.7) : 0)
            }
            ZStack {
                Path { path in
                    let y = sellerDriven ? proxy.size.height * 0.78 : proxy.size.height * 0.22
                    path.move(to: CGPoint(x: 0, y: y)); path.addLine(to: CGPoint(x: proxy.size.width, y: y))
                }
                .stroke(Theme.warning.opacity(0.75), style: StrokeStyle(lineWidth: 1.2, dash: [4, 3]))
                Path { path in
                    path.move(to: CGPoint(x: 0, y: proxy.size.height * 0.56))
                    path.addLine(to: CGPoint(x: proxy.size.width, y: proxy.size.height * 0.46))
                }
                .stroke(Theme.progress.opacity(0.65), lineWidth: 1)
                HStack(alignment: .bottom, spacing: full ? 2 : 4) {
                    ForEach(0..<count, id: \.self) { index in
                        let height = heights[index]
                        ZStack {
                            Rectangle().fill((index.isMultiple(of: 4) ? askColor : bidColor).opacity(0.82))
                                .frame(height: max(6, height * 0.42))
                            Rectangle().fill((index.isMultiple(of: 4) ? askColor : bidColor).opacity(0.9))
                                .frame(width: 1.2, height: height)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: sellerDriven ? .top : .bottom)
                    }
                }
                .padding(.horizontal, 2).padding(.vertical, 3)
            }
        }
    }

    private var domPanel: some View {
        let rows = full ? 8 : 6
        let thinBook = event == "thin_risk" || event == "thin_liquidity"
        let refreshSequence = [108, 86, 72, 45, 31, 126, 104, 68, 33, 121]
        let consumeSequence = [142, 119, 91, 64, 38, 17, 4, 0, 0, 0]
        return GeometryReader { proxy in
            let rowHeight = max(1, (proxy.size.height - CGFloat(rows - 1)) / CGFloat(rows))
            VStack(spacing: 1) {
                ForEach(0..<rows, id: \.self) { index in
                    let ask = index < rows / 2
                    let highlighted = sellerDriven ? index == rows / 2 : index == rows / 2 - 1
                    let base = 70 + index * 19 + loopVariant * 7 + ((marketTick + index) % 3) * 3
                    let consumesLiquidity = event == "breakout" || event == "breakdown_pressure" || event == "low_volume_trend" || (event == "breakout_acceptance_sequence" && scenarioPhase > 0)
                    let activeSequence = consumesLiquidity ? consumeSequence : refreshSequence
                    let size = thinBook ? (index.isMultiple(of: 3) ? 0 : 8 + index * 4)
                        : (highlighted ? activeSequence[(marketTick + loopVariant) % activeSequence.count] : base)
                    HStack(spacing: 3) {
                        Text(ask ? "" : "\(size)").frame(maxWidth: .infinity, alignment: .trailing)
                        Text(String(format: "%.2f", 100.20 + Double(rows / 2 - index) * 0.05))
                            .foregroundColor(ink).frame(width: full ? 42 : 54)
                        Text(ask ? "\(size)" : "").frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(Theme.marketFont(full ? 6 : 7, highlighted ? .bold : .medium))
                    .foregroundColor(ask ? askColor : bidColor)
                    .background(highlighted ? tint.opacity(0.11) : .clear)
                    .contentTransition(.numericText())
                    .lineLimit(1)
                    .frame(height: rowHeight)
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .top)
            .clipped()
        }
    }

    private var tapePanel: some View {
        let rows = full ? 7 : 5
        return VStack(spacing: 1) {
            ForEach(marketTick..<(marketTick + rows), id: \.self) { printNumber in
                let initiatedBuy = sellerDriven ? printNumber.isMultiple(of: 3) : (marketTick > 2 ? printNumber % 4 != 0 : printNumber.isMultiple(of: 2))
                HStack(spacing: 3) {
                    Text("10:\(20 + printNumber / 10).\(printNumber % 10)").foregroundColor(Theme.muted)
                    Spacer(minLength: 2)
                    Text(String(format: "%.2f", 100.15 + Double(printNumber % 3) * 0.05))
                    Text("\(40 + (printNumber % 6) * 35 + loopVariant * 11)").frame(width: 25, alignment: .trailing)
                }
                .font(Theme.marketFont(full ? 6 : 7, .medium))
                .foregroundColor(initiatedBuy ? bidColor : askColor)
                .contentTransition(.numericText())
                .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity),
                                        removal: .move(edge: .top).combined(with: .opacity)))
            }
        }
        .clipped()
    }

    private var footprintPanel: some View {
        let rows = full ? 6 : 4
        let conflictingDelta = event == "conflict" || event == "cvd_warning"
        return VStack(spacing: 1) {
            ForEach(0..<rows, id: \.self) { index in
                let base = 35 + index * 13
                let accumulated = min(145, marketTick * (full ? 11 : 9)) + loopVariant * 8
                let bid = (sellerDriven || conflictingDelta) ? base + accumulated : base
                let ask = !sellerDriven && !conflictingDelta ? base + 8 + accumulated : base + 8
                HStack(spacing: 3) {
                    Text("\(bid)").frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 2).background(askColor.opacity(min(0.55, Double(bid) / 260)))
                    Text("×").foregroundColor(Theme.muted)
                    Text("\(ask)").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 2).background(bidColor.opacity(min(0.55, Double(ask) / 260)))
                }
                .font(Theme.marketFont(full ? 6 : 8, .bold)).foregroundColor(ink)
                .contentTransition(.numericText())
            }
            if full {
                Text("Δ \((sellerDriven || conflictingDelta) ? "−" : "+")\(36 + min(520, marketTick * 38))")
                    .font(Theme.marketFont(7, .bold)).foregroundColor((sellerDriven || conflictingDelta) ? askColor : bidColor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    private var cvdPanel: some View {
        GeometryReader { proxy in
            let count = full ? 10 : 7
            Path { path in
                for index in 0..<count {
                    let progress = CGFloat(index) / CGFloat(max(1, count - 1))
                    let developing = min(CGFloat(marketTick) / 12, 1)
                    let rise = progress < 0.62 ? progress * 0.72 : 0.45 + (progress - 0.62) * 0.15
                    let y = proxy.size.height * (0.88 - rise * developing - progress * 0.18)
                    let point = CGPoint(x: proxy.size.width * progress, y: y)
                    if index == 0 { path.move(to: point) } else { path.addLine(to: point) }
                }
            }
            .stroke(Theme.warning, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            Text("CVD").font(Theme.font(7, .black)).foregroundColor(Theme.warning)
                .position(x: 14, y: 8)
        }
    }

    private var profilePanel: some View {
        let bars = full ? [18, 32, 58, 104, 72, 38, 21] : [24, 52, 96, 61, 29]
        return VStack(alignment: .leading, spacing: full ? 2 : 3) {
            ForEach(Array(bars.enumerated()), id: \.offset) { index, width in
                HStack(spacing: 3) {
                    Text(String(format: "%.2f", 100.40 - Double(index) * 0.05))
                        .font(Theme.marketFont(6, .medium)).foregroundColor(Theme.muted).frame(width: 32)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(index == bars.count / 2 ? Theme.warning : Theme.warning.opacity(0.55))
                        .frame(width: CGFloat(width) * (full ? 0.55 : 0.45), height: full ? 5 : 7)
                }
            }
        }
    }
}

// MARK: - Panel 1: Price + context (candles + VWAP + volume profile + POC)

/// Combined "where are we?" panel: candlesticks with a VWAP line and a volume
/// profile along the right edge, the point-of-control bucket highlighted. Used
/// by the synthesis/boss questions (not the focused teaching questions).
struct PriceContextPanel: View {
    var seed: UInt64
    var bullish: Bool = true

    struct VPBar { let lo: Double; let hi: Double; let vol: Double }

    var body: some View {
        let cs = Self.makeCandles(seed: seed, bullish: bullish)
        let vw = Self.vwapLine(cs)
        let vp = Self.volumeProfile(cs)
        let pocIdx = vp.indices.max(by: { vp[$0].vol < vp[$1].vol }) ?? 0
        let maxVol = vp.map { $0.vol }.max() ?? 1
        let vals = cs.flatMap { [$0.high, $0.low] }
        let rawHi = vals.max() ?? 1, rawLo = vals.min() ?? 0
        let pad = max(rawHi - rawLo, 0.001) * 0.08
        let plo = rawLo - pad, phi = rawHi + pad

        return VStack(alignment: .leading, spacing: 8) {
            Text("PRICE + CONTEXT").font(Theme.font(10, .black)).foregroundColor(Theme.muted)
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    ForEach(vp.indices, id: \.self) { i in
                        vpBarView(vp[i], isPOC: i == pocIdx, maxVol: maxVol, geo: geo.size, plo: plo, phi: phi)
                    }
                    ForEach(cs.indices, id: \.self) { i in
                        candleView(cs[i], i: i, n: cs.count, geo: geo.size, plo: plo, phi: phi)
                    }
                    vwapPath(vw, geo: geo.size, plo: plo, phi: phi)
                    Text("POC").font(Theme.font(8, .black)).foregroundColor(Theme.progress)
                        .position(x: geo.size.width - 22,
                                  y: mapY((vp[pocIdx].lo + vp[pocIdx].hi) / 2, geo.size.height, plo, phi) - 9)
                    Text("VWAP").font(Theme.font(8, .black)).foregroundColor(Color(hex: "#F59E0B"))
                        .position(x: 28, y: mapY(vw.first ?? plo, geo.size.height, plo, phi) - 9)
                }
            }
            .frame(height: 92)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.28)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
    }

    private func mapY(_ p: Double, _ H: CGFloat, _ plo: Double, _ phi: Double) -> CGFloat {
        H * (1 - CGFloat((p - plo) / (phi - plo)))
    }

    private func vpBarView(_ b: VPBar, isPOC: Bool, maxVol: Double, geo: CGSize, plo: Double, phi: Double) -> some View {
        let barW = geo.width * 0.32 * CGFloat(b.vol / maxVol)
        let yTop = mapY(b.hi, geo.height, plo, phi)
        let yBot = mapY(b.lo, geo.height, plo, phi)
        return Rectangle()
            .fill((isPOC ? Theme.progress : Color.white).opacity(isPOC ? 0.45 : 0.12))
            .frame(width: max(barW, 1), height: max(yBot - yTop - 1, 1))
            .position(x: geo.width - barW / 2, y: (yTop + yBot) / 2)
    }

    private func candleView(_ c: Candle, i: Int, n: Int, geo: CGSize, plo: Double, phi: Double) -> some View {
        let slot = geo.width / CGFloat(n)
        let cx = slot * (CGFloat(i) + 0.5)
        let col: Color = c.close >= c.open ? bidColor : askColor
        let top = mapY(max(c.open, c.close), geo.height, plo, phi)
        let bot = mapY(min(c.open, c.close), geo.height, plo, phi)
        return ZStack {
            Path { p in
                p.move(to: CGPoint(x: cx, y: mapY(c.high, geo.height, plo, phi)))
                p.addLine(to: CGPoint(x: cx, y: mapY(c.low, geo.height, plo, phi)))
            }.stroke(col, lineWidth: 1.5)
            RoundedRectangle(cornerRadius: 2).fill(col)
                .frame(width: slot * 0.5, height: max(bot - top, 1.5))
                .position(x: cx, y: (top + bot) / 2)
        }
    }

    private func vwapPath(_ vw: [Double], geo: CGSize, plo: Double, phi: Double) -> some View {
        let slot = geo.width / CGFloat(max(vw.count, 1))
        return Path { p in
            for (i, v) in vw.enumerated() {
                let x = slot * (CGFloat(i) + 0.5)
                let y = mapY(v, geo.height, plo, phi)
                if i == 0 { p.move(to: CGPoint(x: x, y: y)) } else { p.addLine(to: CGPoint(x: x, y: y)) }
            }
        }.stroke(Color(hex: "#F59E0B"), style: StrokeStyle(lineWidth: 2, dash: [5, 3]))
    }

    static func makeCandles(seed: UInt64, bullish: Bool) -> [Candle] {
        var rng = SplitMix(seed: seed)
        var price = 100.0
        return (0..<16).map { _ in
            let open = price
            let drift = (bullish ? 0.5 : -0.5) + Double(Int(rng.next() % 40) - 20) / 10.0
            let close = max(20, open + drift)
            let hi = max(open, close) + Double(rng.next() % 16) / 10.0
            let lo = min(open, close) - Double(rng.next() % 16) / 10.0
            price = close
            return Candle(open: open, high: hi, low: lo, close: close)
        }
    }
    static func vwapLine(_ candles: [Candle]) -> [Double] {
        var cumPV = 0.0, cumV = 0.0
        return candles.map { c in
            let typ = (c.high + c.low + c.close) / 3
            let v = (c.high - c.low) * 100 + 20
            cumPV += typ * v; cumV += v
            return cumV > 0 ? cumPV / cumV : typ
        }
    }
    static func volumeProfile(_ candles: [Candle], buckets: Int = 14) -> [VPBar] {
        let allHi = candles.map { $0.high }.max() ?? 1
        let allLo = candles.map { $0.low }.min() ?? 0
        let step = max(allHi - allLo, 0.001) / Double(buckets)
        var vols = Array(repeating: 0.0, count: buckets)
        for c in candles {
            let v = (c.high - c.low) * 100 + 20
            let loB = max(0, min(buckets - 1, Int((c.low - allLo) / step)))
            let hiB = max(0, min(buckets - 1, Int((c.high - allLo) / step)))
            for b in loB...hiB { vols[b] += v / Double(max(hiB - loB + 1, 1)) }
        }
        return (0..<buckets).map { VPBar(lo: allLo + Double($0) * step, hi: allLo + Double($0 + 1) * step, vol: vols[$0]) }
    }
}

// MARK: - Panel 2: DOM + Tape (Level II ladder + Time & Sales, linked live)

/// Combined "what liquidity exists and what is executing?" panel. A live order
/// book (bids left / asks right) sits above a running tape. On each tick a
/// trade fires against the best bid/ask: the DOM level flashes, its resting size
/// falls (and replenishes when depleted), and the trade prints on the tape — so
/// the learner sees the relationship, not two isolated cards.
struct DOMTapePanel: View {
    var seed: UInt64
    var bullish: Bool = true

    struct DOMLevel: Identifiable { let id = UUID(); let price: Double; var bidSize: Int?; var askSize: Int? }
    struct Trade: Identifiable { let id = UUID(); let price: Double; let size: Int; let buy: Bool }

    @State private var levels: [DOMLevel]
    @State private var tape: [Trade] = []
    @State private var flashPrice: Double? = nil
    private let ticker = Timer.publish(every: 0.95, on: .main, in: .common).autoconnect()

    init(seed: UInt64, bullish: Bool = true) {
        self.seed = seed
        self.bullish = bullish
        _levels = State(initialValue: Self.makeDOM(seed: seed))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("DOM + TAPE").font(Theme.font(10, .black)).foregroundColor(Theme.muted)
            HStack {
                Text("BID").frame(maxWidth: .infinity, alignment: .leading)
                Text("PRICE").frame(width: 62)
                Text("ASK").frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(Theme.font(9, .black)).foregroundColor(Theme.muted).padding(.horizontal, 8)

            VStack(spacing: 2) { ForEach(levels) { domRow($0) } }

            Text("RECENT TRADES").font(Theme.font(9, .black)).foregroundColor(Theme.muted).padding(.top, 4)
            VStack(spacing: 2) {
                ForEach(tape) { tradeRow($0) }
                if tape.isEmpty { Text("—").font(Theme.font(11, .bold)).foregroundColor(Theme.muted) }
            }

            Spacer(minLength: 0)   // pack content to top when the row equalizes height
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.28)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
        .onReceive(ticker) { _ in step() }
        .onAppear { if tape.isEmpty { for _ in 0..<4 { step() } } }
    }

    private func domRow(_ lv: DOMLevel) -> some View {
        let flashed = flashPrice == lv.price
        return HStack {
            Text(lv.bidSize.map { "\($0)" } ?? "").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(bidColor)
            Text(String(format: "%.2f", lv.price)).frame(width: 62).foregroundColor(.white).lineLimit(1).minimumScaleFactor(0.7)
            Text(lv.askSize.map { "\($0)" } ?? "").frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(askColor)
        }
        .font(Theme.marketFont(13, .medium)).padding(.horizontal, 8).frame(height: 22)
        .background(
            GeometryReader { g in
                ZStack(alignment: .leading) {
                    if let b = lv.bidSize {
                        Rectangle().fill(bidColor.opacity(0.16)).frame(width: g.size.width * min(1, CGFloat(b) / 240))
                    }
                    if let a = lv.askSize {
                        Rectangle().fill(askColor.opacity(0.16)).frame(width: g.size.width * min(1, CGFloat(a) / 240))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        )
        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white.opacity(flashed ? 0.3 : 0)))
        .animation(.easeOut(duration: 0.45), value: flashPrice)
    }

    private func tradeRow(_ t: Trade) -> some View {
        HStack(spacing: 2) {
            Text(String(format: "%.2f", t.price)).frame(maxWidth: .infinity, alignment: .leading)
            Text("\(t.size)").frame(maxWidth: .infinity)
            Text(t.buy ? "BUY" : "SELL").frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(Theme.marketFont(12, .bold)).foregroundColor(t.buy ? bidColor : askColor)
        .lineLimit(1).minimumScaleFactor(0.7)
        .padding(.horizontal, 8).padding(.vertical, 3)
        .background(RoundedRectangle(cornerRadius: 5).fill((t.buy ? bidColor : askColor).opacity(0.08)))
    }

    private func step() {
        var rng = SystemRandom()
        let buy = rng.next01() < (bullish ? 0.62 : 0.38)
        let size = 20 + Int(rng.next() % 55)
        if buy, let i = levels.lastIndex(where: { $0.askSize != nil }) {
            var a = (levels[i].askSize ?? 0) - size
            if a <= 15 { a = 90 + Int(rng.next() % 150) }        // depleted → replenishes
            levels[i].askSize = a
            pushTrade(Trade(price: levels[i].price, size: size, buy: true), flash: levels[i].price)
        } else if let i = levels.firstIndex(where: { $0.bidSize != nil }) {
            var b = (levels[i].bidSize ?? 0) - size
            if b <= 15 { b = 90 + Int(rng.next() % 150) }
            levels[i].bidSize = b
            pushTrade(Trade(price: levels[i].price, size: size, buy: false), flash: levels[i].price)
        }
    }

    private func pushTrade(_ t: Trade, flash: Double) {
        withAnimation(.easeOut(duration: 0.2)) { tape = Array(([t] + tape).prefix(4)) }
        flashPrice = flash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { if flashPrice == flash { flashPrice = nil } }
    }

    static func makeDOM(seed: UInt64) -> [DOMLevel] {
        var rng = SplitMix(seed: seed)
        let mid = 100.0 + Double(rng.next() % 40) / 10.0
        let tick = 0.05
        var out: [DOMLevel] = []
        for i in stride(from: 3, through: 1, by: -1) {
            out.append(DOMLevel(price: mid + Double(i) * tick, bidSize: nil, askSize: 70 + Int(rng.next() % 150)))
        }
        for i in 1...3 {
            out.append(DOMLevel(price: mid - Double(i) * tick, bidSize: 70 + Int(rng.next() % 150), askSize: nil))
        }
        return out
    }
}

/// Tiny non-deterministic RNG for the live panels' trade cadence.
private struct SystemRandom {
    private var g = SystemRandomNumberGenerator()
    mutating func next() -> UInt64 { UInt64.random(in: 0..<UInt64.max, using: &g) }
    mutating func next01() -> Double { Double.random(in: 0..<1, using: &g) }
}
