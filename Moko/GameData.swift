 import Foundation

// MARK: - Bundled game content

struct Course: Decodable, Identifiable {
    let id: String
    let name: String
    let color: String
    let level: Int?
    let sections: [PathSectionData]
    let nodes: [PathNodeData]
    let lessons: [Lesson]
    let testOuts: [TestOutDefinition]?
}

struct TestOutDefinition: Decodable {
    let unitIndex: Int
    let unitId: String
    let lessonType: String
    let questionCount: Int
    let passingScore: Int
    let questionPool: [LessonScreen]
    let competencyBlueprint: [String]?
    let competencyEligibleQuestionIds: [String: [String]]?
    let competencySourceUnits: [String: [Int]]?
    let competencySourceNodes: [String: [Int]]?
    let jumpAheadQuestionCount: Int?
    let jumpPassingScore: Int?
    let jumpPrerequisiteMinimum: Int?
    let jumpTargetMinimum: Int?
    let jumpPrerequisiteBlueprint: [JumpCompetencySlot]?
    let jumpTargetBlueprint: [String]?
}

struct JumpCompetencySlot: Decodable {
    let unitIndex: Int
    let competencyId: String
}

struct GameData: Decodable {
    let courses: [Course]
    let legal: [String: LegalDoc]
}

enum Game {
    static let data: GameData = {
        guard let url = Bundle.main.url(forResource: "GameData", withExtension: "json"),
              let raw = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(GameData.self, from: raw) else {
            fatalError("GameData.json missing or failed to decode")
        }
        return decoded
    }()

    static var courses: [Course] { data.courses }
    static var defaultCourseId: String { data.courses.first?.id ?? "money" }

    static func course(_ id: String) -> Course {
        data.courses.first { $0.id == id } ?? data.courses[0]
    }

    static func lesson(course: String, node: Int) -> Lesson? {
        Self.course(course).lessons.first { $0.node == node }
    }

    static func totalNodes(course: String) -> Int { Self.course(course).nodes.count }

    static func legalDoc(_ kind: String) -> LegalDoc? { data.legal[kind] }
}
