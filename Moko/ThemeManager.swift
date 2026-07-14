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
                          base: Theme.appBackground,
                          ink: Theme.inkDark,
                          muted: Theme.muted)
}

// MARK: - Themed full-screen background

struct ThemedBackground: View {
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        ZStack {
            theme.palette.base
            LinearGradient(
                colors: [Theme.backgroundElevated.opacity(0.78), Theme.appBackground, Color(hex: "#050C13")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            RadialGradient(
                colors: [Theme.progress.opacity(0.08), .clear],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 420
            )
            Canvas { context, size in
                var grid = Path()
                let step: CGFloat = 32
                var x: CGFloat = 0
                while x <= size.width {
                    grid.move(to: CGPoint(x: x, y: 0))
                    grid.addLine(to: CGPoint(x: x, y: size.height))
                    x += step
                }
                var y: CGFloat = 0
                while y <= size.height {
                    grid.move(to: CGPoint(x: 0, y: y))
                    grid.addLine(to: CGPoint(x: size.width, y: y))
                    y += step
                }
                context.stroke(grid, with: .color(Theme.surfaceBorder.opacity(0.08)), lineWidth: 0.5)
            }
        }
        .ignoresSafeArea()
    }
}
