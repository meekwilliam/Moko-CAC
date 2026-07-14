import SwiftUI

// MARK: - Moko market design system

/// The single source of truth for Moko's visual language. Product screens
/// should use these semantic roles instead of raw colors or one-off metrics.
enum MarketDesign {
    // MARK: Color

    enum Colors {
        // Deep navy surfaces. No pure black is used in the interface.
        static let backgroundPrimary = Color(hex: "#07111B")
        static let backgroundSecondary = Color(hex: "#0A1622")
        static let backgroundElevated = Color(hex: "#132333")
        static let surfaceBase = Color(hex: "#0E1B28")
        static let surfaceRaised = Color(hex: "#152534")
        static let surfaceStrong = Color(hex: "#1A2D3E")
        static let surfaceMuted = Color(hex: "#203446")
        static let chartSurface = Color(hex: "#08131D")
        static let backdropDeep = Color(hex: "#050C13")
        static let scrim = Color(hex: "#03080D").opacity(0.68)

        static let textPrimaryLight = Color(hex: "#102737")
        static let textPrimary = Color(hex: "#ECF5FC")
        static let textSecondary = Color(hex: "#93A8B8")
        static let textSubtle = Color(hex: "#62798B")
        static let textInverse = Color(hex: "#07111B")

        // Brand accents. These never stand in for bullish or bearish state.
        static let brandTeal = Color(hex: "#25C7B7")
        static let brandTealStrong = Color(hex: "#117D78")
        static let progressBlue = Color(hex: "#4B86FF")
        static let progressBlueStrong = Color(hex: "#2855B8")
        static let expertViolet = Color(hex: "#8B6CFF")
        static let expertVioletStrong = Color(hex: "#5037AA")
        static let premiumMagenta = Color(hex: "#D75BCB")
        static let warningStrong = Color(hex: "#8E6225")

        // Compatibility surface roles used by mechanics awaiting migration.
        static let surfaceSlab = Color(hex: "#1A3041")
        static let slotFill = Color(hex: "#122433")
        static let optionBorderLight = Color(hex: "#DDE3ED")
        static let optionSlabLight = Color(hex: "#B8C4D8")
        static let beginnerAlternate = Color(hex: "#31B7C7")
        static let beginnerAlternateStrong = Color(hex: "#176B7A")
        static let advancedAlternate = Color(hex: "#666FEA")
        static let advancedAlternateStrong = Color(hex: "#363D9E")
        static let premiumStrong = Color(hex: "#85317D")

        static let borderSubtle = Color(hex: "#263D50")
        static let borderInnerHighlight = Color(hex: "#355067")
        static let borderActive = progressBlue.opacity(0.62)
        static let borderSuccess = brandTeal.opacity(0.62)
        // Assessment errors use amber so red remains bearish market language.
        static let borderError = Color(hex: "#E8B45B").opacity(0.64)
        static let borderPremium = expertViolet.opacity(0.68)

        static let bullish = SemanticColor(
            full: Color(hex: "#32C98A"),
            mutedBackground: Color(hex: "#32C98A").opacity(0.12),
            subtleBorder: Color(hex: "#32C98A").opacity(0.42),
            contrastText: Color(hex: "#79E4B7")
        )
        static let bearish = SemanticColor(
            full: Color(hex: "#F26472"),
            mutedBackground: Color(hex: "#F26472").opacity(0.12),
            subtleBorder: Color(hex: "#F26472").opacity(0.42),
            contrastText: Color(hex: "#FFA0AA")
        )
        static let neutral = SemanticColor(
            full: textSecondary,
            mutedBackground: textSecondary.opacity(0.10),
            subtleBorder: borderSubtle,
            contrastText: Color(hex: "#C9D6DF")
        )
        static let warning = SemanticColor(
            full: Color(hex: "#E8B45B"),
            mutedBackground: Color(hex: "#E8B45B").opacity(0.12),
            subtleBorder: Color(hex: "#E8B45B").opacity(0.42),
            contrastText: Color(hex: "#F4D28D")
        )
        static let information = SemanticColor(
            full: progressBlue,
            mutedBackground: progressBlue.opacity(0.12),
            subtleBorder: progressBlue.opacity(0.42),
            contrastText: Color(hex: "#9AB9FF")
        )
    }

    struct SemanticColor {
        let full: Color
        let mutedBackground: Color
        let subtleBorder: Color
        let contrastText: Color
    }

    struct AccentPair {
        let main: Color
        let strong: Color
    }

    static func tierAccent(_ tier: String?, index: Int = 0) -> AccentPair {
        switch tier?.lowercased() {
        case "beginner":
            return index.isMultiple(of: 2)
                ? AccentPair(main: Colors.brandTeal, strong: Colors.brandTealStrong)
                : AccentPair(main: Colors.beginnerAlternate, strong: Colors.beginnerAlternateStrong)
        case "intermediate":
            return AccentPair(main: Colors.progressBlue, strong: Colors.progressBlueStrong)
        case "advanced":
            return index.isMultiple(of: 2)
                ? AccentPair(main: Colors.expertViolet, strong: Colors.expertVioletStrong)
                : AccentPair(main: Colors.advancedAlternate, strong: Colors.advancedAlternateStrong)
        case "expert":
            return AccentPair(main: Colors.premiumMagenta, strong: Colors.premiumStrong)
        default:
            return AccentPair(main: Colors.progressBlue, strong: Colors.progressBlueStrong)
        }
    }

    // MARK: Typography

    enum TextStyle: Equatable {
        case displayLarge
        case displayMedium
        case headlineLarge
        case headlineMedium
        case title
        case bodyLarge
        case body
        case caption
        case overline
        case metricLarge
        case marketNumber
        case buttonLabel

        fileprivate var font: Font {
            switch self {
            case .displayLarge:   return sora(36, face: "Bold")
            case .displayMedium:  return sora(30, face: "Bold")
            case .headlineLarge:  return sora(24, face: "Bold")
            case .headlineMedium: return sora(20, face: "SemiBold")
            case .title:          return jakarta(17, semibold: true)
            case .bodyLarge:      return jakarta(16)
            case .body:           return jakarta(14)
            case .caption:        return jakarta(12)
            case .overline:       return jakarta(10, semibold: true)
            case .metricLarge:    return sora(32, face: "Bold")
            case .marketNumber:   return .system(size: 13, weight: .medium, design: .monospaced)
            case .buttonLabel:    return jakarta(15, semibold: true)
            }
        }

        fileprivate var tracking: CGFloat {
            self == .overline ? 1.1 : 0
        }

        fileprivate var lineSpacing: CGFloat {
            switch self {
            case .displayLarge, .displayMedium: return 2
            case .bodyLarge, .body: return 3
            default: return 0
            }
        }

        fileprivate var usesMonospacedDigits: Bool {
            self == .metricLarge || self == .marketNumber
        }

        private func sora(_ size: CGFloat, face: String) -> Font {
            .custom("Sora-\(face)", size: size)
        }

        private func jakarta(_ size: CGFloat, semibold: Bool = false) -> Font {
            .custom(semibold ? "PlusJakartaSans-SemiBold" : "PlusJakartaSans-Regular", size: size)
        }
    }

    static func font(_ style: TextStyle) -> Font {
        style.font
    }

    // MARK: Layout

    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
        static let xxxl: CGFloat = 40
        static let huge: CGFloat = 48
    }

    enum Radius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 20
    }

    enum Stroke {
        static let standard: CGFloat = 1
        static let selected: CGFloat = 1.5
    }

    enum ControlSize {
        static let progressTrack: CGFloat = 4
        static let compact: CGFloat = 32
        static let standard: CGFloat = 48
        static let lessonModule: CGFloat = 72
        static let secondaryActionWidth: CGFloat = 112
    }

    // MARK: Elevation

    struct ElevationToken {
        let surface: Color
        let shadowOpacity: Double
        let shadowRadius: CGFloat
        let shadowY: CGFloat
        let innerHighlightOpacity: Double
        let glowOpacity: Double
    }

    enum Elevation {
        static let base = ElevationToken(surface: Colors.surfaceBase, shadowOpacity: 0, shadowRadius: 0, shadowY: 0, innerHighlightOpacity: 0.025, glowOpacity: 0)
        static let raised = ElevationToken(surface: Colors.surfaceRaised, shadowOpacity: 0.16, shadowRadius: 10, shadowY: 4, innerHighlightOpacity: 0.04, glowOpacity: 0)
        static let modal = ElevationToken(surface: Colors.backgroundElevated, shadowOpacity: 0.28, shadowRadius: 22, shadowY: 12, innerHighlightOpacity: 0.05, glowOpacity: 0)
        static let focus = ElevationToken(surface: Colors.surfaceRaised, shadowOpacity: 0.18, shadowRadius: 14, shadowY: 6, innerHighlightOpacity: 0.06, glowOpacity: 0.16)
    }

    // MARK: Motion

    enum Motion {
        static let fast: Double = 0.14
        static let normal: Double = 0.22
        static let deliberate: Double = 0.36

        static let fastEase = Animation.easeOut(duration: fast)
        static let standardEase = Animation.easeInOut(duration: normal)
        static let deliberateEase = Animation.easeInOut(duration: deliberate)
    }

    // MARK: Iconography

    enum IconSize {
        static let small: CGFloat = 13
        static let medium: CGFloat = 17
        static let large: CGFloat = 22
    }
}

// MARK: - Typography application

private struct MarketTextStyleModifier: ViewModifier {
    let style: MarketDesign.TextStyle

    func body(content: Content) -> some View {
        let styled = content
            .font(style.font)
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
        if style.usesMonospacedDigits {
            styled.monospacedDigit()
        } else {
            styled
        }
    }
}

extension View {
    func marketText(_ style: MarketDesign.TextStyle) -> some View {
        modifier(MarketTextStyleModifier(style: style))
    }

    func marketIcon(size: CGFloat = MarketDesign.IconSize.medium) -> some View {
        font(.system(size: size, weight: .semibold))
    }

    func marketIcon(size: CGFloat = MarketDesign.IconSize.medium, color: Color) -> some View {
        font(.system(size: size, weight: .semibold))
            .foregroundStyle(color)
    }

    func marketCard(
        elevation: MarketDesign.ElevationToken = MarketDesign.Elevation.raised,
        border: Color = MarketDesign.Colors.borderSubtle,
        radius: CGFloat = MarketDesign.Radius.large,
        accent: Color? = nil
    ) -> some View {
        modifier(MarketCardStyle(elevation: elevation, border: border, radius: radius, accent: accent))
    }
}

// MARK: - Cards

private struct MarketCardStyle: ViewModifier {
    let elevation: MarketDesign.ElevationToken
    let border: Color
    let radius: CGFloat
    let accent: Color?

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(elevation.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .strokeBorder(border, lineWidth: MarketDesign.Stroke.standard)
                    )
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(Color.white.opacity(elevation.innerHighlightOpacity))
                            .frame(height: 1)
                            .padding(.horizontal, radius)
                    }
            )
            .shadow(color: .black.opacity(elevation.shadowOpacity), radius: elevation.shadowRadius, y: elevation.shadowY)
            .shadow(color: (accent ?? .clear).opacity(elevation.glowOpacity), radius: elevation.shadowRadius)
    }
}

// MARK: - Buttons

enum MarketButtonVariant: Equatable {
    case primary
    case secondary
    case premium

    fileprivate var fill: Color {
        switch self {
        case .primary: return MarketDesign.Colors.progressBlue
        case .secondary: return MarketDesign.Colors.surfaceRaised
        case .premium: return MarketDesign.Colors.expertViolet
        }
    }

    fileprivate var border: Color {
        switch self {
        case .primary: return MarketDesign.Colors.progressBlue.opacity(0.75)
        case .secondary: return MarketDesign.Colors.borderSubtle
        case .premium: return MarketDesign.Colors.borderPremium
        }
    }

    fileprivate var text: Color {
        self == .secondary ? MarketDesign.Colors.textPrimary : .white
    }
}

struct MarketButtonStyle: ButtonStyle {
    let variant: MarketButtonVariant
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .marketText(.buttonLabel)
            .foregroundStyle(isEnabled ? variant.text : MarketDesign.Colors.textSubtle)
            .frame(maxWidth: .infinity, minHeight: 48)
            .padding(.horizontal, MarketDesign.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: MarketDesign.Radius.medium, style: .continuous)
                    .fill(isEnabled ? variant.fill : MarketDesign.Colors.surfaceMuted)
                    .overlay(
                        RoundedRectangle(cornerRadius: MarketDesign.Radius.medium)
                            .strokeBorder(isEnabled ? variant.border : MarketDesign.Colors.borderSubtle, lineWidth: 1)
                    )
            )
            .shadow(color: variant.fill.opacity(configuration.isPressed ? 0.06 : 0.16), radius: configuration.isPressed ? 2 : 8, y: configuration.isPressed ? 1 : 3)
            .scaleEffect(configuration.isPressed ? 0.988 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(MarketDesign.Motion.fastEase, value: configuration.isPressed)
    }
}

// MARK: - Trade decisions

enum TradeDecisionKind {
    case long
    case wait
    case short
    case neutral

    init(label: String) {
        switch label.uppercased() {
        case "LONG": self = .long
        case "SHORT": self = .short
        case "WAIT", "WAIT FOR MORE EVIDENCE", "NO ENTRY": self = .wait
        default: self = .neutral
        }
    }

    fileprivate var semantic: MarketDesign.SemanticColor {
        switch self {
        case .long: return MarketDesign.Colors.bullish
        case .short: return MarketDesign.Colors.bearish
        case .wait: return MarketDesign.Colors.warning
        case .neutral: return MarketDesign.Colors.information
        }
    }
}

struct TradeDecisionButtonStyle: ButtonStyle {
    let kind: TradeDecisionKind
    let isSelected: Bool
    let isRevealed: Bool
    let isCorrect: Bool

    func makeBody(configuration: Configuration) -> some View {
        let showsDirection = isSelected || (isRevealed && isCorrect)
        let semantic = isRevealed && isSelected && !isCorrect
            ? MarketDesign.Colors.warning
            : kind.semantic
        let fill = showsDirection ? semantic.mutedBackground : MarketDesign.Colors.surfaceRaised
        let border = showsDirection ? semantic.subtleBorder : MarketDesign.Colors.borderSubtle
        let text = showsDirection ? semantic.contrastText : MarketDesign.Colors.textPrimary

        configuration.label
            .foregroundStyle(text)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(
                RoundedRectangle(cornerRadius: MarketDesign.Radius.medium, style: .continuous)
                    .fill(fill)
                    .overlay(
                        RoundedRectangle(cornerRadius: MarketDesign.Radius.medium)
                            .strokeBorder(border, lineWidth: showsDirection ? MarketDesign.Stroke.selected : MarketDesign.Stroke.standard)
                    )
            )
            .shadow(color: showsDirection ? semantic.full.opacity(0.10) : .clear, radius: 8)
            .scaleEffect(configuration.isPressed ? 0.988 : 1)
            .animation(MarketDesign.Motion.fastEase, value: configuration.isPressed)
    }
}
