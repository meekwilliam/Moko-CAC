import SwiftUI

// MARK: - Training continuity

/// Shown once per day after the first session that extends continuity. The
/// underlying streak rules are unchanged; only the presentation is market-led.
struct StreakCelebrationView: View {
    var count: Int
    var week: [(label: String, active: Bool, isToday: Bool)]
    var onContinue: () -> Void

    @EnvironmentObject private var theme: ThemeManager
    @State private var revealed = false

    var body: some View {
        ZStack {
            ThemedBackground()

            VStack(spacing: Theme.Space.xl) {
                Spacer()

                continuityObject

                VStack(spacing: 5) {
                    Text("\(count)")
                        .font(Theme.marketFont(62, .bold))
                        .foregroundColor(Theme.expert)
                        .monospacedDigit()
                    Text("DAY TRAINING CONTINUITY")
                        .font(Theme.font(11, .black))
                        .tracking(1.6)
                        .foregroundColor(theme.palette.ink)
                    Text("Consistency compounds pattern recognition.")
                        .font(Theme.bodyFont(14))
                        .foregroundColor(Theme.muted)
                }
                .opacity(revealed ? 1 : 0)
                .offset(y: revealed ? 0 : 8)

                weekRow
                    .opacity(revealed ? 1 : 0)
                    .offset(y: revealed ? 0 : 8)

                Spacer()

                Button("CONTINUE TRAINING") {
                    Haptics.selection()
                    onContinue()
                }
                .buttonStyle(Chunky3DStyle(fill: Theme.expert, slab: Color(hex: "#5037AA")))
                .padding(.horizontal, Theme.Space.lg)
                .padding(.bottom, Theme.Space.xs)
                .opacity(revealed ? 1 : 0)
            }
            .padding(.top, Theme.Space.xxl)
        }
        .onAppear {
            Haptics.impact(.medium)
            withAnimation(.easeOut(duration: 0.42)) { revealed = true }
        }
    }

    private var continuityObject: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .trim(from: CGFloat(index) * 0.08, to: 0.64 + CGFloat(index) * 0.08)
                    .stroke(
                        index == 0 ? Theme.expert : Theme.progress.opacity(0.42 - Double(index) * 0.1),
                        style: StrokeStyle(lineWidth: index == 0 ? 4 : 2, lineCap: .round)
                    )
                    .frame(width: 136 - CGFloat(index * 26), height: 136 - CGFloat(index * 26))
                    .rotationEffect(.degrees(revealed ? 15 + Double(index * 70) : -25))
            }
            MarketMark(size: 58, accent: Theme.expert)
        }
        .frame(width: 160, height: 160)
        .opacity(revealed ? 1 : 0)
        .scaleEffect(revealed ? 1 : 0.96)
    }

    private var weekRow: some View {
        HStack(spacing: Theme.Space.sm) {
            ForEach(Array(week.enumerated()), id: \.offset) { _, day in
                VStack(spacing: 8) {
                    Text(day.label.uppercased())
                        .font(Theme.font(9, .black))
                        .foregroundColor(day.isToday ? Theme.expert : Theme.subtle)
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(day.active ? Theme.expert.opacity(0.18) : Theme.surface)
                        .frame(width: 34, height: 34)
                        .overlay(
                            Image(systemName: day.active ? "checkmark" : "minus")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(day.active ? Theme.expert : Theme.subtle)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(day.isToday ? Theme.expert : Theme.surfaceBorder, lineWidth: 1)
                        )
                }
            }
        }
    }
}
