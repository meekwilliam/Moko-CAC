import SwiftUI

// MARK: - Theme
// Colors, fonts and the 3D "chunky" button treatment used across the app,
// ported to native so the lesson player matches the web look & feel.

enum Theme {
    // Rounded, heavy geometric face — a close native stand-in for DIN Round Pro.
    static func font(_ size: CGFloat, _ weight: Font.Weight = .heavy) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }

    static let ink = Color(hex: "#082f49")
    static let inkDark = Color(hex: "#f8fafc")
    static let muted = Color(hex: "#64748b")

    static let correct = Color(hex: "#22c55e")
    static let correctDark = Color(hex: "#15803d")
    static let incorrect = Color(hex: "#f43f5e")
    static let incorrectDark = Color(hex: "#be123c")

    /// Mirrors `lessonUnitColor(nodeNum)` in index.html.
    static func unitColor(_ node: Int) -> (main: Color, dark: Color) {
        switch node {
        case ...5:  return (Color(hex: "#38bdf8"), Color(hex: "#0c4a6e"))
        case ...10: return (Color(hex: "#14B8A6"), Color(hex: "#0F766E"))
        case ...15: return (Color(hex: "#7C3AED"), Color(hex: "#4C1D95"))
        case ...20: return (Color(hex: "#10B981"), Color(hex: "#047857"))
        case ...25: return (Color(hex: "#F59E0B"), Color(hex: "#B45309"))
        case ...30: return (Color(hex: "#0891b2"), Color(hex: "#0e4a6e"))
        case ...35: return (Color(hex: "#4f46e5"), Color(hex: "#3730a3"))
        case ...40: return (Color(hex: "#db2777"), Color(hex: "#9d174d"))
        default:    return (Color(hex: "#ea580c"), Color(hex: "#c2410c"))
        }
    }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: s).scanHexInt64(&rgb)
        let r, g, b, a: Double
        if s.count == 8 {
            r = Double((rgb & 0xFF000000) >> 24) / 255
            g = Double((rgb & 0x00FF0000) >> 16) / 255
            b = Double((rgb & 0x0000FF00) >> 8) / 255
            a = Double(rgb & 0x000000FF) / 255
        } else {
            r = Double((rgb & 0xFF0000) >> 16) / 255
            g = Double((rgb & 0x00FF00) >> 8) / 255
            b = Double(rgb & 0x0000FF) / 255
            a = 1
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}

// MARK: - 3D chunky button
// Solid face + a darker "slab" underneath. On press it sinks down onto the
// slab, matching the web `box-shadow:0 Npx 0 <dark>` + translateY treatment.

struct Chunky3DStyle: ButtonStyle {
    var fill: Color
    var slab: Color
    var textColor: Color = .white
    var depth: CGFloat = 6
    var radius: CGFloat = 18
    var font: Font = Theme.font(19, .black)

    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        configuration.label
            .font(font)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .fill(Color.white.opacity(0.18))
                            .frame(height: 3)
                            .padding(.horizontal, 6)
                            .offset(y: -radius + 4),
                        alignment: .top
                    )
            )
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(slab)
                    .offset(y: depth)
            )
            .offset(y: pressed ? depth : 0)
            .animation(pressed
                       ? .easeIn(duration: 0.055)
                       : .spring(response: 0.34, dampingFraction: 0.55), value: pressed)
    }
}

// A rounded card surface with the subtle 3D lip, used for answer options.
struct OptionSurface: ViewModifier {
    var fill: Color
    var border: Color
    var slab: Color
    var textColor: Color
    var pressed: Bool

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
            .padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(border, lineWidth: 2)
                    )
            )
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(slab)
                    .offset(y: 5)
            )
            .offset(y: pressed ? 5 : 0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: pressed)
    }
}
