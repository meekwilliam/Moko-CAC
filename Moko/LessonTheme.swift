import SwiftUI

// MARK: - Theme
// Semantic type, color, spacing, surface and interaction tokens for the native
// premium market-training interface.

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

    /// Technical numbers only: DOM, tape, price, footprint, delta and CVD.
    static func marketFont(_ size: CGFloat, _ weight: Font.Weight = .medium) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    enum Space {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 40
    }

    enum Radius {
        static let small: CGFloat = 10
        static let control: CGFloat = 14
        static let card: CGFloat = 16
        static let large: CGFloat = 20
    }

    static let ink = Color(hex: "#102737")
    static let inkDark = Color(hex: "#ECF5FC")
    static let muted = Color(hex: "#93A8B8")
    static let subtle = Color(hex: "#62798B")

    // Brand accents. Green/red stay reserved for market-side meaning below.
    static let mastery = Color(hex: "#25C7B7")
    static let masteryDark = Color(hex: "#117D78")
    static let progress = Color(hex: "#4B86FF")
    static let progressDark = Color(hex: "#2855B8")
    static let expert = Color(hex: "#8B6CFF")
    static let premium = Color(hex: "#D75BCB")
    static let warning = Color(hex: "#E8B45B")
    static let warningDark = Color(hex: "#8E6225")

    // Market semantics only.
    static let buyer = Color(hex: "#32C98A")
    static let seller = Color(hex: "#F26472")

    // Assessment feedback uses mastery/warning rather than market green/red.
    static let correct = mastery
    static let correctDark = masteryDark
    static let incorrect = warning
    static let incorrectDark = warningDark

    /// The accent used for answering: selected options, the Check / Got It
    /// buttons, the progress bar, and interactive selections/drawings. Matches
    /// the "Keep Going" button blue so the whole answer flow is one blue.
    static let answer = progress
    static let answerDark = progressDark

    static let appBackground = Color(hex: "#07111B")
    static let backgroundElevated = Color(hex: "#0A1622")
    static let surface = Color(hex: "#0E1B28")
    static let surfaceRaised = Color(hex: "#132333")
    static let surfaceStrong = Color(hex: "#192C3E")
    static let surfaceBorder = Color(hex: "#263D50")
    static let surfaceHighlight = Color(hex: "#355067")
    static let surfaceSlab = Color(hex: "#1A3041")
    static let surfaceMuted = Color(hex: "#203446")
    static let slotFill = Color(hex: "#122433")
    static let slotBorder = Color(hex: "#355067")
    static let chartBackground = Color(hex: "#08131D")

    static func optionFill(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surface : .white
    }

    static func optionBorder(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surfaceBorder : Color(hex: "#DDE3ED")
    }

    static func optionSlab(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? surfaceSlab : Color(hex: "#B8C4D8")
    }

    /// Tier palette used for progression and mastery. It deliberately avoids
    /// bullish green and bearish red.
    static func tierColor(_ tier: String?, index: Int = 0) -> (main: Color, dark: Color) {
        switch tier?.lowercased() {
        case "beginner":
            return index.isMultiple(of: 2) ? (mastery, masteryDark) : (Color(hex: "#31B7C7"), Color(hex: "#176B7A"))
        case "intermediate":
            return (progress, progressDark)
        case "advanced":
            return index.isMultiple(of: 2) ? (expert, Color(hex: "#5037AA")) : (Color(hex: "#666FEA"), Color(hex: "#363D9E"))
        case "expert":
            return (premium, Color(hex: "#85317D"))
        default:
            return (progress, progressDark)
        }
    }

    /// Fallback when unit metadata is unavailable.
    static func unitColor(_ node: Int) -> (main: Color, dark: Color) {
        switch node {
        case ...16: return tierColor("Beginner", index: node)
        case ...32: return tierColor("Intermediate", index: node)
        case ...64: return tierColor("Advanced", index: node)
        default:    return tierColor("Expert", index: node)
        }
    }
}

extension Color {
    // Called in view bodies all over the app, often with the same literal
    // hex, and re-run on every render. The Scanner parse is the costly part, so
    // cache the parsed RGBA per string; constructing the Color value is cheap.
    private static var hexCache: [String: (Double, Double, Double, Double)] = [:]

    init(hex: String) {
        let (r, g, b, a) = Color.rgba(hex: hex)
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }

    private static func rgba(hex: String) -> (Double, Double, Double, Double) {
        if let cached = hexCache[hex] { return cached }
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: s).scanHexInt64(&rgb)
        let out: (Double, Double, Double, Double)
        if s.count == 8 {
            out = (Double((rgb & 0xFF000000) >> 24) / 255,
                   Double((rgb & 0x00FF0000) >> 16) / 255,
                   Double((rgb & 0x0000FF00) >> 8) / 255,
                   Double(rgb & 0x000000FF) / 255)
        } else {
            out = (Double((rgb & 0xFF0000) >> 16) / 255,
                   Double((rgb & 0x00FF00) >> 8) / 255,
                   Double(rgb & 0x0000FF) / 255, 1)
        }
        hexCache[hex] = out
        return out
    }
}

// MARK: - Shared controls
// The compatibility names stay in place so every existing mechanic keeps its
// behavior, but the presentation is now low-depth, restrained and technical.

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
    var minDown: Double = 0.11        // seconds the down state stays visible
    var releaseResponse: Double = 0.3 // spring response on release (lower = snappier)
    @ViewBuilder let content: (_ down: Bool) -> Content

    @State private var down = false
    @State private var pressStart: Date?
    @State private var gen = 0

    var body: some View {
        content(down)
            .onChange(of: isPressed) { _, pressed in
                gen += 1
                if pressed {
                    pressStart = Date()
                    withAnimation(.easeOut(duration: 0.05)) { down = true }
                } else {
                    let elapsed = pressStart.map { Date().timeIntervalSince($0) } ?? minDown
                    let remaining = max(0, minDown - elapsed)
                    let g = gen
                    let release = { withAnimation(.spring(response: releaseResponse, dampingFraction: 0.6)) { down = false } }
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
        configuration.label
            .font(font)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .strokeBorder(border ?? Color.white.opacity(0.12), lineWidth: 1)
                    )
                    .overlay(alignment: .top) {
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(Color.white.opacity(0.07), lineWidth: 1)
                            .padding(1)
                            .mask(
                                LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .center)
                            )
                    }
            )
            .shadow(color: slab.opacity(configuration.isPressed ? 0.12 : 0.28),
                    radius: configuration.isPressed ? 2 : 9, y: configuration.isPressed ? 1 : 4)
            .scaleEffect(configuration.isPressed ? 0.985 : 1)
            .offset(y: configuration.isPressed ? 1 : 0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
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
        configuration.label
            .frame(width: size, height: size)
            .background(
                Circle().fill(face)
                    .overlay(Circle().strokeBorder(Color.white.opacity(0.10), lineWidth: 1))
            )
            .shadow(color: slab.opacity(0.30), radius: configuration.isPressed ? 2 : 7, y: 3)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
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
        configuration.label
            .shadow(color: (slab ?? .black).opacity(configuration.isPressed ? 0.05 : 0.20),
                    radius: configuration.isPressed ? 1 : 7, y: configuration.isPressed ? 0 : 3)
            .scaleEffect(configuration.isPressed ? 0.988 : 1)
            .offset(y: configuration.isPressed ? 1 : 0)
            .animation(.easeOut(duration: 0.11), value: configuration.isPressed)
    }
}

// A lighter press for flat rows/chips that have no slab: a quick squish + dim.
struct RowPressStyle: ButtonStyle {
    var scale: CGFloat = 0.985
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? 0.88 : 1)
            .animation(.easeOut(duration: 0.11), value: configuration.isPressed)
    }
}

// MARK: - Answer reveal effects
// Mirrors the web `optCorrectPop` (springy scale on the right answer) and
// `optShake` (side-to-side shake on a wrong pick) keyframe animations.

struct ShakeEffect: GeometryEffect {
    var travel: CGFloat = 2.5
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
                scale = 1.015
                withAnimation(.easeOut(duration: 0.18)) { scale = 1 }
            }
            .onChange(of: shake) { on in
                guard on else { return }
                withAnimation(.easeInOut(duration: 0.24)) { shakes += 1 }
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
    var vpad: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, vpad)
            .padding(.horizontal, 18)
            .background(
                RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.control, style: .continuous)
                            .strokeBorder(border, lineWidth: 1.25)
                    )
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(Color.white.opacity(0.035))
                            .frame(height: 1)
                            .padding(.horizontal, 12)
                    }
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
                .fill(Theme.chartBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: radius, style: .continuous)
                        .strokeBorder(Theme.surfaceBorder.opacity(0.85), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.18), radius: 10, y: 4)
            content
                .padding(.horizontal, 6).padding(.vertical, 14)
                .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
        }
    }
}
