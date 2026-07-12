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
    let lessonType: String?
    let screens: [LessonScreen]
    var assessmentOverallMinimum: Int? = nil
    var assessmentPrerequisiteMinimum: Int? = nil
    var assessmentTargetMinimum: Int? = nil
    var assessmentTargetCompetencies: [String]? = nil

    enum CodingKeys: String, CodingKey {
        case node, title, celebration, screens, lessonType
        case assessmentOverallMinimum, assessmentPrerequisiteMinimum, assessmentTargetMinimum, assessmentTargetCompetencies
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
    let skillId: String?
    let competencyId: String?
    let sourceLesson: String?
    let sourceUnit: Int?
    let sourceNode: Int?
    let questionId: String?
    let footprintPreview: Bool?

    // Set when a missed question is re-queued, so the UI can flag it.
    var isPreviousMistake = false

    // intro
    let screenTitle: String?
    let text: String?
    // Optional named ChartScenario key (e.g. "doji", "uptrend") to illustrate
    // an intro card with a small candlestick chart.
    let chart: String?
    // live_chart → the direction the live tape walks ("up"/"down"/"sideways"/
    // "volatile"), so the forming candle biases toward a stable answer.
    let direction: String?
    // aggressor → which side hit the book ("lift" = buyers took the offer,
    // "hit" = sellers took the bid); drives the ladder consume animation.
    let event: String?
    // book_drag → the order to route ("market_buy" / "market_sell").
    let order: String?

    // shared question fields
    let question: String?
    let explanation: String?

    // true_false → correct is a Bool
    let correctBool: Bool?

    // multiple_choice / fill_blank → correct is an index
    let options: [String]?
    let correctIndex: Int?
    let wrongExplanations: [String?]?

    // matching
    let pairs: [[String]]?

    // ingredient_match
    let concern: String?

    // fill_blank_multi
    let template: String?
    let blanks: [Blank]?

    // ingredient_match
    let ingredientOptions: [IngredientOption]?

    // sequence_builder / drag_order
    let items: [String]?
    let correctOrder: [String]?

    // tap_candle → index of the candle the learner must tap on the attached chart
    let target: Int?
    // tap_candles → set of candle indices the learner must select (multi-tap)
    let targets: [Int]?
    // mark_level → the price level to mark, and whether it's support/resistance
    let level: Double?
    let levelKind: String?

    // draw_trendline → the two candle indices the learner must connect
    let targetStart: Int?
    let targetEnd: Int?
    // mark_consolidation → the contiguous candle-index range the learner must select
    let targetLo: Int?
    let targetHi: Int?

    // number_slider → drag a slider to the calculated answer
    let numberMin: Double?
    let numberMax: Double?
    let numberStep: Double?
    let numberCorrect: Double?
    let numberTolerance: Double?
    let numberUnit: String?

    enum CodingKeys: String, CodingKey {
        case type, text, question, explanation, options, pairs, template, blanks, direction, event, order, skillId, competencyId, sourceLesson, sourceUnit, sourceNode, questionId, footprintPreview
        case concern, items, chart, target, targets, level
        case levelKind = "level_kind"
        case targetStart = "target_start"
        case targetEnd = "target_end"
        case targetLo = "target_lo"
        case targetHi = "target_hi"
        case numberMin = "number_min"
        case numberMax = "number_max"
        case numberStep = "number_step"
        case numberCorrect = "number_correct"
        case numberTolerance = "number_tolerance"
        case numberUnit = "number_unit"
        case screenTitle = "title"
        case correct
        case wrongExplanations = "wrong_explanations"
        case correctOrder = "correct_order"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        type = try c.decode(String.self, forKey: .type)
        skillId = try c.decodeIfPresent(String.self, forKey: .skillId)
        competencyId = try c.decodeIfPresent(String.self, forKey: .competencyId)
        sourceLesson = try c.decodeIfPresent(String.self, forKey: .sourceLesson)
        sourceUnit = try c.decodeIfPresent(Int.self, forKey: .sourceUnit)
        sourceNode = try c.decodeIfPresent(Int.self, forKey: .sourceNode)
        questionId = try c.decodeIfPresent(String.self, forKey: .questionId)
        footprintPreview = try c.decodeIfPresent(Bool.self, forKey: .footprintPreview)
        screenTitle = try c.decodeIfPresent(String.self, forKey: .screenTitle)
        text = try c.decodeIfPresent(String.self, forKey: .text)
        chart = try c.decodeIfPresent(String.self, forKey: .chart)
        direction = try c.decodeIfPresent(String.self, forKey: .direction)
        event = try c.decodeIfPresent(String.self, forKey: .event)
        order = try c.decodeIfPresent(String.self, forKey: .order)
        question = try c.decodeIfPresent(String.self, forKey: .question)
        explanation = try c.decodeIfPresent(String.self, forKey: .explanation)
        // `options` is [String] for most types, but [IngredientOption] for
        // ingredient_match — decode leniently into whichever matches.
        options = (try? c.decodeIfPresent([String].self, forKey: .options)) ?? nil
        ingredientOptions = (try? c.decodeIfPresent([IngredientOption].self, forKey: .options)) ?? nil
        pairs = try c.decodeIfPresent([[String]].self, forKey: .pairs)
        concern = try c.decodeIfPresent(String.self, forKey: .concern)
        template = try c.decodeIfPresent(String.self, forKey: .template)
        blanks = try c.decodeIfPresent([Blank].self, forKey: .blanks)
        items = try c.decodeIfPresent([String].self, forKey: .items)
        correctOrder = try c.decodeIfPresent([String].self, forKey: .correctOrder)
        target = try c.decodeIfPresent(Int.self, forKey: .target)
        targets = try c.decodeIfPresent([Int].self, forKey: .targets)
        level = try c.decodeIfPresent(Double.self, forKey: .level)
        levelKind = try c.decodeIfPresent(String.self, forKey: .levelKind)
        targetStart = try c.decodeIfPresent(Int.self, forKey: .targetStart)
        targetEnd = try c.decodeIfPresent(Int.self, forKey: .targetEnd)
        targetLo = try c.decodeIfPresent(Int.self, forKey: .targetLo)
        targetHi = try c.decodeIfPresent(Int.self, forKey: .targetHi)
        numberMin = try c.decodeIfPresent(Double.self, forKey: .numberMin)
        numberMax = try c.decodeIfPresent(Double.self, forKey: .numberMax)
        numberStep = try c.decodeIfPresent(Double.self, forKey: .numberStep)
        numberCorrect = try c.decodeIfPresent(Double.self, forKey: .numberCorrect)
        numberTolerance = try c.decodeIfPresent(Double.self, forKey: .numberTolerance)
        numberUnit = try c.decodeIfPresent(String.self, forKey: .numberUnit)

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
