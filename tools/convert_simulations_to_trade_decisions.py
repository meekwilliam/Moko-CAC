#!/usr/bin/env python3
"""Turn every full-board interpretation prompt into LONG / SHORT / WAIT.

The simulator UI stays untouched. Generic tap/select evidence mechanics remain
generic because they use their own answer surfaces rather than the full board.
"""

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "Moko" / "GameData.json"
MARKDOWN = ROOT / "LESSONS_ORDERFLOW.md"

OPTIONS = ["LONG", "SHORT", "WAIT"]

SCENARIOS = {
    "breakout": (
        0,
        [
            "Buyers clear offers and price holds higher. What's your decision?",
            "Buyer aggression continues after price accepts above the level. What's your decision?",
            "Offers thin, buyer prints persist, and price keeps its upward progress. What's your decision?",
        ],
        "Buyer aggression is producing price progress and holding beyond the level, so LONG is the best-supported decision.",
    ),
    "low_volume_trend": (
        0,
        [
            "Price trends higher through thin opposing liquidity. What's your decision?",
            "Shallow pullbacks hold as steady buying moves through sparse offers. What's your decision?",
            "Price responds efficiently to persistent buying while offers remain thin. What's your decision?",
        ],
        "Persistent buying, efficient price response, and little opposing liquidity support LONG despite modest volume.",
    ),
    "seller_loses_control": (
        0,
        [
            "Selling stops making progress and buyers begin lifting price. What's your decision?",
            "Seller pace fades, support holds, and buyer pressure begins moving price. What's your decision?",
            "The prior sellers lose control as buyers produce a confirming response. What's your decision?",
        ],
        "Seller pressure has failed and buyers are now producing a confirming price response, supporting LONG.",
    ),
    "breakdown_pressure": (
        1,
        [
            "Sellers consume bids and price accepts below support. What's your decision?",
            "Seller prints persist as bids withdraw and price holds below the level. What's your decision?",
            "Selling continues after the break and downside price progress holds. What's your decision?",
        ],
        "Persistent seller aggression and acceptance below support align for SHORT.",
    ),
    "seller_absorption": (
        2,
        [
            "Buyers remain aggressive, but a refreshing offer stalls price. What's your decision?",
            "Positive pressure builds while resistance holds and the offer replenishes. What's your decision?",
            "Buyer prints continue without matching upward price progress. What's your decision?",
        ],
        "Buyer aggression is not producing acceptance, but seller control is not confirmed yet. WAIT is best supported.",
    ),
    "seller_absorption_developing": (
        2,
        [
            "Buyers remain aggressive, but a refreshing offer stalls price. What's your decision?",
            "Buying keeps hitting a replenishing offer without gaining progress. What's your decision?",
            "Positive delta grows while price remains pinned below resistance. What's your decision?",
        ],
        "Possible seller absorption is developing, but rejection and seller control are not confirmed. WAIT.",
    ),
    "buyer_absorption": (
        2,
        [
            "Sellers remain aggressive, but a refreshing bid holds support. What's your decision?",
            "Negative pressure builds while support holds and the bid replenishes. What's your decision?",
            "Seller prints continue without matching downward price progress. What's your decision?",
        ],
        "Seller aggression is failing to move price lower, but buyer control is not confirmed yet. WAIT is best supported.",
    ),
    "sweep": (
        2,
        [
            "Price sweeps above resistance and returns below it, but seller follow-through is still developing. What's your decision?",
            "The upside break fails to hold while opposing control remains unconfirmed. What's your decision?",
            "Liquidity is taken above the level and price returns inside. What's your decision?",
        ],
        "The failed hold weakens buyers, but a SHORT still needs confirmed seller control. WAIT.",
    ),
    "downside_sweep": (
        2,
        [
            "Price sweeps below support and reclaims it, but buyer follow-through is still developing. What's your decision?",
            "The downside break fails to hold while opposing control remains unconfirmed. What's your decision?",
            "Liquidity is taken below the level and price returns inside. What's your decision?",
        ],
        "The reclaim weakens sellers, but a LONG still needs confirmed buyer control. WAIT.",
    ),
    "iceberg": (
        2,
        [
            "Repeated buys execute into an offer that keeps replenishing. What's your decision?",
            "Displayed ask size refills as buyer executions accumulate at one price. What's your decision?",
            "An apparent iceberg absorbs repeated buying while price stays pinned. What's your decision?",
        ],
        "Hidden sell liquidity may be absorbing buyers, but direction is not confirmed. WAIT.",
    ),
    "chop": (
        2,
        [
            "Heavy two-sided execution produces little directional progress. What's your decision?",
            "Fast buying and selling rotate inside a range while both sides replenish. What's your decision?",
            "Volume stays high, delta stays balanced, and price remains trapped. What's your decision?",
        ],
        "High-volume chop does not establish directional control, so WAIT is the strongest decision.",
    ),
    "cvd_warning": (
        2,
        [
            "Price holds higher, but CVD fails to confirm the latest high. What's your decision?",
            "Offers thin while price and cumulative delta disagree. What's your decision?",
            "Price remains above resistance as CVD forms a lower high. What's your decision?",
        ],
        "The breakout evidence and CVD disagreement conflict, so WAIT for clearer confirmation.",
    ),
    "volume_profile_context": (
        2,
        [
            "Buying increases at the POC, but the offer replenishes and price stalls. What's your decision?",
            "Price reaches a high-volume area where buyer aggression stops producing progress. What's your decision?",
            "The POC provides location, but execution and price response remain conflicted. What's your decision?",
        ],
        "The profile gives location, but the developing absorption does not yet confirm direction. WAIT.",
    ),
    "thin_risk": (
        2,
        [
            "Nearby depth is sparse and the spread widens during execution. What's your decision?",
            "Price jumps between thin levels while fill quality becomes unstable. What's your decision?",
            "The book thins and slippage risk rises as the setup develops. What's your decision?",
        ],
        "Unstable depth and widening execution risk make WAIT the best-supported trade decision.",
    ),
    "exit_liquidity": (
        2,
        [
            "Price reaches opposing liquidity, but the next directional response is not confirmed. What's your decision?",
            "Available counterparties appear near resistance while displayed depth remains changeable. What's your decision?",
            "Price tests a planned liquidity area without a confirmed new directional read. What's your decision?",
        ],
        "The liquidity can help execution planning, but it does not confirm a new directional entry. WAIT.",
    ),
    "conflict": (
        2,
        [
            "Aggression, liquidity, and price response still disagree. What's your decision?",
            "Buyer pressure appears, but replenishment and weak price response contradict it. What's your decision?",
            "The tape is directional while the book, footprint, and price response remain conflicted. What's your decision?",
        ],
        "The evidence stack does not establish control in either direction, so WAIT.",
    ),
    "championship": (
        2,
        [
            "Buyer aggression meets a refreshing offer while price makes little progress. What's your decision?",
            "Positive delta builds, but resistance holds and the offer keeps replenishing. What's your decision?",
            "The final evidence stack shows aggression without confirming price response. What's your decision?",
        ],
        "Possible seller absorption is visible, but no confirmed rejection or seller control supports a SHORT yet. WAIT.",
    ),
}


def rubric(event, ordinal):
    correct, prompts, explanation = SCENARIOS.get(event, SCENARIOS["conflict"])
    prompt = prompts[ordinal % len(prompts)]
    if correct == 0:
        wrong = [None, "Seller control is not supported by the current evidence.", "Waiting ignores the aligned aggression and price confirmation."]
    elif correct == 1:
        wrong = ["Buyer control is not supported by the current evidence.", None, "Waiting ignores the aligned selling and downside acceptance."]
    else:
        wrong = ["A LONG needs confirmed buyer control and effective upward price response.", "A SHORT needs confirmed seller control and effective downward price response.", None]
    return prompt, correct, explanation, wrong


def convert(screen, ordinal):
    event = screen.get("scenario") or screen.get("event") or "conflict"
    prompt, correct, explanation, wrong = rubric(event, ordinal)
    screen["type"] = "trade_decision"
    screen["scenario"] = event
    screen["render_mode"] = "raw_full"
    screen["difficulty"] = screen.get("difficulty", "advanced")
    screen["skillId"] = "trade_decision_quality"
    screen["question"] = prompt
    screen["options"] = OPTIONS
    screen["correct"] = correct
    screen["wrong_explanations"] = wrong
    screen["explanation"] = explanation
    screen["decision_quality"] = explanation
    return event, prompt, correct, explanation


def replace_markdown(text, node, old_question, event, prompt, correct, explanation, old_tag="ORDERFLOW_SIM"):
    node_start = text.find(f"\nNODE {node}\n")
    if node_start < 0:
        raise RuntimeError(f"Missing node {node}")
    node_end = text.find("\nNODE ", node_start + 1)
    if node_end < 0:
        node_end = len(text)
    token = f"[{old_tag}] {old_question}\n"
    start = text.find(token, node_start, node_end)
    if start < 0:
        raise RuntimeError(f"Missing {old_tag} block in node {node}: {old_question}")
    end = text.find("\n\n", start)
    answer = OPTIONS[correct]
    block = (
        f"[TRADE_DECISION] {prompt}\n"
        "VISUAL: The full synchronized Trade Decision board shows Price and Context, DOM and Tape, and Footprint and Delta evolving from one market event.\n"
        "SKILL: trade_decision_quality\n"
        f"SCENARIO: {event}\n"
        "LONG\nSHORT\nWAIT\n"
        f"ANSWER: {answer}\n"
        f"WHY: {explanation}"
    )
    return text[:start] + block + text[end:]


def main():
    data = json.loads(DATA.read_text())
    course = next(item for item in data["courses"] if item["id"] == "orderflow")
    markdown = MARKDOWN.read_text()
    ordinal = 0

    for lesson in course["lessons"]:
        for screen in lesson["screens"]:
            old_type = screen.get("type")
            if old_type == "orderflow_sim":
                old_question = screen["question"]
                event, prompt, correct, explanation = convert(screen, ordinal)
                markdown = replace_markdown(markdown, lesson["node"], old_question, event, prompt, correct, explanation)
                ordinal += 1
            elif old_type in {"trade_manage", "entry_select", "invalidation_mark"}:
                old_question = screen["question"]
                event, prompt, correct, explanation = convert(screen, ordinal)
                markdown = replace_markdown(markdown, lesson["node"], old_question, event, prompt,
                                            correct, explanation, old_tag=old_type.upper())
                ordinal += 1

    for test_out in course.get("testOuts", []):
        for screen in test_out.get("questionPool", []):
            if screen.get("type") == "orderflow_sim":
                convert(screen, ordinal)
                ordinal += 1

    DATA.write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n")
    MARKDOWN.write_text(markdown)
    print(f"Converted {ordinal} full-board questions to TRADE_DECISION")


if __name__ == "__main__":
    main()
