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
                    LazyVStack(alignment: .leading, spacing: MarketDesign.Spacing.xxxl) {
                        courseOverview
                        ForEach(store.sections, id: \.index) { section in
                            unitSection(section)
                                .id("unit-\(section.index)")
                        }
                        Color.clear.frame(height: MarketDesign.Spacing.huge * 2.5)
                    }
                    .padding(.horizontal, MarketDesign.Spacing.lg)
                    .padding(.top, MarketDesign.Spacing.lg)
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
        VStack(spacing: MarketDesign.Spacing.sm) {
            HStack(spacing: MarketDesign.Spacing.sm) {
                Button {
                    guard Game.courses.count > 1 else { return }
                    Haptics.selection()
                    onOpenCourses()
                } label: {
                    HStack(spacing: MarketDesign.Spacing.xs) {
                        MarketMark(size: 30)
                        VStack(alignment: .leading, spacing: MarketDesign.Spacing.xxs) {
                            Text("MARKET TRAINING")
                                .marketText(.overline)
                                .foregroundColor(MarketDesign.Colors.brandTeal)
                            Text("Order Flow Lab")
                                .marketText(.title)
                                .foregroundColor(theme.palette.ink)
                        }
                    }
                }
                .buttonStyle(RowPressStyle())

                Spacer(minLength: 4)

                hudMetric(icon: "bolt.fill", value: store.xp, tint: MarketDesign.Colors.progressBlue)
                hudMetric(icon: "calendar.badge.clock", value: store.streak, tint: MarketDesign.Colors.expertViolet)
                Button {
                    Haptics.selection()
                    onOpenCapacity()
                } label: {
                    hudMetricContent(icon: "shield.lefthalf.filled", value: store.isUnlimitedHearts ? nil : store.hearts,
                                     text: store.isUnlimitedHearts ? "∞" : nil, tint: MarketDesign.Colors.warning.full)
                }
                .buttonStyle(RowPressStyle())
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(MarketDesign.Colors.surfaceStrong)
                    Capsule()
                        .fill(LinearGradient(colors: [MarketDesign.Colors.brandTeal, MarketDesign.Colors.progressBlue], startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(8, proxy.size.width * completion))
                }
            }
            .frame(height: MarketDesign.ControlSize.progressTrack)
        }
        .padding(.horizontal, MarketDesign.Spacing.lg)
        .padding(.top, MarketDesign.Spacing.xs)
        .padding(.bottom, MarketDesign.Spacing.sm)
        .background(
            MarketDesign.Colors.backgroundPrimary.opacity(0.96)
                .overlay(Rectangle().fill(MarketDesign.Colors.borderSubtle.opacity(0.7)).frame(height: 1), alignment: .bottom)
                .ignoresSafeArea(edges: .top)
        )
    }

    private func hudMetric(icon: String, value: Int, tint: Color) -> some View {
        hudMetricContent(icon: icon, value: value, text: nil, tint: tint)
    }

    private func hudMetricContent(icon: String, value: Int?, text: String?, tint: Color) -> some View {
        HStack(spacing: MarketDesign.Spacing.xxs) {
            Image(systemName: icon)
                .marketIcon(size: MarketDesign.IconSize.small, color: tint)
            Text(text ?? "\(value ?? 0)")
                .marketText(.marketNumber)
                .foregroundColor(theme.palette.ink)
        }
        .padding(.horizontal, MarketDesign.Spacing.xs)
        .frame(height: MarketDesign.ControlSize.compact)
        .marketCard(elevation: MarketDesign.Elevation.base, radius: MarketDesign.Radius.small)
    }

    private var courseOverview: some View {
        HStack(alignment: .bottom, spacing: MarketDesign.Spacing.md) {
            VStack(alignment: .leading, spacing: MarketDesign.Spacing.xs) {
                Text("SKILL MAP")
                    .marketText(.overline)
                    .foregroundColor(MarketDesign.Colors.textSubtle)
                Text("Read the market.\nBuild the decision.")
                    .marketText(.displayMedium)
                    .foregroundColor(theme.palette.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 8)
            VStack(alignment: .trailing, spacing: MarketDesign.Spacing.xxs) {
                Text("\(Int((completion * 100).rounded()))%")
                    .marketText(.metricLarge)
                    .foregroundColor(MarketDesign.Colors.brandTeal)
                Text("COURSE MASTERY")
                    .marketText(.overline)
                    .foregroundColor(MarketDesign.Colors.textSubtle)
            }
        }
    }

    // MARK: Units and lessons

    private func unitSection(_ section: PathSectionData) -> some View {
        let nodes = store.nodes(inSection: section.index)
        let completed = nodes.filter { store.completed.contains($0.num) }.count
        let accent = Theme.tierColor(section.tier, index: section.index).main
        let state = store.progressionState(forSection: section.index)

        return VStack(alignment: .leading, spacing: MarketDesign.Spacing.md) {
            HStack(alignment: .top, spacing: MarketDesign.Spacing.sm) {
                Capsule()
                    .fill(accent)
                    .frame(width: MarketDesign.Spacing.xxs, height: MarketDesign.ControlSize.standard)

                VStack(alignment: .leading, spacing: MarketDesign.Spacing.xxs) {
                    HStack(spacing: MarketDesign.Spacing.xs) {
                        Text("UNIT \(section.index + 1)")
                        Text("//")
                        Text((section.tier ?? "TRAINING").uppercased())
                    }
                    .marketText(.overline)
                    .foregroundColor(accent)

                    Text(section.title)
                        .marketText(.headlineMedium)
                        .foregroundColor(theme.palette.ink)
                }

                Spacer(minLength: 4)

                VStack(alignment: .trailing, spacing: MarketDesign.Spacing.xxs) {
                    Text("\(completed)/\(nodes.count)")
                        .marketText(.marketNumber)
                        .foregroundColor(theme.palette.ink)
                    Text(unitStateLabel(state))
                        .marketText(.overline)
                        .foregroundColor(state == .locked ? Theme.subtle : accent)
                }
            }

            VStack(spacing: MarketDesign.Spacing.sm) {
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
            withAnimation(MarketDesign.Motion.fastEase) { selectedNodeNumber = node.num }
        } label: {
            HStack(spacing: MarketDesign.Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                        .fill(active ? accent.opacity(0.16) : Theme.surfaceStrong)
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                                .strokeBorder(active ? accent.opacity(0.75) : Theme.surfaceBorder, lineWidth: 1)
                        )
                    Image(systemName: node.isBoss ? "waveform.path.ecg.rectangle" : lessonSymbol(node.num))
                        .marketIcon(size: MarketDesign.IconSize.large)
                        .foregroundColor(locked ? Theme.subtle : (done ? Theme.mastery : accent))
                }
                .frame(width: MarketDesign.ControlSize.standard, height: MarketDesign.ControlSize.standard)

                VStack(alignment: .leading, spacing: MarketDesign.Spacing.xxs) {
                    HStack(spacing: MarketDesign.Spacing.xs) {
                        Text(node.isBoss ? "MARKET DRILL" : String(format: "LESSON %02d", node.num))
                            .marketText(.overline)
                            .foregroundColor(node.isBoss ? Theme.expert : Theme.subtle)
                        if placement {
                            Text("PLACEMENT")
                                .marketText(.overline)
                                .foregroundColor(Theme.progress)
                                .padding(.horizontal, MarketDesign.Spacing.xs)
                                .padding(.vertical, MarketDesign.Spacing.xxs)
                                .background(Capsule().fill(Theme.progress.opacity(0.12)))
                        }
                    }
                    Text(node.title)
                        .marketText(.title)
                        .foregroundColor(locked ? Theme.subtle : theme.palette.ink)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 4)

                Image(systemName: done ? "checkmark.circle.fill" : (locked ? "lock.fill" : "chevron.right"))
                    .marketIcon(size: done ? MarketDesign.IconSize.medium : MarketDesign.IconSize.small)
                    .foregroundColor(done ? Theme.mastery : (active ? accent : Theme.subtle))
            }
            .padding(MarketDesign.Spacing.sm)
            .frame(maxWidth: .infinity, minHeight: MarketDesign.ControlSize.lessonModule, alignment: .leading)
            .marketCard(
                elevation: active ? MarketDesign.Elevation.focus : MarketDesign.Elevation.base,
                border: active ? accent.opacity(0.55) : MarketDesign.Colors.borderSubtle.opacity(locked ? 0.45 : 0.9),
                radius: MarketDesign.Radius.large,
                accent: active ? accent : nil
            )
            .opacity(locked ? 0.62 : 1)
            .contentShape(RoundedRectangle(cornerRadius: MarketDesign.Radius.large, style: .continuous))
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
        let action = placement ? "Start placement challenge"
            : (locked ? "Lesson locked"
               : (store.inProgressNode == node.num ? "Continue session"
                  : (state == .done ? "Replay lesson" : "Start lesson")))

        return ZStack(alignment: .bottom) {
            MarketDesign.Colors.scrim
                .ignoresSafeArea()
                .onTapGesture { dismissOverlay() }

            VStack(alignment: .leading, spacing: MarketDesign.Spacing.lg) {
                Capsule().fill(Theme.surfaceHighlight).frame(width: 38, height: 4)
                    .frame(maxWidth: .infinity)

                HStack(alignment: .top, spacing: MarketDesign.Spacing.sm) {
                    MarketMark(size: 42, accent: placement ? Theme.progress : accent.main)
                    VStack(alignment: .leading, spacing: MarketDesign.Spacing.xs) {
                        Text(placement ? "PLACEMENT CHALLENGE" : (node.isBoss ? "SYNTHESIS DRILL" : "TRAINING MODULE"))
                            .marketText(.overline)
                            .foregroundColor(placement ? Theme.progress : accent.main)
                        Text(placement ? "Skip to Unit \(node.sectionIndex + 1)" : node.title)
                            .marketText(.headlineMedium)
                            .foregroundColor(theme.palette.ink)
                    }
                    Spacer(minLength: 0)
                    Button(action: dismissOverlay) {
                        Image(systemName: "xmark")
                            .marketIcon(size: MarketDesign.IconSize.small)
                            .foregroundColor(Theme.muted)
                            .frame(width: MarketDesign.ControlSize.compact, height: MarketDesign.ControlSize.compact)
                            .background(Circle().fill(Theme.surfaceStrong))
                    }
                    .buttonStyle(RowPressStyle())
                }

                if placement {
                    Text("Demonstrate the required competencies to unlock this unit. Assessment scoring and retry rules remain unchanged.")
                        .marketText(.body)
                        .foregroundColor(Theme.muted)
                        .fixedSize(horizontal: false, vertical: true)
                } else if locked {
                    Text("Complete the previous training modules to open this lesson.")
                        .marketText(.body)
                        .foregroundColor(Theme.muted)
                }

                Button(action) {
                    guard !locked else { Haptics.play(.locked); return }
                    Haptics.selection()
                    dismissOverlay()
                    if placement { onTestOut(node.sectionIndex) }
                    else { onSelectNode(node.num) }
                }
                .buttonStyle(MarketButtonStyle(variant: placement ? .primary : .secondary))
                .disabled(locked)
            }
            .padding(.horizontal, MarketDesign.Spacing.lg)
            .padding(.top, MarketDesign.Spacing.sm)
            .padding(.bottom, MarketDesign.Spacing.xl)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: MarketDesign.Radius.extraLarge,
                                       bottomLeadingRadius: 0,
                                       bottomTrailingRadius: 0,
                                       topTrailingRadius: MarketDesign.Radius.extraLarge,
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
        withAnimation(MarketDesign.Motion.fastEase) { selectedNodeNumber = nil }
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
