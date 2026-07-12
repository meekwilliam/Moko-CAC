import SwiftUI
import Combine

// MARK: - Order-flow interactive mechanics
// Two question types that teach how orders move price, both graded through the
// standard selectedIndex path (0/1):
//   • aggressor  — watch a live order-book ladder get consumed, tap whether the
//                  aggressor is the buyer or the seller.
//   • book_drag  — drag a MARKET order onto the side it fills against (bid/ask).

private let askColor = Color(hex: "#E15C5C")
private let bidColor = Color(hex: "#3FB77E")

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
            .modifier(OptionSurface(fill: fill, border: border, textColor: textColor))
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
                    .font(Theme.font(12, .heavy)).foregroundColor(c)
                Spacer()
                Text("\(lv.size)")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
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

// MARK: - Book depth comparison

/// Side by side ladders make depth tangible: the thick book has large nearby
/// resting size, while the thin book has small size and gaps between levels.
struct BookDepthCompareView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

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
                ladder(title: "BOOK A", sizes: bookSizes.a, tint: .cyan)
                ladder(title: "BOOK B", sizes: bookSizes.b, tint: .orange)
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
                        .font(Theme.font(9, .bold)).foregroundColor(Theme.muted)
                    Spacer(minLength: 2)
                    Text(sizes[index] == 0 ? "GAP" : "\(sizes[index])")
                        .font(Theme.font(10, .black)).foregroundColor(ink)
                }
                .padding(.horizontal, 7).padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 7).fill(tint.opacity(sizes[index] == 0 ? 0.04 : 0.10 + min(0.35, Double(sizes[index]) / 3000))))
            }
        }
        .padding(9).frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.22)))
        .overlay(RoundedRectangle(cornerRadius: 15).strokeBorder(tint.opacity(0.45), lineWidth: 1.5))
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
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(player.screen.question ?? "Which replay shows acceptance?")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)
            HStack(spacing: 10) {
                // Neutral tints (not bid/ask green/red) — A vs. B isn't a
                // buy/sell choice, so it shouldn't borrow that color meaning.
                replay(title: "REPLAY A", rows: replayRows.a, tint: .cyan)
                replay(title: "REPLAY B", rows: replayRows.b, tint: .orange)
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
            Text(title).font(Theme.font(10, .black)).foregroundColor(tint)
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    Circle().fill(tint).frame(width: 6, height: 6)
                    Text(row).font(Theme.font(11, .bold)).foregroundColor(ink)
                }
            }
        }
        .padding(11).frame(maxWidth: .infinity, minHeight: 118, alignment: .topLeading)
        .background(RoundedRectangle(cornerRadius: 15).fill(tint.opacity(0.09)))
        .overlay(RoundedRectangle(cornerRadius: 15).strokeBorder(tint.opacity(0.5), lineWidth: 1.5))
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

                ForEach(Array(prints.enumerated().suffix(visibleRows)), id: \.element.id) { index, print in
                    HStack {
                        Text(print.time).frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.2f", print.price)).frame(maxWidth: .infinity)
                        Text("\(print.size)").frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(Theme.font(13, .bold))
                    .foregroundColor(print.buyerInitiated ? bidColor : askColor)
                    .padding(.horizontal, 12).padding(.vertical, 7)
                    .background((print.buyerInitiated ? bidColor : askColor).opacity(0.08))
                    .overlay(RoundedRectangle(cornerRadius: 5).strokeBorder(tapeRowColor(index), lineWidth: tapeRowWidth(index)))
                    .contentShape(Rectangle())
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
        VStack(alignment: .leading, spacing: 16) {
            Text(screen.question ?? "Read the footprint.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            HStack(alignment: .top, spacing: 8) {
                if screen.event == "delta_negative_rising" { risingPriceChart }
                VStack(spacing: 4) {
                    HStack {
                        Text("BID VOL").frame(maxWidth: .infinity)
                        Text("PRICE").frame(width: 72)
                        Text("ASK VOL").frame(maxWidth: .infinity)
                    }
                    .font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                    ForEach(Array(levels.enumerated()), id: \.element.id) { index, level in
                        HStack(spacing: 6) {
                            volumeCell(level.bidVolume, color: askColor)
                            ZStack(alignment: .trailing) {
                                Text(String(format: "%.2f", level.price))
                                    .font(Theme.font(11, .heavy)).foregroundColor(ink).frame(width: 72)
                                if screen.event == "vwap_target" && index == screen.target {
                                    Text("VWAP").font(Theme.font(7, .black)).foregroundColor(.cyan)
                                        .padding(.horizontal, 4).padding(.vertical, 2)
                                        .background(Capsule().fill(Color.cyan.opacity(0.16)))
                                }
                            }
                            .frame(width: 72)
                            volumeCell(level.askVolume, color: bidColor)
                        }
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 9).fill(index == player.selectedIndex ? Theme.answer.opacity(0.14) : .clear))
                        .overlay(RoundedRectangle(cornerRadius: 9).strokeBorder(footprintRowColor(index), lineWidth: footprintRowWidth(index)))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard screen.type == "footprint_tap", !player.revealed else { return }
                            Haptics.selection(); player.selectedIndex = index
                        }
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))

            if screen.type == "footprint_tap" {
                Label("Tap the price row that answers the question", systemImage: "hand.tap.fill")
                    .font(Theme.font(12, .bold)).foregroundColor(Theme.muted)
            } else {
                VStack(spacing: 10) {
                    ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                        footprintChoice(index: index, label: label)
                    }
                }
            }
        }
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
        OFOption(player: player, index: index, label: label, ink: ink)
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

// MARK: - Comprehensive order flow simulation

/// A compact boss screen that puts several sources of evidence in one market
/// moment. The evidence intentionally conflicts so the learner must weigh the
/// full response instead of recognizing one isolated pattern.
struct OrderFlowSimulationView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    private var screen: LessonScreen { player.screen }
    @State private var phase = 0
    private let ticker = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("MULTI SIGNAL READ").font(Theme.font(10, .black)).foregroundColor(Theme.muted)

            Text(screen.question ?? "What is the strongest current observation?")
                .font(Theme.questionFont(20, .heavy)).foregroundColor(ink)

            VStack(spacing: 7) {
                evidenceRow(icon: "chart.xyaxis.line", title: "PRICE + VWAP", value: evidence.price[phase > 0 ? 1 : 0], tint: .cyan)
                evidenceRow(icon: "list.bullet.rectangle", title: "LEVEL II", value: evidence.book[phase > 1 ? 1 : 0], tint: askColor)
                evidenceRow(icon: "bolt.fill", title: "TIME & SALES", value: evidence.tape[phase > 2 ? 1 : 0], tint: bidColor)
                evidenceRow(icon: "square.grid.3x3.fill", title: "FOOTPRINT", value: evidence.footprint[phase > 3 ? 1 : 0], tint: .orange)
                if screen.footprintPreview == true {
                    Text("EXTRA PREVIEW  Delta compares aggressive buying with selling. This clue is supplemental and is taught in Unit 5.")
                        .font(Theme.font(9, .bold)).foregroundColor(.orange)
                        .multilineTextAlignment(.leading).frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 5).padding(.top, 3)
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color.purple.opacity(0.55), lineWidth: 1.5))
            .onReceive(ticker) { _ in
                guard !player.revealed, phase < 4 else { return }
                withAnimation(.easeInOut(duration: 0.25)) { phase += 1 }
            }

            VStack(spacing: 8) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                    choice(index: index, label: label)
                }
            }
        }
    }

    private var evidence: (price: [String], book: [String], tape: [String], footprint: [String]) {
        switch screen.event {
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
            return (["Testing resistance above VWAP", "Stalling at resistance above VWAP"], ["Large offer at 101.25", "Offer refreshes after repeated fills"], ["Buying pace increasing", "Fast buyer initiated prints"], ["Ask volume dominates", "+840 delta with little progress"])
        }
    }

    private func evidenceRow(icon: String, title: String, value: String, tint: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon).font(.system(size: 14, weight: .black)).foregroundColor(tint).frame(width: 22)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                Text(value).font(Theme.font(12, .bold)).foregroundColor(ink).lineLimit(1).minimumScaleFactor(0.8)
            }
            Spacer()
            Circle().fill(tint).frame(width: 7, height: 7)
        }
        .padding(.horizontal, 9).padding(.vertical, 7)
        .background(RoundedRectangle(cornerRadius: 10).fill(tint.opacity(0.09)))
    }

    private func choice(index: Int, label: String) -> some View {
        OFOption(player: player, index: index, label: label, ink: ink)
    }
}
