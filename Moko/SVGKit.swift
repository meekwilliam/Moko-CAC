import SwiftUI

// MARK: - Minimal SVG fragment renderer

struct SVGElement {
    var path: Path
    var fill: Color?
    var stroke: Color?
    var strokeWidth: CGFloat
    var rounded: Bool
}

struct SVGImage {
    var viewBox: CGRect
    var elements: [SVGElement]
}

enum SVGParser {
    static func parse(_ svg: String) -> SVGImage {
        let viewBox = parseViewBox(svg) ?? CGRect(x: 0, y: 0, width: 32, height: 32)
        var elements: [SVGElement] = []

        let rootFill = parseRootAttr(svg, "fill")

        let pattern = "<(path|circle|ellipse|rect|line)\\b([^>]*?)/?>"
        guard let re = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else {
            return SVGImage(viewBox: viewBox, elements: [])
        }
        let ns = svg as NSString
        let matches = re.matches(in: svg, range: NSRange(location: 0, length: ns.length))
        for m in matches {
            let tag = ns.substring(with: m.range(at: 1)).lowercased()
            let attrsStr = ns.substring(with: m.range(at: 2))
            let attrs = parseAttrs(attrsStr)

            guard let path = buildPath(tag: tag, attrs: attrs) else { continue }

            let rounded = (attrs["stroke-linecap"] == "round") || (attrs["stroke-linejoin"] == "round")
            let fillRaw = attrs["fill"] ?? rootFill
            var el = SVGElement(
                path: path,
                fill: colorFrom(fillRaw, defaultFill: true),
                stroke: colorFrom(attrs["stroke"], defaultFill: false),
                strokeWidth: CGFloat(Double(attrs["stroke-width"] ?? "") ?? 1),
                rounded: rounded
            )
            if let t = attrs["transform"], let tf = parseTransform(t) {
                el.path = el.path.applying(tf)
            }
            elements.append(el)
        }
        return SVGImage(viewBox: viewBox, elements: elements)
    }

    // MARK: attribute + primitive helpers

    private static func parseViewBox(_ svg: String) -> CGRect? {
        guard let r = svg.range(of: "viewBox=\"") else { return nil }
        let rest = svg[r.upperBound...]
        guard let end = rest.firstIndex(of: "\"") else { return nil }
        let nums = rest[..<end].split(whereSeparator: { $0 == " " || $0 == "," }).compactMap { Double($0) }
        guard nums.count == 4 else { return nil }
        return CGRect(x: nums[0], y: nums[1], width: nums[2], height: nums[3])
    }

    private static func parseRootAttr(_ svg: String, _ name: String) -> String? {
        guard let open = svg.range(of: "<svg") else { return nil }
        let rest = svg[open.upperBound...]
        let head = rest.prefix(while: { $0 != ">" })
        let pattern = "\\b\(name)\\s*=\\s*\"([^\"]*)\""
        guard let re = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else { return nil }
        let str = String(head)
        let ns = str as NSString
        guard let m = re.firstMatch(in: str, range: NSRange(location: 0, length: ns.length)) else { return nil }
        return ns.substring(with: m.range(at: 1))
    }

    private static func parseAttrs(_ s: String) -> [String: String] {
        var out: [String: String] = [:]
        let pattern = "([a-zA-Z_:\\-]+)\\s*=\\s*\"([^\"]*)\""
        guard let re = try? NSRegularExpression(pattern: pattern) else { return out }
        let ns = s as NSString
        for m in re.matches(in: s, range: NSRange(location: 0, length: ns.length)) {
            out[ns.substring(with: m.range(at: 1))] = ns.substring(with: m.range(at: 2))
        }
        return out
    }

    private static func num(_ attrs: [String: String], _ key: String) -> CGFloat {
        CGFloat(Double(attrs[key] ?? "") ?? 0)
    }

    private static func buildPath(tag: String, attrs: [String: String]) -> Path? {
        switch tag {
        case "path":
            guard let d = attrs["d"] else { return nil }
            return PathData.parse(d)
        case "circle":
            let cx = num(attrs, "cx"), cy = num(attrs, "cy"), r = num(attrs, "r")
            return Path(ellipseIn: CGRect(x: cx - r, y: cy - r, width: r * 2, height: r * 2))
        case "ellipse":
            let cx = num(attrs, "cx"), cy = num(attrs, "cy")
            let rx = num(attrs, "rx"), ry = num(attrs, "ry")
            return Path(ellipseIn: CGRect(x: cx - rx, y: cy - ry, width: rx * 2, height: ry * 2))
        case "rect":
            let x = num(attrs, "x"), y = num(attrs, "y")
            let w = num(attrs, "width"), h = num(attrs, "height")
            let rx = attrs["rx"] != nil ? num(attrs, "rx") : (attrs["ry"] != nil ? num(attrs, "ry") : 0)
            let rect = CGRect(x: x, y: y, width: w, height: h)
            return rx > 0 ? Path(roundedRect: rect, cornerRadius: rx) : Path(rect)
        case "line":
            var p = Path()
            p.move(to: CGPoint(x: num(attrs, "x1"), y: num(attrs, "y1")))
            p.addLine(to: CGPoint(x: num(attrs, "x2"), y: num(attrs, "y2")))
            return p
        default:
            return nil
        }
    }

    private static func parseTransform(_ t: String) -> CGAffineTransform? {
        if let r = t.range(of: "matrix(") {
            let rest = t[r.upperBound...]
            if let end = rest.firstIndex(of: ")") {
                let n = rest[..<end].split(whereSeparator: { $0 == " " || $0 == "," }).compactMap { Double($0) }
                if n.count == 6 {
                    return CGAffineTransform(a: CGFloat(n[0]), b: CGFloat(n[1]),
                                             c: CGFloat(n[2]), d: CGFloat(n[3]),
                                             tx: CGFloat(n[4]), ty: CGFloat(n[5]))
                }
            }
        }
        guard let r = t.range(of: "rotate(") else { return nil }
        let rest = t[r.upperBound...]
        guard let end = rest.firstIndex(of: ")") else { return nil }
        let nums = rest[..<end].split(whereSeparator: { $0 == " " || $0 == "," }).compactMap { Double($0) }
        guard let angle = nums.first else { return nil }
        let rad = CGFloat(angle) * .pi / 180
        if nums.count >= 3 {
            let cx = CGFloat(nums[1]), cy = CGFloat(nums[2])
            return CGAffineTransform(translationX: cx, y: cy)
                .rotated(by: rad)
                .translatedBy(x: -cx, y: -cy)
        }
        return CGAffineTransform(rotationAngle: rad)
    }

    static func colorFrom(_ raw: String?, defaultFill: Bool) -> Color? {
        guard let raw = raw?.trimmingCharacters(in: .whitespaces) else {
            return defaultFill ? .black : nil
        }
        if raw == "none" { return nil }
        if raw == "white" { return .white }
        if raw == "black" { return .black }
        if raw == "currentColor" { return .white }
        if raw.hasPrefix("#") { return Color(hex: raw) }
        if raw.hasPrefix("rgba(") || raw.hasPrefix("rgb(") {
            let inside = raw.replacingOccurrences(of: "rgba(", with: "")
                .replacingOccurrences(of: "rgb(", with: "")
                .replacingOccurrences(of: ")", with: "")
            let parts = inside.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            guard parts.count >= 3,
                  let r = Double(parts[0]), let g = Double(parts[1]), let b = Double(parts[2]) else { return nil }
            let a = parts.count >= 4 ? (Double(parts[3]) ?? 1) : 1
            return Color(.sRGB, red: r/255, green: g/255, blue: b/255, opacity: a)
        }
        return defaultFill ? .black : nil
    }
}

// MARK: - SVG path `d` parser (M L H V C S Q T A Z, absolute + relative)

enum PathData {
    static func parse(_ d: String) -> Path {
        var path = Path()
        var tokens = tokenize(d)
        var i = 0
        var current = CGPoint.zero
        var start = CGPoint.zero
        var lastCtrl: CGPoint? = nil
        var lastCmd: Character = " "

        func nextNum() -> CGFloat? {
            while i < tokens.count, case .command = tokens[i] { i += 1 }
            guard i < tokens.count, case let .number(n) = tokens[i] else { return nil }
            i += 1
            return CGFloat(n)
        }
        func pt(relative: Bool) -> CGPoint? {
            guard let x = nextNum(), let y = nextNum() else { return nil }
            return relative ? CGPoint(x: current.x + x, y: current.y + y) : CGPoint(x: x, y: y)
        }

        while i < tokens.count {
            var cmd: Character
            if case let .command(c) = tokens[i] {
                cmd = c
                i += 1
            } else {
                cmd = (lastCmd == "M") ? "L" : (lastCmd == "m") ? "l" : lastCmd
            }
            let rel = cmd.isLowercase
            switch cmd.uppercased().first! {
            case "M":
                guard let p = pt(relative: rel) else { i = tokens.count; break }
                path.move(to: p); current = p; start = p; lastCtrl = nil
            case "L":
                guard let p = pt(relative: rel) else { i = tokens.count; break }
                path.addLine(to: p); current = p; lastCtrl = nil
            case "H":
                guard let x = nextNum() else { i = tokens.count; break }
                let nx = rel ? current.x + x : x
                current.y == current.y ? path.addLine(to: CGPoint(x: nx, y: current.y)) : ()
                current.x = nx; lastCtrl = nil
            case "V":
                guard let y = nextNum() else { i = tokens.count; break }
                let ny = rel ? current.y + y : y
                path.addLine(to: CGPoint(x: current.x, y: ny)); current.y = ny; lastCtrl = nil
            case "C":
                guard let c1 = pt(relative: rel), let c2 = pt(relative: rel), let p = pt(relative: rel) else { i = tokens.count; break }
                path.addCurve(to: p, control1: c1, control2: c2); current = p; lastCtrl = c2
            case "S":
                let c1 = reflect(lastCtrl, around: current)
                guard let c2 = pt(relative: rel), let p = pt(relative: rel) else { i = tokens.count; break }
                path.addCurve(to: p, control1: c1, control2: c2); current = p; lastCtrl = c2
            case "Q":
                guard let c = pt(relative: rel), let p = pt(relative: rel) else { i = tokens.count; break }
                path.addQuadCurve(to: p, control: c); current = p; lastCtrl = c
            case "T":
                let c = reflect(lastCtrl, around: current)
                guard let p = pt(relative: rel) else { i = tokens.count; break }
                path.addQuadCurve(to: p, control: c); current = p; lastCtrl = c
            case "A":
                guard let rx = nextNum(), let ry = nextNum(), let rot = nextNum(),
                      let laf = nextNum(), let sf = nextNum(), let p = pt(relative: rel) else { i = tokens.count; break }
                addArc(&path, from: current, to: p, rx: rx, ry: ry, xRotDeg: rot,
                       largeArc: laf != 0, sweep: sf != 0)
                current = p; lastCtrl = nil
            case "Z":
                path.closeSubpath(); current = start; lastCtrl = nil
            default:
                i = tokens.count
            }
            lastCmd = cmd
        }
        return path
    }

    private static func reflect(_ ctrl: CGPoint?, around p: CGPoint) -> CGPoint {
        guard let c = ctrl else { return p }
        return CGPoint(x: 2 * p.x - c.x, y: 2 * p.y - c.y)
    }

    private enum Token { case command(Character); case number(Double) }

    private static func tokenize(_ d: String) -> [Token] {
        var tokens: [Token] = []
        let chars = Array(d)
        var i = 0
        let cmdSet = Set("MmLlHhVvCcSsQqTtAaZz")
        while i < chars.count {
            let ch = chars[i]
            if cmdSet.contains(ch) {
                tokens.append(.command(ch)); i += 1
            } else if ch == " " || ch == "," || ch == "\n" || ch == "\t" || ch == "\r" {
                i += 1
            } else if ch == "-" || ch == "." || ch.isNumber || ch == "+" {
                var s = ""
                var seenDot = false
                var seenE = false
                while i < chars.count {
                    let c = chars[i]
                    if c.isNumber { s.append(c); i += 1 }
                    else if c == "." { if seenDot { break }; seenDot = true; s.append(c); i += 1 }
                    else if (c == "-" || c == "+") {
                        if s.isEmpty { s.append(c); i += 1 }
                        else if s.last == "e" || s.last == "E" { s.append(c); i += 1 }
                        else { break }
                    }
                    else if c == "e" || c == "E" { if seenE { break }; seenE = true; s.append(c); i += 1 }
                    else { break }
                }
                if let n = Double(s) { tokens.append(.number(n)) }
            } else {
                i += 1
            }
        }
        return tokens
    }

    private static func addArc(_ path: inout Path, from: CGPoint, to: CGPoint,
                               rx rxIn: CGFloat, ry ryIn: CGFloat, xRotDeg: CGFloat,
                               largeArc: Bool, sweep: Bool) {
        var rx = abs(rxIn), ry = abs(ryIn)
        if rx == 0 || ry == 0 { path.addLine(to: to); return }
        let phi = xRotDeg * .pi / 180
        let cosPhi = cos(phi), sinPhi = sin(phi)
        let dx = (from.x - to.x) / 2, dy = (from.y - to.y) / 2
        let x1p =  cosPhi * dx + sinPhi * dy
        let y1p = -sinPhi * dx + cosPhi * dy
        let lambda = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry)
        if lambda > 1 { let s = sqrt(lambda); rx *= s; ry *= s }
        var num = rx*rx*ry*ry - rx*rx*y1p*y1p - ry*ry*x1p*x1p
        let den = rx*rx*y1p*y1p + ry*ry*x1p*x1p
        if num < 0 { num = 0 }
        var coef = (den == 0) ? 0 : sqrt(num / den)
        if largeArc == sweep { coef = -coef }
        let cxp = coef * (rx * y1p / ry)
        let cyp = coef * (-ry * x1p / rx)
        let cx = cosPhi * cxp - sinPhi * cyp + (from.x + to.x) / 2
        let cy = sinPhi * cxp + cosPhi * cyp + (from.y + to.y) / 2

        func angle(_ ux: CGFloat, _ uy: CGFloat, _ vx: CGFloat, _ vy: CGFloat) -> CGFloat {
            let dot = ux*vx + uy*vy
            let len = sqrt((ux*ux+uy*uy)*(vx*vx+vy*vy))
            var a = acos(max(-1, min(1, dot / (len == 0 ? 1 : len))))
            if ux*vy - uy*vx < 0 { a = -a }
            return a
        }
        let theta1 = angle(1, 0, (x1p - cxp)/rx, (y1p - cyp)/ry)
        var dTheta = angle((x1p - cxp)/rx, (y1p - cyp)/ry, (-x1p - cxp)/rx, (-y1p - cyp)/ry)
        if !sweep && dTheta > 0 { dTheta -= 2 * .pi }
        if sweep && dTheta < 0 { dTheta += 2 * .pi }

        let segments = max(1, Int(ceil(abs(dTheta) / (.pi / 2))))
        let delta = dTheta / CGFloat(segments)
        let t = 4.0 / 3.0 * tan(delta / 4)
        var angleStart = theta1
        for _ in 0..<segments {
            let a1 = angleStart
            let a2 = angleStart + delta
            let cosA1 = cos(a1), sinA1 = sin(a1)
            let cosA2 = cos(a2), sinA2 = sin(a2)
            func map(_ ex: CGFloat, _ ey: CGFloat) -> CGPoint {
                CGPoint(x: cosPhi * rx * ex - sinPhi * ry * ey + cx,
                        y: sinPhi * rx * ex + cosPhi * ry * ey + cy)
            }
            let p2 = map(cosA2, sinA2)
            let c1 = map(cosA1 - t * sinA1, sinA1 + t * cosA1)
            let c2 = map(cosA2 + t * sinA2, sinA2 - t * cosA2)
            path.addCurve(to: p2, control1: c1, control2: c2)
            angleStart = a2
        }
    }
}

// MARK: - SwiftUI view

struct SVGIconView: View {
    let svg: SVGImage
    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width / svg.viewBox.width,
                            geo.size.height / svg.viewBox.height)
            let offX = (geo.size.width - svg.viewBox.width * scale) / 2 - svg.viewBox.minX * scale
            let offY = (geo.size.height - svg.viewBox.height * scale) / 2 - svg.viewBox.minY * scale
            ZStack {
                ForEach(Array(svg.elements.enumerated()), id: \.offset) { _, el in
                    let scaled = el.path
                        .applying(CGAffineTransform(scaleX: scale, y: scale))
                        .applying(CGAffineTransform(translationX: offX, y: offY))
                    ZStack {
                        if let f = el.fill { scaled.fill(f) }
                        if let s = el.stroke {
                            scaled.stroke(s, style: StrokeStyle(
                                lineWidth: el.strokeWidth * scale,
                                lineCap: el.rounded ? .round : .butt,
                                lineJoin: el.rounded ? .round : .miter))
                        }
                    }
                }
            }
        }
    }
}
