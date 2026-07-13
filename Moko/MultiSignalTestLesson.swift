import Foundation

// MARK: - Debug: focused multi-signal mechanic lab
// Reachable from Profile → Preferences. It never spends hearts or writes
// progress, and exercises replay/history plus the new card-answer variants.

enum MultiSignalTestLesson {
    static func build() -> Lesson {
        let screens: [[String: Any]] = [
            [
                "type": "orderflow_sim",
                "event": "seller_absorption",
                "question": "What's the strongest current read?",
                "options": ["Possible seller absorption", "Clean upside acceptance", "Buyer aggression has disappeared"],
                "correct": 0,
                "explanation": "Aggressive buying remains active while a replenishing offer limits upward price progress.",
            ],
            [
                "type": "orderflow_sim_tap",
                "event": "conflict",
                "question": "Tap the evidence that most clearly conflicts with the bullish stack.",
                "target": 3,
                "explanation": "The footprint's price-pressure disagreement conflicts with thinning offers, buyer tape, and price above VWAP.",
            ],
            [
                "type": "orderflow_sim_select",
                "event": "seller_absorption",
                "question": "Select the two clues that best support possible seller absorption.",
                "targets": [0, 1],
                "explanation": "Stalled price and a refreshing offer together show aggressive buying failing to gain progress.",
            ],
            [
                "type": "orderflow_sim_tap",
                "event": "thin_risk",
                "question": "Tap the evidence source showing the clearest execution risk.",
                "target": 1,
                "explanation": "Small nearby depth and gaps in Level II create the clearest immediate slippage risk.",
            ],
            [
                "type": "orderflow_sim",
                "event": "conflict",
                "question": "How strong is the current directional read?",
                "options": ["Developing, but not confirmed", "Strong and fully confirmed", "The first signal cannot be contradicted", "No evidence is available"],
                "correct": 0,
                "explanation": "Several directional clues appear, but replenishment and weakening price response keep the read unresolved.",
            ],
            [
                "type": "sequence_builder",
                "question": "Reconstruct the seller absorption sequence you watched.",
                "items": ["Large offer appears", "Buyers repeatedly execute into it", "Offer replenishes", "Price stalls"],
                "correct_order": ["Large offer appears", "Buyers repeatedly execute into it", "Offer replenishes", "Price stalls"],
                "explanation": "The read develops from visible liquidity through execution, replenishment, and the final price response.",
            ],
        ]

        let data = try! JSONSerialization.data(withJSONObject: screens)
        let decoded = try! JSONDecoder().decode([LessonScreen].self, from: data)
        return Lesson(node: -2, title: "Multi Signal Read Lab",
                      celebration: "Multi signal mechanic test complete.", featurePromo: nil,
                      lessonType: "TEST_OUT", screens: decoded)
    }
}
