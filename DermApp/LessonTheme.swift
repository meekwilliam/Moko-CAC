import SwiftUI

// MARK: - Theme
// Colors, fonts and the 3D "chunky" button treatment used across the app,
// ported to native so the lesson player matches the web look & feel.

enum Theme {
    // DIN Round Pro — the app's real typeface (bundled + registered at launch),
    // matching the original web wrapper. Only Black/Bold/Light faces exist, so
    // weights map onto the nearest available cut.
    static func font(_ size: CGFloat, _ weight: Font.Weight = .heavy) -> Font {
        let name: String
        switch weight {
        case .black, .heavy:
            name = "DINRoundPro-Black"
        case .light, .thin, .ultraLight:
            name = "DINRoundPro-Light"
        default:
            name = "DINRoundPro-Bold"
        }
        return .custom(name, size: size)
    }

    static let ink = Color(hex: "#082f49")
    static let inkDark = Color(hex: "#f8fafc")
    static let muted = Color(hex: "#64748b")

    static let correct = Color(hex: "#22c55e")
    static let correctDark = Color(hex: "#15803d")
    static let incorrect = Color(hex: "#f43f5e")
    static let incorrectDark = Color(hex: "#be123c")

    /// The accent used for answering: selected options, the Check / Got It
    /// buttons, the progress bar, and interactive selections/drawings. Matches
    /// the "Keep Going" button blue so the whole answer flow is one blue.
    static let answer = Color(hex: "#2B70C9")
    static let answerDark = Color(hex: "#1C4A85")

    /// Mirrors `lessonUnitColor(nodeNum)` in index.html.
    static func unitColor(_ node: Int) -> (main: Color, dark: Color) {
        switch node {
        case ...5:  return (Color(hex: "#2B70C9"), Color(hex: "#1C4A85"))
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

// A constant "tilted up toward you" perspective for the path pucks (mirrors the
// web `perspective(560px) rotateX(15deg)`), so they read as 3D instead of flat.
struct TiltModifier: ViewModifier {
    var isPressed: Bool
    var base: CGFloat = 26

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(isPressed ? base + 3 : base),
                axis: (x: 1, y: 0, z: 0),
                anchor: .center,
                perspective: 0.4
            )
    }
}

struct Chunky3DStyle: ButtonStyle {
    var fill: Color
    var slab: Color
    var textColor: Color = .white
    var depth: CGFloat = 6
    var radius: CGFloat = 18
    var font: Font = Theme.font(19, .black)
    // A crisp rim around the top face, like OptionSurface's answer chips —
    // without it the button reads flatter than the answer options next to it.
    // Defaults to the slab color, matching how tinted OptionSurface states work.
    var border: Color? = nil

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
                            .strokeBorder(border ?? slab, lineWidth: 2)
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

// Sinks the label straight down onto its slab on touch-down (the tactile 3D
// press). Use `depth` = the slab offset of whatever it's applied to. Because it
// reacts to `isPressed`, pair it with `delaysContentTouches = false` so the
// press shows instantly inside scroll views.
struct SinkButtonStyle: ButtonStyle {
    var depth: CGFloat = 5
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .offset(y: configuration.isPressed ? depth : 0)
            .animation(configuration.isPressed
                       ? .easeIn(duration: 0.05)
                       : .spring(response: 0.3, dampingFraction: 0.55),
                       value: configuration.isPressed)
    }
}

// A lighter press for flat rows/chips that have no slab: a quick squish + dim.
struct RowPressStyle: ButtonStyle {
    var scale: CGFloat = 0.96
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? 0.82 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Answer reveal effects
// Mirrors the web `optCorrectPop` (springy scale on the right answer) and
// `optShake` (side-to-side shake on a wrong pick) keyframe animations.

struct ShakeEffect: GeometryEffect {
    var travel: CGFloat = 7
    var animatableData: CGFloat = 0
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX: travel * sin(animatableData * .pi * 2), y: 0))
    }
}

struct AnswerFeedbackFX: ViewModifier {
    var pop: Bool    // revealed & this is the correct option
    var shake: Bool  // revealed & this was the (wrong) pick
    @State private var scale: CGFloat = 1
    @State private var shakes: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .modifier(ShakeEffect(animatableData: shakes))
            .onChange(of: pop) { on in
                guard on else { scale = 1; return }
                scale = 1.06   // jump up, spring back — reads as the web's pop
                withAnimation(.spring(response: 0.34, dampingFraction: 0.45)) { scale = 1 }
            }
            .onChange(of: shake) { on in
                guard on else { return }
                withAnimation(.easeInOut(duration: 0.45)) { shakes += 2 }
            }
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

/// The raised card panel a chart sits in, matching the app's chunky-button
/// slab language (a darker copy offset downward) instead of a flat translucent
/// rectangle. Used by every chart-attached view (tap/mark/draw/consolidation
/// screens, question charts, the intro card).
struct ChartCard: ViewModifier {
    var depth: CGFloat = 6
    var radius: CGFloat = 16
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 6).padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(Color.white.opacity(0.07))
                    .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .strokeBorder(Color(hex: "#334155"), lineWidth: 1.5))
            )
            .background(
                // Slab matches the border color (the same neutral slate used by
                // every answer option's outline), not a translucent black blend —
                // that blended into the page background and read as flat.
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(Color(hex: "#334155"))
                    .offset(y: depth)
            )
    }
}
