import SwiftUI

// MARK: - Market training progression

/// Linear skill map built directly on PathStore. It changes only presentation:
/// unlocks, test-out availability, lesson resume, completion and rewards remain
/// owned by the existing progression engine.
struct SkillMapView: View {
    @ObservedObject var store: PathStore
    @EnvironmentObject private var theme: ThemeManager

    var onSelectNode: (Int) -> Void
    var onTestOut: (Int) -> Void = { _ in }
    var onOpenCapacity: () -> Void = {}
    var onOpenCourses: () -> Void = {}

    @State private var selectedNodeNumber: Int?
    @State private var didInitialScroll = false

    private var selectedNode: PathNode? {
        selectedNodeNumber.flatMap { number in store.nodes.first { $0.num == number } }
    }

    private var completion: Double {
        guard store.totalNodes > 0 else { return 0 }
        return Double(store.completed.count) / Double(store.totalNodes)
    }

    var body: some View {
        ZStack {
            ThemedBackground()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: Theme.Space.xxxl) {
                        courseOverview
                        ForEach(store.sections, id: \.index) { section in
                            unitSection(section)
                                .id("unit-\(section.index)")
                        }
                        Color.clear.frame(height: 128)
                    }
                    .padding(.horizontal, Theme.Space.lg)
                    .padding(.top, Theme.Space.lg)
                }
                .safeAreaInset(edge: .top, spacing: 0) { trainingHUD }
                .onAppear {
                    guard !didInitialScroll else { return }
                    didInitialScroll = true
                    if let active = store.activeNode,
                       let unit = store.nodes.first(where: { $0.num == active })?.sectionIndex {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                            proxy.scrollTo("unit-\(unit)", anchor: .top)
                        }
                    }
                }
            }

            if let node = selectedNode {
                lessonActionOverlay(node)
                    .zIndex(50)
            }
        }
    }

    // MARK: HUD

    private var trainingHUD: some View {
        VStack(spacing: Theme.Space.sm) {
            HStack(spacing: Theme.Space.sm) {
                Button {
                    guard Game.courses.count > 1 else { return }
                    Haptics.selection()
                    onOpenCourses()
                } label: {
                    HStack(spacing: Theme.Space.xs) {
                        MarketMark(size: 30)
                        VStack(alignment: .leading, spacing: 1) {
                            Text("MARKET TRAINING")
                                .font(Theme.font(9, .black))
                                .tracking(1.4)
                                .foregroundColor(Theme.mastery)
                            Text("Order Flow Lab")
                                .font(Theme.font(16, .bold))
                                .foregroundColor(theme.palette.ink)
                        }
                    }
                }
                .buttonStyle(RowPressStyle())

                Spacer(minLength: 4)

                hudMetric(icon: "bolt.fill", value: store.xp, tint: Theme.progress)
                hudMetric(icon: "calendar.badge.clock", value: store.streak, tint: Theme.expert)
                Button {
                    Haptics.selection()
                    onOpenCapacity()
                } label: {
                    hudMetricContent(icon: "shield.lefthalf.filled", value: store.isUnlimitedHearts ? nil : store.hearts,
                                     text: store.isUnlimitedHearts ? "∞" : nil, tint: Theme.warning)
                }
                .buttonStyle(RowPressStyle())
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(Theme.surfaceStrong)
                    Capsule()
                        .fill(LinearGradient(colors: [Theme.mastery, Theme.progress], startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(8, proxy.size.width * completion))
                }
            }
            .frame(height: 3)
        }
        .padding(.horizontal, Theme.Space.lg)
        .padding(.top, Theme.Space.xs)
        .padding(.bottom, Theme.Space.sm)
        .background(
            Theme.appBackground.opacity(0.96)
                .overlay(Rectangle().fill(Theme.surfaceBorder.opacity(0.7)).frame(height: 1), alignment: .bottom)
                .ignoresSafeArea(edges: .top)
        )
    }

    private func hudMetric(icon: String, value: Int, tint: Color) -> some View {
        hudMetricContent(icon: icon, value: value, text: nil, tint: tint)
    }

    private func hudMetricContent(icon: String, value: Int?, text: String?, tint: Color) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(tint)
            Text(text ?? "\(value ?? 0)")
                .font(Theme.marketFont(12, .semibold))
                .foregroundColor(theme.palette.ink)
                .monospacedDigit()
        }
        .padding(.horizontal, 8)
        .frame(height: 30)
        .background(
            RoundedRectangle(cornerRadius: Theme.Radius.small, style: .continuous)
                .fill(Theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.small, style: .continuous)
                        .strokeBorder(Theme.surfaceBorder, lineWidth: 1)
                )
        )
    }

    private var courseOverview: some View {
        HStack(alignment: .bottom, spacing: Theme.Space.md) {
            VStack(alignment: .leading, spacing: Theme.Space.xs) {
                Text("SKILL MAP")
                    .font(Theme.font(10, .black)).tracking(1.8)
                    .foregroundColor(Theme.subtle)
                Text("Read the market.\nBuild the decision.")
                    .font(Theme.font(28, .bold))
                    .foregroundColor(theme.palette.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 8)
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(Int((completion * 100).rounded()))%")
                    .font(Theme.marketFont(28, .bold))
                    .foregroundColor(Theme.mastery)
                Text("COURSE MASTERY")
                    .font(Theme.font(9, .black)).tracking(1.1)
                    .foregroundColor(Theme.subtle)
            }
        }
    }

    // MARK: Units and lessons

    private func unitSection(_ section: PathSectionData) -> some View {
        let nodes = store.nodes(inSection: section.index)
        let completed = nodes.filter { store.completed.contains($0.num) }.count
        let accent = Theme.tierColor(section.tier, index: section.index).main
        let state = store.progressionState(forSection: section.index)

        return VStack(alignment: .leading, spacing: Theme.Space.md) {
            HStack(alignment: .top, spacing: Theme.Space.sm) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(accent)
                    .frame(width: 4, height: 48)
                    .shadow(color: accent.opacity(0.35), radius: 6)

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: Theme.Space.xs) {
                        Text("UNIT \(section.index + 1)")
                        Text("//")
                        Text((section.tier ?? "TRAINING").uppercased())
                    }
                    .font(Theme.font(9, .black)).tracking(1.2)
                    .foregroundColor(accent)

                    Text(section.title)
                        .font(Theme.font(19, .bold))
                        .foregroundColor(theme.palette.ink)
                }

                Spacer(minLength: 4)

                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(completed)/\(nodes.count)")
                        .font(Theme.marketFont(13, .semibold))
                        .foregroundColor(theme.palette.ink)
                    Text(unitStateLabel(state))
                        .font(Theme.font(8, .black)).tracking(0.8)
                        .foregroundColor(state == .locked ? Theme.subtle : accent)
                }
            }

            VStack(spacing: Theme.Space.sm) {
                ForEach(nodes) { node in
                    lessonModule(node, accent: accent)
                        .id("lesson-\(node.num)")
                }
            }
        }
    }

    private func lessonModule(_ node: PathNode, accent: Color) -> some View {
        let state = store.state(for: node.num)
        let placement = shouldShowTestOut(for: node)
        let visualState: NodeState = placement ? .active : state
        let locked = visualState == .locked
        let done = visualState == .done
        let active = visualState == .active

        return Button {
            if locked { Haptics.play(.locked) } else { Haptics.selection() }
            withAnimation(.easeOut(duration: 0.18)) { selectedNodeNumber = node.num }
        } label: {
            HStack(spacing: Theme.Space.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                        .fill(active ? accent.opacity(0.16) : Theme.surfaceStrong)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                                .strokeBorder(active ? accent.opacity(0.75) : Theme.surfaceBorder, lineWidth: 1)
                        )
                    Image(systemName: node.isBoss ? "waveform.path.ecg.rectangle" : lessonSymbol(node.num))
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundColor(locked ? Theme.subtle : (done ? Theme.mastery : accent))
                }
                .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 7) {
                        Text(node.isBoss ? "MARKET DRILL" : String(format: "LESSON %02d", node.num))
                            .font(Theme.font(9, .black)).tracking(1)
                            .foregroundColor(node.isBoss ? Theme.expert : Theme.subtle)
                        if placement {
                            Text("PLACEMENT")
                                .font(Theme.font(8, .black)).tracking(0.7)
                                .foregroundColor(Theme.progress)
                                .padding(.horizontal, 7).padding(.vertical, 3)
                                .background(Capsule().fill(Theme.progress.opacity(0.12)))
                        }
                    }
                    Text(node.title)
                        .font(Theme.questionFont(15, .semibold))
                        .foregroundColor(locked ? Theme.subtle : theme.palette.ink)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 4)

                Image(systemName: done ? "checkmark.circle.fill" : (locked ? "lock.fill" : "chevron.right"))
                    .font(.system(size: done ? 18 : 14, weight: .semibold))
                    .foregroundColor(done ? Theme.mastery : (active ? accent : Theme.subtle))
            }
            .padding(Theme.Space.sm)
            .frame(maxWidth: .infinity, minHeight: 74, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: Theme.Radius.card, style: .continuous)
                    .fill(active ? Theme.surfaceRaised : Theme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.card, style: .continuous)
                            .strokeBorder(active ? accent.opacity(0.55) : Theme.surfaceBorder.opacity(locked ? 0.45 : 0.9), lineWidth: 1)
                    )
                    .shadow(color: active ? accent.opacity(0.10) : .black.opacity(0.10), radius: 8, y: 3)
            )
            .opacity(locked ? 0.62 : 1)
            .contentShape(RoundedRectangle(cornerRadius: Theme.Radius.card, style: .continuous))
        }
        .buttonStyle(RowPressStyle(scale: 0.992))
    }

    private func lessonSymbol(_ number: Int) -> String {
        let symbols = [
            "chart.xyaxis.line", "rectangle.split.3x1", "list.number", "waveform.path",
            "chart.bar.xaxis", "scope", "arrow.up.and.down.and.arrow.left.and.right",
            "point.3.connected.trianglepath.dotted", "slider.horizontal.3", "checkmark.seal"
        ]
        return symbols[(number - 1) % symbols.count]
    }

    private func unitStateLabel(_ state: UnitProgressState) -> String {
        switch state {
        case .locked: return "LOCKED"
        case .available: return "READY"
        case .inProgress: return "IN PROGRESS"
        case .testedOut: return "PLACED"
        case .completed: return "COMPLETE"
        case .mastered: return "MASTERED"
        }
    }

    // MARK: Action overlay

    private func lessonActionOverlay(_ node: PathNode) -> some View {
        let state = store.state(for: node.num)
        let placement = shouldShowTestOut(for: node)
        let locked = state == .locked && !placement
        let accent = Theme.tierColor(store.section(node.sectionIndex)?.tier, index: node.sectionIndex)
        let action = placement ? "START PLACEMENT CHALLENGE"
            : (locked ? "LESSON LOCKED"
               : (store.inProgressNode == node.num ? "CONTINUE SESSION"
                  : (state == .done ? "REPLAY LESSON" : "START LESSON")))

        return ZStack(alignment: .bottom) {
            Color.black.opacity(0.58)
                .ignoresSafeArea()
                .onTapGesture { dismissOverlay() }

            VStack(alignment: .leading, spacing: Theme.Space.lg) {
                Capsule().fill(Theme.surfaceHighlight).frame(width: 38, height: 4)
                    .frame(maxWidth: .infinity)

                HStack(alignment: .top, spacing: Theme.Space.sm) {
                    MarketMark(size: 42, accent: placement ? Theme.progress : accent.main)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(placement ? "PLACEMENT CHALLENGE" : (node.isBoss ? "SYNTHESIS DRILL" : "TRAINING MODULE"))
                            .font(Theme.font(9, .black)).tracking(1.3)
                            .foregroundColor(placement ? Theme.progress : accent.main)
                        Text(placement ? "Skip to Unit \(node.sectionIndex + 1)" : node.title)
                            .font(Theme.font(21, .bold))
                            .foregroundColor(theme.palette.ink)
                    }
                    Spacer(minLength: 0)
                    Button(action: dismissOverlay) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.muted)
                            .frame(width: 34, height: 34)
                            .background(Circle().fill(Theme.surfaceStrong))
                    }
                    .buttonStyle(RowPressStyle())
                }

                if placement {
                    Text("Demonstrate the required competencies to unlock this unit. Assessment scoring and retry rules remain unchanged.")
                        .font(Theme.bodyFont(14))
                        .foregroundColor(Theme.muted)
                        .fixedSize(horizontal: false, vertical: true)
                } else if locked {
                    Text("Complete the previous training modules to open this lesson.")
                        .font(Theme.bodyFont(14))
                        .foregroundColor(Theme.muted)
                }

                Button(action) {
                    guard !locked else { Haptics.play(.locked); return }
                    Haptics.selection()
                    dismissOverlay()
                    if placement { onTestOut(node.sectionIndex) }
                    else { onSelectNode(node.num) }
                }
                .buttonStyle(Chunky3DStyle(
                    fill: locked ? Theme.surfaceStrong : (placement ? Theme.progress : accent.main),
                    slab: locked ? Theme.surfaceBorder : (placement ? Theme.progressDark : accent.dark),
                    textColor: locked ? Theme.subtle : .white,
                    radius: Theme.Radius.control,
                    font: Theme.font(14, .bold)
                ))
                .disabled(locked)
            }
            .padding(.horizontal, Theme.Space.lg)
            .padding(.top, Theme.Space.sm)
            .padding(.bottom, Theme.Space.xl)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: Theme.Radius.large,
                                       bottomLeadingRadius: 0,
                                       bottomTrailingRadius: 0,
                                       topTrailingRadius: Theme.Radius.large,
                                       style: .continuous)
                    .fill(Theme.surfaceRaised)
                    .overlay(alignment: .top) {
                        Rectangle().fill(Theme.surfaceBorder).frame(height: 1)
                    }
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }

    private func dismissOverlay() {
        withAnimation(.easeOut(duration: 0.16)) { selectedNodeNumber = nil }
    }

    private func shouldShowTestOut(for node: PathNode) -> Bool {
        guard node.sectionIndex > 0,
              store.section(node.sectionIndex)?.testOutEnabled == true,
              let first = store.nodes(inSection: node.sectionIndex).first,
              first.num == node.num else { return false }
        if store.testOutBlockedUnits.contains(node.sectionIndex) { return false }
        if store.testOutRetryUnits.contains(node.sectionIndex) { return true }
        return store.nodes(inSection: node.sectionIndex).allSatisfy { !store.completed.contains($0.num) }
    }
}

// MARK: - Brand mark

/// Code-native market mark used in navigation and launch UI. It is a compact
/// price/volume composition rather than a character or brokerage logo.
struct MarketMark: View {
    var size: CGFloat
    var accent: Color = Theme.mastery

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(Theme.surfaceStrong)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                        .strokeBorder(accent.opacity(0.65), lineWidth: 1)
                )

            HStack(alignment: .bottom, spacing: size * 0.07) {
                candle(height: 0.34, color: Theme.progress)
                candle(height: 0.56, color: accent)
                candle(height: 0.76, color: Theme.expert)
            }
            .frame(width: size * 0.48, height: size * 0.58)
        }
        .frame(width: size, height: size)
        .shadow(color: accent.opacity(0.16), radius: size * 0.22)
    }

    private func candle(height: CGFloat, color: Color) -> some View {
        GeometryReader { proxy in
            let bodyHeight = proxy.size.height * height
            ZStack(alignment: .bottom) {
                Rectangle().fill(color.opacity(0.8))
                    .frame(width: 1, height: min(proxy.size.height, bodyHeight + proxy.size.height * 0.18))
                RoundedRectangle(cornerRadius: 1.5)
                    .fill(color)
                    .frame(height: bodyHeight)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
