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
    var onPreviewStreak: () -> Void = {}
    var onBumpStreak: () -> Void = {}

    @EnvironmentObject var theme: ThemeManager

    private let cardBg = Color(hex: "#1E293B")
    private let cardBorder = Color(hex: "#334155")
    private var muted: Color { theme.palette.muted }

    var body: some View {
        ZStack(alignment: .bottom) {
            ThemedBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    headerSection
                    preferencesSection
                    Color.clear.frame(height: showsHomeButton ? 110 : 140)
                }
                .padding(.horizontal, 18)
                .padding(.top, 20)
            }
            if showsHomeButton { homeFab }
        }
    }

    // MARK: Header + bento stats

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 14) {
                ZStack {
                    Circle().fill(Color(hex: "#0369a1")).frame(width: 62, height: 62).offset(y: 4)
                    Circle().fill(Color(hex: "#38bdf8")).frame(width: 62, height: 62)
                        .overlay(Circle().strokeBorder(Color(hex: "#0284c7"), lineWidth: 2))
                    Image(systemName: "person.fill").font(.system(size: 28)).foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(store.userName).font(Theme.font(21, .black)).foregroundColor(theme.palette.ink)
                    Text("Skincare Learner").font(Theme.font(14, .bold)).foregroundColor(muted)
                }
            }

            // Streak hero
            statCard(fill: "#FF9F1C", border: "#E07B00", slab: "#C2640A", radius: 22) {
                HStack(spacing: 18) {
                    Image(systemName: "flame.fill").font(.system(size: 26)).foregroundColor(.white)
                        .frame(width: 54, height: 54)
                        .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white.opacity(0.22))
                            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(Color.white.opacity(0.30), lineWidth: 2)))
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(store.streak)").font(Theme.font(34, .black)).foregroundColor(.white)
                        Text("DAY STREAK").font(Theme.font(12, .black)).tracking(1)
                            .foregroundColor(Color.white.opacity(0.92))
                    }
                    Spacer()
                }
            }

            // XP + Lessons
            HStack(spacing: 12) {
                statCard(fill: "#FFC83D", border: "#E0A410", slab: "#C2850A", radius: 20) {
                    smallStat(value: store.xp, label: "TOTAL XP")
                }
                statCard(fill: "#14B8A6", border: "#0E9485", slab: "#0B6F65", radius: 20) {
                    smallStat(value: store.lessons, label: "LESSONS")
                }
            }
        }
    }

    private func smallStat(value: Int, label: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(value)").font(Theme.font(34, .black)).foregroundColor(.white)
            Text(label).font(Theme.font(11, .black)).tracking(0.9).foregroundColor(.white)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func statCard<Content: View>(fill: String, border: String, slab: String, radius: CGFloat,
                                          @ViewBuilder _ content: () -> Content) -> some View {
        content()
            .padding(.vertical, 18).padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous).fill(Color(hex: fill))
                    .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .strokeBorder(Color(hex: border), lineWidth: 2))
            )
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous).fill(Color(hex: slab)).offset(y: 4))
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
                        .tint(Color(hex: "#34C759"))
                }
                prefButton(iconSystem: "shield.fill", iconColor: Color(hex: "#38bdf8"),
                           iconBg: Color(hex: "#38bdf8").opacity(0.12), label: "Privacy Policy") {
                    onOpenLegal("privacy")
                }
                prefButton(iconSystem: "doc.text.fill", iconColor: Color(hex: "#6366F1"),
                           iconBg: Color.white.opacity(0.20), label: "Terms & Legal Disclaimer") {
                    onOpenLegal("terms")
                }
                prefButton(iconSystem: "lock.open.fill", iconColor: Color(hex: "#34C759"),
                           iconBg: Color(hex: "#34C759").opacity(0.12), label: "Unlock All Lessons (Test)") {
                    onUnlockAll()
                }
                prefButton(iconSystem: "bone.fill", iconColor: Color(hex: "#F59E0B"),
                           iconBg: Color(hex: "#F59E0B").opacity(0.12), label: "Give Unlimited Bones (Test)") {
                    onGrantTestTreats()
                }
                prefButton(iconSystem: "hammer.fill", iconColor: Color(hex: "#8B5CF6"),
                           iconBg: Color(hex: "#8B5CF6").opacity(0.12), label: "Test All Question Mechanics") {
                    onTestMechanics()
                }
                prefButton(iconSystem: "flame.fill", iconColor: Color(hex: "#F59E0B"),
                           iconBg: Color(hex: "#F59E0B").opacity(0.12), label: "Preview Streak Screen (Test)") {
                    onPreviewStreak()
                }
                prefButton(iconSystem: "plus.circle.fill", iconColor: Color(hex: "#F59E0B"),
                           iconBg: Color(hex: "#F59E0B").opacity(0.12), label: "Bump Streak +1 & Play Animation (Test)") {
                    onBumpStreak()
                }
                prefButton(iconSystem: "trash.fill", iconColor: Color(hex: "#D6536D"),
                           iconBg: Color(hex: "#D6536D").opacity(0.12), label: "Clear Application Data",
                           labelColor: Color(hex: "#D6536D")) {
                    onClearData()
                }
            }
        }
    }

    private func prefRowSurface<Trailing: View>(iconSystem: String, iconColor: Color, iconBg: Color,
                                                label: String, labelColor: Color = .white,
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
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Color.black.opacity(0.38)).offset(y: 4))
    }

    private func prefRow<Trailing: View>(iconSystem: String, iconColor: Color, iconBg: Color,
                                         label: String, @ViewBuilder trailing: () -> Trailing) -> some View {
        prefRowSurface(iconSystem: iconSystem, iconColor: iconColor, iconBg: iconBg, label: label, trailing: trailing)
    }

    private func prefButton(iconSystem: String, iconColor: Color, iconBg: Color, label: String,
                            labelColor: Color = .white, action: @escaping () -> Void) -> some View {
        Button(action: { Haptics.selection(); action() }) {
            prefRowSurface(iconSystem: iconSystem, iconColor: iconColor, iconBg: iconBg,
                           label: label, labelColor: labelColor) {
                Image(systemName: "chevron.right").font(.system(size: 14, weight: .heavy)).foregroundColor(muted)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 4))
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
