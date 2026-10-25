import SwiftUI
import Combine

// MARK: - App theme (Light / Dark / Space)

struct Palette {
    let scheme: ColorScheme
    let base: Color
    let ink: Color
    let muted: Color
}

final class ThemeManager: ObservableObject {
    let palette = Palette(scheme: .dark,
                          base: Theme.appBackground,
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
