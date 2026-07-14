import SwiftUI

// MARK: - Native Profile screen
// Rebuild of the web #screen-profile: progress header (avatar + bento stats),
// the badge trophy room, preferences (reminders / privacy / terms / clear data),
// and a bottom Home button. Presented as a modal stacked over the native home.

struct ProfileView: View {
    @ObservedObject var store: ProfileStore
    var showsHomeButton: Bool = true    // false when hosted inside the tab bar
    var onHome: () -> Void
    var onToggleReminders: (Bool) -> Void
    var onOpenLegal: (String) -> Void
    var onClearData: () -> Void
    var onUnlockAll: () -> Void = {}
    var onGrantTestTreats: () -> Void = {}
    var onTestMechanics: () -> Void = {}
    var onTestMultiSignal: () -> Void = {}
    var onPreviewStreak: () -> Void = {}
    var onBumpStreak: () -> Void = {}
    var onTestOnboarding: () -> Void = {}

    @EnvironmentObject var theme: ThemeManager

    private let cardBg = Theme.surface
    private let cardBorder = Theme.surfaceBorder
    private var muted: Color { theme.palette.muted }

    var body: some View {
        ZStack(alignment: .bottom) {
            ThemedBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    headerSection
                    achievementSection
                    preferencesSection
                    Color.clear.frame(height: showsHomeButton ? 110 : 140)
                }
                .padding(.horizontal, 18)
                .padding(.top, 20)
            }
            if showsHomeButton { homeFab }
        }
    }

    // MARK: Identity + performance stats

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 14) {
                MarketMark(size: 58)
                VStack(alignment: .leading, spacing: 3) {
                    Text(store.userName).font(Theme.font(21, .bold)).foregroundColor(theme.palette.ink)
                    Text("MARKET READER // TRAINING PROFILE")
                        .font(Theme.font(9, .black)).tracking(1.1).foregroundColor(Theme.mastery)
                }
            }

            HStack(spacing: Theme.Space.sm) {
                performanceStat(value: store.xp, label: "TOTAL XP", symbol: "bolt.fill", accent: Theme.progress)
                performanceStat(value: store.lessons, label: "MODULES", symbol: "square.stack.3d.up.fill", accent: Theme.mastery)
                performanceStat(value: store.streak, label: "CONTINUITY", symbol: "calendar.badge.checkmark", accent: Theme.expert)
            }
        }
    }

    private func performanceStat(value: Int, label: String, symbol: String, accent: Color) -> some View {
        VStack(alignment: .leading, spacing: Theme.Space.xs) {
            Image(systemName: symbol)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(accent)
            Text("\(value)").font(Theme.marketFont(24, .bold)).foregroundColor(theme.palette.ink)
            Text(label).font(Theme.font(8, .black)).tracking(0.8).foregroundColor(muted)
        }
        .padding(Theme.Space.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: Theme.Radius.card, style: .continuous)
                .fill(cardBg)
                .overlay(RoundedRectangle(cornerRadius: Theme.Radius.card).strokeBorder(cardBorder, lineWidth: 1))
        )
    }

    // MARK: Achievement objects

    private var achievementSection: some View {
        VStack(alignment: .leading, spacing: Theme.Space.sm) {
            Text("MASTERY OBJECTS").font(Theme.font(11, .black)).tracking(1.3).foregroundColor(theme.palette.ink)
            if store.badges.isEmpty {
                HStack(spacing: Theme.Space.md) {
                    AchievementObject(accent: Theme.mastery, symbol: "waveform.path.ecg", unlocked: false)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your collection starts here")
                            .font(Theme.font(14, .bold)).foregroundColor(theme.palette.ink)
                        Text("Clear synthesis drills and placement challenges to forge mastery objects.")
                            .font(Theme.bodyFont(13)).foregroundColor(muted)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(Theme.Space.md)
                .background(RoundedRectangle(cornerRadius: Theme.Radius.card).fill(cardBg)
                    .overlay(RoundedRectangle(cornerRadius: Theme.Radius.card).strokeBorder(cardBorder, lineWidth: 1)))
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Theme.Space.sm) {
                        ForEach(store.badges) { badge in
                            VStack(spacing: 8) {
                                AchievementObject(accent: Color(hex: badge.color), symbol: badgeSymbol(badge.icon), unlocked: badge.unlocked)
                                Text(badge.name.uppercased())
                                    .font(Theme.font(8, .black)).tracking(0.6)
                                    .foregroundColor(badge.unlocked ? theme.palette.ink : muted)
                                    .lineLimit(1)
                            }
                            .frame(width: 94)
                        }
                    }
                }
            }
        }
    }

    private func badgeSymbol(_ source: String) -> String {
        let value = source.lowercased()
        if value.contains("book") { return "rectangle.split.3x1" }
        if value.contains("tape") { return "list.number" }
        if value.contains("chart") { return "chart.xyaxis.line" }
        if value.contains("crown") { return "scope" }
        return "waveform.path.ecg"
    }

    // MARK: Preferences

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Preferences").font(Theme.font(15, .black)).foregroundColor(theme.palette.ink)
            VStack(spacing: 12) {
                // Daily reminders (toggle)
                prefRow(iconSystem: "bell.fill", iconColor: Color(hex: "#F5A623"),
                        iconBg: Color.white.opacity(0.20), label: "Daily Reminders") {
                    Toggle("", isOn: Binding(
                        get: { store.reminderOn },
                        set: { store.reminderOn = $0; Haptics.selection(); onToggleReminders($0) }))
                        .labelsHidden()
                        .tint(Theme.mastery)
                }
                prefButton(iconSystem: "shield.fill", iconColor: Color(hex: "#38bdf8"),
                           iconBg: Color(hex: "#38bdf8").opacity(0.12), label: "Privacy Policy") {
                    onOpenLegal("privacy")
                }
                prefButton(iconSystem: "doc.text.fill", iconColor: Color(hex: "#6366F1"),
                           iconBg: Color.white.opacity(0.20), label: "Terms & Legal Disclaimer") {
                    onOpenLegal("terms")
                }
                prefButton(iconSystem: "lock.open.fill", iconColor: Theme.mastery,
                           iconBg: Theme.mastery.opacity(0.12), label: "Unlock All Lessons (Test)") {
                    onUnlockAll()
                }
                prefButton(iconSystem: "diamond.fill", iconColor: Theme.warning,
                           iconBg: Theme.warning.opacity(0.12), label: "Give Unlimited Credits (Test)") {
                    onGrantTestTreats()
                }
                prefButton(iconSystem: "hammer.fill", iconColor: Color(hex: "#8B5CF6"),
                           iconBg: Color(hex: "#8B5CF6").opacity(0.12), label: "Test All Question Mechanics") {
                    onTestMechanics()
                }
                prefButton(iconSystem: "square.stack.3d.up.fill", iconColor: Color(hex: "#A855F7"),
                           iconBg: Color(hex: "#A855F7").opacity(0.12), label: "Test Multi Signal Read") {
                    onTestMultiSignal()
                }
                prefButton(iconSystem: "calendar.badge.checkmark", iconColor: Theme.expert,
                           iconBg: Theme.expert.opacity(0.12), label: "Preview Continuity Screen (Test)") {
                    onPreviewStreak()
                }
                prefButton(iconSystem: "plus.circle.fill", iconColor: Theme.expert,
                           iconBg: Theme.expert.opacity(0.12), label: "Bump Continuity +1 (Test)") {
                    onBumpStreak()
                }
                prefButton(iconSystem: "flag.fill", iconColor: Color(hex: "#38bdf8"),
                           iconBg: Color(hex: "#38bdf8").opacity(0.12), label: "Preview Onboarding (Test)") {
                    onTestOnboarding()
                }
                prefButton(iconSystem: "trash.fill", iconColor: Color(hex: "#D6536D"),
                           iconBg: Color(hex: "#D6536D").opacity(0.12), label: "Clear Application Data",
                           labelColor: Color(hex: "#D6536D")) {
                    onClearData()
                }
            }
        }
    }

    // `sunk`: static rows (a toggle) draw their own fixed slab lip. Buttons pass
    // sunk:true so the slab is instead drawn by SinkButtonStyle and vanishes on
    // press (the tactile 2D press).
    private func prefRowSurface<Trailing: View>(iconSystem: String, iconColor: Color, iconBg: Color,
                                                label: String, labelColor: Color = .white, sunk: Bool = false,
                                                @ViewBuilder trailing: () -> Trailing) -> some View {
        HStack(spacing: 13) {
            Image(systemName: iconSystem).font(.system(size: 16)).foregroundColor(iconColor)
                .frame(width: 38, height: 38)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(iconBg))
            Text(label).font(Theme.font(15, .black)).foregroundColor(labelColor)
            Spacer()
            trailing()
        }
        .padding(.vertical, 14).padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(cardBg)
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).strokeBorder(cardBorder, lineWidth: 1.5)))
        .background {
            if !sunk {
                RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Theme.surfaceSlab).offset(y: 4)
            }
        }
    }

    private func prefRow<Trailing: View>(iconSystem: String, iconColor: Color, iconBg: Color,
                                         label: String, @ViewBuilder trailing: () -> Trailing) -> some View {
        prefRowSurface(iconSystem: iconSystem, iconColor: iconColor, iconBg: iconBg, label: label, trailing: trailing)
    }

    private func prefButton(iconSystem: String, iconColor: Color, iconBg: Color, label: String,
                            labelColor: Color = .white, action: @escaping () -> Void) -> some View {
        Button(action: { Haptics.selection(); action() }) {
            prefRowSurface(iconSystem: iconSystem, iconColor: iconColor, iconBg: iconBg,
                           label: label, labelColor: labelColor, sunk: true) {
                Image(systemName: "chevron.right").font(.system(size: 14, weight: .heavy)).foregroundColor(muted)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(slab: Theme.surfaceSlab, radius: 18, depth: 4))
    }

    // MARK: Home fab

    private var homeFab: some View {
        Button(action: { Haptics.selection(); onHome() }) {
            HStack(spacing: 8) {
                Image(systemName: "house.fill").font(.system(size: 17, weight: .bold))
                Text("Home").font(Theme.font(18, .black))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.top, 20).padding(.bottom, 34)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: 26, bottomLeadingRadius: 0,
                                       bottomTrailingRadius: 0, topTrailingRadius: 26, style: .continuous)
                    .fill(Color(hex: "#42A5F5"))
            )
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct AchievementObject: View {
    let accent: Color
    let symbol: String
    let unlocked: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(unlocked ? accent.opacity(0.12) : Theme.surface)
                .frame(width: 70, height: 70)
                .rotationEffect(.degrees(45))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(unlocked ? accent.opacity(0.5) : Theme.surfaceBorder, lineWidth: 1)
                        .rotationEffect(.degrees(45))
                )
            Image(systemName: unlocked ? symbol : "lock.fill")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(unlocked ? accent : Theme.subtle)
        }
        .frame(width: 86, height: 86)
        .rotation3DEffect(.degrees(unlocked ? 7 : 0), axis: (x: 1, y: -0.35, z: 0))
        .shadow(color: unlocked ? accent.opacity(0.18) : .clear, radius: 10, y: 6)
        .opacity(unlocked ? 1 : 0.72)
    }
}

// MARK: - Legal sheet (privacy / terms)

struct LegalSheetView: View {
    let doc: LegalDoc
    var onBack: () -> Void

    @EnvironmentObject var theme: ThemeManager
    private var ink: Color { theme.palette.ink }
    private var muted: Color { theme.palette.muted }

    var body: some View {
        ZStack(alignment: .top) {
            ThemedBackground()
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Button(action: { Haptics.selection(); onBack() }) {
                        Image(systemName: "chevron.left").font(.system(size: 18, weight: .heavy))
                            .foregroundColor(ink).frame(width: 40, height: 40)
                            .background(Circle().fill(ink.opacity(0.06)))
                    }
                    .buttonStyle(RowPressStyle())
                    Text(doc.title).font(Theme.font(18, .black)).foregroundColor(ink)
                    Spacer()
                }
                .padding(.horizontal, 16).padding(.vertical, 12)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(doc.title).font(Theme.font(26, .black)).foregroundColor(ink)
                            .padding(.bottom, 4)
                        Text(doc.date).font(Theme.font(13, .bold)).foregroundColor(muted)
                            .padding(.bottom, 20)
                        ForEach(doc.sections) { s in
                            Text(s.heading).font(Theme.font(16, .black)).foregroundColor(ink)
                                .padding(.bottom, 8)
                            Text(s.body).font(Theme.font(15, .medium)).foregroundColor(ink.opacity(0.75))
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(3)
                                .padding(.bottom, 22)
                        }
                    }
                    .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 60)
                }
            }
        }
    }
}
