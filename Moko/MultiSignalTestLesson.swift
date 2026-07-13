import Foundation

// MARK: - Debug: focused multi-signal mechanic lab
// Reachable from Profile → Preferences. It never spends hearts or writes
// progress, and exercises replay/history plus the new card-answer variants.

enum MultiSignalTestLesson {
    static func build() -> Lesson {
        let screens: [[String: Any]] = [
            [
                "type": "trade_decision",
                "event": "seller_absorption",
                "render_mode": "summary",
                "scenario": "seller_absorption",
                "question": "Buyers remain aggressive, but a replenishing offer stalls price. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "explanation": "Possible seller absorption is developing, but rejection and seller control are not confirmed. WAIT.",
            ],
            [
                "type": "trade_decision",
                "event": "seller_absorption",
                "render_mode": "raw_simplified",
                "scenario": "seller_absorption",
                "question": "Buying presses into replenishing sell liquidity without price progress. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "explanation": "Aggression is visible, but neither upside acceptance nor confirmed seller control supports a directional trade.",
            ],
            [
                "type": "trade_decision",
                "event": "conflict",
                "render_mode": "raw_full",
                "scenario": "conflict",
                "question": "Bullish pressure is losing effectiveness as the evidence diverges. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "explanation": "Conflicting pressure and price response leave direction unconfirmed, so WAIT.",
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
                "type": "trade_decision",
                "event": "conflict",
                "render_mode": "raw_full",
                "scenario": "conflict",
                "question": "Directional clues appear, but replenishment and price response disagree. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "explanation": "The read remains unresolved, so neither directional entry is justified yet.",
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
                "type": "trade_decision",
                "scenario": "cvd_warning",
                "question": "Buying fades and CVD fails to confirm the latest high. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "decision_quality": "Directional confirmation is weakening.",
                "trade_outcome": "loss",
                "explanation": "Reducing is the best-supported response because the long thesis has weakened without being fully invalidated.",
            ],
            [
                "type": "trade_decision",
                "scenario": "thin_risk",
                "question": "The spread widens as price jumps through thin depth. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "explanation": "Execution risk is too unstable to justify either directional entry, so WAIT.",
            ],
            [
                "type": "trade_decision",
                "scenario": "breakdown_pressure",
                "question": "Seller pressure regains control and price accepts below support. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 1,
                "explanation": "Renewed seller aggression and downside acceptance align for SHORT.",
            ],
        ]

        let data = try! JSONSerialization.data(withJSONObject: screens)
        let decoded = try! JSONDecoder().decode([LessonScreen].self, from: data)
        return Lesson(node: -2, title: "Multi Signal Read Lab",
                      celebration: "Multi signal mechanic test complete.", featurePromo: nil,
                      lessonType: "TEST_OUT", screens: decoded)
    }
}
