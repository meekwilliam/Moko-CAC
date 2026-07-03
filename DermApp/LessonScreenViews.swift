import SwiftUI

// MARK: - Router

struct LessonScreenRouter: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        switch player.screen.type {
        case "intro":
            IntroView(player: player, ink: ink)
        case "matching":
            MatchingView(player: player, ink: ink)
        case "fill_blank_multi":
            FillBlankMultiView(player: player, ink: ink)
        case "ingredient_match":
            IngredientMatchView(player: player, ink: ink)
        case "sequence_builder", "drag_order":
            OrderBuilderView(player: player, ink: ink)
        default:
            // true_false / multiple_choice / fill_blank / spot_mistake
            ChoiceView(player: player, ink: ink)
        }
        // Re-key so per-screen @State resets when the step changes.
        // (id applied by parent via player.index)
    }
}

// MARK: - Intro

struct IntroView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(player.screen.screenTitle ?? player.lesson.title)
                .font(Theme.font(30, .black))
                .foregroundColor(ink)
                .fixedSize(horizontal: false, vertical: true)

            if let text = player.screen.text {
                Text(RichText.attributed(text,
                                         base: Theme.font(17, .medium),
                                         bold: Theme.font(17, .black),
                                         color: ink.opacity(0.85)))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
    }
}

// MARK: - Choice (true_false / multiple_choice / fill_blank / spot_mistake)

struct ChoiceView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var s: LessonScreen { player.screen }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            if s.type == "spot_mistake", let scenario = s.scenario {
                scenarioCard(scenario)
            }

            promptText

            VStack(spacing: 14) {
                ForEach(Array(player.currentOptions.enumerated()), id: \.offset) { idx, opt in
                    optionButton(idx: idx, label: opt)
                }
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var promptText: some View {
        let raw = displayQuestion()
        return Text(RichText.attributed(raw,
                                        base: Theme.font(21, .heavy),
                                        bold: Theme.font(21, .black),
                                        color: ink))
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// For fill_blank, fill the [___] with the chosen option (or a blank).
    private func displayQuestion() -> String {
        var q = s.question ?? ""
        if s.type == "fill_blank" {
            let fill: String
            if let sel = player.selectedIndex, let opts = s.options, opts.indices.contains(sel) {
                fill = "<b>\(opts[sel])</b>"
            } else {
                fill = "______"
            }
            q = q.replacingOccurrences(of: "[___]", with: fill)
        }
        return q
    }

    private func scenarioCard(_ scenario: String) -> some View {
        Text(RichText.attributed(scenario,
                                 base: Theme.font(15.5, .semibold),
                                 bold: Theme.font(15.5, .black),
                                 color: .white))
            .lineSpacing(3)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(hex: "#F59E0B"))
                    .background(RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(hex: "#B45309")).offset(y: 5))
            )
    }

    private func optionButton(idx: Int, label: String) -> some View {
        let selected = player.selectedIndex == idx
        let revealed = player.revealed
        let isCorrect = idx == player.currentCorrectIndex

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#0F172A") : Color(hex: "#B8C4D8")
        var textColor = ink

        if revealed {
            if isCorrect {
                fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white
            } else if selected {
                fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white
            }
        } else if selected {
            fill = Color(hex: "#38bdf8"); border = Color(hex: "#0284c7"); slab = Color(hex: "#0369a1"); textColor = .white
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.selectedIndex = idx
        } label: {
            HStack {
                Text(label).font(Theme.font(16, .bold))
                Spacer(minLength: 0)
                if revealed && isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                } else if revealed && selected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .modifier(OptionSurface(fill: fill, border: border, slab: slab, textColor: textColor, pressed: false))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(revealed)
        .modifier(AnswerFeedbackFX(pop: revealed && isCorrect,
                                   shake: revealed && selected && !isCorrect))
    }
}

// MARK: - Matching

struct MatchingView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    // Snapshot the pairs/question locally so they can't change out from under
    // `rightOrder` when the player advances to the next (non-matching) screen.
    @State private var pairs: [[String]] = []
    @State private var question: String = ""
    @State private var rightOrder: [Int] = []
    @State private var matchedLeft: Set<Int> = []
    @State private var matchedRight: Set<Int> = []
    @State private var selLeft: Int? = nil
    @State private var selRight: Int? = nil
    @State private var wrongPair: (Int, Int)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(RichText.attributed(question.isEmpty ? "Match the pairs:" : question,
                                     base: Theme.font(21, .heavy),
                                     bold: Theme.font(21, .black), color: ink))
                .fixedSize(horizontal: false, vertical: true)

            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 12) {
                    ForEach(pairs.indices, id: \.self) { i in
                        chip(text: pairs[i][safe: 0] ?? "", isLeft: true, index: i)
                    }
                }
                VStack(spacing: 12) {
                    ForEach(rightOrder.indices, id: \.self) { slot in
                        let p = rightOrder[slot]
                        chip(text: (pairs[safe: p]?[safe: 1]) ?? "", isLeft: false, index: slot)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            if pairs.isEmpty {
                pairs = player.screen.pairs ?? []
                question = player.screen.question ?? ""
                rightOrder = Array(pairs.indices).shuffled()
            }
        }
    }

    private func chip(text: String, isLeft: Bool, index: Int) -> some View {
        let matched = isLeft ? matchedLeft.contains(index) : matchedRight.contains(index)
        let selected = isLeft ? (selLeft == index) : (selRight == index)
        let isWrong = wrongPair != nil && ((isLeft && wrongPair!.0 == index) || (!isLeft && wrongPair!.1 == index))

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#0F172A") : Color(hex: "#B8C4D8")
        var textColor = ink

        if matched {
            fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white
        } else if isWrong {
            fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white
        } else if selected {
            fill = Color(hex: "#38bdf8"); border = Color(hex: "#0284c7"); slab = Color(hex: "#0369a1"); textColor = .white
        }

        return Button {
            tap(isLeft: isLeft, index: index)
        } label: {
            Text(text).font(Theme.font(13.5, .bold))
                .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .modifier(OptionSurface(fill: fill, border: border, slab: slab, textColor: textColor, pressed: false))
                .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(matched)
    }

    private func tap(isLeft: Bool, index: Int) {
        guard wrongPair == nil else { return }
        Haptics.selection()
        if isLeft { selLeft = index } else { selRight = index }
        guard let l = selLeft, let r = selRight else { return }

        // rightOrder[r] is the original pair index for the chosen right chip.
        if rightOrder[r] == l {
            matchedLeft.insert(l); matchedRight.insert(r)
            selLeft = nil; selRight = nil
            Haptics.impact(.light)
            if matchedLeft.count == pairs.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation { player.markMatchingSolved() }
                }
            }
        } else {
            wrongPair = (l, r)
            Haptics.impact(.rigid)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation { wrongPair = nil; selLeft = nil; selRight = nil }
            }
        }
    }
}

// MARK: - Fill blank (multi)

struct FillBlankMultiView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var blanks: [Blank] { player.screen.blanks ?? [] }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(RichText.attributed(filledTemplate(),
                                     base: Theme.font(20, .heavy),
                                     bold: Theme.font(20, .black), color: ink))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            ForEach(blanks.indices, id: \.self) { bi in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Blank \(bi + 1)")
                        .font(Theme.font(12, .black))
                        .foregroundColor(Theme.muted)
                    FlowChips(options: blanks[bi].options,
                              selected: player.multiSelections[safe: bi] ?? nil,
                              revealed: player.revealed,
                              correctIndex: blanks[bi].correct,
                              ink: ink,
                              scheme: scheme) { idx in
                        guard !player.revealed else { return }
                        Haptics.selection()
                        if player.multiSelections.count == blanks.count {
                            player.multiSelections[bi] = idx
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func filledTemplate() -> String {
        var t = player.screen.template ?? ""
        for (i, b) in blanks.enumerated() {
            let token = "[__\(i + 1)__]"
            let fill: String
            if let sel = player.multiSelections[safe: i] ?? nil, b.options.indices.contains(sel) {
                fill = "<b>\(b.options[sel])</b>"
            } else {
                fill = "______"
            }
            t = t.replacingOccurrences(of: token, with: fill)
        }
        return t
    }
}

struct FlowChips: View {
    var options: [String]
    var selected: Int?
    var revealed: Bool
    var correctIndex: Int
    var ink: Color
    var scheme: ColorScheme
    var onTap: (Int) -> Void

    var body: some View {
        HStack(spacing: 10) {
            ForEach(Array(options.enumerated()), id: \.offset) { idx, opt in
                chip(idx: idx, label: opt)
            }
        }
    }

    private func chip(idx: Int, label: String) -> some View {
        let isSel = selected == idx
        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var textColor = ink
        if revealed && idx == correctIndex {
            fill = Theme.correct; border = Theme.correctDark; textColor = .white
        } else if revealed && isSel {
            fill = Theme.incorrect; border = Theme.incorrectDark; textColor = .white
        } else if isSel {
            fill = Color(hex: "#38bdf8"); border = Color(hex: "#0284c7"); textColor = .white
        }
        return Button { onTap(idx) } label: {
            Text(label).font(Theme.font(14, .bold)).foregroundColor(textColor)
                .padding(.vertical, 10).padding(.horizontal, 14)
        }
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(fill)
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).strokeBorder(border, lineWidth: 2))
        )
        .buttonStyle(RowPressStyle())
        .modifier(AnswerFeedbackFX(pop: revealed && idx == correctIndex,
                                   shake: revealed && isSel && idx != correctIndex))
    }
}

// MARK: - Ingredient match (single choice with label + detail)

struct IngredientMatchView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    private var s: LessonScreen { player.screen }
    private var options: [IngredientOption] { s.ingredientOptions ?? [] }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            if let concern = s.concern {
                VStack(alignment: .leading, spacing: 6) {
                    Text("THE CONCERN")
                        .font(Theme.font(11, .black))
                        .foregroundColor(.white.opacity(0.7))
                        .tracking(1.2)
                    Text(RichText.attributed(concern,
                                             base: Theme.font(15.5, .semibold),
                                             bold: Theme.font(15.5, .black), color: .white))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(hex: "#0891b2"))
                        .background(RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color(hex: "#0e4a6e")).offset(y: 5))
                )
            }

            Text(RichText.attributed(s.question ?? "",
                                     base: Theme.font(21, .heavy),
                                     bold: Theme.font(21, .black), color: ink))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 14) {
                ForEach(Array(options.enumerated()), id: \.offset) { idx, opt in
                    optionButton(idx: idx, opt: opt)
                }
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func optionButton(idx: Int, opt: IngredientOption) -> some View {
        let selected = player.selectedIndex == idx
        let revealed = player.revealed
        let isCorrect = (opt.correct == true)

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED")
        var slab = scheme == .dark ? Color(hex: "#0F172A") : Color(hex: "#B8C4D8")
        var textColor = ink
        var subColor = Theme.muted

        if revealed {
            if isCorrect { fill = Theme.correct; border = Theme.correctDark; slab = Theme.correctDark; textColor = .white; subColor = .white.opacity(0.85) }
            else if selected { fill = Theme.incorrect; border = Theme.incorrectDark; slab = Theme.incorrectDark; textColor = .white; subColor = .white.opacity(0.85) }
        } else if selected {
            fill = Color(hex: "#38bdf8"); border = Color(hex: "#0284c7"); slab = Color(hex: "#0369a1"); textColor = .white; subColor = .white.opacity(0.85)
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.selectedIndex = idx
        } label: {
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(opt.label).font(Theme.font(16, .black)).foregroundColor(textColor)
                    if let detail = opt.detail {
                        Text(detail).font(Theme.font(13, .semibold)).foregroundColor(subColor)
                    }
                }
                Spacer(minLength: 0)
                if revealed && isCorrect { Image(systemName: "checkmark.circle.fill").foregroundColor(.white) }
                else if revealed && selected { Image(systemName: "xmark.circle.fill").foregroundColor(.white) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 15).padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(border, lineWidth: 2))
            )
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(slab).offset(y: 5))
            .contentShape(Rectangle())
        }
        .buttonStyle(SinkButtonStyle(depth: 5))
        .disabled(revealed)
        .modifier(AnswerFeedbackFX(pop: revealed && isCorrect,
                                   shake: revealed && selected && !isCorrect))
    }
}

// MARK: - Order builder (sequence_builder / drag_order)

struct OrderBuilderView: View {
    @ObservedObject var player: LessonPlayer
    var ink: Color
    @Environment(\.colorScheme) private var scheme

    @State private var items: [String] = []
    @State private var correctOrder: [String] = []
    @State private var question: String = ""

    private var pool: [String] { items.filter { !player.builtOrder.contains($0) } }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(RichText.attributed(question,
                                     base: Theme.font(21, .heavy),
                                     bold: Theme.font(21, .black), color: ink))
                .fixedSize(horizontal: false, vertical: true)

            // Built sequence
            VStack(spacing: 10) {
                ForEach(Array(player.builtOrder.enumerated()), id: \.offset) { i, item in
                    builtRow(i: i, item: item)
                }
                if player.builtOrder.count < items.count {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6, 5]))
                        .foregroundColor(Theme.muted.opacity(0.4))
                        .frame(height: 52)
                        .overlay(Text("Tap an item below").font(Theme.font(13, .bold)).foregroundColor(Theme.muted.opacity(0.7)))
                }
            }

            // Pool
            if !pool.isEmpty {
                VStack(spacing: 10) {
                    ForEach(pool, id: \.self) { item in
                        Button {
                            guard !player.revealed else { return }
                            Haptics.selection()
                            player.builtOrder.append(item)
                        } label: {
                            HStack {
                                Text(item).font(Theme.font(15, .bold)).foregroundColor(ink)
                                Spacer(minLength: 0)
                                Image(systemName: "plus.circle.fill").foregroundColor(player.unit.main)
                            }
                            .padding(.vertical, 15).padding(.horizontal, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(scheme == .dark ? Color(hex: "#1E293B") : Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .strokeBorder(scheme == .dark ? Color(hex: "#334155") : Color(hex: "#DDE3ED"), lineWidth: 2))
                            )
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(RowPressStyle())
                    }
                }
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            if items.isEmpty {
                items = player.screen.items ?? []
                correctOrder = player.screen.correctOrder ?? []
                question = player.screen.question ?? ""
            }
        }
    }

    private func builtRow(i: Int, item: String) -> some View {
        let revealed = player.revealed
        let rightPlace = revealed && (correctOrder[safe: i] == item)

        var fill = scheme == .dark ? Color(hex: "#1E293B") : Color.white
        var border = player.unit.main
        var textColor = ink
        if revealed {
            if rightPlace { fill = Theme.correct; border = Theme.correctDark; textColor = .white }
            else { fill = Theme.incorrect; border = Theme.incorrectDark; textColor = .white }
        }

        return Button {
            guard !revealed else { return }
            Haptics.selection()
            player.builtOrder.removeAll { $0 == item }
        } label: {
            HStack(spacing: 12) {
                Text("\(i + 1)")
                    .font(Theme.font(15, .black))
                    .foregroundColor(revealed ? .white : player.unit.main)
                    .frame(width: 26, height: 26)
                    .background(Circle().fill((revealed ? Color.white : player.unit.main).opacity(revealed ? 0.25 : 0.15)))
                Text(item).font(Theme.font(15, .bold)).foregroundColor(textColor)
                Spacer(minLength: 0)
                if !revealed { Image(systemName: "xmark.circle.fill").foregroundColor(Theme.muted.opacity(0.5)) }
            }
            .padding(.vertical, 13).padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous).fill(fill)
                    .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(border, lineWidth: 2))
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(RowPressStyle())
        .disabled(revealed)
    }
}
