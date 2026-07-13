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
                "render_mode": "summary",
                "question": "What's the strongest current read?",
                "options": ["Possible seller absorption", "Clean upside acceptance", "Buyer aggression has disappeared"],
                "correct": 0,
                "explanation": "Aggressive buying remains active while a replenishing offer limits upward price progress.",
            ],
            [
                "type": "orderflow_sim",
                "event": "seller_absorption",
                "render_mode": "raw_simplified",
                "question": "What does the combined evidence suggest?",
                "options": ["Possible seller absorption", "Clean upside acceptance", "Not enough market data is visible"],
                "correct": 0,
                "explanation": "The simplified chart, DOM, tape, and footprint show buying pressing into replenishing sell liquidity without matching price progress.",
            ],
            [
                "type": "orderflow_sim",
                "event": "conflict",
                "render_mode": "raw_full",
                "question": "What's strongest?",
                "options": ["Evidence conflicts, so direction is not confirmed", "Buyer continuation is fully confirmed", "The footprint should override price"],
                "correct": 0,
                "explanation": "The denser synchronized board contains both bullish pressure and evidence that the pressure is losing effectiveness.",
            ],
            [
                "type": "orderflow_sim_tap",
                "event": "conflict",
                "render_mode": "raw_full",
                "question": "Tap the evidence that most clearly conflicts with the bullish stack.",
                "target": 3,
                "explanation": "The footprint's price-pressure disagreement conflicts with thinning offers, buyer tape, and price above VWAP.",
            ],
            [
                "type": "orderflow_sim_select",
                "event": "seller_absorption",
                "render_mode": "raw_simplified",
                "question": "Select the two clues that best support possible seller absorption.",
                "targets": [0, 1],
                "explanation": "Stalled price and a refreshing offer together show aggressive buying failing to gain progress.",
            ],
            [
                "type": "orderflow_sim_tap",
                "event": "thin_risk",
                "render_mode": "raw_full",
                "question": "Tap the evidence source showing the clearest execution risk.",
                "target": 1,
                "explanation": "Small nearby depth and gaps in Level II create the clearest immediate slippage risk.",
            ],
            [
                "type": "orderflow_sim",
                "event": "conflict",
                "render_mode": "raw_full",
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
            [
                "type": "trade_decision",
                "skillId": "trade_decision_quality",
                "difficulty": "advanced",
                "render_mode": "raw_full",
                "scenario": "seller_absorption_developing",
                "question": "The market is evolving. What's the best-supported decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "wrong_explanations": [
                    "Buyer aggression is visible, but price has not confirmed control through the replenishing offer.",
                    "Seller absorption may be developing, but rejection and seller control are not confirmed yet.",
                    NSNull(),
                ],
                "explanation": "Buyers remain aggressive, but a replenishing offer limits progress. Waiting separates a developing clue from confirmed direction.",
            ],
            [
                "type": "trade_scenario",
                "skillId": "trade_decision_quality",
                "difficulty": "expert",
                "render_mode": "raw_full",
                "scenario": "breakout_acceptance_sequence",
                "stages": [
                    ["prompt": "Price reaches resistance. What's your decision?", "correct": 2,
                     "options": ["LONG", "SHORT", "WAIT"], "start_tick": 0,
                     "explanation": "The setup is developing, but no break has occurred."],
                    ["prompt": "Price breaks resistance but has not held. What's your decision?", "correct": 2,
                     "options": ["LONG", "SHORT", "WAIT"], "start_tick": 6,
                     "explanation": "A break without acceptance is not enough confirmation."],
                    ["prompt": "The retest holds and buyer aggression resumes. What's your decision?", "correct": 0,
                     "options": ["LONG", "SHORT", "WAIT"], "start_tick": 12,
                     "explanation": "Acceptance, a successful retest, renewed aggression, and price response now align."],
                ],
                "explanation": "Each decision is graded from the evidence visible at that stage.",
            ],
            [
                "type": "trade_manage",
                "scenario": "cvd_warning",
                "question": "You are long. Buying fades and CVD fails to confirm the latest high. What now?",
                "options": ["HOLD", "EXIT", "REDUCE", "WAIT FOR MORE EVIDENCE"],
                "correct": 2,
                "decision_quality": "Risk is increasing while confirmation weakens.",
                "trade_outcome": "loss",
                "explanation": "Reducing is the best-supported response because the long thesis has weakened without being fully invalidated.",
            ],
            [
                "type": "entry_select",
                "scenario": "thin_risk",
                "question": "The spread widens as price jumps through thin depth. Which entry is best supported?",
                "options": ["MARKET", "LIMIT", "NO ENTRY"],
                "correct": 2,
                "explanation": "Execution risk is too unstable. No entry is stronger than forcing an order into widening spread and sparse depth.",
            ],
            [
                "type": "invalidation_mark",
                "scenario": "breakout",
                "question": "You are long after acceptance. Tap the level whose loss invalidates the read.",
                "options": ["101.40 extension", "101.00 reclaimed resistance", "100.65 distant swing low"],
                "correct": 1,
                "explanation": "Losing the reclaimed resistance removes the acceptance evidence supporting the long thesis.",
            ],
        ]

        let data = try! JSONSerialization.data(withJSONObject: screens)
        let decoded = try! JSONDecoder().decode([LessonScreen].self, from: data)
        return Lesson(node: -2, title: "Multi Signal Read Lab",
                      celebration: "Multi signal mechanic test complete.", featurePromo: nil,
                      lessonType: "TEST_OUT", screens: decoded)
    }
}
