import SwiftUI

// MARK: - Streak celebration screen
// Shown once per day, right after the first lesson that extends the streak
// (not on replays or a second lesson the same day). A grey, unlit flame spins
// and reveals the real animated FlameIcon underneath, then the streak count,
// "day streak" label, and a Mo–Su week row (checked days) fade/pop in —
// Duolingo's streak screen, without the mascot.

struct StreakCelebrationView: View {
    var count: Int
    var week: [(label: String, active: Bool, isToday: Bool)]
    var onContinue: () -> Void

    @EnvironmentObject var theme: ThemeManager
    @Environment(\.colorScheme) private var scheme

    @State private var spinDegrees: Double = 0
    @State private var revealed = false
    @State private var popIn = false

    private var ink: Color { scheme == .dark ? Theme.inkDark : Theme.ink }
    private let flameSize: CGFloat = 150

    var body: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()

                ZStack {
                    UnlitFlameIcon(size: flameSize).opacity(revealed ? 0 : 1)
                    FlameIcon(size: flameSize).opacity(revealed ? 1 : 0)
                }
                .rotation3DEffect(.degrees(spinDegrees), axis: (x: 0, y: 1, z: 0), perspective: 0.45)

                VStack(spacing: 4) {
                    Text("\(count)")
                        .font(Theme.font(64, .black))
                        .foregroundColor(Color(hex: "#F59E0B"))
                    Text("day streak")
                        .font(Theme.font(20, .black))
                        .foregroundColor(Color(hex: "#F59E0B"))
                }
                .scaleEffect(popIn ? 1 : 0.6)
                .opacity(popIn ? 1 : 0)

                weekRow
                    .opacity(popIn ? 1 : 0)
                    .offset(y: popIn ? 0 : 8)

                Spacer()

                Button("Continue") {
                    Haptics.selection()
                    onContinue()
                }
                .buttonStyle(Chunky3DStyle(fill: Color(hex: "#F59E0B"), slab: Color(hex: "#B45309")))
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .opacity(popIn ? 1 : 0)
            }
            .padding(.top, 40)
        }
        .onAppear { runIntro() }
    }

    private var weekRow: some View {
        HStack(spacing: 14) {
            ForEach(Array(week.enumerated()), id: \.offset) { _, day in
                VStack(spacing: 8) {
                    Text(day.label)
                        .font(Theme.font(13, .heavy))
                        .foregroundColor(day.isToday ? Color(hex: "#F59E0B") : Theme.muted)
                    ZStack {
                        Circle()
                            .fill(day.active ? Color(hex: "#F59E0B") : Color(hex: "#2A3649"))
                            .frame(width: 34, height: 34)
                        if day.active {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .black))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }

    private func runIntro() {
        // A one-turn flip: swap the grey silhouette for the real flame right
        // as the view is edge-on (halfway through), so the "reveal" lands
        // mid-spin instead of as a plain crossfade.
        withAnimation(.easeInOut(duration: 0.85)) {
            spinDegrees = 360
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.42) {
            Haptics.impact(.medium)
            withAnimation(.easeInOut(duration: 0.18)) { revealed = true }
        }
        withAnimation(.spring(response: 0.5, dampingFraction: 0.62).delay(0.75)) {
            popIn = true
        }
    }
}
