import SwiftUI

// MARK: - Treat currency icon
// The in-app currency ("treats") — a solid emerald-green gem with a glossy
// shine highlight, matching the simple flat treatment used for HeartBadge.

/// A classic emerald-cut gem outline: an octagon with clipped corners.
struct GemShape: Shape {
    func path(in r: CGRect) -> Path {
        let w = r.width, h = r.height
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint { CGPoint(x: r.minX + x * w, y: r.minY + y * h) }
        var p = Path()
        p.move(to: pt(0.30, 0.0))
        p.addLine(to: pt(0.70, 0.0))
        p.addLine(to: pt(1.0, 0.22))
        p.addLine(to: pt(1.0, 0.78))
        p.addLine(to: pt(0.70, 1.0))
        p.addLine(to: pt(0.30, 1.0))
        p.addLine(to: pt(0.0, 0.78))
        p.addLine(to: pt(0.0, 0.22))
        p.closeSubpath()
        return p
    }
}

struct TreatIcon: View {
    var height: CGFloat = 20
    private var width: CGFloat { height * 0.92 }

    private let emerald = Color(hex: "#10A868")

    var body: some View {
        GemShape()
            .fill(emerald)
            .overlay(alignment: .topLeading) {
                Ellipse()
                    .fill(Color.white.opacity(0.55))
                    .frame(width: width * 0.28, height: height * 0.16)
                    .rotationEffect(.degrees(-28))
                    .offset(x: width * 0.2, y: height * 0.18)
                    .blur(radius: height * 0.01)
            }
            .frame(width: width, height: height)
    }
}
