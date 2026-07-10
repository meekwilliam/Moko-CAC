import SwiftUI

// MARK: - Unit Color Lab (temporary dev tool)
// A floating panel on the home path that edits each unit's live banner
// colors directly on `PathStore.sections` — every path node re-renders in
// real time as you drag. Toggled from the paintbrush FAB in MainTabView.
// Delete this file + its MainTabView hook once colors are final.

struct UnitColorLabView: View {
    @ObservedObject var store: PathStore
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Unit Color Lab")
                    .font(Theme.font(15, .black))
                    .foregroundColor(.white)
                Spacer()
                Button {
                    UIPasteboard.general.string = jsonSnippet()
                    Haptics.selection()
                } label: {
                    Text("Copy JSON")
                        .font(Theme.font(12, .bold))
                        .foregroundColor(Theme.answer)
                }
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Theme.muted)
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(store.sections, id: \.index) { section in
                        unitRow(section)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .frame(maxHeight: 320)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 22, bottomLeadingRadius: 0,
                                   bottomTrailingRadius: 0, topTrailingRadius: 22, style: .continuous)
                .fill(Theme.surface)
                .overlay(
                    UnevenRoundedRectangle(topLeadingRadius: 22, bottomLeadingRadius: 0,
                                           bottomTrailingRadius: 0, topTrailingRadius: 22, style: .continuous)
                        .strokeBorder(Theme.surfaceBorder, lineWidth: 1.5)
                )
        )
    }

    private func unitRow(_ section: PathSectionData) -> some View {
        let mainBinding = Binding<Color>(
            get: { Color(hex: section.bg) },
            set: { newColor in
                store.setSectionColor(index: section.index, bg: newColor.hexString,
                                      slab: newColor.darkened(0.65).hexString)
            }
        )
        let slabBinding = Binding<Color>(
            get: { Color(hex: section.slab) },
            set: { newColor in
                store.setSectionColor(index: section.index, bg: section.bg, slab: newColor.hexString)
            }
        )
        return HStack(spacing: 10) {
            Text(section.title)
                .font(Theme.font(12, .bold))
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(width: 84, alignment: .leading)

            ColorPicker("", selection: mainBinding).labelsHidden()
            ColorPicker("", selection: slabBinding).labelsHidden()

            Text(section.bg)
                .font(Theme.font(10, .bold))
                .foregroundColor(Theme.muted)
            Spacer(minLength: 0)
        }
    }

    private func jsonSnippet() -> String {
        store.sections
            .sorted { $0.index < $1.index }
            .map { "  { \"index\": \($0.index), \"bg\": \"\($0.bg)\", \"slab\": \"\($0.slab)\" }" }
            .joined(separator: ",\n")
    }
}

extension Color {
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
