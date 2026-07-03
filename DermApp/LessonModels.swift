import Foundation
import SwiftUI

// MARK: - Lesson data models
// These decode the exact JSON shape that the web app already stores in
// ALL_LESSONS_DATA and hands to the native player over the JS→Swift bridge,
// so the lesson content stays single-sourced in index.html.

struct Lesson: Decodable {
    let node: Int
    let title: String
    let celebration: String?
    let featurePromo: String?
    let screens: [LessonScreen]

    enum CodingKeys: String, CodingKey {
        case node, title, celebration, screens
        case featurePromo = "feature_promo"
    }
}

struct Blank: Decodable {
    let options: [String]
    let correct: Int
}

/// An option for the ingredient_match type (label + detail subtitle).
struct IngredientOption: Decodable {
    let label: String
    let detail: String?
    let correct: Bool?
    let wrongExplanation: String?
    enum CodingKeys: String, CodingKey {
        case label, detail, correct
        case wrongExplanation = "wrong_explanation"
    }
}

/// A single step in a lesson. The JSON is heterogeneous (fields depend on
/// `type`), so we decode leniently into one struct of optionals.
struct LessonScreen: Decodable, Identifiable {
    let id = UUID()
    let type: String

    // Set when a missed question is re-queued, so the UI can flag it.
    var isPreviousMistake = false

    // intro
    let screenTitle: String?
    let text: String?

    // shared question fields
    let question: String?
    let explanation: String?

    // true_false → correct is a Bool
    let correctBool: Bool?

    // multiple_choice / fill_blank / spot_mistake → correct is an index
    let options: [String]?
    let correctIndex: Int?
    let wrongExplanations: [String?]?

    // matching
    let pairs: [[String]]?

    // spot_mistake / ingredient_match
    let scenario: String?
    let concern: String?

    // fill_blank_multi
    let template: String?
    let blanks: [Blank]?

    // ingredient_match
    let ingredientOptions: [IngredientOption]?

    // sequence_builder / drag_order
    let items: [String]?
    let correctOrder: [String]?

    enum CodingKeys: String, CodingKey {
        case type, text, question, explanation, options, pairs, scenario, template, blanks
        case concern, items
        case screenTitle = "title"
        case correct
        case wrongExplanations = "wrong_explanations"
        case correctOrder = "correct_order"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(String.self, forKey: .type)
        screenTitle = try c.decodeIfPresent(String.self, forKey: .screenTitle)
        text = try c.decodeIfPresent(String.self, forKey: .text)
        question = try c.decodeIfPresent(String.self, forKey: .question)
        explanation = try c.decodeIfPresent(String.self, forKey: .explanation)
        // `options` is [String] for most types, but [IngredientOption] for
        // ingredient_match — decode leniently into whichever matches.
        options = (try? c.decodeIfPresent([String].self, forKey: .options)) ?? nil
        ingredientOptions = (try? c.decodeIfPresent([IngredientOption].self, forKey: .options)) ?? nil
        pairs = try c.decodeIfPresent([[String]].self, forKey: .pairs)
        scenario = try c.decodeIfPresent(String.self, forKey: .scenario)
        concern = try c.decodeIfPresent(String.self, forKey: .concern)
        template = try c.decodeIfPresent(String.self, forKey: .template)
        blanks = try c.decodeIfPresent([Blank].self, forKey: .blanks)
        items = try c.decodeIfPresent([String].self, forKey: .items)
        correctOrder = try c.decodeIfPresent([String].self, forKey: .correctOrder)

        // wrong_explanations may contain nulls
        wrongExplanations = (try? c.decodeIfPresent([String?].self, forKey: .wrongExplanations)) ?? nil

        // `correct` is a Bool for true_false, an Int otherwise.
        if let b = try? c.decodeIfPresent(Bool.self, forKey: .correct) {
            correctBool = b
            correctIndex = nil
        } else if let i = try? c.decodeIfPresent(Int.self, forKey: .correct) {
            correctIndex = i
            correctBool = nil
        } else {
            correctBool = nil
            correctIndex = nil
        }
    }
}

// MARK: - Lightweight <b> markup → AttributedString
// The web content uses <b>…</b> inside questions/explanations. Render those
// as bold runs so the native text keeps the same emphasis.

enum RichText {
    static func attributed(_ raw: String, base: Font, bold: Font, color: Color) -> AttributedString {
        var result = AttributedString()
        var remaining = Substring(raw)

        while let open = remaining.range(of: "<b>") {
            // plain text before <b>
            let before = remaining[remaining.startIndex..<open.lowerBound]
            if !before.isEmpty {
                var seg = AttributedString(decodeEntities(String(before)))
                seg.font = base; seg.foregroundColor = color
                result.append(seg)
            }
            let afterOpen = remaining[open.upperBound...]
            guard let close = afterOpen.range(of: "</b>") else {
                var seg = AttributedString(decodeEntities(String(afterOpen)))
                seg.font = base; seg.foregroundColor = color
                result.append(seg)
                return result
            }
            let boldText = afterOpen[afterOpen.startIndex..<close.lowerBound]
            var seg = AttributedString(decodeEntities(String(boldText)))
            seg.font = bold; seg.foregroundColor = color
            result.append(seg)
            remaining = afterOpen[close.upperBound...]
        }

        if !remaining.isEmpty {
            var seg = AttributedString(decodeEntities(String(remaining)))
            seg.font = base; seg.foregroundColor = color
            result.append(seg)
        }
        return result
    }

    private static func decodeEntities(_ s: String) -> String {
        return s
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
    }
}
