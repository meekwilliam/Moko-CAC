import SwiftUI
import Combine

// MARK: - Path payload (decoded from the JS bridge)

struct PathStats: Decodable {
    let xp: Int
    let treats: Int
    let streak: Int
    let hearts: Int
    let energy: Int
}

struct PathSectionData: Decodable {
    let index: Int
    let eyebrow: String
    let title: String
    let bg: String
    let slab: String
    let tier: String?
    let unitId: String?
    let difficulty: String?
    let testOutEnabled: Bool?
}

struct PathNodeData: Decodable {
    let num: Int
    let svg: String
    let title: String?
    let sectionIndex: Int
    var symbol: String? = nil
}

struct PathPayload: Decodable {
    let stats: PathStats
    let completed: [Int]
    let sections: [PathSectionData]
    let nodes: [PathNodeData]
    let inProgressNode: Int?
    let testedOutUnits: [Int]
    let recommendedReviewNodes: [Int]
    let testOutBlockedUnits: [Int]
    let testOutRetryUnits: [Int]
}

// MARK: - Node model (icon parsed once)

enum NodeState { case done, active, locked }

struct PathNode: Identifiable {
    let num: Int
    let icon: SVGImage
    let title: String
    let sectionIndex: Int
    let isBoss: Bool
    var symbol: String? = nil
    var id: Int { num }

    var xOffset: CGFloat {
        let amplitude: CGFloat = 70
        return -amplitude * CGFloat(sin(Double(num - 1) * .pi / 4.0))
    }
}

// MARK: - Store

final class PathStore: ObservableObject {
    @Published var completed: Set<Int>
    @Published var xp: Int
    @Published var treats: Int
    @Published var streak: Int
    @Published var hearts: Int
    @Published var energy: Int
    @Published var inProgressNode: Int?
    @Published var testedOutUnits: Set<Int>
    @Published var recommendedReviewNodes: Set<Int>
    @Published var testOutBlockedUnits: Set<Int>
    @Published var testOutRetryUnits: Set<Int>

    let sections: [PathSectionData]
    let nodes: [PathNode]
    let totalNodes: Int

    init(payload: PathPayload) {
        self.completed = Set(payload.completed)
        self.xp = payload.stats.xp
        self.treats = payload.stats.treats
        self.streak = payload.stats.streak
        self.hearts = payload.stats.hearts
        self.energy = payload.stats.energy
        self.inProgressNode = payload.inProgressNode
        self.testedOutUnits = Set(payload.testedOutUnits)
        self.recommendedReviewNodes = Set(payload.recommendedReviewNodes)
        self.testOutBlockedUnits = Set(payload.testOutBlockedUnits)
        self.testOutRetryUnits = Set(payload.testOutRetryUnits)
        self.sections = payload.sections.sorted { $0.index < $1.index }
        var lastInUnit: [Int: Int] = [:]
        for n in payload.nodes {
            lastInUnit[n.sectionIndex] = max(lastInUnit[n.sectionIndex] ?? n.num, n.num)
        }
        self.nodes = payload.nodes
            .sorted { $0.num < $1.num }
            .map { PathNode(num: $0.num, icon: SVGParser.parse($0.svg),
                            title: $0.title ?? "Lesson \($0.num)", sectionIndex: $0.sectionIndex,
                            isBoss: lastInUnit[$0.sectionIndex] == $0.num, symbol: $0.symbol) }
        self.totalNodes = self.nodes.count
    }

    var frontier: Int {
        var f = 0
        while completed.contains(f + 1) { f += 1 }
        return f
    }

    var activeNode: Int? {
        let f = frontier
        return f < totalNodes ? f + 1 : nil
    }

    func state(for num: Int) -> NodeState {
        if recommendedReviewNodes.contains(num) && !completed.contains(num) { return .active }
        let f = frontier
        if num <= f { return .done }
        if num == activeNode { return .active }
        return .locked
    }

    func colors(for num: Int, state: NodeState) -> (main: Color, dark: Color) {
        if state == .locked {
            return (Color(hex: "#3a6080"), Color(hex: "#1a3a50"))
        }
        guard let node = nodes.first(where: { $0.num == num }),
              let sec = section(node.sectionIndex) else {
            let c = Theme.unitColor(num)
            return (c.main, c.dark)
        }
        return (Color(hex: sec.bg), Color(hex: sec.slab))
    }

    func section(_ index: Int) -> PathSectionData? {
        sections.first { $0.index == index }
    }

    func nodes(inSection index: Int) -> [PathNode] {
        nodes.filter { $0.sectionIndex == index }
    }

    var sectionCount: Int {
        sections.count
    }

    func update(completed: [Int], xp: Int, treats: Int, streak: Int, inProgressNode: Int?, testedOutUnits: [Int] = [], recommendedReviewNodes: [Int] = [], testOutBlockedUnits: [Int] = [], testOutRetryUnits: [Int] = []) {
        self.completed = Set(completed)
        self.xp = xp
        self.treats = treats
        self.streak = streak
        self.inProgressNode = inProgressNode
        self.testedOutUnits = Set(testedOutUnits)
        self.recommendedReviewNodes = Set(recommendedReviewNodes)
        self.testOutBlockedUnits = Set(testOutBlockedUnits)
        self.testOutRetryUnits = Set(testOutRetryUnits)
    }
}
