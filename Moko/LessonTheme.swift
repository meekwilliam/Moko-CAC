import SwiftUI

// MARK: - Theme
// Colors, fonts and the 3D "chunky" button treatment used across the app,
// ported to native so the lesson player matches the web look & feel.

enum Theme {
    // Sora — the app's chrome typeface (bundled + registered at launch).
    // Keep the weight mapping explicit: SwiftUI cannot reliably select a
    // custom face from `.weight(...)` when fonts are registered at runtime.
    static func font(_ size: CGFloat, _ weight: Font.Weight = .heavy) -> Font {
        switch weight {
        case .ultraLight, .thin, .light, .regular:
            return .custom("Sora-Regular", size: size)
        case .medium:
            return .custom("Sora-Medium", size: size)
        case .semibold:
            return .custom("Sora-SemiBold", size: size)
        case .bold:
            return .custom("Sora-Bold", size: size)
        default:
            // Sora tops out at 800, so ExtraBold is the closest native face
            // for SwiftUI's Heavy (800) and Black (900) semantics.
            return .custom("Sora-ExtraBold", size: size)
        }
    }

    // Plus Jakarta Sans SemiBold — section titles and quiz questions (the
    // prompt itself and its answer choices).
    static func questionFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .custom("PlusJakartaSans-SemiBold", size: size)
    }

    // Plus Jakarta Sans Regular — body copy and supporting/secondary text
    // (subtitles, descriptions, detail captions under a choice).
    static func bodyFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .custom("PlusJakartaSans-Regular", size: size)
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

    static let appBackground = Color(hex: "#0E161A")
    static let surface = Color(hex: "#17242B")
    static let surfaceRaised = Color(hex: "#1E293B")
    static let surfaceBorder = Color(hex: "#41515D")
    static let surfaceSlab = Color(hex: "#33424D")
    static let surfaceMuted = Color(hex: "#3A4A54")
    static let slotFill = Color(hex: "#2B3A44")
    static let slotBorder = Color(hex: "#536673")

    static func optionFill(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surface : .white
    }

    static func optionBorder(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surfaceBorder : Color(hex: "#DDE3ED")
    }

    static func optionSlab(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surfaceSlab : Color(hex: "#B8C4D8")
    }

    /// Mirrors `lessonUnitColor(nodeNum)` in index.html.
    static func unitColor(_ node: Int) -> (main: Color, dark: Color) {
        switch node {
        case ...5:  return (Color(hex: "#0062CC"), Color(hex: "#004A99"))
        case ...10: return (Color(hex: "#0F8A82"), Color(hex: "#0B6862"))
        case ...15: return (Color(hex: "#6D4AA6"), Color(hex: "#543880"))
        case ...20: return (Color(hex: "#1F9E74"), Color(hex: "#17795A"))
        case ...25: return (Color(hex: "#C08A2E"), Color(hex: "#93690F"))
        case ...30: return (Color(hex: "#0B7A94"), Color(hex: "#085A6E"))
        case ...35: return (Color(hex: "#4A55A2"), Color(hex: "#383F7D"))
        case ...40: return (Color(hex: "#B84C7D"), Color(hex: "#8C3861"))
        default:    return (Color(hex: "#C1672E"), Color(hex: "#954E22"))
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

// Drives a chunky-3D press: turns the button style's `isPressed` into a `down`
// flag that is GUARANTEED to hold for a minimum duration, so even an instant
// tap plays a full down-then-up (fast taps used to reverse before the offset
// visibly moved). Hands `down` to a content closure that renders the button.
struct PressSink<Content: View>: View {
    let isPressed: Bool
    @ViewBuilder let content: (_ down: Bool) -> Content

    @State private var down = false
    @State private var pressStart: Date?
    @State private var gen = 0
    private let minDown: Double = 0.11   // seconds the down state stays visible

    var body: some View {
        content(down)
            .onChange(of: isPressed) { _, pressed in
                gen += 1
                if pressed {
                    pressStart = Date()
                    withAnimation(.easeOut(duration: 0.06)) { down = true }
                } else {
                    let elapsed = pressStart.map { Date().timeIntervalSince($0) } ?? minDown
                    let remaining = max(0, minDown - elapsed)
                    let g = gen
                    let release = { withAnimation(.spring(response: 0.3, dampingFraction: 0.55)) { down = false } }
                    if remaining <= 0 {
                        release()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + remaining) {
                            if g == gen { release() }
                        }
                    }
                }
            }
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
        PressSink(isPressed: configuration.isPressed) { down in
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
                        // Counter-offset the whole-label sink so the slab stays
                        // fixed and the face lands flush on it (the 3D lip
                        // vanishes on press — the "goes 2D" look, like the puck).
                        .offset(y: down ? 0 : depth)
                )
                .offset(y: down ? depth : 0)
        }
    }
}

// A circular chunky-3D button (same raised-face-over-slab feel as Chunky3DStyle,
// round). Used for the lesson close (X) button so it reads as a tactile 3D chip.
struct Circle3DStyle: ButtonStyle {
    var face: Color
    var slab: Color
    var size: CGFloat = 34
    var depth: CGFloat = 3
    func makeBody(configuration: Configuration) -> some View {
        PressSink(isPressed: configuration.isPressed) { down in
            configuration.label
                .frame(width: size, height: size)
                .background(
                    Circle().fill(face)
                        .overlay(Circle().strokeBorder(slab, lineWidth: 1.5))
                )
                // Counter-offset so the slab stays fixed and the face sinks flush
                // onto it (the lip vanishes on press), like the path puck.
                .background(Circle().fill(slab).offset(y: down ? 0 : depth))
                .offset(y: down ? depth : 0)
        }
    }
}

// Sinks the label straight down onto its slab on touch-down (the tactile 3D
// press). Use `depth` = the slab offset of whatever it's applied to. Because it
// reacts to `isPressed`, pair it with `delaysContentTouches = false` so the
// press shows instantly inside scroll views.
struct SinkButtonStyle: ButtonStyle {
    // When `slab` is provided the style draws its own fixed 3D lip beneath the
    // face and counter-offsets it, so on press the face sinks flush onto the
    // slab and the lip vanishes (same tactile "goes flat" feel as the path
    // puck). When nil it just offsets the label (legacy behavior, for buttons
    // that draw no slab lip).
    var slab: Color? = nil
    var radius: CGFloat = 16
    var depth: CGFloat = 5
    func makeBody(configuration: Configuration) -> some View {
        PressSink(isPressed: configuration.isPressed) { down in
            configuration.label
                .background(
                    Group {
                        if let slab {
                            RoundedRectangle(cornerRadius: radius, style: .continuous)
                                .fill(slab)
                                .offset(y: down ? 0 : depth)
                        }
                    }
                )
                .offset(y: down ? depth : 0)
        }
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

// The rounded answer-option face (fill + border). The 3D lip beneath is drawn
// by SinkButtonStyle(slab:radius:16) so it stays fixed and the face sinks flush
// onto it on press.
struct OptionSurface: ViewModifier {
    var fill: Color
    var border: Color
    var textColor: Color

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
    }
}

/// The raised card panel a chart sits in, matching the app's chunky-button
/// slab language (a darker copy offset downward) instead of a flat translucent
/// rectangle. Used by every chart-attached view (tap/mark/draw/consolidation
/// screens, question charts, the intro card).
struct ChartCard: ViewModifier {
    var radius: CGFloat = 16
    func body(content: Content) -> some View {
        // A plain ZStack instead of chained .background/.clipShape/.overlay —
        // that chain rendered an extra ghosted rounded-rect edge at the top
        // corners. Layer order here is explicit: the flat card fill+border, and
        // the chart's own content clipped to the same rounded shape on top.
        ZStack {
            // Flat panel — a deep navy distinctly darker than the page background
            // so it reads as an opaque card, not a hazy translucent film.
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .fill(Color(hex: "#10191E"))
                .overlay(
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .strokeBorder(Theme.surfaceBorder.opacity(0.45), lineWidth: 1.5)
                )
            content
                .padding(.horizontal, 6).padding(.vertical, 14)
                .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
        }
    }
}
