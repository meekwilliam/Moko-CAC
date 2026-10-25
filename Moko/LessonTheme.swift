import SwiftUI

// MARK: - Theme

enum Theme {
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
            return .custom("Sora-ExtraBold", size: size)
        }
    }

    static func questionFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .custom("PlusJakartaSans-SemiBold", size: size)
    }

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

    static func unitColor(_ node: Int) -> (main: Color, dark: Color) {
        switch node {
        case ...5:  return (Color(hex: "#3575DD"), Color(hex: "#1A46C2"))
        case ...10: return (Color(hex: "#12A695"), Color(hex: "#0E6A63"))
        case ...15: return (Color(hex: "#7D53DD"), Color(hex: "#6224C3"))
        case ...20: return (Color(hex: "#0EA674"), Color(hex: "#046C4E"))
        case ...25: return (Color(hex: "#DC8E0A"), Color(hex: "#A24B08"))
        case ...30: return (Color(hex: "#0A6E85"), Color(hex: "#075163"))
        case ...35: return (Color(hex: "#595CD9"), Color(hex: "#3C32B6"))
        case ...40: return (Color(hex: "#D4418A"), Color(hex: "#AB1654"))
        default:    return (Color(hex: "#E06814"), Color(hex: "#AF3A0B"))
        }
    }
}

extension Color {
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

// MARK: - 3D chunky button

struct PressSink<Content: View>: View {
    let isPressed: Bool
    var minDown: Double = 0.11
    var releaseResponse: Double = 0.3
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
                        .offset(y: down ? 0 : depth)
                )
                .offset(y: down ? depth : 0)
        }
    }
}

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
                .background(Circle().fill(slab).offset(y: down ? 0 : depth))
                .offset(y: down ? depth : 0)
        }
    }
}

struct SinkButtonStyle: ButtonStyle {
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

struct ShakeEffect: GeometryEffect {
    var travel: CGFloat = 7
    var animatableData: CGFloat = 0
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(
            translationX: travel * sin(animatableData * .pi * 2), y: 0))
    }
}

struct AnswerFeedbackFX: ViewModifier {
    var pop: Bool
    var shake: Bool
    @State private var scale: CGFloat = 1
    @State private var shakes: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .modifier(ShakeEffect(animatableData: shakes))
            .onChange(of: pop) { on in
                guard on else { scale = 1; return }
                scale = 1.06
                withAnimation(.spring(response: 0.34, dampingFraction: 0.45)) { scale = 1 }
            }
            .onChange(of: shake) { on in
                guard on else { return }
                withAnimation(.easeInOut(duration: 0.45)) { shakes += 2 }
            }
    }
}

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
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(border, lineWidth: 2)
                    )
            )
    }
}

struct ChartCard: ViewModifier {
    var radius: CGFloat = 16
    func body(content: Content) -> some View {
        ZStack {
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
