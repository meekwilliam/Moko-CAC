import SwiftUI

struct Starfield: View {
    let starCount: Int
    @State private var phase: Double = 0

    init(starCount: Int = 120) {
        self.starCount = starCount
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                
                // Seed random so it's consistent for drawing
                var generator = SeededRandomGenerator(seed: 42)
                
                for _ in 0..<starCount {
                    let x = CGFloat.random(in: 0...size.width, using: &generator)
                    let y = CGFloat.random(in: 0...size.height, using: &generator)
                    let radius = CGFloat.random(in: 0.5...1.8, using: &generator)
                    
                    // Twinkle parameters
                    let speed = Double.random(in: 0.5...2.0, using: &generator)
                    let offset = Double.random(in: 0...10, using: &generator)
                    
                    // Calculate opacity based on time
                    let opacity = 0.3 + 0.7 * abs(sin(time * speed + offset))
                    
                    context.opacity = opacity
                    
                    let path = Path(ellipseIn: CGRect(x: x, y: y, width: radius * 2, height: radius * 2))
                    context.fill(path, with: .color(.white))
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct SeededRandomGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        self.state = seed
    }
    
    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z &>> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z &>> 27)) &* 0x94D049BB133111EB
        return z ^ (z &>> 31)
    }
}
