import SwiftUI
import Combine

// MARK: - Path payload (decoded from the JS bridge)
// index.html serializes the current progress, the 9 section banners, and the
// 45 node icons (as inline SVG) so the native path stays visually identical and
// content stays single-sourced in the web layer.

struct PathStats: Decodable {
    let xp: Int
    let treats: Int
    let streak: Int
    let hearts: Int
    let energy: Int
}

struct PathSectionData: Decodable {
    let index: Int      // 0-based section order
    let eyebrow: String // "SECTION 1"
    let title: String
    let bg: String      // hex
    let slab: String    // hex (darker slab / shadow)
    let tier: String?   // "Beginner" / "Intermediate" / … (optional grouping)
    let unitId: String?
    let difficulty: String?
    let testOutEnabled: Bool?
    let testOutQuestionCount: Int?
    let testOutPassingScore: Int?
    let bossLessonId: String?
    let finalBossRequiredForCourseMastery: Bool?
}

struct PathNodeData: Decodable {
    let num: Int
    let svg: String
    let title: String?
    let sectionIndex: Int   // which unit this node belongs to — units can be any size
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

/// Lightweight progress refresh pushed back after a lesson completes.
struct PathState: Decodable {
    let completed: [Int]
    let xp: Int
    let streak: Int
    let inProgressNode: Int?
}

// MARK: - Node model (icon parsed once)

enum NodeState: Equatable { case done, active, locked }

enum UnitProgressState: String {
    case locked = "LOCKED"
    case available = "AVAILABLE"
    case inProgress = "IN_PROGRESS"
    case testedOut = "TESTED_OUT"
    case completed = "COMPLETED"
    case mastered = "MASTERED"
}

struct PathNode: Identifiable {
    let num: Int
    let icon: SVGImage
    let title: String
    /// 0-based unit this node belongs to — units can be any size, this comes
    /// straight from the content data, not a fixed node-count assumption.
    let sectionIndex: Int
    /// The final node of its unit — a review test covering everything the unit
    /// taught. Structural (the highest node number in the section), unlike
    /// `unitBonusEligible`, which only asks whether the *rest* of the unit
    /// happens to be done already.
    let isBoss: Bool
    var id: Int { num }

    /// Legacy offset retained for the retired path renderer. The active skill
    /// map is linear and does not use horizontal lesson-node sway.
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
    @Published var isUnlimitedHearts: Bool = false
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
        // The last node of each unit is that unit's review test.
        var lastInUnit: [Int: Int] = [:]
        for n in payload.nodes {
            lastInUnit[n.sectionIndex] = max(lastInUnit[n.sectionIndex] ?? n.num, n.num)
        }
        self.nodes = payload.nodes
            .sorted { $0.num < $1.num }
            .map { PathNode(num: $0.num, icon: SVGParser.parse($0.svg),
                            title: $0.title ?? "Lesson \($0.num)", sectionIndex: $0.sectionIndex,
                            isBoss: lastInUnit[$0.sectionIndex] == $0.num) }
        self.totalNodes = self.nodes.count
    }

    /// Longest unbroken completed run from node 1 — the unlock frontier.
    var frontier: Int {
        var f = 0
        while completed.contains(f + 1) { f += 1 }
        return f
    }

    /// The single unlocked-but-unfinished node, or nil if everything is done.
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

    func progressionState(forSection index: Int) -> UnitProgressState {
        let unitNodes = nodes(inSection: index)
        guard let first = unitNodes.first else { return .locked }
        if index == sections.last?.index && unitNodes.allSatisfy({ completed.contains($0.num) }) { return .mastered }
        if testedOutUnits.contains(index) { return .testedOut }
        if unitNodes.allSatisfy({ completed.contains($0.num) }) {
            return .completed
        }
        if unitNodes.contains(where: { completed.contains($0.num) }) ||
            unitNodes.contains(where: { recommendedReviewNodes.contains($0.num) }) { return .inProgress }
        return state(for: first.num) == .locked ? .locked : .available
    }

    /// Progression colors use the semantic tier palette. Course metadata can
    /// keep its old color fields without leaking them into the active UI.
    func colors(for num: Int, state: NodeState) -> (main: Color, dark: Color) {
        if state == .locked {
            return (Theme.surfaceHighlight, Theme.surfaceStrong)
        }
        guard let node = nodes.first(where: { $0.num == num }),
              let sec = section(node.sectionIndex) else {
            let c = Theme.unitColor(num)   // fallback for any missing section data
            return (c.main, c.dark)
        }
        return Theme.tierColor(sec.tier, index: sec.index)
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
