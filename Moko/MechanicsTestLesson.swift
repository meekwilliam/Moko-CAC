import Foundation

// MARK: - Debug: one lesson exercising every question mechanic
// Built from a hand-authored JSON blob (same shape convert_lessons.py emits)
// and decoded through the real LessonScreen.init(from:) path, so it tests the
// actual production decoding + rendering, not a special-cased shortcut.
// Reachable from Profile → Preferences → "Test All Question Mechanics".

enum MechanicsTestLesson {
    static func build() -> Lesson {
        let screens: [[String: Any]] = [
            [
                "type": "intro",
                "title": "Mechanics Test",
                "text": "One screen per question type, in order. Nothing here is graded content — for checking rendering and gestures only.",
                "chart": "uptrend",
            ],
            [
                "type": "true_false",
                "question": "This is a true_false screen.",
                "correct": true,
                "explanation": "true_false: single True/False choice.",
            ],
            [
                "type": "multiple_choice",
                "question": "This is a multiple_choice screen. Pick the correct option.",
                "options": ["Correct option", "Wrong option A", "Wrong option B"],
                "correct": 0,
                "wrong_explanations": [NSNull(), "Wrong A explanation", "Wrong B explanation"],
                "explanation": "multiple_choice: pick 1 of N options.",
            ],
            [
                "type": "fill_blank",
                "question": "This is a fill_blank screen with a [___] to fill.",
                "options": ["correct word", "wrong word A", "wrong word B"],
                "correct": 0,
                "explanation": "fill_blank: same UI as multiple_choice, phrased as a blank.",
            ],
            [
                "type": "spot_mistake",
                "scenario": "Someone made a mistake in this made-up scenario.",
                "question": "What is the mistake?",
                "options": ["Correct explanation of the mistake", "Wrong take A", "Wrong take B"],
                "correct": 0,
                "explanation": "spot_mistake: a scenario blurb plus a question.",
            ],
            [
                "type": "fill_blank_multi",
                "template": "This is [__1__] and this is [__2__].",
                "blanks": [
                    ["options": ["blank one", "wrong one"], "correct": 0],
                    ["options": ["blank two", "wrong two"], "correct": 0],
                ],
                "explanation": "fill_blank_multi: two independent blanks in one template.",
            ],
            [
                "type": "matching",
                "question": "Match each term to its pair.",
                "pairs": [["Term A", "Match A"], ["Term B", "Match B"], ["Term C", "Match C"]],
                "explanation": "matching: drag/tap pairs until all match.",
            ],
            [
                "type": "sequence_builder",
                "question": "Put these in the correct order.",
                "items": ["Step one", "Step two", "Step three", "Step four"],
                "correct_order": ["Step one", "Step two", "Step three", "Step four"],
                "explanation": "sequence_builder: order 4 items correctly.",
            ],
            [
                "type": "ingredient_match",
                "question": "Pick the best answer.",
                "concern": "Testing this mechanic",
                "options": [
                    ["label": "Correct pick", "detail": "This is the right one", "correct": true],
                    ["label": "Wrong pick A", "wrong_explanation": "Why A is wrong", "correct": false],
                    ["label": "Wrong pick B", "wrong_explanation": "Why B is wrong", "correct": false],
                ],
                "explanation": "ingredient_match (PICK): labeled options with a detail/concern card.",
            ],
            [
                "type": "tap_candle",
                "question": "Tap candle #2 (0-based index 1).",
                "chart": "uptrend",
                "target": 1,
                "explanation": "tap_candle: single tap target on a chart.",
            ],
            [
                "type": "tap_candles",
                "question": "Tap candles #1 and #3 (0-based indices 0 and 2).",
                "chart": "uptrend",
                "targets": [0, 2],
                "explanation": "tap_candles: multi-select tap targets on a chart.",
            ],
            [
                "type": "mark_level",
                "question": "Drag the line to the support level.",
                "chart": "supportBounce",
                "level_kind": "support",
                "explanation": "mark_level: drag a horizontal line to a level.",
            ],
            [
                "type": "draw_trendline",
                "question": "Drag to connect the two higher lows.",
                "chart": "pullbackUptrend",
                "target_start": 0,
                "target_end": 2,
                "explanation": "draw_trendline: drag between two candles to connect them.",
            ],
            [
                "type": "mark_consolidation",
                "question": "Drag across the whole consolidation zone.",
                "chart": "range",
                "target_lo": 0,
                "target_hi": 5,
                "explanation": "mark_consolidation: drag across a contiguous range of candles.",
            ],
            [
                "type": "ohlc_label",
                "question": "Drag Open, High, Low, Close onto the matching part of the candle.",
                "explanation": "ohlc_label: drag 4 labels onto a candle's four levels.",
            ],
            [
                "type": "number_slider",
                "question": "You risk 1% of a $10,000 account with a $0.50 stop distance. Drag to the correct share size.",
                "number_min": 0, "number_max": 500, "number_step": 10,
                "number_correct": 200, "number_tolerance": 10, "number_unit": "shares",
                "explanation": "number_slider: drag to a calculated numeric answer, graded with tolerance.",
            ],
            [
                "type": "draw_trendline",
                "question": "Draw the lower boundary of this ascending channel.",
                "chart": "ascendingChannel",
                "target_start": 0,
                "target_end": 4,
                "explanation": "Chart check: parallel channel boundary lines (labeled CHANNEL).",
            ],
            [
                "type": "tap_candle",
                "question": "Tap the candle where price crosses above the VWAP line.",
                "chart": "priceAboveVWAP",
                "target": 3,
                "explanation": "Chart overlay check: single VWAP line, labeled \"VWAP\" not \"MA\".",
            ],
            [
                "type": "tap_candle",
                "question": "Tap the candle where the fast MA crosses above the slow MA.",
                "chart": "maCrossUp",
                "target": 3,
                "explanation": "Chart overlay check: two overlay lines (fast + slow MA) crossing.",
            ],
            [
                "type": "multiple_choice",
                "question": "Chart overlay check: do the Bollinger Bands look like they're widening here?",
                "chart": "bandsWidening",
                "options": ["Yes, they widen left to right", "No, they narrow", "There are no bands shown"],
                "correct": 0,
                "explanation": "Chart overlay check: shaded band between two lines, widening.",
            ],
            [
                "type": "tap_candle",
                "question": "Tap the candle that stretches out to touch the upper Bollinger Band.",
                "chart": "touchUpperBand",
                "target": 4,
                "explanation": "Chart overlay check: price touching the upper band, mid MA line visible.",
            ],
        ]

        let data = try! JSONSerialization.data(withJSONObject: screens)
        let decoded = try! JSONDecoder().decode([LessonScreen].self, from: data)
        return Lesson(node: -1, title: "Mechanics Test", celebration: "You made it through every mechanic!",
                     featurePromo: nil, screens: decoded)
    }
}
