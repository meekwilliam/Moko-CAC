import SwiftUI
import Combine

// MARK: - Hearts screen

struct HeartsView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager
    var onClose: () -> Void

    @State private var now = Date()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isClosing = false

    private let heartRed = Color(hex: "#FF4D6D")

    private var hearts: Int { router.hearts }
    private var seconds: Int? { router.secondsUntilNextHeart }
    private var treats: Int { router.treats }
    private static let refillCost = 50
    private static let inviteBonus = 5

    var body: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    heartRow
                        .padding(.top, 26)
                    countdown
                        .padding(.top, 22)
                    offersSection
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                }
            }
            .safeAreaInset(edge: .top, spacing: 0) { header }
        }
        .onReceive(ticker) { t in
            guard !isClosing else { return }
            now = t
            router.onOpenHearts?()
        }
    }

    private func close() {
        isClosing = true
        onClose()
    }

    // MARK: Pieces

    private var header: some View {
        ZStack {
            Text("Hearts")
                .font(Theme.font(20, .black))
                .foregroundColor(theme.palette.ink)
            HStack {
                Button(action: { Haptics.selection(); close() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(theme.palette.muted)
                }
                Spacer()
                HStack(spacing: 6) {
                    TreatIcon(height: 15)
                    Text("\(treats)").font(Theme.font(16, .heavy)).foregroundColor(theme.palette.ink)
                }
            }
        }
        .padding(.horizontal, 22)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(theme.palette.base)
    }

    private var heartRow: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .bottomTrailing) {
                HeartBadge(filled: hearts > 0, size: 76)
                Text("\(hearts)")
                    .font(Theme.font(18, .black))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Theme.surfaceRaised))
                    .offset(x: 18, y: 4)
            }
            Text("/ \(ProgressStore.maxHearts)")
                .font(Theme.font(28, .black))
                .foregroundColor(theme.palette.ink)
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

    // MARK: Offers

    private var offersSection: some View {
        VStack(spacing: 14) {
            offerRow(
                badge: AnyView(heartCountBadge("+\(ProgressStore.maxHearts)")),
                title: "Refill",
                trailing: AnyView(
                    HStack(spacing: 5) { TreatIcon(height: 14); Text("\(Self.refillCost)")
                        .font(Theme.font(15, .black)).foregroundColor(theme.palette.ink) }),
                action: { router.onRefillHearts?() }
            )
            offerRow(
                badge: AnyView(heartCountBadge("+\(Self.inviteBonus)")),
                title: "+\(Self.inviteBonus) hearts",
                trailing: AnyView(Text("INVITE A FRIEND")
                    .font(Theme.font(13, .black)).foregroundColor(Color(hex: "#38bdf8"))),
                action: { router.onInviteFriend?() }
            )
        }
    }

    private func offerRow(badge: AnyView, title: String, trailing: AnyView, action: @escaping () -> Void) -> some View {
        Button(action: { Haptics.selection(); action() }) {
            HStack(spacing: 14) {
                badge
                Text(title).font(Theme.font(16, .black)).foregroundColor(theme.palette.ink)
                Spacer(minLength: 0)
                trailing
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Theme.surface)
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Theme.surfaceBorder.opacity(0.65), lineWidth: 1.5))
            )
        }
        .buttonStyle(RowPressStyle())
    }

    private func heartCountBadge(_ label: String) -> some View {
        ZStack {
            Circle().fill(heartRed.opacity(0.16)).frame(width: 42, height: 42)
            HeartBadge(filled: true, size: 24)
            Text(label)
                .font(Theme.font(11, .black)).foregroundColor(.white)
                .padding(.horizontal, 4).padding(.vertical, 1)
                .background(Capsule().fill(Theme.surfaceRaised))
                .offset(x: 14, y: 12)
        }
        .frame(width: 42, height: 42)
    }

    private func timeString(_ total: Int) -> String {
        let m = total / 60, s = total % 60
        return String(format: "%02dM%02dS", m, s)
    }
}

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
