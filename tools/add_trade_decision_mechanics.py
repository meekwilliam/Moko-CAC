#!/usr/bin/env python3
"""Convert selected late-course simulations into scored trade decisions."""

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "Moko" / "GameData.json"
MARKDOWN = ROOT / "LESSONS_ORDERFLOW.md"


def decision(question, scenario, answer, why, wrong, *, kind="trade_decision", options=None, outcome=None):
    result = {
        "type": kind,
        "skillId": "trade_decision_quality",
        "difficulty": "expert" if kind != "trade_decision" else "advanced",
        "render_mode": "raw_full",
        "scenario": scenario,
        "question": question,
        "options": options or ["LONG", "SHORT", "WAIT"],
        "correct": answer,
        "wrong_explanations": wrong,
        "explanation": why,
        "decision_quality": why,
    }
    if outcome:
        result["trade_outcome"] = outcome
    return result


def scenario():
    return {
        "type": "trade_scenario",
        "skillId": "trade_decision_quality",
        "difficulty": "expert",
        "render_mode": "raw_full",
        "scenario": "breakout_acceptance_sequence",
        "stages": [
            {
                "prompt": "Price reaches resistance. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "start_tick": 0,
                "wrong_explanations": [
                    "Buyer activity is increasing, but resistance has not broken.",
                    "Resistance is present, but sellers have not confirmed control.",
                    None,
                ],
                "explanation": "The setup is developing, but no breakout or rejection has occurred.",
            },
            {
                "prompt": "Price breaks resistance but has not held. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 2,
                "start_tick": 6,
                "wrong_explanations": [
                    "A break without acceptance can still fail.",
                    "The break has not failed or returned below resistance yet.",
                    None,
                ],
                "explanation": "The break is visible, but acceptance beyond resistance is not confirmed.",
            },
            {
                "prompt": "The retest holds and buyer aggression resumes. What's your decision?",
                "options": ["LONG", "SHORT", "WAIT"],
                "correct": 0,
                "start_tick": 12,
                "wrong_explanations": [
                    None,
                    "Sellers failed to reclaim resistance while buyers regained pressure.",
                    "Waiting now ignores the aligned acceptance, retest, aggression, and price response.",
                ],
                "explanation": "Acceptance, a successful retest, renewed aggression, and price response align for a long decision.",
            },
        ],
        "explanation": "Each decision is graded from the evidence visible at that stage, not the later trade outcome.",
    }


def replace_screen(lessons, node, index, value):
    lesson = next(item for item in lessons if item["node"] == node)
    lesson["screens"][index] = value


def markdown_block(tag, question, lines):
    return f"[{tag}] {question}\n" + "\n".join(lines) + "\n"


def replace_markdown_block(text, node, old_tag, old_question, replacement):
    start_token = f"[{old_tag}] {old_question}\n"
    node_start = text.find(f"\nNODE {node}\n")
    if node_start < 0:
        raise RuntimeError(f"Missing Markdown node: {node}")
    node_end = text.find("\nNODE ", node_start + 1)
    if node_end < 0:
        node_end = len(text)
    start = text.find(start_token, node_start, node_end)
    if start < 0:
        return text
    end = text.find("\n\n", start)
    if end < 0:
        raise RuntimeError(f"Unterminated Markdown block: {old_question}")
    return text[:start] + replacement.rstrip() + text[end:]


def main():
    data = json.loads(DATA.read_text())
    course = next(course for course in data["courses"] if course["id"] == "orderflow")
    lessons = course["lessons"]

    conversions = [
        (41, 3, decision(
            "The prior low is swept and reclaimed, but buyer control is still developing. What's your decision?",
            "downside_sweep", 2,
            "The reclaim weakens the breakdown, but stronger buyer follow through is still needed before a long.",
            ["The reclaim is constructive, but buyer control is not confirmed.", "Price failed to accept below the low, so a short is no longer best supported.", None])),
        (49, 0, decision(
            "Price holds above resistance after offers are consumed. What's your decision?",
            "breakout", 0,
            "Buyer aggression, acceptance above resistance, and continued price response align for a long decision.",
            [None, "Sellers have not reclaimed the broken level.", "Acceptance and continued buyer pressure provide enough confirmation to act."])),
        (52, 3, decision(
            "Fast buying hits a replenishing offer while price stalls. What's your decision?",
            "seller_absorption_developing", 2,
            "Buying is aggressive, but neither upside acceptance nor confirmed seller control is present.",
            ["Aggression alone does not confirm a long while price cannot advance.", "Absorption may be developing, but rejection and seller control are not confirmed.", None])),
        (54, 7, scenario()),
        (64, 6, decision(
            "Book, tape, footprint, and price response still conflict. What's your decision?",
            "conflict", 2,
            "Conflicting evidence leaves neither direction sufficiently confirmed.",
            ["Bullish clues are being contradicted by replenishment and weak response.", "Seller control is not confirmed either.", None])),
        (66, 0, decision(
            "The breakout fails, price returns below resistance, and sellers begin hitting bids. What's your decision?",
            "sweep", 1,
            "Failed acceptance and confirmed seller response align for a short decision.",
            ["Buyers failed to hold the breakout and lost control.", None, "The return below resistance and seller pressure provide confirmation beyond a developing trap."])),
        (70, 5, decision(
            "You are long after a bullish reversal. Tap the level whose loss invalidates the read.",
            "breakdown_pressure", 1,
            "Losing reclaimed support with renewed seller acceptance invalidates the bullish control change.",
            ["The extension target does not define the thesis.", None, "A distant level gives the failed read too much room."],
            kind="invalidation_mark",
            options=["101.35 extension", "100.90 reclaimed support", "100.45 distant swing low"])),
        (72, 1, decision(
            "The spread widens and nearby depth becomes unstable. Which entry is best supported?",
            "thin_risk", 2,
            "No entry is best while fill quality and slippage risk are unstable.",
            ["A market order accepts the worst execution risk in this thin book.", "A limit controls price but does not make the unstable setup worth entering.", None],
            kind="entry_select", options=["MARKET", "LIMIT", "NO ENTRY"])),
        (76, 0, decision(
            "You are long into resistance as buying slows and the offer replenishes. What now?",
            "exit_liquidity", 1,
            "Exiting into available liquidity is best supported as buying weakens at the planned resistance area.",
            ["Holding ignores deteriorating pressure at the planned exit.", None, "Reducing leaves exposure after the exit evidence has fully aligned.", "More evidence is unnecessary once the planned exit condition is met."],
            kind="trade_manage", options=["HOLD", "EXIT", "REDUCE", "WAIT FOR MORE EVIDENCE"], outcome="profit")),
        (78, 8, decision(
            "The final evidence stack remains conflicted. What's your decision?",
            "conflict", 2,
            "Expert execution includes staying out when the evidence does not establish control.",
            ["Buyer aggression is contradicted by the price response.", "Possible absorption is not yet confirmed seller control.", None])),
    ]

    for node, index, value in conversions:
        replace_screen(lessons, node, index, value)

    DATA.write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n")

    text = MARKDOWN.read_text()
    mechanics_anchor = "  [ORDERFLOW_SIM] Combine book, tape, footprint, and price response.\n"
    additions = (
        "  [TRADE_DECISION] Read synchronized raw evidence and choose LONG, SHORT, or WAIT.\n"
        "  [TRADE_SCENARIO] Make several decisions during one continuous market replay.\n"
        "  [TRADE_MANAGE] Manage an open position from evolving evidence.\n"
        "  [ENTRY_SELECT] Choose MARKET, LIMIT, or NO ENTRY from execution conditions.\n"
        "  [INVALIDATION_MARK] Tap the price level that invalidates the current hypothesis.\n"
    )
    if additions not in text:
        text = text.replace(mechanics_anchor, mechanics_anchor + additions)

    markdown_replacements = [
        (41, "Price trades below the prior low and immediately reclaims it. Is this a downside sweep or acceptance?", "TRADE_DECISION", conversions[0][2]),
        (49, "Offers are consumed and price holds beyond resistance. What is strongest?", "TRADE_DECISION", conversions[1][2]),
        (52, "Fast buying appears, but the offer refreshes and price stalls. Is breakout acceptance confirmed?", "TRADE_DECISION", conversions[2][2]),
        (54, "What's the strongest read?", "TRADE_SCENARIO", conversions[3][2]),
        (64, "What's the best conclusion?", "TRADE_DECISION", conversions[4][2]),
        (66, "What shows buyers became trapped?", "TRADE_DECISION", conversions[5][2]),
        (70, "Which event would invalidate the bullish reversal hypothesis?", "INVALIDATION_MARK", conversions[6][2]),
        (72, "Price approaches a trigger as the spread widens and nearby depth changes. How should order choice be interpreted?", "ENTRY_SELECT", conversions[7][2]),
        (76, "What does the evidence support?", "TRADE_MANAGE", conversions[8][2]),
        (78, "Is direction confirmed?", "TRADE_DECISION", conversions[9][2]),
    ]

    for node, old_question, tag, value in markdown_replacements:
        if tag == "TRADE_SCENARIO":
            lines = ["SKILL: trade_decision_quality", "DIFFICULTY: expert", "SCENARIO: breakout_acceptance_sequence"]
            for number, stage in enumerate(value["stages"], 1):
                lines += [f"STAGE {number}", f"PROMPT: {stage['prompt']}", f"ANSWER: {stage['options'][stage['correct']]}", f"WHY: {stage['explanation']}"]
            replacement = markdown_block(tag, "Read the breakout as it develops.", lines)
        else:
            lines = ["SKILL: trade_decision_quality", f"SCENARIO: {value['scenario']}"]
            lines += value["options"]
            lines += [f"ANSWER: {value['options'][value['correct']]}", f"WHY: {value['explanation']}"]
            replacement = markdown_block(tag, value["question"], lines)
        text = replace_markdown_block(text, node, "ORDERFLOW_SIM", old_question, replacement)

    MARKDOWN.write_text(text)


if __name__ == "__main__":
    main()
