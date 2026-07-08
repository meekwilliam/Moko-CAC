 import Foundation

// MARK: - Bundled game content (multi-course)
// GameData.json holds several courses (Skincare, Personal Finance, …), each with
// its own units / nodes / lessons — like Duolingo's language courses. Legal docs
// are shared across courses.

struct Course: Decodable, Identifiable {
    let id: String
    let name: String
    let color: String            // accent hex for the course
    let level: Int?              // difficulty level (1=Beginner … 4=Expert), if tiered
    let sections: [PathSectionData]
    let nodes: [PathNodeData]
    let lessons: [Lesson]
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
    static var defaultCourseId: String { data.courses.first?.id ?? "skincare" }

    static func course(_ id: String) -> Course {
        data.courses.first { $0.id == id } ?? data.courses[0]
    }

    static func lesson(course: String, node: Int) -> Lesson? {
        Self.course(course).lessons.first { $0.node == node }
    }

    static func totalNodes(course: String) -> Int { Self.course(course).nodes.count }

    static func legalDoc(_ kind: String) -> LegalDoc? { data.legal[kind] }
}
