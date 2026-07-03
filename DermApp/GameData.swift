import Foundation

// MARK: - Bundled game content (replaces the web ALL_LESSONS_DATA / DOM data)
// Exported once from index.html into GameData.json, decoded natively so the app
// no longer needs the WKWebView as a data source.

struct GameData: Decodable {
    let lessons: [Lesson]
    let sections: [PathSectionData]
    let nodes: [PathNodeData]
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

    static func lesson(node: Int) -> Lesson? {
        data.lessons.first { $0.node == node }
    }

    static var totalNodes: Int { data.nodes.count }

    static func legalDoc(_ kind: String) -> LegalDoc? { data.legal[kind] }
}
