import Foundation
import SwiftUI

// MARK: - Lesson data models

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

struct TradeStage: Decodable {
    let prompt: String
    let options: [String]?
    let correct: Int
    let explanation: String
    let wrongExplanations: [String?]?
    let startTick: Int?

    enum CodingKeys: String, CodingKey {
        case prompt, options, correct, explanation
        case wrongExplanations = "wrong_explanations"
        case startTick = "start_tick"
    }
}

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
    let renderMode: String?
    let scenarioId: String?
    let difficulty: String?
    let tradeStages: [TradeStage]?
    let decisionQuality: String?
    let tradeOutcome: String?

    var isPreviousMistake = false

    let screenTitle: String?
    let text: String?
    let chart: String?
    let direction: String?
    let event: String?
    let order: String?

    let question: String?
    let explanation: String?

    let correctBool: Bool?

    let options: [String]?
    let correctIndex: Int?
    let wrongExplanations: [String?]?

    let pairs: [[String]]?

    let concern: String?

    let template: String?
    let blanks: [Blank]?

    let ingredientOptions: [IngredientOption]?

    let items: [String]?
    let correctOrder: [String]?

    let target: Int?
    let targets: [Int]?
    let level: Double?
    let levelKind: String?

    let targetStart: Int?
    let targetEnd: Int?
    let targetLo: Int?
    let targetHi: Int?

    let numberMin: Double?
    let numberMax: Double?
    let numberStep: Double?
    let numberCorrect: Double?
    let numberTolerance: Double?
    let numberUnit: String?

    enum CodingKeys: String, CodingKey {
        case type, text, question, explanation, options, pairs, template, blanks, direction, event, order, skillId, competencyId, sourceLesson, sourceUnit, sourceNode, questionId, footprintPreview, difficulty
        case scenarioId = "scenario"
        case tradeStages = "stages"
        case decisionQuality = "decision_quality"
        case tradeOutcome = "trade_outcome"
        case renderMode = "render_mode"
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
        renderMode = try c.decodeIfPresent(String.self, forKey: .renderMode)
        scenarioId = try c.decodeIfPresent(String.self, forKey: .scenarioId)
        difficulty = try c.decodeIfPresent(String.self, forKey: .difficulty)
        tradeStages = try c.decodeIfPresent([TradeStage].self, forKey: .tradeStages)
        decisionQuality = try c.decodeIfPresent(String.self, forKey: .decisionQuality)
        tradeOutcome = try c.decodeIfPresent(String.self, forKey: .tradeOutcome)
        screenTitle = try c.decodeIfPresent(String.self, forKey: .screenTitle)
        text = try c.decodeIfPresent(String.self, forKey: .text)
        chart = try c.decodeIfPresent(String.self, forKey: .chart)
        direction = try c.decodeIfPresent(String.self, forKey: .direction)
        event = try c.decodeIfPresent(String.self, forKey: .event)
        order = try c.decodeIfPresent(String.self, forKey: .order)
        question = try c.decodeIfPresent(String.self, forKey: .question)
        explanation = try c.decodeIfPresent(String.self, forKey: .explanation)
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

        wrongExplanations = (try? c.decodeIfPresent([String?].self, forKey: .wrongExplanations)) ?? nil

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

enum RichText {
    static func attributed(_ raw: String, base: Font, bold: Font, color: Color) -> AttributedString {
        var result = AttributedString()
        var remaining = Substring(raw)

        while let open = remaining.range(of: "<b>") {
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
