import SwiftUI
import Combine

// MARK: - App theme (Light / Dark / Space)
// Space is the starfield/navy look; Dark is plain black; Light is plain white.
// Controls screen backgrounds + the primary on-background text colors, and sets
// the SwiftUI color scheme so scheme-aware views (e.g. the lesson) adapt too.

struct Palette {
    let scheme: ColorScheme
    let base: Color        // solid backdrop
    let ink: Color         // primary on-background text
    let muted: Color       // secondary on-background text
}

/// Single dark theme (navy/slate). Kept as a manager so views can stay themed
/// and a picker can be re-added later.
final class ThemeManager: ObservableObject {
    let palette = Palette(scheme: .dark,
                          base: Color(hex: "#131F24"),
                          ink: .white,
                          muted: Color(hex: "#94A3B8"))
}

// MARK: - Themed full-screen background

struct ThemedBackground: View {
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        theme.palette.base.ignoresSafeArea()
    }
}
