import SwiftUI

// MARK: - Native Glowo mascot
// A clean SwiftUI rendition of "Blobin" — a rounded blue blob with round glasses
// and a little smile. The web version is a gradient/filter-heavy animated SVG that
// our minimal SVG renderer can't reproduce, so this captures the character natively.

struct MascotView: View {
    var size: CGFloat = 160
    var showPedestal: Bool = true

    var body: some View {
        ZStack {
            if showPedestal {
                Ellipse()
                    .fill(Color.white)
                    .frame(width: size * 0.66, height: size * 0.14)
                    .offset(y: size * 0.44)
                    .shadow(color: Color(hex: "#000442").opacity(0.10), radius: 5, y: 4)
            }

            // Body
            Circle()
                .fill(LinearGradient(
                    colors: [Color(hex: "#7dd3fc"), Color(hex: "#38bdf8"), Color(hex: "#225FC2")],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: size * 0.86, height: size * 0.86)
                .overlay(
                    Ellipse().fill(Color.white.opacity(0.30))
                        .frame(width: size * 0.34, height: size * 0.22)
                        .offset(x: -size * 0.13, y: -size * 0.20)
                        .blur(radius: size * 0.02)
                )
                .shadow(color: Color(hex: "#000442").opacity(0.14), radius: size * 0.04, y: size * 0.03)

            // Little hands
            Circle().fill(Color(hex: "#38bdf8")).frame(width: size * 0.13, height: size * 0.13)
                .offset(x: -size * 0.40, y: size * 0.10)
            Circle().fill(Color(hex: "#38bdf8")).frame(width: size * 0.13, height: size * 0.13)
                .offset(x: size * 0.40, y: size * 0.10)

            // Glasses + face
            face
        }
        .frame(width: size, height: size)
    }

    private var face: some View {
        let lens = size * 0.17
        let dx = size * 0.175
        let eyeY = -size * 0.05
        return ZStack {
            // bridge
            Capsule().fill(Color.white)
                .frame(width: dx * 2 - lens, height: size * 0.03)
                .offset(y: eyeY)
            ForEach([-1.0, 1.0], id: \.self) { sign in
                lensView(radius: lens)
                    .offset(x: dx * CGFloat(sign), y: eyeY)
            }
            // smile
            Smile()
                .stroke(Color(hex: "#000442"), style: StrokeStyle(lineWidth: size * 0.022, lineCap: .round))
                .frame(width: size * 0.16, height: size * 0.09)
                .offset(y: size * 0.16)
        }
    }

    private func lensView(radius: CGFloat) -> some View {
        ZStack {
            Circle().fill(Color(hex: "#eaf6ff"))
                .frame(width: radius * 2, height: radius * 2)
                .overlay(Circle().strokeBorder(Color.white, lineWidth: radius * 0.34))
            // pupil
            Circle().fill(Color(hex: "#000442"))
                .frame(width: radius * 0.5, height: radius * 0.5)
            // glare
            Circle().fill(Color.white.opacity(0.9))
                .frame(width: radius * 0.34, height: radius * 0.34)
                .offset(x: -radius * 0.32, y: -radius * 0.32)
        }
    }
}

private struct Smile: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY),
                       control: CGPoint(x: rect.midX, y: rect.maxY * 1.6))
        return p
    }
}
