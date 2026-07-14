import SwiftUI

// MARK: - Super (premium subscription) tab
// A dedicated store page for the "Super" unlimited-hearts subscription, styled
// after the reference paywall: a big gradient heart, two selectable plan tiers
// (Monthly / Yearly), restore + legal fine print, and a pinned Buy button.
// Purchases run through the real StoreKit 2 flow wired in ViewController.

// Shared brand gradient for everything "Super" (blue → pink → amber).
enum SuperTheme {
    static let colors = [Color(hex: "#6366F1"), Color(hex: "#EC4899"), Color(hex: "#F59E0B")]
    static let gradient = LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)

    static let monthlyProductID = "com.meeko.moko.unlimitedhearts.monthly"
    static let yearlyProductID  = "com.meeko.moko.unlimitedhearts.yearly"
}

/// The subscription heart: a white-bordered, gradient-filled heart with an
/// optional infinity glyph. Reused as the tab icon (small, no infinity) and the
/// page header (large, with infinity).
struct SuperHeartIcon: View {
    var size: CGFloat
    var showInfinity: Bool = true
    /// When true, the fill uses the sliding brand gradient (matches the Hearts UI).
    var animated: Bool = false

    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .font(.system(size: size, weight: .black))
                .foregroundColor(.white)
            heartFill
            if showInfinity {
                Image(systemName: "infinity")
                    .font(.system(size: size * 0.34, weight: .black))
                    .foregroundColor(.white)
                    .offset(y: size * 0.02)
            }
        }
        .frame(width: size * 1.06, height: size * 1.02)
    }

    @ViewBuilder private var heartFill: some View {
        let mask = Image(systemName: "heart.fill")
            .font(.system(size: size * 0.84, weight: .black))
        if animated {
            AnimatedSuperGradient()
                .frame(width: size, height: size)
                .mask(mask)
        } else {
            mask.foregroundStyle(SuperTheme.gradient)
        }
    }
}

struct SuperView: View {
    @ObservedObject var router: AppRouter
    @EnvironmentObject var theme: ThemeManager

    private enum Plan { case monthly, yearly }
    @State private var plan: Plan = .monthly

    private var subscribed: Bool { router.isUnlimitedHearts }

    var body: some View {
        ZStack(alignment: .bottom) {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ZStack {
                        SuperSparkles()
                        SuperHeartIcon(size: 96, animated: true)
                            .shadow(color: Color(hex: "#EC4899").opacity(0.35), radius: 22, y: 8)
                    }
                    .frame(height: 150)
                    .padding(.top, 20)

                    title.padding(.top, 26)

                    Text("Super gives you unlimited hearts to reach every level and more.")
                        .font(Theme.font(16, .semibold))
                        .foregroundColor(theme.palette.muted)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 30)
                        .padding(.top, 16)

                    planCards.padding(.top, 34)

                    restoreButton.padding(.top, 22)

                    finePrint.padding(.top, 4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 150)   // clear the pinned Buy button + tab bar
            }
            .safeAreaInset(edge: .top, spacing: 0) { Color.clear.frame(height: 6) }

            buyBar
        }
    }

    // MARK: Pieces

    private var background: some View {
        ZStack {
            theme.palette.base.ignoresSafeArea()
            RadialGradient(colors: [Color(hex: "#EC4899").opacity(0.18), .clear],
                           center: .top, startRadius: 10, endRadius: 420)
                .ignoresSafeArea()
        }
    }

    private var title: some View {
        HStack(spacing: 0) {
            Text("Learn faster ").foregroundStyle(SuperTheme.gradient)
            Text("with Super").foregroundColor(theme.palette.ink)
        }
        .font(Theme.font(30, .black))
        .minimumScaleFactor(0.6)
        .lineLimit(1)
    }

    private var planCards: some View {
        VStack(spacing: 16) {
            planCard(
                selected: plan == .monthly,
                leading: AnyView(
                    Text("Monthly").font(Theme.font(22, .black)).foregroundColor(theme.palette.ink)
                ),
                trailing: AnyView(
                    Text("$9.99 / MO").font(Theme.font(20, .black)).foregroundColor(theme.palette.ink)
                ),
                tap: { withAnimation(.easeInOut(duration: 0.18)) { plan = .monthly } }
            )
            planCard(
                selected: plan == .yearly,
                leading: AnyView(
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 8) {
                            Text("Yearly").font(Theme.font(22, .black)).foregroundColor(theme.palette.ink)
                            Text("Save 50%")
                                .font(Theme.font(12, .black)).foregroundColor(.white)
                                .padding(.horizontal, 9).padding(.vertical, 4)
                                .background(Capsule().fill(SuperTheme.gradient))
                        }
                        Text("12 mo · $59.99")
                            .font(Theme.font(13, .bold)).foregroundColor(theme.palette.muted)
                    }
                ),
                trailing: AnyView(
                    Text("$5.00 / MO").font(Theme.font(20, .black)).foregroundColor(theme.palette.ink)
                ),
                tap: { withAnimation(.easeInOut(duration: 0.18)) { plan = .yearly } }
            )
        }
    }

    private func planCard(selected: Bool,
                          leading: AnyView, trailing: AnyView,
                          tap: @escaping () -> Void) -> some View {
        Button(action: { Haptics.selection(); tap() }) {
            HStack {
                leading
                Spacer(minLength: 12)
                trailing
            }
            .padding(.horizontal, 22)
            .frame(height: 84)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(0.03))
            )
            .overlay(
                Group {
                    if selected {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .strokeBorder(SuperTheme.gradient, lineWidth: 2.5)
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.12), lineWidth: 1.5)
                    }
                }
            )
            .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(RowPressStyle())
    }

    private var restoreButton: some View {
        Button(action: { Haptics.selection(); router.onRestorePurchases?() }) {
            Text("Restore purchase")
                .font(Theme.font(16, .black))
                .foregroundColor(theme.palette.muted)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .buttonStyle(RowPressStyle())
    }

    private var finePrint: some View {
        (Text("Your Super subscription will automatically renew at the same price within 24 hours before the end of your current subscription period. You can cancel anytime in your App Store settings. View our ")
            .foregroundColor(theme.palette.muted)
         + Text("terms of use").foregroundColor(theme.palette.ink).bold()
         + Text(" and ").foregroundColor(theme.palette.muted)
         + Text("privacy policy").foregroundColor(theme.palette.ink).bold()
         + Text(" for more details.").foregroundColor(theme.palette.muted))
            .font(Theme.font(13, .semibold))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 4)
    }

    private var buyBar: some View {
        VStack(spacing: 0) {
            Button(action: {
                guard !subscribed else { return }
                Haptics.impact(.medium)
                let id = plan == .monthly ? SuperTheme.monthlyProductID : SuperTheme.yearlyProductID
                router.onPurchaseSubscription?(id)
            }) {
                Text(subscribed ? "You're Subscribed" : "Buy now")
                    .font(Theme.font(19, .black))
                    .foregroundColor(subscribed ? .white : .black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(subscribed ? AnyShapeStyle(SuperTheme.gradient) : AnyShapeStyle(Color.white))
                    )
            }
            .buttonStyle(RowPressStyle())
            .disabled(subscribed)
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 78)   // sit above the bottom tab bar
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [theme.palette.base.opacity(0), theme.palette.base],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .bottom)
                .allowsHitTesting(false)
        )
    }
}

// MARK: - Sparkles emanating from the heart

/// A ring of small stars that drift outward from behind the heart and fade —
/// they reset while still hidden behind the heart, so the loop reads seamlessly.
struct SuperSparkles: View {
    private struct Spec {
        let angle: Double        // radians
        let size: CGFloat
        let radius: CGFloat      // how far it travels from center
        let delay: Double
        let duration: Double
        let color: Color
        let symbol: String
    }

    private static let specs: [Spec] = {
        let palette = SuperTheme.colors + [Color.white, Color(hex: "#FBCFE8")]
        let symbols = ["sparkle", "star.fill"]
        var out: [Spec] = []
        let n = 10
        for i in 0..<n {
            let a = (Double(i) / Double(n)) * 2 * .pi + Double(i % 3) * 0.2
            out.append(Spec(
                angle: a,
                size: [8.0, 10.0, 12.0, 9.0][i % 4],
                radius: [72, 86, 64, 92][i % 4],
                delay: Double(i) * 0.28,
                duration: [1.9, 2.3, 2.1][i % 3],
                color: palette[i % palette.count],
                symbol: symbols[i % symbols.count]
            ))
        }
        return out
    }()

    var body: some View {
        ZStack {
            ForEach(Array(Self.specs.enumerated()), id: \.offset) { _, spec in
                Sparkle(spec: spec)
            }
        }
    }

    private struct Sparkle: View {
        let spec: Spec
        @State private var out = false

        var body: some View {
            Image(systemName: spec.symbol)
                .font(.system(size: spec.size, weight: .black))
                .foregroundColor(spec.color)
                .offset(x: cos(spec.angle) * (out ? spec.radius : 6),
                        y: sin(spec.angle) * (out ? spec.radius : 6))
                .scaleEffect(out ? 1.0 : 0.2)
                .opacity(out ? 0 : 1)
                .onAppear {
                    withAnimation(.easeOut(duration: spec.duration)
                        .repeatForever(autoreverses: false)
                        .delay(spec.delay)) {
                        out = true
                    }
                }
        }
    }
}
