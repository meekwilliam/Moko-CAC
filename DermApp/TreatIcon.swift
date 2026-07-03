import SwiftUI

// MARK: - Treat currency icon
// The in-app currency ("treats") — a dog-biscuit bone rendered with a chunky
// 3D look: a darker base slab under a shaded top face, plus texture dots.
// Geometry taken from treat.svg (117 × 43 viewBox).

/// The bone silhouette: a central slab with a rounded lobe at each corner.
struct BoneShape: Shape {
    func path(in r: CGRect) -> Path {
        let w = r.width, h = r.height
        func fx(_ x: CGFloat) -> CGFloat { r.minX + x / 117 * w }
        func fy(_ y: CGFloat) -> CGFloat { r.minY + y / 43 * h }
        // A lobe centered at (cx,cy) with rx≈9.5, ry≈11 in viewBox units.
        func lobe(_ cx: CGFloat, _ cy: CGFloat) -> CGRect {
            CGRect(x: fx(cx - 9.5), y: fy(cy - 11), width: (19 / 117) * w, height: (22 / 43) * h)
        }
        var p = Path()
        // Thin middle bar (pinched waist) connecting the two knobbed ends —
        // gives the classic dog-bone silhouette instead of a fat biscuit.
        p.addRoundedRect(in: CGRect(x: fx(9.5), y: fy(13.5),
                                    width: (98 / 117) * w, height: (16 / 43) * h),
                         cornerSize: CGSize(width: (5 / 43) * h, height: (5 / 43) * h))
        // Four rounded knobs (a pair at each end).
        p.addEllipse(in: lobe(9.5, 11))
        p.addEllipse(in: lobe(9.5, 31))
        p.addEllipse(in: lobe(107.5, 12))
        p.addEllipse(in: lobe(107.5, 32))
        return p
    }
}

struct TreatIcon: View {
    var height: CGFloat = 20
    private var width: CGFloat { height * 117 / 43 }
    // Underside offset (8px in the 43-unit face → the 3D lip).
    private var depth: CGFloat { height * 8 / 43 }

    var body: some View {
        ZStack {
            // Base slab (the 3D underside — grey lip).
            BoneShape()
                .fill(Color(hex: "#B7C0CE"))
                .offset(y: depth)

            // Light top face.
            BoneShape()
                .fill(Color(hex: "#ECECEC"))
        }
        .frame(width: width, height: height + depth)
    }
}
