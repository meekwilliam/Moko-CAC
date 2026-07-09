import Foundation
import UIKit
import CoreHaptics

// MARK: - Cues

/// The app's vocabulary of feels. Each cue is a hand-authored Core Haptics
/// pattern rather than one of UIKit's five canned generators, so a correct
/// answer, a locked node and a routine tap are distinguishable by touch alone.
///
/// Intensity = how hard it hits. Sharpness = timbre: 0 is a dull thud, 1 is a
/// crisp click. Most of the character lives in sharpness.
enum HapticCue: Hashable {
    case selection          // crisp tick — routine taps, toggles, drag steps
    case soft, light, medium, rigid, heavy
    case success            // rising double tap — correct answer, lesson cleared
    case error              // dull double thud — wrong answer
    case warning
    case puckPress          // sharp click as a 3D face sinks onto its slab
    case puckRelease        // softer pop as it springs back
    case locked             // short decaying buzz — "you can't do that"
    case celebrate          // ascending four-tap flourish over a swell
}

private func tap(_ intensity: Float, _ sharpness: Float, at t: TimeInterval = 0) -> CHHapticEvent {
    CHHapticEvent(eventType: .hapticTransient, parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
    ], relativeTime: t)
}

private func swell(_ intensity: Float, _ sharpness: Float, at t: TimeInterval, for d: TimeInterval) -> CHHapticEvent {
    CHHapticEvent(eventType: .hapticContinuous, parameters: [
        CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
        CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
    ], relativeTime: t, duration: d)
}

extension HapticCue {
    var events: [CHHapticEvent] {
        switch self {
        case .selection:    return [tap(0.35, 0.75)]
        case .soft:         return [tap(0.45, 0.15)]
        case .light:        return [tap(0.45, 0.45)]
        case .medium:       return [tap(0.70, 0.50)]
        case .rigid:        return [tap(0.70, 1.00)]
        case .heavy:        return [tap(1.00, 0.65)]

        // Two taps climbing in pitch — the haptic equivalent of a rising chime.
        case .success:      return [tap(0.60, 0.45), tap(1.00, 0.90, at: 0.085)]

        // Blunt and falling. Low sharpness reads as a thud, not a click.
        case .error:        return [tap(0.95, 0.18), tap(0.70, 0.10, at: 0.13)]

        case .warning:      return [tap(0.80, 0.50), tap(0.50, 0.30, at: 0.11)]

        case .puckPress:    return [tap(0.50, 0.90)]
        case .puckRelease:  return [tap(0.32, 0.35)]

        case .locked:       return [swell(0.55, 0.15, at: 0, for: 0.16)]

        case .celebrate:
            var e = [swell(0.35, 0.30, at: 0, for: 0.30)]
            let steps: [(Float, Float, TimeInterval)] = [
                (0.50, 0.30, 0.00), (0.65, 0.45, 0.07),
                (0.80, 0.60, 0.14), (1.00, 0.85, 0.23),
            ]
            e.append(contentsOf: steps.map { tap($0.0, $0.1, at: $0.2) })
            return e
        }
    }

    var curves: [CHHapticParameterCurve] {
        switch self {
        // Decay the buzz so it dies away instead of cutting off square.
        case .locked:
            return [CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [
                .init(relativeTime: 0, value: 1.0),
                .init(relativeTime: 0.16, value: 0.2),
            ], relativeTime: 0)]
        case .celebrate:
            return [CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [
                .init(relativeTime: 0, value: 0.3),
                .init(relativeTime: 0.23, value: 1.0),
                .init(relativeTime: 0.30, value: 0.0),
            ], relativeTime: 0)]
        default:
            return []
        }
    }
}

// MARK: - Engine

/// Owns the single `CHHapticEngine` and a cache of compiled pattern players.
///
/// The engine is lazy, auto-shuts-down when idle, and is torn down in the
/// background — so it costs nothing when the app isn't buzzing. Both of the
/// engine's failure paths (idle stop, and a media-services reset) invalidate
/// the cached players, so both handlers clear the cache; `play` also retries
/// once from scratch if a player start throws.
final class HapticEngine {
    static let shared = HapticEngine()

    /// iPhone 8 and later. iPad, simulator and older phones fall back to UIKit.
    let supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics

    private var engine: CHHapticEngine?
    private var players: [HapticCue: CHHapticPatternPlayer] = [:]
    private var holdPlayer: CHHapticAdvancedPatternPlayer?
    private var observing = false

    private init() {}

    /// Warm the engine so the first tap of the session isn't late. Safe to
    /// call repeatedly; a running engine is left alone.
    func prepare() {
        guard supportsHaptics, engine == nil else { return }
        do {
            let e = try CHHapticEngine()
            e.playsHapticsOnly = true       // don't touch the audio session
            e.isAutoShutdownEnabled = true  // idle engines cost battery
            e.stoppedHandler = { [weak self] _ in
                DispatchQueue.main.async { self?.invalidatePlayers() }
            }
            e.resetHandler = { [weak self] in
                DispatchQueue.main.async {
                    guard let self else { return }
                    self.invalidatePlayers()
                    try? self.engine?.start()
                }
            }
            try e.start()
            engine = e
            observeLifecycle()
        } catch {
            engine = nil
        }
    }

    private func invalidatePlayers() {
        players.removeAll()
        holdPlayer = nil
    }

    private func observeLifecycle() {
        guard !observing else { return }
        observing = true
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            self.endHold()
            self.engine?.stop()
            self.invalidatePlayers()
        }
    }

    func play(_ cue: HapticCue) {
        guard supportsHaptics else { return }
        do {
            try start(cue)
        } catch {
            // Engine died out from under us (reset, idle shutdown). Rebuild once.
            invalidatePlayers()
            try? engine?.start()
            try? start(cue)
        }
    }

    private func start(_ cue: HapticCue) throws {
        prepare()
        guard let engine else { throw CHHapticError(.engineNotRunning) }
        try engine.start()   // no-op when already running

        let player: CHHapticPatternPlayer
        if let cached = players[cue] {
            player = cached
        } else {
            let pattern = try CHHapticPattern(events: cue.events, parameterCurves: cue.curves)
            player = try engine.makePlayer(with: pattern)
            players[cue] = player
        }
        try player.start(atTime: CHHapticTimeImmediate)
    }

    // MARK: Hold-to-commit ramp

    /// A flat, continuous buzz for as long as the finger is down — no ramp, no
    /// ticks. `duration` only caps it; `endHold()` is what normally stops it.
    /// This is the thing UIKit's generators simply cannot do.
    func beginHold(duration: TimeInterval) {
        guard supportsHaptics else { return }
        prepare()
        guard let engine else { return }
        endHold()
        do {
            try engine.start()
            let event = swell(0.55, 0.30, at: 0, for: duration)
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [])
            let p = try engine.makeAdvancedPlayer(with: pattern)
            try p.start(atTime: CHHapticTimeImmediate)
            holdPlayer = p
        } catch {
            holdPlayer = nil
        }
    }

    /// Cut the ramp short — the finger lifted, or the hold completed.
    func endHold() {
        try? holdPlayer?.stop(atTime: CHHapticTimeImmediate)
        holdPlayer = nil
    }
}

// MARK: - Facade

/// What the rest of the app calls. Routes to the custom engine on capable
/// hardware and degrades to UIKit's generators everywhere else, so no call
/// site has to care which it got.
enum Haptics {
    private static let enabledKey = "haptics.enabled"

    /// User-facing kill switch. Defaults on; nothing plays when off.
    static var isEnabled: Bool {
        get { UserDefaults.standard.object(forKey: enabledKey) as? Bool ?? true }
        set { UserDefaults.standard.set(newValue, forKey: enabledKey) }
    }

    static func prepare() { HapticEngine.shared.prepare() }

    static func play(_ cue: HapticCue) {
        guard isEnabled else { return }
        if HapticEngine.shared.supportsHaptics {
            HapticEngine.shared.play(cue)
        } else {
            fallback(cue)
        }
    }

    static func beginHold(duration: TimeInterval) {
        guard isEnabled else { return }
        if HapticEngine.shared.supportsHaptics {
            HapticEngine.shared.beginHold(duration: duration)
        } else {
            fallback(.light)
        }
    }

    static func endHold() { HapticEngine.shared.endHold() }

    // Legacy surface — the names the app already calls, now custom-patterned.
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) { play(cue(for: style)) }
    static func selection() { play(.selection) }
    static func light()     { play(.light) }
    static func rigid()     { play(.rigid) }

    // Outcome cues — reserved for answer reveals, not routine taps.
    static func success()   { play(.success) }
    static func error()     { play(.error) }

    private static func cue(for style: UIImpactFeedbackGenerator.FeedbackStyle) -> HapticCue {
        switch style {
        case .light: return .light
        case .medium: return .medium
        case .heavy: return .heavy
        case .soft: return .soft
        case .rigid: return .rigid
        @unknown default: return .medium
        }
    }

    // MARK: UIKit fallback (iPad, simulator, iPhone 7 and earlier)

    private static let selectionGen = UISelectionFeedbackGenerator()
    private static let notificationGen = UINotificationFeedbackGenerator()

    private static func fallback(_ cue: HapticCue) {
        switch cue {
        case .selection:
            selectionGen.selectionChanged()
        case .success, .celebrate:
            notificationGen.notificationOccurred(.success)
        case .error:
            notificationGen.notificationOccurred(.error)
        case .warning:
            notificationGen.notificationOccurred(.warning)
        case .soft:                     impactFallback(.soft)
        case .light, .puckRelease:      impactFallback(.light)
        case .medium:                   impactFallback(.medium)
        case .rigid, .locked:           impactFallback(.rigid)
        case .heavy:                    impactFallback(.heavy)
        case .puckPress:                impactFallback(.light)
        }
    }

    private static func impactFallback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
