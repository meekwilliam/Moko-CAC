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
        let chosen = player.selectedIndex == index
        let correct = player.currentCorrectIndex == index
        let revealed = player.revealed
        let fill: Color = revealed
            ? (correct ? bidColor : (chosen ? askColor : Theme.surface))
            : (chosen ? tint.opacity(0.25) : Theme.surface)
        let border: Color = revealed
            ? (correct ? bidColor : (chosen ? askColor : Theme.surfaceBorder))
            : (chosen ? tint : Theme.surfaceBorder)
        return Button(action: {
            guard !player.revealed else { return }
            Haptics.selection()
            player.selectedIndex = index
        }) {
            Text(label)
                .font(Theme.font(17, .black))
                .foregroundColor(revealed && (correct || chosen) ? .white : ink)
                .frame(maxWidth: .infinity).padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(fill))
                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(border, lineWidth: 2))
        }
        .buttonStyle(RowPressStyle())
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
        let signal: Color? = revealed ? (correct ? bidColor : (chosen ? askColor : nil)) : (chosen ? tint : nil)
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

// MARK: - Time and Sales

private struct TapePrint: Identifiable {
    let id = UUID()
    let time: String
    let price: Double
    let size: Int
    let buyerInitiated: Bool
}

private func makeTape(seed: UInt64, event: String) -> [TapePrint] {
    var rng = SplitMix(seed: seed)
    var price = 100.0 + Double(rng.next() % 300) / 10.0
    return (0..<9).map { index in
        let favoredBuy = event == "lift"
        let buyerInitiated: Bool
        if event == "balanced" {
            buyerInitiated = index % 2 == 0
        } else {
            buyerInitiated = index % 4 != 0 ? favoredBuy : !favoredBuy
        }
        price += buyerInitiated ? 0.02 : -0.02
        return TapePrint(
            time: String(format: "10:04:%02d", 12 + index),
            price: price,
            size: 20 + Int(rng.next() % 480),
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
    private let ticker = Timer.publish(every: 0.28, on: .main, in: .common).autoconnect()

    init(player: LessonPlayer, ink: Color) {
        self.player = player
        self.ink = ink
        _prints = State(initialValue: makeTape(seed: chartSeed(player.screen), event: player.screen.event ?? "balanced"))
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

                ForEach(Array(prints.suffix(visibleRows))) { print in
                    HStack {
                        Text(print.time).frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.2f", print.price)).frame(maxWidth: .infinity)
                        Text("\(print.size)").frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(Theme.font(13, .bold))
                    .foregroundColor(print.buyerInitiated ? bidColor : askColor)
                    .padding(.horizontal, 12).padding(.vertical, 7)
                    .background((print.buyerInitiated ? bidColor : askColor).opacity(0.08))
                }
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onReceive(ticker) { _ in
                guard !player.revealed, visibleRows < prints.count else { return }
                withAnimation(.easeOut(duration: 0.2)) { visibleRows += 1 }
            }

            choices
        }
    }

    private var choices: some View {
        VStack(spacing: 10) {
            ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                flowChoice(index: index, label: label)
            }
        }
    }

    private func flowChoice(index: Int, label: String) -> some View {
        let selected = player.selectedIndex == index
        let correct = player.currentCorrectIndex == index
        let revealed = player.revealed
        let tint = revealed ? (correct ? bidColor : (selected ? askColor : Theme.surfaceBorder)) : Theme.answer
        return Button {
            guard !revealed else { return }
            Haptics.selection(); player.selectedIndex = index
        } label: {
            Text(label).font(Theme.font(15, .black)).foregroundColor(ink)
                .frame(maxWidth: .infinity).padding(.vertical, 13)
                .background(RoundedRectangle(cornerRadius: 14).fill(selected ? tint.opacity(0.2) : Theme.surface))
                .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(selected || (revealed && correct) ? tint : Theme.surfaceBorder, lineWidth: 2))
        }
        .buttonStyle(RowPressStyle())
    }
}

// MARK: - Footprint chart

private struct FootprintLevel: Identifiable {
    let id = UUID()
    let price: Double
    let bidVolume: Int
    let askVolume: Int
}

private func makeFootprint(seed: UInt64, event: String) -> [FootprintLevel] {
    var rng = SplitMix(seed: seed)
    let base = 99.8 + Double(rng.next() % 200) / 100.0
    return (0..<7).reversed().map { row in
        let baseVolume = 20 + Int(rng.next() % 90)
        let bid: Int
        let ask: Int
        switch event {
        case "lift":
            bid = baseVolume
            ask = baseVolume + 60 + Int(rng.next() % 120)
        case "hit":
            bid = baseVolume + 60 + Int(rng.next() % 120)
            ask = baseVolume
        default:
            bid = baseVolume + Int(rng.next() % 45)
            ask = baseVolume + Int(rng.next() % 45)
        }
        return FootprintLevel(price: base + Double(row) * 0.05, bidVolume: bid, askVolume: ask)
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
        _levels = State(initialValue: makeFootprint(seed: chartSeed(player.screen), event: player.screen.event ?? "balanced"))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(screen.question ?? "Read the footprint.")
                .font(Theme.questionFont(21, .heavy)).foregroundColor(ink)

            VStack(spacing: 4) {
                HStack {
                    Text("BID VOL").frame(maxWidth: .infinity)
                    Text("PRICE").frame(width: 72)
                    Text("ASK VOL").frame(maxWidth: .infinity)
                }
                .font(Theme.font(9, .black)).foregroundColor(Theme.muted)
                ForEach(levels) { level in
                    HStack(spacing: 6) {
                        volumeCell(level.bidVolume, color: askColor)
                        Text(String(format: "%.2f", level.price))
                            .font(Theme.font(11, .heavy)).foregroundColor(ink).frame(width: 72)
                        volumeCell(level.askVolume, color: bidColor)
                    }
                }
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.24)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5))

            VStack(spacing: 10) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { index, label in
                    footprintChoice(index: index, label: label)
                }
            }
        }
    }

    private func volumeCell(_ volume: Int, color: Color) -> some View {
        Text("\(volume)").font(Theme.font(13, .black)).foregroundColor(.white)
            .frame(maxWidth: .infinity).padding(.vertical, 7)
            .background(RoundedRectangle(cornerRadius: 7).fill(color.opacity(min(0.75, 0.16 + Double(volume) / 360.0))))
    }

    private func footprintChoice(index: Int, label: String) -> some View {
        let selected = player.selectedIndex == index
        let correct = player.currentCorrectIndex == index
        let revealed = player.revealed
        let tint = revealed ? (correct ? bidColor : (selected ? askColor : Theme.surfaceBorder)) : Theme.answer
        return Button {
            guard !revealed else { return }
            Haptics.selection(); player.selectedIndex = index
        } label: {
            Text(label).font(Theme.font(15, .black)).foregroundColor(ink)
                .frame(maxWidth: .infinity).padding(.vertical, 13)
                .background(RoundedRectangle(cornerRadius: 14).fill(selected ? tint.opacity(0.2) : Theme.surface))
                .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(selected || (revealed && correct) ? tint : Theme.surfaceBorder, lineWidth: 2))
        }
        .buttonStyle(RowPressStyle())
    }
}
