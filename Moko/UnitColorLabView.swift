import SwiftUI

// MARK: - Unit Color Lab (temporary dev tool)
// A quick color-picker sheet, one row per path unit, so unit colors can be
// tuned live on-device and the resulting hex codes read off / copied back
// into Theme.unitColor. Reachable from Profile → Preferences → "Unit Color
// Lab (Test)". Delete this file + its ProfileView hook once colors are final.

struct UnitColorLabView: View {
    @Environment(\.dismiss) private var dismiss

    // One representative node per Theme.unitColor range, seeded from the
    // current values so the lab opens showing exactly what's live today.
    private static let sampleNodes = [3, 8, 13, 18, 23, 28, 33, 38, 43]

    @State private var mainColors: [Color]
    // Dark shade tracks main automatically (existing pairs are all ~0.65x),
    // but can be nudged independently if a unit needs more contrast.
    @State private var darkColors: [Color]
    @State private var linkDark: [Bool]

    init() {
        let mains = Self.sampleNodes.map { Theme.unitColor($0).main }
        let darks = Self.sampleNodes.map { Theme.unitColor($0).dark }
        _mainColors = State(initialValue: mains)
        _darkColors = State(initialValue: darks)
        _linkDark = State(initialValue: Array(repeating: true, count: mains.count))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(Self.sampleNodes.indices, id: \.self) { i in
                        unitRow(i)
                    }

                    Button {
                        UIPasteboard.general.string = swiftSnippet()
                        Haptics.selection()
                    } label: {
                        Text("Copy Swift Snippet")
                            .font(Theme.font(15, .bold))
                    }
                    .buttonStyle(Chunky3DStyle(fill: Theme.answer, slab: Theme.answerDark))
                    .padding(.top, 8)
                }
                .padding(16)
            }
            .background(Theme.appBackground.ignoresSafeArea())
            .navigationTitle("Unit Color Lab")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private func unitRow(_ i: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            rowHeader(i)
            rowPickers(i)
            rowHexLine(i)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14, style: .continuous).fill(Theme.surface)
            .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).strokeBorder(Theme.surfaceBorder, lineWidth: 1.5)))
    }

    private func rowHeader(_ i: Int) -> some View {
        HStack {
            Text("Unit \(i + 1)")
                .font(Theme.font(15, .black))
                .foregroundColor(.white)
            Spacer()
            Circle().fill(mainColors[i]).frame(width: 22, height: 22)
            Circle().fill(darkColors[i]).frame(width: 22, height: 22)
        }
    }

    private func rowPickers(_ i: Int) -> some View {
        let mainBinding = Binding<Color>(
            get: { mainColors[i] },
            set: { newValue in
                mainColors[i] = newValue
                if linkDark[i] { darkColors[i] = newValue.darkened(0.65) }
            }
        )
        let darkBinding = Binding<Color>(
            get: { darkColors[i] },
            set: { newValue in
                darkColors[i] = newValue
                linkDark[i] = false   // manual override — stop auto-tracking
            }
        )
        return HStack(spacing: 16) {
            ColorPicker("Main", selection: mainBinding)
                .font(Theme.font(12, .bold))
                .foregroundColor(Theme.muted)
            ColorPicker("Dark", selection: darkBinding)
                .font(Theme.font(12, .bold))
                .foregroundColor(Theme.muted)
        }
    }

    private func rowHexLine(_ i: Int) -> some View {
        HStack {
            Text(mainColors[i].hexString)
            Text(darkColors[i].hexString)
            Spacer()
            Button {
                linkDark[i] = true
                darkColors[i] = mainColors[i].darkened(0.65)
                Haptics.selection()
            } label: {
                Text("Reset dark")
            }
        }
        .font(Theme.font(11, .bold))
        .foregroundColor(Theme.muted)
    }

    private func swiftSnippet() -> String {
        var lines = ["static func unitColor(_ node: Int) -> (main: Color, dark: Color) {"]
        let bounds = [5, 10, 15, 20, 25, 30, 35, 40]
        for i in Self.sampleNodes.indices {
            let condition = i < bounds.count ? "case ...\(bounds[i]):" : "default:"
            lines.append("    \(condition) return (\(mainColors[i].hexString.asColorLiteral), \(darkColors[i].hexString.asColorLiteral))")
        }
        lines.append("}")
        return lines.joined(separator: "\n")
    }
}

private extension String {
    var asColorLiteral: String { "Color(hex: \"\(self)\")" }
}

private extension Color {
    /// Multiplies each RGB channel by `factor` (matches the ~0.65 ratio the
    /// app's existing main/dark unit-color pairs already use).
    func darkened(_ factor: Double) -> Color {
        let c = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        c.getRed(&r, green: &g, blue: &b, alpha: &a)
        return Color(.sRGB, red: r * factor, green: g * factor, blue: b * factor, opacity: a)
    }

    var hexString: String {
        let c = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        c.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "#%02X%02X%02X", Int(round(r * 255)), Int(round(g * 255)), Int(round(b * 255)))
    }
}
