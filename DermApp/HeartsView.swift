import SwiftUI
import Combine

// MARK: - Hearts screen
// Shows the current hearts and a live countdown to the next regenerated heart.
// Hearts gate lessons: each lesson costs 1, and one regenerates every hour up
// to `ProgressStore.maxHearts`. (Payment / refill options intentionally omitted.)

struct HeartsView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager
    var onClose: () -> Void

    // Drives the 1-second countdown tick.
    @State private var now = Date()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private let heartRed = Color(hex: "#FF4D6D")

    private var hearts: Int { router.hearts }
    private var seconds: Int? { router.secondsUntilNextHeart }

    var body: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                heartRow
                    .padding(.top, 30)
                countdown
                    .padding(.top, 22)
                infoCard
                    .padding(.top, 34)
                    .padding(.horizontal, 22)
                Spacer()
            }
        }
        .onReceive(ticker) { t in
            now = t
            router.onOpenHearts?()   // ask the VC to refresh hearts/seconds from the store
        }
    }

    // MARK: Pieces

    private var header: some View {
        ZStack {
            Text("Hearts")
                .font(Theme.font(20, .black))
                .foregroundColor(theme.palette.ink)
            HStack {
                Button(action: { Haptics.selection(); onClose() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(theme.palette.muted)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 22)
        .padding(.top, 12)
    }

    private var heartRow: some View {
        HStack(spacing: 12) {
            ForEach(0..<ProgressStore.maxHearts, id: \.self) { i in
                HeartBadge(filled: i < hearts, size: 46)
            }
        }
    }

    @ViewBuilder private var countdown: some View {
        if let s = seconds, hearts < ProgressStore.maxHearts {
            (Text("NEXT HEART IN  ").font(Theme.font(15, .black)).foregroundColor(theme.palette.muted)
             + Text(timeString(s)).font(Theme.font(15, .black)).foregroundColor(heartRed))
        } else {
            Text("HEARTS FULL")
                .font(Theme.font(15, .black))
                .foregroundColor(theme.palette.muted)
        }
    }

    private var infoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            infoRow(icon: "heart.fill", tint: heartRed,
                    title: "\(ProgressStore.maxHearts) hearts",
                    detail: "Each lesson costs one heart.")
            Divider().background(theme.palette.ink.opacity(0.08))
            infoRow(icon: "clock.fill", tint: Color(hex: "#38bdf8"),
                    title: "1 heart every hour",
                    detail: "Hearts refill on their own over time.")
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.04))
                .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.08), lineWidth: 1.5))
        )
    }

    private func infoRow(icon: String, tint: Color, title: String, detail: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(tint)
                .frame(width: 30)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(Theme.font(16, .black)).foregroundColor(theme.palette.ink)
                Text(detail).font(Theme.font(13, .bold)).foregroundColor(theme.palette.muted)
            }
            Spacer(minLength: 0)
        }
    }

    private func timeString(_ total: Int) -> String {
        let m = total / 60, s = total % 60
        return String(format: "%02dM%02dS", m, s)
    }
}

// A filled/empty heart with a deep red and a glossy shine highlight.
struct HeartBadge: View {
    var filled: Bool
    var size: CGFloat

    private let deepRed = Color(hex: "#E01033")

    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: size, weight: .bold))
            .foregroundColor(filled ? deepRed : Color(hex: "#3A4553"))
            .overlay(alignment: .topLeading) {
                if filled {
                    Ellipse()
                        .fill(Color.white.opacity(0.55))
                        .frame(width: size * 0.24, height: size * 0.15)
                        .rotationEffect(.degrees(-28))
                        .offset(x: size * 0.22, y: size * 0.2)
                        .blur(radius: size * 0.01)
                }
            }
    }
}
