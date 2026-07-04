import SwiftUI
import Combine

// MARK: - Hearts screen
// Shows the current hearts, a live countdown to the next regenerated heart,
// and prototype monetization: a treats-funded refill, an invite-a-friend
// bonus, and a mock "Super" unlimited-hearts subscription card.

struct HeartsView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager
    var onClose: () -> Void

    // Drives the 1-second countdown tick.
    @State private var now = Date()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // Set the instant the user taps close, so a ticker fire mid-dismiss-animation
    // can't call back into the router and pop the screen right back open.
    @State private var isClosing = false

    private let heartRed = Color(hex: "#FF4D6D")

    private var hearts: Int { router.hearts }
    private var seconds: Int? { router.secondsUntilNextHeart }
    private var unlimited: Bool { router.isUnlimitedHearts }
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
            // safeAreaInset reserves real layout space for the header, instead
            // of overlaying it — so scroll content (and the hearts) never sit
            // underneath it and get visually clipped.
            .safeAreaInset(edge: .top, spacing: 0) { header }
        }
        .onReceive(ticker) { t in
            guard !isClosing else { return }
            now = t
            router.onOpenHearts?()   // ask the VC to refresh hearts/seconds/treats from the store
        }
    }

    private func close() {
        isClosing = true
        onClose()
    }

    // Dismiss the Hearts screen and land on the Super (premium) tab.
    private func openSuperTab() {
        Haptics.selection()
        router.selectedTab = .premium
        close()
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
            if unlimited {
                Image(systemName: "infinity")
                    .font(.system(size: 40, weight: .black))
                    .foregroundColor(heartRed)
            } else {
                ForEach(0..<ProgressStore.maxHearts, id: \.self) { i in
                    HeartBadge(filled: i < hearts, size: 46)
                }
            }
        }
    }

    @ViewBuilder private var countdown: some View {
        if unlimited {
            Text("UNLIMITED HEARTS ACTIVE")
                .font(Theme.font(15, .black))
                .foregroundColor(heartRed)
        } else if let s = seconds, hearts < ProgressStore.maxHearts {
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
            superCard
            // With Unlimited active, hearts never run out — no need to buy a
            // refill or invite a friend for bonus hearts, so hide both.
            if !unlimited {
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
            restoreButton
        }
    }

    // Standard App Store requirement: a way to restore an existing subscription
    // (e.g. after reinstalling or switching devices).
    private var restoreButton: some View {
        Button(action: { Haptics.selection(); router.onRestorePurchases?() }) {
            Text("Restore Purchases")
                .font(Theme.font(14, .black))
                .foregroundColor(theme.palette.muted)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .buttonStyle(RowPressStyle())
        .padding(.top, 2)
    }

    private var superCard: some View {
        Button(action: { openSuperTab() }) {
            VStack(spacing: 0) {
                Text("SUPER")
                    .font(Theme.font(13, .black)).tracking(1)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 18).padding(.vertical, 8)
                    .background(AnimatedSuperGradient())
                HStack(spacing: 14) {
                    ZStack {
                        AnimatedSuperGradient()
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        Image(systemName: "infinity")
                            .font(.system(size: 20, weight: .black)).foregroundColor(.white)
                    }
                    Text("Unlimited")
                        .font(Theme.font(17, .black)).foregroundColor(theme.palette.ink)
                    Spacer(minLength: 0)
                    if unlimited {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                            Text("ACTIVE")
                        }
                        .font(Theme.font(13, .black))
                        .foregroundColor(Color(hex: "#34C759"))
                    } else {
                        Text("FREE TRIAL")
                            .font(Theme.font(13, .black))
                            .foregroundColor(Color(hex: "#EC4899"))
                    }
                }
                .padding(16)
            }
        }
        .buttonStyle(RowPressStyle())
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color.white.opacity(0.04)))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
            .strokeBorder(Color.white.opacity(0.1), lineWidth: 1.5))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
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
                    .fill(Color.white.opacity(0.04))
                    .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 1.5))
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
                .background(Capsule().fill(Color(hex: "#1E293B")))
                .offset(x: 14, y: 12)
        }
        .frame(width: 42, height: 42)
    }

    private func timeString(_ total: Int) -> String {
        let m = total / 60, s = total % 60
        return String(format: "%02dM%02dS", m, s)
    }
}

// A "Super" gradient that slides the same fixed palette (blue → pink →
// orange, matching the reference) back and forth for a shimmer effect —
// no hue-cycling, so it never drifts into other colors.
struct AnimatedSuperGradient: View {
    @State private var slide = false
    private let colors = [Color(hex: "#6366F1"), Color(hex: "#EC4899"), Color(hex: "#F59E0B")]

    var body: some View {
        GeometryReader { geo in
            LinearGradient(colors: colors + colors.reversed(), startPoint: .leading, endPoint: .trailing)
                .frame(width: geo.size.width * 2)
                .offset(x: slide ? -geo.size.width : 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        slide = true
                    }
                }
        }
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
