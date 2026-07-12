#!/usr/bin/env python3
"""Expand the Order Flow course with a deterministic visual curriculum."""

import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "Moko" / "GameData.json"
MARKDOWN_PATH = ROOT / "LESSONS_ORDERFLOW.md"


def lesson(title, chart, bias, clue, signal):
    return {
        "title": title,
        "chart": chart,
        "bias": bias,
        "clue": clue,
        "signal": signal,
    }


UNITS = [
    {
        "eyebrow": "STRATEGY · UNIT 3",
        "title": "Tape Reading",
        "bg": "#8B5CF6",
        "slab": "#6D28D9",
        "tier": "Strategy",
        "lessons": [
            lesson("Reading the Tape", "sideways", "neutral", "executed trades", "Prints reveal completed trades"),
            lesson("Trade Speed", "volatile", "up", "faster prints", "Faster prints can reveal rising activity"),
            lesson("Trade Size", "marubozu", "up", "larger trades", "Larger trades can show stronger participation"),
            lesson("Repeated Prints", "uptrend", "up", "repeated buying", "Repeated buys can show persistent demand"),
            lesson("Buyer Initiated Prints", "priceAboveVWAP", "up", "ask prints", "Trades at the ask suggest buyer aggression"),
            lesson("Seller Initiated Prints", "priceBelowVWAP", "down", "bid prints", "Trades at the bid suggest seller aggression"),
            lesson("Pace Changes", "bandsWidening", "up", "rising pace", "A faster pace can precede expansion"),
            lesson("Tape at Key Levels", "resistanceRejection", "down", "reaction at resistance", "Tape reaction matters most near key levels"),
            lesson("False Urgency", "spinningTop", "neutral", "follow through", "Fast prints need price confirmation"),
            lesson("Tape Reading Review", "volatile", "neutral", "pace and direction", "Read pace, size, direction, and response together"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 4",
        "title": "Absorption and Exhaustion",
        "bg": "#EC4899",
        "slab": "#BE185D",
        "tier": "Strategy",
        "lessons": [
            lesson("What Is Absorption", "sideways", "neutral", "price holding", "Absorption appears when pressure fails to move price"),
            lesson("Buyer Absorption", "supportBounce", "up", "bids holding", "Buyers absorb selling near support"),
            lesson("Seller Absorption", "resistanceRejection", "down", "offers holding", "Sellers absorb buying near resistance"),
            lesson("Repeated Tests", "doubleBottom", "up", "level survival", "A level that survives tests may contain absorption"),
            lesson("Hidden Liquidity", "range", "neutral", "replenishing size", "Refreshing liquidity can hide true available size"),
            lesson("What Is Exhaustion", "doji", "neutral", "slowing aggression", "Exhaustion appears when aggressive pressure fades"),
            lesson("Buyer Exhaustion", "shootingStar", "down", "weaker buying", "Fading buyers can stall an advance"),
            lesson("Seller Exhaustion", "hammer", "up", "weaker selling", "Fading sellers can stall a decline"),
            lesson("Absorption or Exhaustion", "spinningTop", "neutral", "price response", "Price response separates absorption from exhaustion"),
            lesson("Absorption Review", "rejectionWickDown", "up", "pressure without movement", "Strong pressure with little movement suggests absorption"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 5",
        "title": "Imbalances and Momentum",
        "bg": "#F59E0B",
        "slab": "#B45309",
        "tier": "Strategy",
        "lessons": [
            lesson("Order Imbalance", "volatile", "up", "uneven aggression", "Imbalance means one side is more aggressive"),
            lesson("Buyer Imbalance", "uptrend", "up", "offers consumed", "Buyer imbalance can push price higher"),
            lesson("Seller Imbalance", "downtrend", "down", "bids consumed", "Seller imbalance can push price lower"),
            lesson("Momentum Ignition", "breakout", "up", "sudden aggression", "Sudden aggression can ignite momentum"),
            lesson("Momentum Continuation", "bullFlag", "up", "renewed buying", "Renewed buying can continue momentum"),
            lesson("Momentum Failure", "shootingStar", "down", "lost follow through", "Momentum weakens when price stops responding"),
            lesson("Stacked Pressure", "marubozu", "up", "pressure across levels", "Pressure across several levels strengthens the move"),
            lesson("Delta Thinking", "bandsWidening", "up", "net aggression", "Net aggression compares buying with selling"),
            lesson("Price and Pressure Divergence", "bearishEngulfing", "down", "pressure disagreement", "Price and pressure disagreement warns of weakness"),
            lesson("Imbalance Review", "maCrossUp", "up", "sustained aggression", "Sustained imbalance matters more than one burst"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 6",
        "title": "Liquidity and Sweeps",
        "bg": "#06B6D4",
        "slab": "#0E7490",
        "tier": "Strategy",
        "lessons": [
            lesson("Liquidity Pools", "range", "neutral", "clustered orders", "Liquidity often gathers near obvious levels"),
            lesson("Resting Stops", "supportBounce", "down", "inferred stop clusters beyond obvious levels", "Traders often infer that stops may cluster beyond obvious support resistance highs and lows"),
            lesson("Buy Stops", "breakout", "up", "stops above resistance", "Buy stops can fuel an upside break"),
            lesson("Sell Stops", "breakdown", "down", "stops below support", "Sell stops can fuel a downside break"),
            lesson("Liquidity Sweep", "rejectionWickDown", "up", "quick level breach", "A sweep takes liquidity then returns"),
            lesson("Upside Sweep", "rejectionWickUp", "down", "failed push above", "An upside sweep can trap late buyers"),
            lesson("Downside Sweep", "hammer", "up", "failed push below", "A downside sweep can trap late sellers"),
            lesson("Sweep or Breakout", "breakoutRetest", "up", "acceptance beyond level", "Acceptance beyond a level supports a breakout"),
            lesson("Thin Liquidity", "gapUp", "up", "few nearby orders", "Thin liquidity lets price travel quickly"),
            lesson("Liquidity Review", "volatile", "neutral", "location and response", "Judge liquidity events by location and response"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 7",
        "title": "Breakouts and Failures",
        "bg": "#22C55E",
        "slab": "#15803D",
        "tier": "Strategy",
        "lessons": [
            lesson("Breakout Pressure", "breakout", "up", "offers consumed withdrawn or thin", "An upside breakout can develop as buyers consume offers sellers withdraw liquidity or both"),
            lesson("Breakdown Pressure", "breakdown", "down", "bids consumed withdrawn or thin", "A downside break can develop as sellers consume bids buyers withdraw liquidity or both"),
            lesson("Acceptance Above", "breakoutRetest", "up", "price holding above", "Holding above a level shows acceptance"),
            lesson("Acceptance Below", "breakdownRetest", "down", "price holding below", "Holding below a level shows acceptance"),
            lesson("Failed Breakout", "resistanceRejection", "down", "return below resistance", "A quick return below resistance signals failure"),
            lesson("Failed Breakdown", "supportBounce", "up", "return above support", "A quick return above support signals failure"),
            lesson("Breakout Retest", "breakoutRetest", "up", "support on retest", "A defended retest can confirm a breakout"),
            lesson("Breakdown Retest", "breakdownRetest", "down", "resistance on retest", "A rejected retest can confirm a breakdown"),
            lesson("Chasing Breakouts", "gapUp", "neutral", "entry distance", "Late entries carry worse risk and reward"),
            lesson("Breakout Review", "ascendingTriangle", "up", "pressure and acceptance", "Combine pressure, level break, and acceptance"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 8",
        "title": "Pullbacks and Continuation",
        "bg": "#6366F1",
        "slab": "#4338CA",
        "tier": "Strategy",
        "lessons": [
            lesson("Healthy Pullbacks", "pullbackUptrend", "up", "lighter selling", "A healthy pullback shows weaker counter pressure"),
            lesson("Pullback Depth", "ascendingChannel", "up", "defended structure", "Shallow defended pullbacks show trend strength"),
            lesson("Seller Pullback", "lowerHighsDowntrend", "down", "lighter buying", "A bearish pullback shows weaker buying"),
            lesson("Continuation Trigger", "bullFlag", "up", "buyers return", "Continuation begins when trend pressure returns"),
            lesson("Bearish Continuation", "bearFlag", "down", "sellers return", "Bearish continuation begins when sellers return"),
            lesson("Order Flow at VWAP", "priceAboveVWAP", "up", "response as price tests VWAP", "VWAP provides location while order flow determines the response"),
            lesson("Order Flow at a Moving Average", "priceAboveMA", "up", "aggression near the average", "The average provides location but execution evidence determines the read"),
            lesson("Pullback Failure", "bearishEngulfing", "down", "counter pressure grows", "Strong counter pressure can end continuation"),
            lesson("Entry After Confirmation", "breakoutRetest", "up", "pressure returns", "Wait for pressure to return before entry"),
            lesson("Continuation Review", "bullFlag", "up", "trend pressure returns", "Continuation needs structure and renewed pressure"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 9",
        "title": "Reversals and Traps",
        "bg": "#EF4444",
        "slab": "#B91C1C",
        "tier": "Strategy",
        "lessons": [
            lesson("Reversal Pressure", "bullishEngulfing", "up", "control changes", "Reversals need a clear change in control"),
            lesson("Buyer Trap", "shootingStar", "down", "failed buying", "A buyer trap forms when a breakout fails"),
            lesson("Seller Trap", "hammer", "up", "failed selling", "A seller trap forms when a breakdown fails"),
            lesson("Exhaustion Reversal", "doji", "neutral", "slowing pressure", "Exhaustion can prepare a reversal"),
            lesson("Absorption Reversal", "rejectionWickDown", "up", "selling absorbed", "Absorbed selling can support a reversal"),
            lesson("Double Top Flow", "doubleTop", "down", "buyers fail twice", "Repeated failure can shift control to sellers"),
            lesson("Double Bottom Flow", "doubleBottom", "up", "sellers fail twice", "Repeated failure can shift control to buyers"),
            lesson("Confirmation Before Entry", "bullishEngulfing", "up", "price confirms pressure", "Confirmation reduces premature reversal entries"),
            lesson("Reversal Review", "inverseHeadShoulders", "up", "control and confirmation", "A reversal needs control change and confirmation"),
        ],
    },
    {
        "eyebrow": "STRATEGY · UNIT 10",
        "title": "Execution and Risk",
        "bg": "#64748B",
        "slab": "#334155",
        "tier": "Strategy",
        "lessons": [
            lesson("Plan the Entry", "breakoutRetest", "up", "defined trigger", "A clear trigger keeps execution disciplined"),
            lesson("Choose the Order Type", "sideways", "neutral", "speed versus price", "Order choice balances speed with price control"),
            lesson("Manage Slippage", "volatile", "neutral", "available liquidity", "Thin liquidity can increase slippage"),
            lesson("Order Flow Invalidation", "supportBounce", "up", "evidence that disproves the read", "Risk belongs beyond the evidence that would invalidate the order flow read"),
            lesson("Risk in Thin Liquidity", "bandsWidening", "neutral", "slippage and unstable depth", "Thin liquidity can require smaller risk and more cautious execution"),
            lesson("No Clear Order Flow Read", "spinningTop", "neutral", "conflicting evidence", "Conflicting evidence is a valid reason to stay out"),
            lesson("Exit Into Liquidity", "resistanceRejection", "down", "available buyers or sellers", "Liquidity can improve planned exits"),
            lesson("Review the Order Flow Read", "sideways", "neutral", "whether book tape footprint and price behaved as expected", "Review each evidence source separately from the trade outcome"),
            lesson("Order Flow Final Review", "volatile", "neutral", "context and risk", "Use order flow as context with defined risk"),
        ],
    },
]

# Add the bridge, cumulative reviews, comparisons, misconceptions, and footprint
# work without duplicating the long unit definitions above.
UNITS[0]["lessons"].insert(0, lesson("Reading Time and Sales", "sideways", "neutral", "price size and side", "Time and Sales lists completed trades in sequence"))
UNITS[1]["lessons"].append(lesson("Tape and Absorption Mixed Review", "rejectionWickDown", "neutral", "aggression and price response", "Separate active pressure from the market response"))
UNITS[1]["lessons"].insert(9, lesson("Seller Absorption Simulation", "resistanceRejection", "down", "buying stalls against refreshing offers", "Aggressive buyers can be absorbed by passive sellers at resistance"))
UNITS[1]["lessons"].insert(10, lesson("Buyer Absorption Simulation", "supportBounce", "up", "selling stalls against refreshing bids", "Aggressive sellers can be absorbed by passive buyers at support"))
UNITS[2]["lessons"].insert(0, lesson("Reading a Footprint Chart", "sideways", "neutral", "bid and ask volume by price", "A footprint shows executed volume at each price"))
UNITS[2]["lessons"].insert(1, lesson("Footprint Imbalances", "volatile", "up", "diagonal volume ratios at neighboring prices", "A conventional footprint imbalance compares diagonally adjacent bid and ask volume using a ratio threshold"))
UNITS[2]["lessons"].insert(10, lesson("Delta vs Volume", "volatile", "neutral", "total activity versus net aggression", "Volume measures total trading while delta compares aggressive buying and selling"))
UNITS[2]["lessons"].insert(11, lesson("Positive Delta While Price Falls", "bearishEngulfing", "down", "buying without upward progress", "Positive delta with falling price can reveal seller absorption or trapped buyers"))
UNITS[2]["lessons"].insert(12, lesson("Negative Delta While Price Rises", "bullishEngulfing", "up", "selling without downward progress", "Negative delta with rising price can reveal buyer absorption or trapped sellers"))
UNITS[3]["lessons"].insert(9, lesson("Thick Book vs Thin Book", "volatile", "neutral", "available depth", "Book depth changes how easily price can travel"))
UNITS[3]["lessons"].insert(10, lesson("Iceberg Orders", "sideways", "neutral", "repeated fills at one price", "An iceberg can replenish displayed size while absorbing repeated trades"))
UNITS[3]["lessons"].append(lesson("Flow and Liquidity Mixed Review", "breakoutRetest", "neutral", "pressure location and acceptance", "Combine pressure with liquidity and price response"))
UNITS[3]["lessons"].insert(8, lesson("Liquidity Sweep Rejection Simulation", "rejectionWickUp", "down", "a level breach followed by rejection", "A sweep takes liquidity but fails to gain acceptance"))
UNITS[4]["lessons"].append(lesson("Common Order Flow Misconceptions", "shootingStar", "neutral", "price response", "Pressure is context rather than a guarantee"))
UNITS[4]["lessons"].insert(4, lesson("Breakout Acceptance Simulation", "breakoutRetest", "up", "aggression followed by acceptance", "A real breakout combines pressure with sustained trade beyond the level"))
UNITS[5]["lessons"].append(lesson("Breakout and Continuation Mixed Review", "bullFlag", "neutral", "acceptance and renewed pressure", "Continuation needs both structure and returning pressure"))
UNITS[5]["lessons"].insert(8, lesson("Conflicting Order Flow Signals", "spinningTop", "neutral", "evidence that does not agree", "Conflicting signals call for patience and a weaker conclusion"))
UNITS[5]["lessons"].insert(9, lesson("No Clear Read Simulation", "spinningTop", "neutral", "conflicting book tape and price evidence", "When evidence conflicts the strongest conclusion may be no clear read"))
UNITS[5]["lessons"].insert(9, lesson("High Volume Chop", "range", "neutral", "heavy trading without progress", "High volume without directional progress can show two sided absorption"))
UNITS[5]["lessons"].insert(10, lesson("Low Volume Trend", "ascendingChannel", "up", "steady movement through thin liquidity", "A trend can travel on low volume when little liquidity opposes it"))
UNITS[7]["lessons"][-1] = lesson("Comprehensive Order Flow Simulation", "volatile", "neutral", "the complete market response", "Build one read from book tape footprint price and risk")

# Common misconceptions belongs immediately before the Unit 7 Boss, which is
# converted from Breakout Review below.
unit7_lessons = UNITS[4]["lessons"]
misconceptions = next(item for item in unit7_lessons if item["title"] == "Common Order Flow Misconceptions")
unit7_lessons.remove(misconceptions)
review_index = next(i for i, item in enumerate(unit7_lessons) if item["title"] == "Breakout Review")
unit7_lessons.insert(review_index, misconceptions)


NODE_SVGS = [
    '<svg viewBox="0 0 32 32" fill="white"><circle cx="16" cy="16" r="9"/></svg>',
    '<svg viewBox="0 0 32 32" fill="white"><path d="M16 4 L27 16 L16 28 L5 16 Z"/></svg>',
    '<svg viewBox="0 0 32 32" fill="white"><path d="M5 24 L11 15 L17 19 L26 7 L28 9 L18 24 L12 20 L7 27 Z"/></svg>',
    '<svg viewBox="0 0 32 32" fill="white"><rect x="6" y="8" width="20" height="4" rx="2"/><rect x="6" y="15" width="15" height="4" rx="2"/><rect x="6" y="22" width="10" height="4" rx="2"/></svg>',
]


def event_for(meta, node):
    if meta["bias"] == "up":
        return "lift"
    if meta["bias"] == "down":
        return "hit"
    return "lift" if node % 2 else "hit"


def chain_for(meta):
    if meta["bias"] == "up":
        return [
            "Buyer pressure appears",
            "Offers get consumed",
            "Price reaches higher levels",
            "The chart confirms the move",
        ]
    if meta["bias"] == "down":
        return [
            "Seller pressure appears",
            "Bids get consumed",
            "Price reaches lower levels",
            "The chart confirms the move",
        ]
    return [
        "Observe the order book",
        "Compare trades with liquidity",
        "Wait for price confirmation",
        "Manage the risk",
    ]


SHORT_SIGNALS = {
    "Foundations and Book Mixed Review": "Combine aggression, liquidity, and price response",
    "Footprint Imbalances": "Compare diagonal bid and ask volume by ratio",
    "Delta vs Volume": "Volume is total activity. Delta is net aggression",
    "Positive Delta While Price Falls": "Possible seller absorption or trapped buyers",
    "Negative Delta While Price Rises": "Possible buyer absorption or trapped sellers",
    "Resting Stops": "Beyond obvious highs, lows, and levels",
    "Sweep or Breakout": "Sweeps reject. Breakouts gain acceptance",
    "Breakout Pressure": "Offers are consumed, withdrawn, or both",
    "Breakdown Pressure": "Bids are consumed, withdrawn, or both",
    "Breakout Acceptance Simulation": "Pressure is confirmed by acceptance above",
    "Low Volume Trend": "Thin opposition can allow a low volume trend",
    "No Clear Read Simulation": "Conflicting evidence means no confirmed read",
    "Order Flow Invalidation": "Beyond the level that disproves the read",
}


def signal_for(meta):
    return SHORT_SIGNALS.get(meta["title"], meta["signal"])


def choice_screen(meta, node, advanced=False):
    questions = [
        "What's the best read?", "What does the evidence support?",
        "Which explanation fits best?", "What's the strongest conclusion?",
        "What best connects the evidence?", "Which read needs fewer assumptions?",
        "What matters most here?", "Which conclusion fits the response?",
        "How should this be interpreted?", "What does the response suggest?",
        "Which read is best supported?", "What's the most reasonable read?",
    ]
    distractor_sets = [
        ["Displayed liquidity is stronger evidence than completed executions", "A short aggressive burst can outweigh a stalled price response", "The candle response makes tape confirmation optional"],
        ["Tape speed matters more than the level where it occurs", "A replenishing order is probably new unrelated liquidity", "Brief trade beyond the level is enough to establish acceptance"],
        ["High total volume normally implies strongly directional delta", "A large wall deserves more weight than repeated fills against it", "One unusually large trade is more reliable than subsequent response"],
        ["The current book is more useful than the executions that changed it", "Location adds little once the tape accelerates", "The earliest signal should anchor the read even after conditions change"],
        ["Positive delta is usually sufficient confirmation for higher prices", "A pull in liquidity is equivalent to aggressive execution", "Slower counter pressure automatically confirms continuation"],
        ["Repeated tests always make a liquidity level stronger", "A fast rejection proves the resting wall was genuine", "Stable displayed size means hidden liquidity cannot be present"],
        ["Price progress can be ignored when aggression is persistent", "A narrow spread confirms directional control", "The largest footprint row determines the entire candle read"],
        ["Acceptance is present as soon as one trade prints beyond a level", "Passive absorption and fading aggression produce the same evidence", "A high volume candle reveals which side initiated every trade"],
        ["Thin liquidity implies the move has strong aggressive sponsorship", "Negative delta prevents price from rising", "Refreshing bids matter only after sellers stop trading"],
        ["A failed breakout is confirmed before price returns through the level", "More displayed depth necessarily means more actual liquidity", "A second test should be read the same way as the first"],
        ["Large executions are directional even when price does not respond", "A moving average reaction can substitute for execution evidence", "Balanced delta means neither side traded aggressively"],
        ["Fast tape near resistance is stronger than failure to gain acceptance", "A liquidity sweep and breakout differ mainly by candle size", "Order flow evidence remains valid regardless of changing volatility"],
    ]
    wrong = distractor_sets[node % len(distractor_sets)]
    options = [signal_for(meta)] + (wrong if advanced else wrong[:2])
    question = "Where might stops cluster?" if meta["title"] == "Resting Stops" else questions[node % len(questions)]
    return {"type": "multiple_choice", "chart": meta["chart"], "question": question,
            "options": options, "correct": 0, "explanation": meta["signal"] + "."}


def live_screen(meta, node):
    direction = meta["bias"] if meta["bias"] != "neutral" else "sideways"
    questions = [
        "What changed in price response?", "Which price behavior supports the read?",
        "What does follow through add?", "What does the developing response support?",
    ]
    return {
        "type": "live_chart", "direction": direction,
        "question": questions[node % len(questions)],
        "options": ["Upward price response is developing", "Downward price response is developing", "Price is not gaining directional acceptance"],
        "correct": 0 if direction == "up" else (1 if direction == "down" else 2),
        "explanation": "Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.",
    }


def comparison_screen(meta):
    title = meta["title"]
    comparisons = {
        "Absorption or Exhaustion": ("Absorption shows pressure without progress. Exhaustion shows pressure fading.", "Both require price to accelerate immediately", "They can be separated using order size alone"),
        "Sweep or Breakout": ("Sweeps reject the level. Breakouts gain acceptance.", "A sweep always has slower tape than a breakout", "Any trade beyond the level confirms a breakout"),
        "Thick Book vs Thin Book": ("Thick books resist travel. Thin books allow easier travel.", "A thick book guarantees reversal", "A thin book proves aggressive buyers are present"),
        "Buyer Imbalance": ("Buyer imbalance consumes offers. Buyer absorption holds bids against selling.", "Both mean resting buyers are being hit", "Both guarantee a higher close"),
    }
    if title not in comparisons:
        return None
    correct, wrong1, wrong2 = comparisons[title]
    return {"type": "multiple_choice", "chart": meta["chart"],
            "question": "Which comparison best separates these two ideas?",
            "options": [correct, wrong1, wrong2], "correct": 0,
            "explanation": correct}


def tape_tap_screen(meta, node):
    target = 1 + ((node * 5 + 2) % 7)
    title = meta["title"]
    specs = {
        "Trade Speed": ("accelerating", "Tap the first print where the tape begins accelerating.", "This print begins the faster arrival sequence."),
        "Trade Size": ("large_print", "Tap the unusually large executed trade.", "This execution is much larger than the surrounding prints."),
        "Repeated Prints": ("sequence_break", "Tap the print that breaks the dominant side sequence.", "This print interrupts the persistent aggression shown before it."),
        "Buyer Initiated Prints": ("buyer_target", "Tap a buyer initiated execution at the ask.", "The selected trade executes at the ask and is buyer initiated."),
        "Seller Initiated Prints": ("seller_target", "Tap a seller initiated execution at the bid.", "The selected trade executes at the bid and is seller initiated."),
        "Pace Changes": ("accelerating", "Tap where the tape first changes to a faster pace.", "The interval between prints begins shrinking here."),
        "Tape at Key Levels": ("sequence_break", "Tap the execution that first contradicts the dominant pressure.", "The selected print is the first opposing execution at the level."),
        "False Urgency": ("stall", "Tap where fast activity begins losing follow through.", "Prints continue but size and pace begin fading here."),
        "Tape Reading Review": ("seller_target", "Tap the seller initiated print that changes the developing read.", "This bid side execution is the relevant opposing print."),
    }
    event, question, explanation = specs.get(title, ("large_print", f"In {title.lower()}, tap the most informative print.", "The selected execution carries the key tape evidence."))
    return {"type": "time_sales_tap", "event": event, "target": target,
            "question": question, "explanation": explanation}


def footprint_tap_screen(meta, node):
    target = (node * 3 + 1) % 7
    mode = node % 4
    if mode == 0:
        event, question, explanation = "lift", "Tap the row with the greatest ask side execution advantage.", "This row has the largest positive same price execution difference."
    elif mode == 1:
        event, question, explanation = "hit", "Tap the row with the greatest bid side execution advantage.", "This row has the largest negative same price execution difference."
    elif mode == 2:
        event, question, explanation = "balanced_target", "Tap the row where bid and ask execution is most balanced.", "This row has the smallest difference between bid and ask volume."
    else:
        event, question, explanation = "total_target", "Tap the row with the largest total executed volume.", "This row has the highest combined bid and ask execution."
    return {"type": "footprint_tap", "event": event, "target": target,
            "question": question, "explanation": explanation}


def concept_footprint_task(meta, node):
    """Advanced Unit 5 taps test the named concept, never a random row task."""
    target = (node * 3 + 1) % 6
    specs = {
        "Reading a Footprint Chart": ("total_target", "Tap the row with most executed volume.", "This row has the largest bid plus ask total."),
        "Footprint Imbalances": ("diagonal_ask", "Tap the first diagonal ask imbalance.", "Ask execution exceeds the adjacent lower bid by ratio."),
        "Order Imbalance": ("lift", "Tap the strongest execution imbalance.", "This row has the widest directional execution advantage."),
        "Buyer Imbalance": ("lift", "Tap the strongest ask side advantage.", "Aggressive buyers execute at the ask."),
        "Seller Imbalance": ("hit", "Tap the strongest bid side advantage.", "Aggressive sellers execute at the bid."),
        "Momentum Ignition": ("lift", "Tap the row where buyer pressure concentrates.", "Concentrated ask executions can help ignite momentum."),
        "Momentum Continuation": ("stacked_ask", "Tap the first stacked ask imbalance.", "Consecutive ask imbalances support continued buyer pressure."),
        "Momentum Failure": ("balanced_target", "Tap where directional pressure disappears.", "Execution becomes balanced as momentum loses force."),
        "Stacked Pressure": ("stacked_ask", "Tap the first row in the stack.", "The selected row begins consecutive ask side imbalances."),
        "Delta Thinking": ("delta_positive", "Tap the row adding most positive delta.", "This row contributes the largest ask minus bid volume."),
        "Delta vs Volume": ("total_target", "Tap the highest volume row.", "Total volume adds bid and ask executions, unlike delta."),
        "Positive Delta While Price Falls": ("delta_positive", "Tap the row contradicting falling price.", "Strong positive delta conflicts with the downward price response."),
        "Negative Delta While Price Rises": ("delta_negative", "Tap the row contradicting rising price.", "Strong negative delta conflicts with the upward price response."),
        "Price and Pressure Divergence": ("delta_negative", "Tap the execution clue opposing price.", "The selected negative delta row contradicts the price direction."),
        "Imbalance Review": ("stacked_ask", "Tap where sustained pressure begins.", "The first stacked row begins persistent ask side pressure."),
    }
    event, question, explanation = specs[meta["title"]]
    if event == "stacked_ask":
        target %= 5
    return {"type": "footprint_tap", "event": event, "target": target,
            "question": question, "explanation": explanation}


def screens_for(meta, node, unit_index=2):
    event = event_for(meta, node)
    buyer = event == "lift"
    order = "market_buy" if node % 2 else "market_sell"
    chain = chain_for(meta)
    advanced = unit_index >= 5
    candle_target = (node * 3 + 1) % 5
    trend_targets = [(0, 3), (1, 4), (0, 4), (1, 3), (2, 4)]
    trend_start, trend_end = trend_targets[node % len(trend_targets)]
    if unit_index == 7 and meta["chart"] in {"ascendingChannel", "lowerHighsDowntrend", "pullbackUptrend", "bullFlag", "bearFlag"}:
        chart_action = {
            "type": "draw_trendline", "chart": meta["chart"],
            "question": "Mark the structure that provides location for the order flow read.",
            "target_start": trend_start, "target_end": trend_end,
            "explanation": "Structure supplies location. Execution evidence supplies the read.",
        }
    else:
        chart_action = {
            "type": "tap_candle",
            "chart": meta["chart"],
            "question": "Tap the clearest price response.",
            "target": candle_target,
            "explanation": "The selected candle shows whether execution produced follow through.",
        }
    aggressor = {
            "type": "aggressor",
            "event": event,
            "question": "Who's crossing the spread?",
            "correct": 0 if buyer else 1,
            "explanation": "Buyers take offers. Sellers take bids.",
        }
    book = {
            "type": "book_drag",
            "order": order,
            "question": "Route this order.",
            "correct": 1 if order == "market_buy" else 0,
            "explanation": "Market buys take asks. Market sells take bids.",
        }
    fill_distractors = [
        ["a single large print", "displayed depth without execution", "candle color without location"],
        ["speed without price response", "a level breach without acceptance", "delta without total volume"],
        ["resting size that never trades", "one isolated footprint row", "direction without follow through"],
        ["total volume without side separation", "a wall before it is tested", "pace without trade direction"],
        ["one execution without persistence", "price location without response", "a pull that never changes depth"],
        ["positive delta without progress", "a wick without tape evidence", "depth far from the active price"],
    ][node % 6]
    fill_options = [meta["clue"]] + fill_distractors
    fill = {
            "type": "fill_blank",
            "chart": meta["chart"],
            "question": "The missing evidence is [___].",
            "options": fill_options,
            "correct": 0,
            "explanation": "Focus on " + meta["clue"] + ".",
        }
    advanced_pairs = [
        [[meta["title"], meta["clue"].capitalize()], ["Absorption", "Aggression without price progress"], ["Exhaustion", "Aggression begins fading"]],
        [[meta["title"], meta["clue"].capitalize()], ["Iceberg", "Displayed size repeatedly replenishes"], ["Acceptance", "Price holds beyond the level"]],
        [[meta["title"], meta["clue"].capitalize()], ["Positive delta with falling price", "Possible seller absorption"], ["Negative delta with rising price", "Possible buyer absorption"]],
        [[meta["title"], meta["clue"].capitalize()], ["Fast tape without progress", "Urgency without confirmation"], ["Sweep", "Liquidity taken followed by rejection"]],
    ]
    beginner_pairs = [[meta["title"], meta["clue"].capitalize()], ["Aggressive order", "Trades immediately"], ["Passive order", "Rests as liquidity"]]
    matching = {
            "type": "matching",
            "question": "Match each clue.",
            "pairs": advanced_pairs[node % len(advanced_pairs)] if advanced else beginner_pairs,
            "explanation": "Match the signal with its order flow clue.",
        }
    sequence = {
            "type": "sequence_builder",
            "chart": meta["chart"],
            "question": "Build the read.",
            "items": chain,
            "correct_order": chain,
            "explanation": "Read pressure, liquidity, price, then confirmation.",
        }
    title = meta["title"]
    if title == "Reading Time and Sales":
        return [
            {"type": "time_sales", "event": "lift", "question": "What information does each row provide?", "options": ["Execution time price size and initiating side", "Resting bid and ask size before execution", "Total candle volume without trade direction"], "correct": 0, "explanation": "Each row is a completed trade with time price size and side."},
            {"type": "time_sales", "event": "hit", "question": "Which side is initiating these trades?", "options": ["Sellers", "Buyers", "Neither side can initiate a trade"], "correct": 0, "explanation": "Trades at the bid are seller initiated."},
            tape_tap_screen(meta, node),
            matching,
        ]
    if unit_index == 2:
        tape_events = {
            "Trade Speed": "accelerating", "Trade Size": "large_print", "Repeated Prints": "lift",
            "Buyer Initiated Prints": "lift", "Seller Initiated Prints": "hit", "Pace Changes": "accelerating",
            "False Urgency": "stall", "Tape at Key Levels": "lift",
        }
        tape_event = tape_events.get(title, event)
        question = {
            "Trade Speed": "The prints begin slowly and then arrive faster. What changed?",
            "Trade Size": "Which change in the feed shows unusually large participation?",
            "Repeated Prints": "Which side shows more persistent aggression across the sequence?",
            "Buyer Initiated Prints": "Where are the buyer initiated trades executing?",
            "Seller Initiated Prints": "Where are the seller initiated trades executing?",
            "Pace Changes": "What changed first before activity expanded?",
            "False Urgency": "Fast prints lose pace without price progress. What weakened?",
        }.get(title, f"Which tape behavior best supports the {title.lower()} read?")
        tape_wrongs = [
            ["Displayed depth changed but no completed trade confirms participation", "Candle direction identifies the initiating side of every execution"],
            ["The spread narrowed so trade pace no longer matters", "One large print establishes persistent control"],
            ["Total tape volume reveals where every resting order sits", "The final print deserves more weight than the full sequence"],
            ["A faster feed confirms acceptance regardless of price response", "Alternating print colors mean no side can be aggressive"],
        ][node % 4]
        response_specs = {
            "Reading the Tape": ("sideways", "Price response remains inconclusive", ["Buyers are fully confirmed", "Sellers are fully confirmed"]),
            "Trade Speed": ("sideways", "No. Price barely moved", ["Yes. Faster tape confirms buyers", "Yes. Volatility confirms direction"]),
            "Trade Size": ("resistanceRejection", "No. The large buy was rejected", ["Yes. One large print confirms control", "Yes. Size guarantees acceptance"]),
            "Repeated Prints": ("uptrend", "Yes. Higher prices continued", ["No. Repetition never matters", "Inconclusive despite higher highs"]),
            "Buyer Initiated Prints": ("range", "Price response remains inconclusive", ["Buyer control is confirmed", "Seller control is confirmed"]),
            "Seller Initiated Prints": ("downtrend", "Yes. Price made downward progress", ["No. Selling was absorbed", "Inconclusive despite lower lows"]),
            "Pace Changes": ("breakout", "Yes. Price expanded higher", ["No. Pace cannot confirm", "Inconclusive after acceptance"]),
            "Tape at Key Levels": ("resistanceRejection", "No. Buying failed at resistance", ["Yes. Fast buying confirmed control", "Inconclusive despite rejection"]),
            "False Urgency": ("sideways", "No. Price failed to follow through", ["Yes. Speed confirmed acceptance", "Yes. Activity guarantees control"]),
        }
        response_chart, chart_answer, chart_wrongs = response_specs.get(title, ("sideways", "Price response remains inconclusive", ["Buyers are confirmed", "Sellers are confirmed"]))
        chart_options = [chart_answer] + chart_wrongs
        chart_response = {"type": "multiple_choice", "chart": response_chart,
                          "question": "Did price confirm the tape?",
                          "options": chart_options, "correct": 0,
                          "explanation": "Use the chart only to judge whether price confirmed the tape evidence."}
        return [
            {"type": "time_sales", "event": tape_event, "question": question, "options": [signal_for(meta)] + tape_wrongs, "correct": 0, "explanation": meta["signal"] + "."},
            tape_tap_screen(meta, node),
            chart_response,
            aggressor,
        ][:3 + (node % 2)]
    if title in {"Reading a Footprint Chart", "Footprint Imbalances"}:
        footprint_event = "lift" if meta["bias"] == "up" else "balanced"
        if title == "Footprint Imbalances":
            definition = {"type": "footprint", "event": footprint_event,
                "question": "How is an ask imbalance measured?",
                "options": ["Compare diagonal bid and ask volume by ratio", "Use the largest same row difference", "Compare ask depth with bid executions"],
                "correct": 0,
                "explanation": "Diagonal comparison and a defined ratio distinguish conventional imbalance from a simple same price execution difference."}
        else:
            definition = {"type": "footprint", "event": footprint_event,
                "question": "What does the bid and ask split inside each row represent?",
                "options": ["Executed selling at the bid and buying at the ask", "Resting limit orders waiting at each price", "Total candle volume without side separation"],
                "correct": 0,
                "explanation": "A footprint separates executed bid volume from executed ask volume at each price."}
        tap_task = concept_footprint_task(meta, node)
        return [
            definition,
            tap_task,
            choice_screen(meta, node, True), matching,
        ]
    if title == "Common Order Flow Misconceptions":
        return [
            {"type": "true_false", "chart": "resistanceRejection", "question": "A large visible wall guarantees a reversal.", "correct": False, "explanation": "Walls can trade pull or fail."},
            {"type": "true_false", "chart": "breakout", "question": "Fast tape guarantees a breakout.", "correct": False, "explanation": "Speed needs acceptance and follow through."},
            {"type": "multiple_choice", "chart": "shootingStar", "question": "Positive delta appears but price cannot rise. What is the best explanation?", "options": ["Buying may be absorbed by passive sellers", "Positive delta guarantees delayed upside", "The chart invalidates all tape data"], "correct": 0, "explanation": "Aggressive buying without progress can reveal seller absorption."},
            {"type": "time_sales", "event": "stall", "question": "Buying prints remain active but price response stalls. Which warning is present?", "options": ["Aggression is not producing follow through", "The breakout is guaranteed after a delay", "Resting liquidity no longer matters"], "correct": 0, "explanation": "Active prints are not enough when price stops responding."}, sequence,
        ]
    if title in {"Delta vs Volume", "Positive Delta While Price Falls", "Negative Delta While Price Rises"}:
        event = "hit" if title == "Negative Delta While Price Rises" else "lift"
        return [
            {"type": "footprint", "event": event, "question": "Price and delta disagree. Why?", "options": [signal_for(meta), "Delta determines the next price", "Volume and delta are identical", "The disagreement cancels both readings"], "correct": 0, "explanation": meta["signal"] + "."},
            choice_screen(meta, node, True),
            concept_footprint_task(meta, node),
            sequence,
        ]
    if title == "Iceberg Orders":
        return [
            {"type": "orderflow_sim", "event": "iceberg", "question": "The offer refills after buy prints. Why?", "options": ["A possible sell iceberg is replenishing hidden size", "Buyers have already secured a breakout", "The tape is showing canceled orders", "Displayed size cannot change after a fill"], "correct": 0, "explanation": "Repeated execution against refreshing displayed size is consistent with an iceberg."},
            aggressor,
            choice_screen(meta, node, True),
            tape_tap_screen(meta, node),
        ]
    if title == "Thick Book vs Thin Book":
        return [
            {"type": "book_compare", "question": "Which book should move more easily?",
             "options": ["Book B, because depth is thin", "Book A, because depth is thick", "Both should move equally"],
             "correct": 0,
             "explanation": "Thin nearby depth and gaps can let price travel with less incoming pressure."},
            {"type": "multiple_choice", "question": "What does thick depth change?",
             "options": ["More liquidity must trade or withdraw", "Price is guaranteed to reverse", "Aggressors can ignore nearby size"],
             "correct": 0,
             "explanation": "Thick displayed depth can slow travel, but it may still trade or be pulled."},
            comparison_screen(meta),
        ]
    if title in {"Conflicting Order Flow Signals", "High Volume Chop", "Low Volume Trend"}:
        context_action = matching if chart_action["type"] == "live_chart" else chart_action
        evidence = {
            "Conflicting Order Flow Signals": (("What does the tape show?", "Urgency appears, then fades"), ("What contradicts the tape?", "Delta and price response disagree")),
            "High Volume Chop": (("What defines the tape?", "Fast two sided execution"), ("What does the footprint add?", "Heavy volume without directional progress")),
            "Low Volume Trend": (("What does the tape show?", "Steady movement without urgent prints"), ("Is execution strongly directional?", "No. Thin opposition still allows travel")),
        }[title]
        tape_evidence, footprint_evidence = evidence
        return [
            {"type": "time_sales", "event": "stall", "question": tape_evidence[0], "options": [tape_evidence[1], "Tape speed confirms acceptance", "One print resolves the read"], "correct": 0, "explanation": meta["signal"] + "."},
            {"type": "footprint", "event": "balanced" if meta["bias"] == "neutral" else "lift", "question": footprint_evidence[0], "options": [footprint_evidence[1], "The largest cell decides direction", "Volume guarantees a trend"], "correct": 0, "explanation": meta["signal"] + "."},
            choice_screen(meta, node, True),
            context_action,
            sequence,
        ]
    if "Simulation" in title:
        scenarios = {
            "Seller Absorption Simulation": ("seller_absorption", "Buying is aggressive but price cannot clear resistance. What is strongest?", "Buyers are active but may be absorbed by refreshing sellers"),
            "Buyer Absorption Simulation": ("buyer_absorption", "Selling is aggressive but price cannot break support. What is strongest?", "Sellers are active but may be absorbed by refreshing buyers"),
            "Liquidity Sweep Rejection Simulation": ("sweep", "Price trades beyond the level and immediately returns. What is strongest?", "Liquidity was taken but acceptance failed"),
            "Breakout Acceptance Simulation": ("breakout", "Offers are consumed and price holds beyond resistance. What is strongest?", "Aggression is receiving confirming price acceptance"),
            "No Clear Read Simulation": ("conflict", "Book tape and price response disagree. What is strongest?", "The evidence conflicts so no directional read is confirmed"),
            "Comprehensive Order Flow Simulation": ("championship", "Buyers stay aggressive, but resistance holds. What's strongest?", "Buyers are active but may be absorbed by refreshing sellers"),
        }
        scenario, prompt, answer = scenarios[title]
        if title == "Comprehensive Order Flow Simulation":
            stages = [
                ("Who is aggressive?", ["Buyers lifting offers", "Sellers hitting bids", "Neither side trading"], "Buyer initiated prints dominate the tape."),
                ("Where is liquidity defending?", ["At the refreshing offer", "Below the distant bid", "No liquidity is visible"], "The offer repeatedly replenishes after fills."),
                ("Is buying moving price?", ["No. Price is stalling", "Yes. Price is accepting higher", "Price response is irrelevant"], "Aggression is strong, but upward progress remains weak."),
                ("Which clue conflicts with delta?", ["Price stalls at resistance", "Buyer prints stay fast", "Ask volume stays positive"], "Positive delta conflicts with the lack of upward price progress."),
                ("What's the strongest read?", ["Possible seller absorption", "Confirmed buyer continuation", "Guaranteed reversal"], "Refreshing offers and stalled price support possible seller absorption."),
                ("What would invalidate that read?", ["Offers clear and price holds above", "Another buy print appears", "The spread stays unchanged"], "Acceptance above resistance would invalidate the absorption read."),
                ("Is continuation confirmed?", ["No. More acceptance is needed", "Yes. Positive delta is enough", "Yes. Fast tape is enough"], "Aggression without acceptance does not confirm continuation."),
            ]
            return [{"type": "orderflow_sim", "event": "championship", "direction": "neutral",
                     "question": question, "options": options, "correct": 0,
                     "explanation": explanation} for question, options, explanation in stages]
        return [
            {"type": "orderflow_sim", "event": scenario, "direction": meta["bias"], "question": prompt, "options": [answer, "The fastest evidence guarantees the next move", "Displayed size alone determines the outcome", "The candle should be read without execution context"], "correct": 0, "explanation": meta["signal"] + "."},
            choice_screen(meta, node, True),
            sequence,
        ]
    if unit_index == 3:
        absorption_titles = {"What Is Absorption", "Buyer Absorption", "Seller Absorption", "Repeated Tests", "Hidden Liquidity", "Absorption Review"}
        exhaustion_titles = {"What Is Exhaustion", "Buyer Exhaustion", "Seller Exhaustion", "Absorption or Exhaustion"}
        if title in absorption_titles:
            scenario = "buyer_absorption" if meta["bias"] == "up" else "seller_absorption"
            if title == "Hidden Liquidity":
                scenario = "seller_absorption"
            tape_checks = {
                "What Is Absorption": ("Is pressure moving price?", "No. Execution is strong; progress is weak"),
                "Buyer Absorption": ("What are sellers failing to do?", "Push price below support"),
                "Seller Absorption": ("What are buyers failing to do?", "Clear the refreshing offer"),
                "Repeated Tests": ("What keeps happening at the level?", "Pressure trades, but the level holds"),
                "Hidden Liquidity": ("What suggests hidden liquidity?", "Displayed size keeps replenishing"),
                "Absorption Review": ("Which clue confirms absorption?", "Strong pressure with little progress"),
            }
            tape_question, tape_answer = tape_checks[title]
            return [
                {"type": "orderflow_sim", "event": scenario, "question": "What does the combined evidence show?", "options": [signal_for(meta), "The candle alone proves the cause", "Aggression confirms continuation", "Displayed size reveals hidden liquidity"], "correct": 0, "explanation": meta["signal"] + "."},
                {"type": "orderflow_sim" if title == "Hidden Liquidity" else "time_sales", "event": "iceberg" if title == "Hidden Liquidity" else ("hit" if meta["bias"] == "up" else "lift"), "question": tape_question, "options": [tape_answer, "Pressure and price accelerate together", "No aggressive executions appear"], "correct": 0, "explanation": "Absorption requires pressure plus a weak corresponding price response."},
                choice_screen(meta, node, True),
            ]
        if title in exhaustion_titles:
            if title == "Absorption or Exhaustion":
                return [
                    {"type": "time_sales", "event": "lift", "question": "Pressure stays strong, but price stalls. Which is it?", "options": ["Absorption", "Exhaustion", "Acceptance"], "correct": 0, "explanation": "Absorption keeps strong aggression but loses price progress. Exhaustion means aggression itself fades."},
                    {"type": "time_sales", "event": "stall", "question": "Aggressive pace now fades. Which is it?", "options": ["Exhaustion", "Absorption", "Breakout acceptance"], "correct": 0, "explanation": "Fading aggression defines exhaustion."},
                    comparison_screen(meta),
                ]
            exhaustion_checks = {
                "What Is Exhaustion": ("What changed in the tape?", "Pace and size are fading"),
                "Buyer Exhaustion": ("Which side is losing urgency?", "Aggressive buyers"),
                "Seller Exhaustion": ("Which side is losing urgency?", "Aggressive sellers"),
            }
            exhaustion_question, exhaustion_answer = exhaustion_checks[title]
            return [
                {"type": "time_sales", "event": "stall", "question": exhaustion_question, "options": [exhaustion_answer, "Resting depth proves reversal", "Execution gains urgency"], "correct": 0, "explanation": "Exhaustion is defined by aggressive activity fading."},
                tape_tap_screen({**meta, "title": "False Urgency"}, node),
                {"type": "footprint", "event": "balanced", "question": "Which footprint change would support exhaustion?", "options": ["Directional execution becomes less dominant near the extreme", "One large row guarantees reversal", "Displayed orders replace executed volume"], "correct": 0, "explanation": "Fading directional execution can support an exhaustion read."},
            ]
    if unit_index == 4:
        footprint_event = "hit" if meta["bias"] == "down" else ("lift" if meta["bias"] == "up" else "balanced")
        flow_choice = choice_screen(meta, node, True)
        flow_choice.pop("chart", None)
        flow_sequence = dict(sequence)
        flow_sequence.pop("chart", None)
        footprint_wrongs = [
            ["The largest total row proves directional delta", "The bid ask split represents resting limit orders", "One same price difference confirms a stacked diagonal imbalance"],
            ["Positive candle delta guarantees price acceptance", "A quiet row invalidates aggression elsewhere", "Absolute volume matters more than price response"],
            ["The brightest cell identifies the next candle direction", "A same row advantage and diagonal imbalance are identical", "Displayed depth can be inferred directly from executed volume"],
            ["Several ask heavy rows prove sellers withdrew", "High total volume must contain directional delta", "One footprint candle is enough to ignore location"],
        ][node % 4]
        return [
            {"type": "footprint", "event": footprint_event, "question": "What's the best footprint read?", "options": [signal_for(meta)] + footprint_wrongs, "correct": 0, "explanation": meta["signal"] + "."},
            concept_footprint_task(meta, node),
            flow_choice,
            flow_sequence,
        ][:3 + (node % 2)]
    if unit_index == 8:
        reversal_event = "hit" if meta["bias"] == "up" else ("lift" if meta["bias"] == "down" else "stall")
        reversal_wrongs = [
            ["The candle pattern identifies every initiating trade", "The earliest pressure cannot be contradicted later"],
            ["A rejection wick proves passive absorption", "The second test should inherit the first test's order flow"],
            ["Positive delta confirms a reversal regardless of price response", "Slower tape guarantees the opposing side has control"],
            ["A large opposing print outweighs the executions that follow", "Price location is unnecessary once a reversal candle closes"],
        ][node % 4]
        reversal_checks = {
            "Reversal Pressure": (("What changed on the tape?", "The initiating side lost control"), ("What confirms the control change?", "Opposing aggression gains strength")),
            "Buyer Trap": (("What shows buyers became trapped?", "Buy prints fail above resistance"), ("What contradicts the positive delta?", "Price returns below resistance")),
            "Seller Trap": (("What shows sellers became trapped?", "Sell prints fail below support"), ("What contradicts the negative delta?", "Price returns above support")),
            "Exhaustion Reversal": (("What shows aggression fading?", "Print pace and size decline"), ("What weakens the prior side?", "Directional execution loses dominance")),
            "Absorption Reversal": (("What shows pressure being absorbed?", "Heavy prints make little progress"), ("What confirms passive defense?", "Aggression stalls at one level")),
            "Double Top Flow": (("How does the second test differ?", "Buyer urgency is weaker"), ("What changes on the retest?", "Seller response strengthens")),
            "Double Bottom Flow": (("Which side weakens on the retest?", "Aggressive sellers"), ("What changes on the second test?", "Buyer response strengthens")),
            "Confirmation Before Entry": (("What confirms the reversal?", "Opposing prints gain follow through"), ("What must execution produce?", "A confirming price response")),
            "Reversal Review": (("What completes the reversal read?", "Control change plus confirmation"), ("What does the footprint verify?", "Aggressive control changed")),
        }
        tape_check, footprint_check = reversal_checks[title]
        screens = [
            {"type": "time_sales", "event": reversal_event, "question": tape_check[0], "options": [tape_check[1]] + reversal_wrongs, "correct": 0, "explanation": meta["signal"] + "."},
            {"type": "footprint", "event": "hit" if meta["bias"] == "down" else ("lift" if meta["bias"] == "up" else "balanced"), "question": footprint_check[0], "options": [footprint_check[1], "The pattern target is guaranteed", "Only resting liquidity matters"], "correct": 0, "explanation": "Tape and footprint evidence reveal what changed beneath the candle pattern."},
            choice_screen(meta, node, True),
        ]
        if title == "Reversal Review":
            screens.insert(0, {"type": "orderflow_sim", "event": "conflict", "question": "Which evidence source prevents an immediate reversal conclusion?", "options": ["Aggression and price response still conflict", "The candle pattern guarantees confirmation", "Positive delta makes location irrelevant"], "correct": 0, "explanation": "A reversal needs a control change and confirming response."})
        return screens
    comparison = comparison_screen(meta)
    price_context = live_screen(meta, node)
    core = [choice_screen(meta, node, advanced), price_context, chart_action, fill, matching, sequence]
    if comparison:
        core[3] = comparison
    # Rotate mechanics so repeated lesson rhythm does not become predictable.
    variants = [
        [aggressor, core[0], core[3]],
        [core[0], book, core[4], core[2]],
        [core[0], core[2], core[3]],
        [book, core[4], core[0]],
        [core[2], aggressor, core[0], core[5]],
        [core[3], core[0], core[4]],
    ]
    if unit_index in {6, 7} and node % 3 == 0:
        variants[node % len(variants)].insert(1, price_context)
    return variants[node % len(variants)]


def remove_text_dashes(value, key=None):
    """Keep learner facing Order Flow copy free of dash punctuation."""
    if isinstance(value, dict):
        return {k: remove_text_dashes(v, k) for k, v in value.items()}
    if isinstance(value, list):
        return [remove_text_dashes(item, key) for item in value]
    if isinstance(value, str) and key != "svg":
        replacements = {
            "A company news schedule": "A single candle without execution context",
            "company size": "one isolated print",
            "news schedule": "candle color without price response",
            "An order that keeps vanishing before it trades may be…": "Repeated deceptive posting and cancellation intended to mislead may constitute…",
            "Orders shown then pulled to mislead is spoofing. Absorption actually fills; a breakout is a price move.": "Repeated deceptive posting and cancellation intended to mislead may constitute spoofing. One cancelled order alone does not prove intent.",
            "A strong directional move needs an order [___].": "Directional moves often develop from an order [___].",
            "Directional movement often develops when aggressive and passive pressure create an order [___].": "Directional moves often develop from an order [___].",
            "An imbalance means one side is more aggressive.": "Directional movement can develop when aggressive pressure overwhelms liquidity, opposing liquidity withdraws, or both.",
            "You buy at the ask and sell at the bid when you trade aggressively.": "Aggressive buyers trade at asks; sellers trade at bids.",
            "The full depth of resting orders on both sides.": "Depth of resting orders across price levels.",
            "The full depth of resting orders.": "Available depth from the relevant venue or feed.",
        }
        value = replacements.get(value, value)
        return value.replace(" — ", ". ").replace("–", " ").replace("-", " ")
    return value


def answer_first(screen):
    options = list(screen.get("options", []))
    correct = screen.get("correct", 0)
    if not options or isinstance(correct, bool) or not 0 <= correct < len(options):
        return options
    return [options[correct]] + options[:correct] + options[correct + 1:]


CHART_VISUALS = {
    "ascendingChannel": "Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.",
    "ascendingTriangle": "Higher lows press into a flat resistance level before price tests the upper boundary.",
    "bandsWidening": "Candles expand in range as the surrounding volatility bands spread farther apart.",
    "bearFlag": "A sharp decline pauses in a small upward sloping channel before sellers test control again.",
    "bearishEngulfing": "A large bearish candle covers the prior bullish body after an attempted rise.",
    "breakdown": "Price drives below a visible support level with expanding bearish candles.",
    "breakdownRetest": "Price breaks support, returns to test it from below, then reacts lower.",
    "breakout": "Price pushes through a visible resistance level with expanding bullish candles.",
    "breakoutRetest": "Price breaks resistance, returns to test it from above, then attempts to continue higher.",
    "bullFlag": "A sharp advance pauses in a compact downward sloping channel before buyers test control again.",
    "bullishEngulfing": "A large bullish candle covers the prior bearish body after an attempted decline.",
    "doji": "A narrow candle body with wicks on both sides shows little net price progress.",
    "doubleBottom": "Price tests the same support area twice and rebounds after the second test.",
    "doubleTop": "Price tests the same resistance area twice and retreats after the second test.",
    "downtrend": "A sequence of lower highs and lower lows moves from the upper left toward the lower right.",
    "gapUp": "Price opens well above the prior trading area with little activity between the two zones.",
    "hammer": "A candle with a small upper body and long lower wick shows rejection of lower prices.",
    "inverseHeadShoulders": "Three troughs form with the middle trough deepest before price challenges the neckline.",
    "lowerHighsDowntrend": "Each rebound ends below the previous high while price continues making lower lows.",
    "maCrossUp": "A faster moving average crosses above a slower average as candles begin rising.",
    "marubozu": "A wide directional candle has almost no wick, showing sustained movement through its range.",
    "priceAboveMA": "Candles hold above a rising moving average and react near it during pullbacks.",
    "priceAboveVWAP": "Candles trade above the VWAP line while pullbacks test it as potential support.",
    "priceBelowVWAP": "Candles trade below the VWAP line while rebounds test it as potential resistance.",
    "pullbackUptrend": "An established rise pauses with smaller bearish candles before testing trend continuation.",
    "range": "Candles rotate between clear upper and lower boundaries without sustained direction.",
    "rejectionWickDown": "Price briefly trades below a level and closes back above it, leaving a long lower wick.",
    "rejectionWickUp": "Price briefly trades above a level and closes back below it, leaving a long upper wick.",
    "resistanceRejection": "An advance reaches resistance and turns lower with visible upper wick rejection.",
    "shootingStar": "A small candle body with a long upper wick shows rejection of higher prices.",
    "sideways": "Small mixed candles overlap inside a narrow horizontal trading area.",
    "spinningTop": "A small candle body with upper and lower wicks shows two sided movement and little progress.",
    "supportBounce": "A decline reaches support and rebounds with buyers defending the lower area.",
    "uptrend": "A sequence of higher highs and higher lows moves from the lower left toward the upper right.",
    "volatile": "Alternating wide candles and long wicks show rapid movement with changing control.",
}


def visual_description(screen):
    kind = screen["type"]
    chart = screen.get("chart")
    chart_copy = CHART_VISUALS.get(chart, "A candlestick chart displays the price structure referenced by the question.")
    if kind == "aggressor":
        side = "ask sizes being consumed by incoming buy orders" if screen.get("event") == "lift" else "bid sizes being consumed by incoming sell orders"
        return f"An animated Level II ladder shows prices between bid and ask columns, with {side}."
    if kind == "book_drag":
        order = "market buy" if screen.get("order") == "market_buy" else "market sell"
        return f"A draggable {order} card sits beside a Level II ladder with bid and ask drop targets."
    if kind == "book_compare":
        book_visuals = {
            "wall": "Two Level II ladders appear side by side. Book A concentrates 1,500 shares at one ask price while surrounding levels remain near 100. Book B has ordinary size across every level.",
            "pool": "Two Level II ladders appear side by side. Book A clusters large resting orders across three adjacent prices near an obvious level. Book B has modest evenly distributed depth.",
        }
        return book_visuals.get(screen.get("event"), "Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.")
    if kind == "evidence_select":
        return "Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination."
    if kind == "replay_compare":
        replay_visuals = {
            "wall": "Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.",
            "sweep": "Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.",
            "trap": "Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.",
            "trigger": "Replay A reaches the trigger level, shows confirming execution, and price responds. Replay B shows one fast print, no meaningful confirmation, and stalled price.",
            "absorption": "Replay A keeps strong buying against a replenishing offer with stalled price. Replay B shows buying pace itself fading as price stalls.",
            "wall_challenge": "Replay A shows several uneven waves of selling absorbed by a bid that keeps returning while price holds. Replay B shows the bid thinning and price slipping through.",
            "sweep_challenge": "Replay A briefly clears a prior extreme before snapping back into the range. Replay B retests the breached level and continues to hold beyond it.",
            "trap_challenge": "Replay A pauses above the break, defends a deeper retest, and resumes higher. Replay B loses the level after an initially strong burst and sellers take control.",
            "absorption_challenge": "Replay A shows varied buy sizes continuing into an offer that replenishes while price stays pinned. Replay B shows both buy size and pace fading before price stalls.",
            "acceptance_challenge": "Replay A clears staggered offers, survives a retest, and establishes trade above. Replay B meets renewed offers and returns to the prior range.",
            "double_top_flow": "Replay A shows the first resistance test with strong buyer execution. Replay B shows a second test with weaker buying, stronger seller response, and a return below resistance.",
            "double_bottom_flow": "Replay A shows the first support test with strong seller execution. Replay B shows a second test with weaker selling, stronger buyer response, and a reclaim above support.",
        }
        return replay_visuals.get(screen.get("event"), "Replay A shows offers clearing and price holding above resistance. Replay B shows replenishment and price falling back inside.")
    if kind in {"time_sales", "time_sales_tap"}:
        tape_details = {
            "lift": "buyer initiated prints dominating at the ask",
            "hit": "seller initiated prints dominating at the bid",
            "large_print": "one unusually large execution among ordinary prints",
            "accelerating": "the interval between prints shrinking after the target row",
            "stall": "pace and trade size fading after the target row",
            "sequence_break": "one opposing print interrupting a persistent buyer sequence",
            "buyer_target": "the target row showing a buyer initiated execution at the ask",
            "seller_target": "the target row showing a seller initiated execution at the bid",
            "buyer_sequence_break": "one buyer initiated print at the ask interrupting a seller initiated sequence",
            "buyer_fading": "buyer initiated prints at the ask losing pace and trade size",
        }
        detail = tape_details.get(screen.get("event"), "mixed buyer and seller initiated executions")
        return f"An animated Time and Sales table lists time, execution price, and trade size, with {detail}."
    if kind in {"footprint", "footprint_tap"}:
        event = screen.get("event", "balanced")
        detail = {"lift": "one target row carrying the largest ask side execution advantage", "hit": "one target row carrying the largest bid side execution advantage", "balanced": "similar bid and ask volume across the price rows", "balanced_target": "one target row with the smallest bid ask execution difference", "total_target": "one target row with the largest combined executed volume", "vwap_target": "a VWAP badge aligned with the target row carrying the largest combined executed volume", "diagonal_ask": "ask volume at the target price exceeding bid volume at the diagonally adjacent lower price by a clear ratio", "stacked_ask": "three consecutive rows showing ask side execution imbalances", "delta_positive": "one row contributing the largest positive ask minus bid delta", "delta_negative": "one row contributing the largest negative ask minus bid delta"}.get(event, "bid and ask execution volume by price")
        return f"A footprint grid places bid volume left of price and ask volume right of price, showing {detail}."
    if kind == "live_chart":
        direction = screen.get("direction", "sideways")
        movement = {"up": "building upward", "down": "building downward", "sideways": "alternating inside a range"}.get(direction, "updating")
        return f"A live candlestick chart adds new candles over time, with price currently {movement}."
    if kind == "orderflow_sim":
        scenarios = {
            "seller_absorption": "Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.",
            "buyer_absorption": "Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.",
            "sweep": "Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.",
            "breakout": "Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level.",
            "conflict": "Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.",
            "iceberg": "Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys.",
            "chop": "A range shows little net progress while Time and Sales alternates rapidly between buyers and sellers and the footprint displays heavy balanced execution on both sides.",
            "low_volume_trend": "Price advances steadily as Level II shows sparse opposing offers, Time and Sales prints at a measured pace, and the footprint shows modest directional execution rather than a volume surge.",
            "thin_risk": "Level II shows small nearby size with gaps, the spread widens during a market order, Time and Sales jumps across prices, and the simulated fill lands worse than the initial quote.",
            "downside_sweep": "Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.",
            "breakdown_pressure": "Seller initiated prints persist into bids that are being consumed or withdrawn, footprint execution favors sellers, and price establishes sustained trade below support.",
            "seller_loses_control": "Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.",
            "exit_liquidity": "Price approaches resistance while Level II shows concentrated opposing ask depth, Time and Sales remains active, and the chart identifies the planned exit area without guaranteeing the displayed liquidity will remain.",
            "championship": "A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.",
        }
        description = scenarios.get(screen.get("event"), scenarios["championship"])
        if screen.get("footprintPreview"):
            description += " A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5."
        return description
    if kind == "tap_candle":
        return chart_copy + " The candles are tappable and the learner must select the requested candle."
    if kind == "draw_trendline":
        return chart_copy + " The learner draws directly between two candles to mark the structure."
    if chart:
        return chart_copy
    return None


def markdown_screen(screen):
    kind = screen["type"]
    question = screen.get("question", "")
    lines = []
    if kind == "multiple_choice":
        lines.append(f"[MC] {question}")
        if screen.get("chart"):
            lines.append(f"CHART: {screen['chart']}")
        lines.extend(answer_first(screen))
    elif kind == "true_false":
        lines.extend([f"[TF] {question}", f"ANSWER: {'True' if screen.get('correct') else 'False'}"])
        if screen.get("chart"):
            lines.insert(1, f"CHART: {screen['chart']}")
    elif kind == "aggressor":
        event = screen.get("event", "lift")
        lines.extend([
            f"[AGGRESSOR] {question}",
            f"EVENT: {event}",
            f"ANSWER: {'The buyer' if event == 'lift' else 'The seller'}",
        ])
    elif kind == "book_drag":
        order = screen.get("order", "market_buy")
        lines.extend([
            f"[BOOKDRAG] {question}",
            f"ORDER: {order}",
            f"ANSWER: {'the ask' if order == 'market_buy' else 'the bid'}",
        ])
    elif kind == "book_compare":
        lines.append(f"[BOOK_COMPARE] {question}")
        lines.extend(answer_first(screen))
    elif kind == "evidence_select":
        lines.append(f"[EVIDENCE_SELECT] {question}")
        lines.append("SELECT: " + ", ".join(str(i) for i in screen.get("targets", [])))
        lines.extend(screen.get("options", []))
    elif kind == "replay_compare":
        lines.append(f"[REPLAY_COMPARE] {question}")
        lines.extend(answer_first(screen))
    elif kind == "time_sales":
        lines.extend([f"[TIME_SALES] {question}", f"EVENT: {screen.get('event', 'lift')}"])
        lines.extend(answer_first(screen))
    elif kind == "time_sales_tap":
        lines.extend([f"[TIME_SALES_TAP] {question}", f"EVENT: {screen.get('event', 'balanced')}", f"TARGET: {screen.get('target', 0)}"])
    elif kind == "footprint":
        lines.extend([f"[FOOTPRINT] {question}", f"EVENT: {screen.get('event', 'balanced')}"])
        lines.extend(answer_first(screen))
    elif kind == "footprint_tap":
        lines.extend([f"[FOOTPRINT_TAP] {question}", f"EVENT: {screen.get('event', 'balanced')}", f"TARGET: {screen.get('target', 0)}"])
    elif kind == "orderflow_sim":
        lines.append(f"[ORDERFLOW_SIM] {question}")
        lines.extend(answer_first(screen))
    elif kind == "matching":
        lines.append(f"[MATCH] {question}")
        if screen.get("chart"):
            lines.append(f"CHART: {screen['chart']}")
        lines.extend(f"{pair[0]} => {pair[1]}" for pair in screen.get("pairs", []))
    elif kind == "fill_blank":
        lines.append(f"[FILL] {question}")
        if screen.get("chart"):
            lines.append(f"CHART: {screen['chart']}")
        lines.extend(answer_first(screen))
    elif kind == "sequence_builder":
        lines.append(f"[ORDER] {question}")
        if screen.get("chart"):
            lines.append(f"CHART: {screen['chart']}")
        lines.extend(screen.get("correct_order", screen.get("items", [])))
    elif kind == "tap_candle":
        lines.extend([
            f"[TAP_CANDLE] {question}",
            f"CHART: {screen.get('chart', '')}",
            f"TARGET: {screen.get('target', 0)}",
        ])
    elif kind == "draw_trendline":
        lines.extend([
            f"[TRENDLINE] {question}",
            f"CHART: {screen.get('chart', '')}",
            f"TARGET: {screen.get('target_start', 0)} => {screen.get('target_end', 4)}",
        ])
    elif kind == "live_chart":
        lines.extend([
            f"[LIVE_CHART] {question}",
            f"DIRECTION: {screen.get('direction', 'sideways')}",
        ])
        lines.extend(answer_first(screen))
    else:
        lines.append(f"[{kind.upper()}] {question}")
        if screen.get("chart"):
            lines.append(f"CHART: {screen['chart']}")
    if screen.get("explanation"):
        lines.append(f"WHY: {screen['explanation']}")
    if screen.get("skillId"):
        lines.insert(1, f"SKILL: {screen['skillId']}")
    visual = visual_description(screen)
    if visual:
        lines.insert(1, f"VISUAL: {visual}")
    return lines


def write_markdown(course):
    lines = [
        "# Order Flow strategy course authoring source",
        "",
        "Course id: `orderflow` · accent `#14B8A6` · standalone strategy track.",
        "Mirrors `Moko/GameData.json`. Correct answers appear first for choice and fill questions.",
        "No intro blocks. Most questions render an order book, chart, or live chart.",
        "",
        "Interactive mechanics:",
        "  [AGGRESSOR] Watch a live ladder and choose the aggressive side.",
        "  [BOOKDRAG] Route a market order to the bid or ask.",
        "  [BOOK_COMPARE] Compare thick and thin Level II depth.",
        "  [EVIDENCE_SELECT] Choose the clues that complete an evidence stack.",
        "  [MARK_LEVEL] Mark relevant support, resistance, or inferred liquidity.",
        "  [REPLAY_COMPARE] Compare acceptance with replenishment and rejection.",
        "  [TAP_CANDLE] Select a candle directly on a chart.",
        "  [TRENDLINE] Connect two candles on a chart.",
        "  [LIVE_CHART] Read pressure while candles update.",
        "  [ORDERFLOW_SIM] Combine book, tape, footprint, and price response.",
        "  [TIME_SALES] Read an animated feed of completed trades.",
        "  [TIME_SALES_TAP] Select evidence directly from the animated tape.",
        "  [FOOTPRINT] Compare bid and ask volume at each price.",
        "  [FOOTPRINT_TAP] Select an imbalance directly on the footprint.",
        "",
        f"TOTAL UNITS: {len(course['sections'])}",
        f"TOTAL LESSONS: {len(course['lessons'])}",
        f"TOTAL QUESTIONS: {sum(len(item['screens']) for item in course['lessons'])}",
        "",
    ]
    lessons_by_node = {item["node"]: item for item in course["lessons"]}
    for section in course["sections"]:
        lines.extend([f"UNIT {section['index'] + 1} — {section['title']}", f"TIER: {section.get('tier', '')}", ""])
        nodes = [node for node in course["nodes"] if node["sectionIndex"] == section["index"]]
        for node in nodes:
            item = lessons_by_node[node["num"]]
            lines.extend([
                f"NODE {node['num']}",
                f"TITLE: {item['title']}",
                f"TYPE: {item.get('lessonType', 'STANDARD')}",
                f"CELEBRATION: {item.get('celebration', '')}",
                "",
            ])
            for screen in item["screens"]:
                lines.extend(markdown_screen(screen))
                lines.append("")
        lines.append("")
    lines.extend(["TEST OUT METADATA", ""])
    for test in course.get("testOuts", []):
        lines.extend([
            f"UNIT {test['unitIndex'] + 1}",
            f"QUESTIONS PER ATTEMPT: {test['questionCount']}",
            f"PASSING SCORE: {test['passingScore']}",
            f"POOL SIZE: {len(test['questionPool'])}",
            f"COMPETENCY BLUEPRINT: {', '.join(test.get('competencyBlueprint', []))}",
            "COMPETENCY MAPPINGS: " + "; ".join(
                f"{competency} => {', '.join(skills)}"
                for competency, skills in test.get("competencyMappings", {}).items()),
            "COMPETENCY SOURCE UNITS: " + "; ".join(
                f"{competency} => {', '.join(str(unit + 1) for unit in units)}"
                for competency, units in test.get("competencySourceUnits", {}).items()),
            "COMPETENCY SOURCE NODES: " + "; ".join(
                f"{competency} => {', '.join(str(node) for node in nodes)}"
                for competency, nodes in test.get("competencySourceNodes", {}).items()),
            "ELIGIBLE QUESTION IDS: " + "; ".join(
                f"{competency} => {', '.join(question_ids)}"
                for competency, question_ids in test.get("competencyEligibleQuestionIds", {}).items()),
            f"JUMP QUESTIONS: {test.get('jumpAheadQuestionCount', 'N/A')}",
            f"JUMP PASSING SCORE: {test.get('jumpPassingScore', 'N/A')}",
            f"JUMP PREREQUISITE QUESTIONS: {len(test.get('jumpPrerequisiteBlueprint', [])) or 'N/A'}",
            f"JUMP TARGET QUESTIONS: {len(test.get('jumpTargetBlueprint', [])) or 'N/A'}",
            f"JUMP MIN PREREQUISITE SCORE: {test.get('jumpPrerequisiteMinimum', 'N/A')}",
            f"JUMP MIN TARGET SCORE: {test.get('jumpTargetMinimum', 'N/A')}",
            "JUMP PREREQUISITES: " + (", ".join(
                slot["competencyId"] for slot in test.get("jumpPrerequisiteBlueprint", [])) or "N/A"),
            "",
        ])
    MARKDOWN_PATH.write_text("\n".join(lines).rstrip() + "\n")


def replace_fill_questions(course):
    """Replace every Order Flow fill with concept-specific market practice."""
    scenario_mc = {
        "What Is Order Flow?": ("What does order flow reveal?", ["Buyer and seller pressure", "Future prices with certainty", "Only candle direction"], "Order flow compares active pressure, liquidity, and price response."),
        "The Bid, Ask & Spread": ("What's the bid ask gap called?", ["The spread", "Delta", "Depth"], "The spread is the distance between the best bid and ask."),
        "Lifting the Offer & Hitting the Bid": ("How do sellers trade aggressively?", ["They hit the bid", "They post above the ask", "They raise the bid"], "Aggressive sellers cross the spread and execute against bids."),
        "What Actually Moves Price": ("What can create directional movement?", ["Aggression overwhelms or outlasts liquidity", "More candles appear", "Displayed size never changes"], "Price can move when pressure consumes liquidity, liquidity withdraws, or both."),
        "Choose the Order Type": ("What tradeoff guides order choice?", ["Speed versus price control", "Candle color versus volume", "Bid size versus chart scale"], "Market and limit orders trade speed against control of execution price."),
        "No Clear Order Flow Read": ("What does conflicting evidence suggest?", ["No clear read yet", "Follow the fastest signal", "Ignore price response"], "Conflicting evidence supports patience rather than a forced conclusion."),
    }
    evidence_select = {
        "Foundations and Book Mixed Review": ("Select the full market read.", ["Aggressor side", "Resting liquidity", "Price response", "Company headline"], [0, 1, 2]),
        "Liquidity Review": ("Select the two essential clues.", ["Event location", "Price response", "Candle color alone", "One isolated print"], [0, 1]),
        "Flow and Liquidity Mixed Review": ("Select the two confirmation clues.", ["Pressure at the level", "Acceptance or rejection", "Company size", "Chart color"], [0, 1]),
        "Breakout Review": ("Select the two breakout clues.", ["Aggressive pressure", "Acceptance beyond the level", "One large wall", "A brief wick through"], [0, 1]),
    }
    mark_levels = {
        "Resting Stops": ("supportBounce", "support", "Mark the support hiding inferred sell stops."),
        "Sell Stops": ("breakdown", "support", "Mark the level sell stops may sit below."),
    }
    candle_taps = {
        "Downside Sweep": ("rejectionWickDown", 4, "Tap the rejection after the sweep."),
        "Failed Breakout": ("resistanceRejection", 3, "Tap where the breakout fails."),
        "Breakout Retest": ("breakoutRetest", 2, "Tap the defended retest."),
    }
    tape_tasks = {
        "Bearish Continuation": ("hit", "Which tape clue supports continuation?", ["Seller prints regain persistence", "Buy prints accelerate at support", "Trade pace becomes balanced"]),
        "Pullback Failure": ("lift", "What changes as the pullback fails?", ["Counter pressure gains urgency", "Aggression disappears", "The spread proves continuation"]),
        "Continuation Review": ("accelerating", "What confirms continuation on tape?", ["Trend side pressure returns", "One opposing print appears", "Displayed depth stays unchanged"]),
    }
    footprint_tasks = {
        "Pullback Depth": ("balanced_target", "Tap the most balanced execution row."),
        "Order Flow at VWAP": ("total_target", "Tap the busiest row near VWAP."),
    }
    book_tasks = {
        "Liquidity Pools": ("Which book holds the larger liquidity pool?", ["Book A, with thick clustered depth", "Book B, with gaps and thin depth", "Both show equal liquidity"]),
        "Thin Liquidity": ("Which book should move more easily?", ["Book B, because depth is thin", "Book A, because depth is thick", "Both should move equally"]),
    }
    order_tasks = {
        "Breakdown Pressure": ["Sellers hit bids", "Bids trade or withdraw", "Price moves below support", "Acceptance is tested"],
        "Risk in Thin Liquidity": ["Inspect nearby depth", "Estimate slippage risk", "Reduce size if needed", "Define invalidation"],
    }

    for lesson_item in course["lessons"]:
        title = lesson_item["title"]
        replaced = []
        for screen in lesson_item["screens"]:
            if screen["type"] != "fill_blank":
                replaced.append(screen)
                continue
            node = lesson_item["node"]
            if title in scenario_mc:
                question, options, explanation = scenario_mc[title]
                replacement = {"type": "multiple_choice", "question": question, "options": options, "correct": 0, "explanation": explanation}
            elif title == "Review the Order Flow Read":
                replacement = {"type": "replay_compare", "question": "Which replay shows acceptance?", "options": ["Replay A", "Replay B", "Neither replay"], "correct": 0, "explanation": "Replay A clears offers and holds above the level. Replay B refreshes and rejects."}
            elif title in evidence_select:
                question, options, targets = evidence_select[title]
                replacement = {"type": "evidence_select", "question": question, "options": options, "targets": targets, "explanation": "A complete read separates aggression, liquidity, and price response."}
            elif title in mark_levels:
                chart, level_kind, question = mark_levels[title]
                replacement = {"type": "mark_level", "chart": chart, "level_kind": level_kind, "question": question, "explanation": "Stops are inferred beyond obvious levels rather than directly visible before triggering."}
            elif title in candle_taps:
                chart, target, question = candle_taps[title]
                replacement = {"type": "tap_candle", "chart": chart, "target": target, "question": question, "explanation": "Price response distinguishes rejection from acceptance."}
            elif title in tape_tasks:
                event, question, options = tape_tasks[title]
                replacement = {"type": "time_sales", "event": event, "question": question, "options": options, "correct": 0, "explanation": "Use completed executions to judge whether trend pressure returned."}
            elif title in footprint_tasks:
                event, question = footprint_tasks[title]
                replacement = {"type": "footprint_tap", "event": event, "target": (node * 3 + 1) % 7, "question": question, "explanation": "The selected row contains the requested execution profile."}
            elif title in book_tasks:
                question, options = book_tasks[title]
                replacement = {"type": "book_compare", "event": "pool" if title == "Liquidity Pools" else "thin",
                               "question": question, "options": options, "correct": 0,
                               "explanation": "Nearby depth changes how much pressure price needs to travel."}
            elif title in order_tasks:
                items = order_tasks[title]
                replacement = {"type": "sequence_builder", "question": "Build the decision sequence.", "items": items, "correct_order": items, "explanation": "Order flow decisions move from evidence to response and risk."}
            else:
                raise AssertionError(f"Unmapped fill question in {title}")
            replaced.append(replacement)
        lesson_item["screens"] = replaced


def apply_difficulty_progression(course):
    """Make difficulty come from evidence count, conflict, and ambiguity."""
    lessons = {item["title"]: item for item in course["lessons"]}

    def replace_first(title, kinds, replacement):
        screens = lessons[title]["screens"]
        for screen in screens:
            if screen["type"] == replacement["type"] and screen.get("question") == replacement.get("question"):
                screen.update(replacement)
                return
        for index, screen in enumerate(screens):
            if screen["type"] in kinds:
                screens[index] = replacement
                return
        raise AssertionError(f"No {kinds} screen to replace in {title}")

    # Unit 2 peaks in direct book use and bridges into absorption.
    replace_first("Large Orders as Walls", {"multiple_choice"}, {
        "type": "book_compare", "event": "wall", "question": "Which book shows the larger wall?",
        "options": ["Book A", "Book B", "Both are equal"], "correct": 0,
        "explanation": "Book A shows substantially more resting depth near price."})
    replace_first("Pulling & Spoofing", {"multiple_choice"}, {
        "type": "replay_compare", "event": "wall", "question": "Which wall absorbed selling?",
        "options": ["Replay A", "Replay B", "Neither replay"], "correct": 0,
        "explanation": "Replay A replenishes while trading and price holds. Replay B pulls before the decline."})

    # The later Tape lessons always pair execution with its price response.
    for title in ["Repeated Prints", "Buyer Initiated Prints", "Seller Initiated Prints", "Pace Changes", "Tape at Key Levels", "False Urgency", "Tape Reading Review"]:
        screens = lessons[title]["screens"]
        for index, screen in enumerate(screens):
            if screen["type"] == "aggressor":
                screens[index] = {"type": "evidence_select", "question": "Select both confirmation clues.",
                                  "options": ["Persistent tape pressure", "Matching price response", "One isolated print", "Candle color alone"],
                                  "targets": [0, 1],
                                  "explanation": "Intermediate tape reading combines executions with price follow through."}
    replace_first("Tape Reading Review", {"multiple_choice"}, {
        "type": "replay_compare", "question": "Which replay shows stronger buyer control?",
        "options": ["Replay A", "Replay B", "Both are equal"], "correct": 0,
        "explanation": "Both show buying, but only Replay A gains and holds higher prices."})

    # Unit 4 reinforces absorption versus exhaustion through direct comparison.
    replace_first("Hidden Liquidity", {"multiple_choice"}, {
        "type": "evidence_select", "question": "Select two hidden liquidity clues.",
        "options": ["Refreshing displayed size", "Repeated executions at one price", "Positive delta alone", "Candle color"],
        "targets": [0, 1],
        "explanation": "Repeated same price fills plus replenishment directly suggest hidden liquidity."})
    replace_first("Absorption or Exhaustion", {"multiple_choice"}, {
        "type": "replay_compare", "event": "absorption", "question": "Which replay shows absorption?",
        "options": ["Replay A", "Replay B", "Both show exhaustion"], "correct": 0,
        "explanation": "Replay A keeps strong aggression while price stalls. Replay B shows aggression fading."})

    # Unit 6 uses location and replay evidence instead of definitions.
    replace_first("Buy Stops", {"multiple_choice"}, {
        "type": "mark_level", "chart": "breakout", "level_kind": "resistance",
        "question": "Mark where buy stops may cluster.",
        "explanation": "Buy stops may cluster beyond obvious resistance or prior highs."})
    replace_first("Sweep or Breakout", {"multiple_choice"}, {
        "type": "replay_compare", "event": "sweep", "question": "Which replay gains acceptance?",
        "options": ["Replay B", "Replay A", "Both replays"], "correct": 0,
        "explanation": "Replay B holds beyond the level. Replay A rejects immediately."})

    # Unit 7 repeatedly contrasts a break with actual acceptance.
    for title, question, answer in [
        ("Breakout Pressure", "Which replay confirms a breakout?", "Replay A"),
        ("Failed Breakout", "Which replay traps breakout buyers?", "Replay B"),
        ("Breakout Retest", "Which replay shows a defended break?", "Replay A"),
        ("Breakout Review", "Which replay has genuine acceptance?", "Replay A"),
    ]:
        replace_first(title, {"book_drag", "aggressor", "multiple_choice", "tap_candle"}, {
            "type": "replay_compare", "event": "trap", "question": question,
            "options": [answer, "Replay B" if answer == "Replay A" else "Replay A", "Not enough evidence"], "correct": 0,
            "explanation": "Acceptance needs continued execution and price holding beyond the level."})
    for title in ["Breakdown Pressure", "Acceptance Above", "Acceptance Below", "Failed Breakdown", "Breakdown Retest", "Chasing Breakouts"]:
        screens = lessons[title]["screens"]
        for index, screen in enumerate(screens):
            if screen["type"] in {"book_drag", "aggressor"}:
                screens[index] = {"type": "evidence_select", "question": "Select the two acceptance clues.",
                                  "options": ["Execution persists", "Price holds beyond the level", "Price returns inside", "Liquidity replenishes against the move"],
                                  "targets": [0, 1],
                                  "explanation": "An advanced breakout read requires both pressure and acceptance."}

    # Unit 8 makes continuation conditional on multiple aligned clues.
    continuation_specs = {
        "Healthy Pullbacks": ["Shallow pullback", "Trend pressure returns", "Counter pressure accelerates", "Key level fails"],
        "Order Flow at VWAP": ["VWAP holds as location", "Trend aggression returns", "Price loses VWAP", "Counter tape accelerates"],
        "Conflicting Order Flow Signals": ["Tape and delta disagree", "Price response is weak", "Every clue aligns", "Acceptance is confirmed"],
        "Entry After Confirmation": ["Trend side aggression", "Confirming price response", "One isolated print", "An untested wall"],
    }
    for title, options in continuation_specs.items():
        replace_first(title, {"book_drag", "aggressor", "matching", "multiple_choice"}, {
            "type": "evidence_select", "question": "Select the two strongest clues.",
            "options": options, "targets": [0, 1],
            "explanation": "Advanced continuation requires structure plus confirming execution evidence."})
    for title in ["Pullback Depth", "Seller Pullback", "Continuation Trigger", "Bearish Continuation", "Order Flow at a Moving Average", "Pullback Failure", "High Volume Chop", "Low Volume Trend", "Continuation Review", "Breakout and Continuation Mixed Review"]:
        screens = lessons[title]["screens"]
        for index, screen in enumerate(screens):
            if screen["type"] in {"book_drag", "aggressor"}:
                screens[index] = {"type": "evidence_select", "question": "Select the two continuation clues.",
                                  "options": ["Structure remains intact", "Trend pressure returns", "Counter pressure accelerates", "The key level fails"],
                                  "targets": [0, 1],
                                  "explanation": "Continuation needs intact structure plus returning trend pressure."}

    # Unit 9 compares accepted breaks with traps and allows uncertainty.
    replace_first("Buyer Trap", {"multiple_choice"}, {
        "type": "replay_compare", "event": "trap", "question": "Which replay trapped buyers?",
        "options": ["Replay B", "Replay A", "Neither replay"], "correct": 0,
        "explanation": "Replay B returns below resistance and transfers control to sellers."})
    replace_first("Seller Trap", {"multiple_choice"}, {
        "type": "replay_compare", "event": "sweep", "question": "Which replay trapped sellers?",
        "options": ["Replay A", "Replay B", "Not enough evidence"], "correct": 0,
        "explanation": "The rejected break fails to gain acceptance and traps the initiating side."})

    # Unit 10 contains no isolated beginner mechanics. Each replacement asks
    # the learner to combine two execution or risk clues.
    expert_specs = {
        "Plan the Entry": ["Defined trigger", "Confirming response", "One fast print", "Candle color"],
        "Choose the Order Type": ["Available depth", "Execution urgency", "Chart pattern name", "Company size"],
        "Manage Slippage": ["Thin nearby depth", "Widening spread", "Positive delta", "A resting wall far away"],
        "Order Flow Invalidation": ["Opposing aggression", "Loss of the key level", "One small print", "Unchanged spread"],
        "Risk in Thin Liquidity": ["Sparse depth", "Higher slippage risk", "Large candle body", "Positive delta"],
        "No Clear Order Flow Read": ["Conflicting tape", "Unconfirmed price response", "One aligned clue", "Stable spread"],
        "Exit Into Liquidity": ["Available opposing liquidity", "Current execution pace", "Candle color", "Moving average slope"],
        "Review the Order Flow Read": ["Expected book behavior", "Expected price response", "Trade profit alone", "One final print"],
    }
    for title, options in expert_specs.items():
        screens = lessons[title]["screens"]
        for index, screen in enumerate(screens):
            if screen["type"] in {"book_drag", "aggressor", "matching"}:
                screens[index] = {"type": "evidence_select", "question": "Select the two relevant clues.",
                                  "options": options, "targets": [0, 1],
                                  "explanation": "Expert execution decisions combine market evidence with risk."}

    # By Advanced, isolated order routing and aggressor identification are no
    # longer sufficient. Replace any stragglers in Units 6 to 8 with paired
    # evidence tasks tied to each unit's reasoning goal.
    node_sections = {node["num"]: node["sectionIndex"] for node in course["nodes"]}
    advanced_evidence = {
        5: ("Select the two liquidity clues.", ["Nearby resting depth", "Execution at the level", "A distant candle", "Company news"]),
        6: ("Select the two acceptance clues.", ["Persistent execution", "Price holds beyond the level", "Immediate return inside", "One isolated print"]),
        7: ("Select the two continuation clues.", ["Structure remains intact", "Trend pressure returns", "Counter pressure accelerates", "The key level fails"]),
    }
    for lesson_item in course["lessons"]:
        section_index = node_sections[lesson_item["node"]]
        if section_index not in advanced_evidence:
            continue
        question, options = advanced_evidence[section_index]
        for index, screen in enumerate(lesson_item["screens"]):
            if screen["type"] in {"aggressor", "book_drag"}:
                lesson_item["screens"][index] = {
                    "type": "evidence_select", "question": question,
                    "options": options, "targets": [0, 1],
                    "explanation": "Advanced reads combine at least two aligned evidence sources.",
                }

    # Final QA: advanced evidence prompts must test the lesson's actual decision,
    # not repeat a generic unit template.
    specialized_evidence = {
        "Resting Stops": ("Select clues suggesting nearby stop liquidity.", ["An obvious prior low", "Repeated tests of that level", "A distant candle", "Displayed bids alone prove stops"]),
        "Buy Stops": ("Select clues that may fuel an upside trigger.", ["An obvious prior high", "Price pressing beneath it", "A slow print far below", "A bid wall under support"]),
        "Sell Stops": ("Select clues that may fuel a downside trigger.", ["An obvious prior low", "Price pressing above it", "An offer far above", "One green candle"]),
        "Liquidity Sweep": ("Select clues showing liquidity was taken and rejected.", ["Price trades through the level", "Price immediately returns inside", "Price holds beyond the level", "Execution continues away"]),
        "Upside Sweep": ("Select clues supporting an upside sweep.", ["The prior high trades", "Price rejects back below it", "Price builds acceptance above", "Offers stay cleared"]),
        "Downside Sweep": ("Select clues supporting a downside sweep.", ["The prior low trades", "Price rejects back above it", "Price accepts below support", "Selling keeps making progress"]),
        "Sweep or Breakout": ("Select clues showing acceptance instead of rejection.", ["Execution persists beyond the level", "Price holds outside the range", "Price immediately returns inside", "Aggression disappears"]),
        "Iceberg Orders": ("Select clues suggesting hidden replenishment.", ["Displayed size repeatedly refills", "Executions repeat at one price", "Positive delta alone", "One large candle"]),
        "Acceptance Above": ("Select the clues showing price accepted above resistance.", ["Buying persists above the level", "Price holds above resistance", "Price immediately returns inside", "The offer keeps rejecting price"]),
        "Acceptance Below": ("Select the clues showing price accepted below support.", ["Selling persists below the level", "Price holds below support", "Price immediately reclaims support", "The bid repeatedly absorbs selling"]),
        "Failed Breakdown": ("Select the clues showing the breakdown failed.", ["Price reclaims support", "Selling loses follow through", "Price holds below support", "Seller execution accelerates lower"]),
        "Breakdown Retest": ("Select the clues showing acceptance held on the retest.", ["Former support rejects price", "Selling resumes after the retest", "Price reclaims the range", "Buyers clear the nearby offer"]),
        "Chasing Breakouts": ("Select the clues still missing before acceptance is confirmed.", ["Sustained trade above the level", "A hold or successful retest", "One fast buy print", "A single wide candle"]),
    }
    for title, (question, options) in specialized_evidence.items():
        for screen in lessons[title]["screens"]:
            if screen["type"] == "evidence_select":
                screen.update({"question": question, "options": options, "targets": [0, 1],
                               "explanation": "The interaction must match the evidence required by this specific setup."})

    # Remove the three remaining exact duplicates in Unit 10 with mechanics
    # that better match the execution decision being tested.
    duplicate_replacements = {
        "Plan the Entry": {"type": "replay_compare", "event": "trigger", "question": "Which replay shows a confirmed trigger?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A reaches the trigger, confirms it, and produces a price response."},
        "Manage Slippage": {"type": "book_compare", "question": "Which book creates greater slippage risk?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Book B has thinner nearby depth and gaps."},
        "Exit Into Liquidity": {"type": "mark_level", "chart": "resistanceRejection", "level_kind": "resistance", "question": "Mark the opposing liquidity relevant to the exit.", "explanation": "Nearby opposing liquidity is more relevant than a distant level."},
    }
    for title, replacement in duplicate_replacements.items():
        seen = False
        for index, screen in enumerate(lessons[title]["screens"]):
            if screen["type"] == "evidence_select" and screen.get("question") == "Select the two relevant clues.":
                if seen:
                    lessons[title]["screens"][index] = replacement
                    break
                seen = True

    for screen in lessons["Footprint Imbalances"]["screens"]:
        if screen.get("options", [None])[0] == "Compare diagonal bid and ask volume by ratio":
            screen["question"] = "What comparison defines the imbalance?"

    # Evenly distribute direct footprint answers so screen position cannot
    # become an accidental shortcut.
    footprint_tap_index = 0
    for lesson_item in course["lessons"]:
        for screen in lesson_item["screens"]:
            if screen["type"] == "footprint_tap":
                screen["target"] = footprint_tap_index % 7
                footprint_tap_index += 1


def condense_course(course):
    """Merge mirrored micro-lessons into the requested 77-lesson course."""
    def evidence(question, options, explanation):
        return {"type": "evidence_select", "question": question, "options": options,
                "targets": [0, 1], "explanation": explanation}

    def choice(question, options, explanation):
        return {"type": "multiple_choice", "question": question, "options": options,
                "correct": 0, "explanation": explanation}

    def sequence(title):
        return {"type": "sequence_builder", "question": f"Build the reading process for {title}.",
                "items": ["Find the location", "Observe aggression", "Inspect liquidity", "Judge price response"],
                "correct_order": ["Find the location", "Observe aggression", "Inspect liquidity", "Judge price response"],
                "explanation": "Read context first, then action, liquidity, and response."}

    extension_bank = {
        "Repeated Prints & Sequence Breaks": [
            evidence("Which two clues make repeated prints meaningful?", ["One side keeps initiating", "Price responds to the sequence", "One isolated print", "Candle color changes"], "Persistence matters when execution produces a matching response."),
            choice("What makes a sequence break important?", ["The opposing print changes the established execution pattern", "It is always the largest print", "It guarantees a reversal"], "A sequence break matters when it interrupts persistent aggression."),
        ],
        "Tape at Key Levels": [
            evidence("Which two clues make tape activity meaningful at a key level?", ["Execution reaches the level", "Price shows acceptance or rejection", "The session logo changes", "A distant candle is large"], "Location and response give tape activity context."),
            choice("How should fast buying at resistance be interpreted?", ["Check whether price accepts above or rejects", "Assume buyers control the next candle", "Ignore the resting offer"], "Fast tape needs a confirming response at the level."),
        ],
        "What Is Absorption?": [
            evidence("Which two clues best support absorption?", ["Aggressive execution stays active", "Price makes little corresponding progress", "Aggression disappears", "Price accepts cleanly through the level"], "Absorption combines continued pressure with weak price progress."),
            choice("How should absorption be interpreted?", ["Passive liquidity is containing active pressure", "Aggression has completely stopped", "A reversal is guaranteed"], "Absorption describes pressure being contained, not a guaranteed reversal."),
        ],
        "What Is Exhaustion?": [
            evidence("Which two clues best support exhaustion?", ["Print pace or size fades", "Price stops extending in the original direction", "Aggression accelerates", "Price accepts farther through the level"], "Exhaustion means the initiating pressure itself is fading."),
            choice("How should exhaustion be interpreted?", ["The aggressive side is losing urgency", "Passive size must be hidden", "The opposing side has guaranteed control"], "Exhaustion weakens the prior move but still needs confirmation."),
        ],
        "Buyer vs. Seller Exhaustion": [
            evidence("Which two observations identify the exhausting side?", ["Its initiated prints lose pace", "Its price progress weakens", "Opposing liquidity disappears", "The spread never changes"], "Compare each side's urgency with the progress it produces."),
            choice("What separates buyer exhaustion from seller exhaustion?", ["Which initiating side loses pressure", "The candle color alone", "Whether total volume is high"], "Buyer and seller exhaustion mirror each other on opposite sides."),
        ],
        "Absorption vs. Exhaustion": [
            evidence("Which two clues distinguish absorption from exhaustion?", ["Whether aggression remains strong", "Whether price still makes progress", "The company sector", "The latest candle color"], "Absorption keeps pressure active; exhaustion shows that pressure fading."),
            choice("Strong aggression continues but price stalls. Which explanation fits?", ["Absorption", "Exhaustion", "Clean acceptance"], "Continued aggression without progress is the defining absorption pattern."),
        ],
        "Momentum Ignition": [
            evidence("Which two clues support momentum ignition?", ["Aggression expands suddenly", "Price begins making directional progress", "Execution stays balanced", "Opposing depth grows untouched"], "Ignition needs a surge in pressure and a matching price response."),
            choice("What makes a burst a possible momentum ignition?", ["It overwhelms nearby opposition and moves price", "It contains one large print", "It occurs after any green candle"], "A burst matters when it changes both liquidity and price."),
        ],
        "Stacked Pressure": [
            evidence("Which evidence makes stacked pressure more meaningful?", ["Several consecutive directional imbalances", "Price progresses with the stack", "One isolated large cell", "Balanced execution at every price"], "A stack is consecutive and stronger when price responds."),
            choice("What separates stacked pressure from one imbalance?", ["Directional imbalance repeats across adjacent prices", "The largest row has high volume", "Displayed depth is perfectly even"], "Stacking requires consecutive imbalances rather than one cell."),
        ],
        "Price and Pressure Divergence": [
            evidence("Which two clues define price and pressure divergence?", ["Aggression points one way", "Price response points the other way", "The spread is unchanged", "Total volume is low"], "Divergence is disagreement between executed pressure and price response."),
            choice("Positive pressure appears while price weakens. What is the best conclusion?", ["The buying is not achieving the expected response", "Higher prices are guaranteed later", "The execution data should be ignored"], "Pressure without its expected response is a warning, not a signal by itself."),
        ],
        "What Is a Liquidity Sweep?": [
            evidence("Which two clues identify a liquidity sweep?", ["Price trades beyond an obvious level", "Price quickly returns without acceptance", "Price holds beyond the level", "Execution continues cleanly away"], "A sweep takes liquidity and then rejects rather than accepting."),
            choice("How should a brief breach followed by immediate rejection be read?", ["Possible liquidity sweep", "Confirmed breakout acceptance", "Guaranteed reversal"], "The return inside shows that trade beyond the level was not accepted."),
        ],
        "Sweep vs. Breakout Acceptance": [
            evidence("Which two clues favor breakout acceptance over a sweep?", ["Execution persists beyond the level", "Price holds outside the prior range", "Price immediately returns inside", "Aggression disappears after the breach"], "Acceptance requires continued trade and a hold beyond the level."),
            choice("What best separates a sweep from an accepted breakout?", ["Whether price holds beyond the breached level", "Whether one large order traded", "The direction of the prior candle"], "The key distinction is rejection versus sustained acceptance."),
        ],
        "Icebergs & Hidden Replenishment": [
            evidence("Which two clues suggest an iceberg?", ["Displayed size repeatedly refills", "Executions repeat at the same price", "Positive delta appears once", "A distant wall remains visible"], "Repeated fills plus replenishment suggest hidden size."),
            choice("What makes repeated same price fills suspicious for hidden size?", ["Displayed liquidity keeps returning after it trades", "Every print has the same color", "Price must break out next"], "The visible amount understates what continues to execute."),
        ],
        "Breakout Acceptance Practice Replay": [
            evidence("Which two observations confirm the replay gained acceptance?", ["Offers clear with persistent buying", "Price establishes trade above resistance", "Price immediately falls back inside", "The offer keeps rejecting every attempt"], "Execution and sustained trade above the level confirm acceptance."),
            choice("Which response would invalidate this accepted breakout replay?", ["Price returns and holds below resistance", "Another buy prints at the ask", "The spread stays stable"], "A sustained return inside invalidates acceptance."),
        ],
        "Continuation Triggers": [
            evidence("Which two clues show trend pressure has actually returned?", ["Trend side execution accelerates", "Price resumes progress from structure", "Counter pressure strengthens", "The defended level fails"], "A trigger needs renewed pressure and confirming movement."),
            choice("What turns a pullback into a continuation setup?", ["Trend side aggression returns and price responds", "One fast print appears", "Volume is higher than yesterday"], "Continuation begins when the trend side regains effective control."),
        ],
        "Pullback Failure": [
            evidence("Which two clues show the pullback is failing?", ["Countertrend aggression strengthens", "Trend structure breaks", "Trend pressure returns", "The reference level holds"], "Growing counter pressure plus lost structure weakens continuation."),
            choice("When should a continuation idea be invalidated?", ["Counter pressure takes control and the key level fails", "One opposing print appears", "The tape briefly slows"], "Failure requires evidence that the original structure and control are gone."),
        ],
        "Reversal Pressure": [
            evidence("Which two clues support a change in reversal pressure?", ["The prior side stops making progress", "Opposing aggression gains follow through", "One rejection wick forms", "Total volume stays constant"], "A reversal needs weakening prior control and effective opposing pressure."),
            choice("What is the strongest evidence that control may be changing?", ["Opposing aggression begins producing price progress", "One large opposing print", "A familiar candle pattern appears"], "Control change is stronger when execution receives a confirming response."),
        ],
        "Exhaustion Reversals": [
            evidence("Which two clues best support an exhaustion reversal?", ["Prior aggression fades", "Opposing price response develops", "Original aggression accelerates", "Price continues cleanly in the original direction"], "Exhaustion plus an opposing response supports reversal."),
            choice("What must follow exhaustion before a reversal is stronger?", ["Opposing control and price confirmation", "A guaranteed target", "A larger candle wick"], "Fading pressure alone does not confirm that the other side has taken control."),
        ],
        "Absorption Reversals": [
            evidence("Which two clues best support an absorption reversal?", ["Heavy aggression makes little progress", "Opposing execution begins moving price", "The defended level immediately fails", "Aggression disappears before reaching the level"], "Contained pressure followed by opposing control supports reversal."),
            choice("When does absorption become a stronger reversal case?", ["The absorbed side fails and opposing pressure gains follow through", "Displayed size appears once", "Delta stays directional"], "Absorption needs a subsequent control change before it supports reversal."),
        ],
        "Order Flow Invalidation": [
            evidence("Which two observations invalidate an order flow read?", ["Opposing aggression takes control", "The key structural level fails", "One small opposing print", "The spread remains unchanged"], "Invalidation should be tied to evidence that disproves the original read."),
            choice("Where should invalidation be defined?", ["Beyond the evidence that would disprove the setup", "At an arbitrary fixed distance", "After the trade becomes profitable"], "Risk belongs where the underlying order flow thesis is no longer valid."),
        ],
        "No Clear Read": [
            evidence("Which two clues justify a no clear read decision?", ["Evidence sources conflict", "Price response remains unconfirmed", "One clue points directionally", "The spread is stable"], "Conflicting evidence and no confirmation are valid reasons to wait."),
            choice("What is the best action when book, tape, and price disagree?", ["Wait for clearer alignment", "Follow the fastest source", "Assume the footprint is always correct"], "No trade is a valid decision when evidence conflicts."),
        ],
        "Exiting Into Liquidity": [
            evidence("Which two clues matter when exiting into liquidity?", ["Nearby opposing depth", "Current execution pace", "Candle color alone", "A distant moving average"], "Exit planning should account for available liquidity and current execution."),
            choice("Why can opposing liquidity be useful for an exit?", ["It may provide counterparties near the planned price", "It guarantees zero slippage", "It predicts the next trend"], "Available counterparties can improve execution but never guarantee a fill."),
        ],
    }
    structures = [
        [
            ("What Is Order Flow?", ["What Is Order Flow?"], 6),
            ("Aggressive vs. Passive Orders", ["Aggressive vs. Passive Orders"], 6),
            ("The Bid, Ask & Spread", ["The Bid, Ask & Spread"], 6),
            ("Lifting the Offer & Hitting the Bid", ["Lifting the Offer & Hitting the Bid"], 6),
        ],
        [
            ("Reading the Order Book", ["What the Order Book Shows", "Bid Side vs. Ask Side"], 7),
            ("Size & Liquidity", ["Size & Liquidity"], 6),
            ("Large Orders as Walls", ["Large Orders as Walls"], 6),
            ("Pulling, Replenishment & Spoofing", ["Pulling & Spoofing"], 6),
            ("What Actually Moves Price", ["What Actually Moves Price"], 6),
            ("Order Book Challenge", ["The Order Book Review", "Foundations and Book Mixed Review"], 7),
        ],
        [
            ("Reading Time & Sales", ["Reading Time and Sales", "Reading the Tape"], 7),
            ("Speed & Size", ["Trade Speed", "Trade Size"], 7),
            ("Buyer vs. Seller Initiated Prints", ["Buyer Initiated Prints", "Seller Initiated Prints"], 7),
            ("Repeated Prints & Sequence Breaks", ["Repeated Prints"], 6),
            ("Acceleration, Slowdown & False Urgency", ["Pace Changes", "False Urgency"], 7),
            ("Tape at Key Levels", ["Tape at Key Levels"], 6),
        ],
        [
            ("What Is Absorption?", ["What Is Absorption"], 6),
            ("Buyer vs. Seller Absorption", ["Buyer Absorption", "Seller Absorption"], 7),
            ("Repeated Tests & Hidden Liquidity", ["Repeated Tests", "Hidden Liquidity"], 7),
            ("What Is Exhaustion?", ["What Is Exhaustion"], 6),
            ("Buyer vs. Seller Exhaustion", ["Buyer Exhaustion", "Seller Exhaustion"], 7),
            ("Absorption vs. Exhaustion", ["Absorption or Exhaustion"], 6),
            ("Absorption Practice Replays", ["Seller Absorption Simulation", "Buyer Absorption Simulation", "Absorption Review", "Tape and Absorption Mixed Review"], 6),
        ],
        [
            ("Reading Footprints & Imbalances", ["Reading a Footprint Chart", "Footprint Imbalances"], 7),
            ("Buyer vs. Seller Imbalances", ["Order Imbalance", "Buyer Imbalance", "Seller Imbalance"], 8),
            ("Momentum Ignition", ["Momentum Ignition"], 6),
            ("Momentum Continuation & Failure", ["Momentum Continuation", "Momentum Failure"], 7),
            ("Stacked Pressure", ["Stacked Pressure"], 6),
            ("Delta vs. Volume", ["Delta Thinking", "Delta vs Volume"], 7),
            ("Positive vs. Negative Delta Divergence", ["Positive Delta While Price Falls", "Negative Delta While Price Rises"], 7),
            ("Price and Pressure Divergence", ["Price and Pressure Divergence"], 6),
            ("Footprint & Momentum Challenge", ["Imbalance Review", "Momentum Ignition", "Momentum Failure", "Price and Pressure Divergence"], 8),
        ],
        [
            ("Liquidity Pools & Stop Clusters", ["Liquidity Pools", "Resting Stops"], 7),
            ("Buy Stops vs. Sell Stops", ["Buy Stops", "Sell Stops"], 7),
            ("What Is a Liquidity Sweep?", ["Liquidity Sweep"], 6),
            ("Upside vs. Downside Sweeps", ["Upside Sweep", "Downside Sweep"], 7),
            ("Sweep vs. Breakout Acceptance", ["Sweep or Breakout"], 6),
            ("Thin vs. Thick Liquidity", ["Thin Liquidity", "Thick Book vs Thin Book"], 7),
            ("Icebergs & Hidden Replenishment", ["Iceberg Orders"], 6),
            ("Liquidity Challenge", ["Liquidity Sweep Rejection Simulation", "Liquidity Review", "Flow and Liquidity Mixed Review"], 8),
        ],
        [
            ("Breakout vs. Breakdown Pressure", ["Breakout Pressure", "Breakdown Pressure"], 7),
            ("Acceptance Above vs. Below", ["Acceptance Above", "Acceptance Below"], 7),
            ("Breakout Acceptance Practice Replay", ["Breakout Acceptance Simulation"], 6),
            ("Failed Breakouts vs. Failed Breakdowns", ["Failed Breakout", "Failed Breakdown"], 7),
            ("Breakout and Breakdown Retests", ["Breakout Retest", "Breakdown Retest"], 7),
            ("Chasing, Confirmation & Common Misconceptions", ["Chasing Breakouts", "Common Order Flow Misconceptions"], 7),
            ("Breakout Challenge", ["Breakout Review", "Acceptance Above", "Failed Breakout", "Breakout Retest"], 8),
        ],
        [
            ("Healthy Pullbacks & Pullback Depth", ["Healthy Pullbacks", "Pullback Depth"], 7),
            ("Bullish vs. Bearish Pullbacks", ["Seller Pullback", "Bearish Continuation"], 7),
            ("Continuation Triggers", ["Continuation Trigger"], 6),
            ("Order Flow at VWAP & Moving Averages", ["Order Flow at VWAP", "Order Flow at a Moving Average"], 7),
            ("Pullback Failure", ["Pullback Failure"], 6),
            ("Conflicting Signals", ["Conflicting Order Flow Signals"], 6),
            ("Volume Context: Chop vs. Low Volume Trend", ["High Volume Chop", "Low Volume Trend"], 7),
            ("Confirmation & Continuation Challenge", ["Entry After Confirmation", "Continuation Review", "No Clear Read Simulation", "Breakout and Continuation Mixed Review"], 8),
        ],
        [
            ("Reversal Pressure", ["Reversal Pressure"], 6),
            ("Buyer Traps vs. Seller Traps", ["Buyer Trap", "Seller Trap"], 7),
            ("Exhaustion Reversals", ["Exhaustion Reversal"], 6),
            ("Absorption Reversals", ["Absorption Reversal"], 6),
            ("Double Top vs. Double Bottom Flow", ["Double Top Flow", "Double Bottom Flow"], 7),
            ("Reversal Confirmation & Insufficient Evidence", ["Confirmation Before Entry", "Reversal Review"], 7),
        ],
        [
            ("Planning the Entry & Choosing the Order Type", ["Plan the Entry", "Choose the Order Type"], 7),
            ("Slippage & Thin Liquidity Risk", ["Manage Slippage", "Risk in Thin Liquidity"], 7),
            ("Order Flow Invalidation", ["Order Flow Invalidation"], 6),
            ("No Clear Read", ["No Clear Order Flow Read"], 6),
            ("Exiting Into Liquidity", ["Exit Into Liquidity"], 6),
            ("Reviewing the Full Order Flow Read", ["Review the Order Flow Read", "Comprehensive Order Flow Simulation"], 8),
        ],
    ]
    old_lessons = {item["title"]: item for item in course["lessons"]}

    def select_screens(source_titles, target):
        groups = []
        for source_title in source_titles:
            if source_title not in old_lessons:
                raise AssertionError(f"Missing condensed source lesson: {source_title}")
            groups.append(old_lessons[source_title]["screens"])
        selected, seen = [], set()
        depth = 0
        while len(selected) < target and any(depth < len(group) for group in groups):
            for group in groups:
                if depth >= len(group):
                    continue
                screen = group[depth]
                key = (screen["type"], screen.get("question"))
                if key not in seen:
                    selected.append(dict(screen))
                    seen.add(key)
                    if len(selected) == target:
                        break
            depth += 1
        return selected

    def extend_short_lesson(title, screens, minimum):
        additions = extension_bank.get(title, []) + [sequence(title)]
        while len(screens) < minimum:
            if not additions:
                raise AssertionError(f"Missing concept specific extension for {title}")
            screens.append(additions[(len(screens) - 3) % len(additions)])
        return screens

    new_nodes, new_lessons = [], []
    continuation_evidence = {
        "Healthy Pullbacks & Pullback Depth": ("Select the clues showing the pullback remains healthy.", ["Counter pressure stays lighter", "Trend structure remains defended", "Counter pressure accelerates", "The key level fails"]),
        "Bullish vs. Bearish Pullbacks": ("Select the clues supporting continuation after the pullback.", ["Trend side pressure returns", "Price resumes from defended structure", "Counter pressure takes control", "Price loses the reference level"]),
        "Continuation Triggers": ("Select the clues showing trend pressure has actually returned.", ["Trend side execution accelerates", "Price makes renewed progress", "One isolated print appears", "Counter pressure strengthens"]),
        "Order Flow at VWAP & Moving Averages": ("Select the clues confirming the reference level held.", ["Execution defends the reference", "Price responds in the trend direction", "Price accepts through the reference", "Counter tape accelerates"]),
        "Confirmation & Continuation Challenge": ("Select the strongest continuation evidence.", ["Structure holds under the pullback", "Renewed trend pressure moves price", "One fast print appears", "The latest candle matches the trend"]),
    }
    challenge_prompt_overrides = {
        ("Footprint & Momentum Challenge", "What's the best footprint read?"): "How do the footprint rows combine into one directional read?",
        ("Footprint & Momentum Challenge", "Tap the row where buyer pressure concentrates."): "Tap where sustained buyer pressure is most concentrated.",
        ("Footprint & Momentum Challenge", "Tap where directional pressure disappears."): "Tap where the prior directional footprint loses control.",
        ("Footprint & Momentum Challenge", "Tap the execution clue opposing price."): "Tap the footprint row that most clearly conflicts with price.",
        ("Footprint & Momentum Challenge", "What best connects the evidence?"): "Which interpretation best combines delta with price response?",
        ("Footprint & Momentum Challenge", "Which conclusion fits the response?"): "Which momentum conclusion best fits this new response?",
        ("Footprint & Momentum Challenge", "What does the response suggest?"): "What does the changing response imply about momentum?",
        ("Liquidity Challenge", "What does the evidence support?"): "Which liquidity conclusion is best supported by the full setup?",
        ("Liquidity Challenge", "Which read needs fewer assumptions?"): "Which sweep interpretation needs fewer assumptions here?",
        ("Liquidity Challenge", "What matters most here?"): "Which liquidity behavior carries the most weight?",
        ("Liquidity Challenge", "Build the read."): "Order the liquidity evidence from location to response.",
        ("Liquidity Challenge", "Match each clue."): "Match each liquidity clue with the behavior it supports.",
        ("Breakout Challenge", "Select the clues showing price accepted above resistance."): "Select the clues showing trade became established beyond the level.",
        ("Breakout Challenge", "Which replay traps breakout buyers?"): "Which replay turns the initial break into a buyer trap?",
        ("Breakout Challenge", "Which replay shows a defended break?"): "Which replay survives the deeper retest?",
        ("Breakout Challenge", "Which price behavior supports the read?"): "Which evolving price response confirms acceptance?",
        ("Breakout Challenge", "What changed in price response?"): "Where does breakout follow through begin to fail?",
        ("Breakout Challenge", "Tap the clearest price response."): "Tap the candle that best confirms the order flow response.",
        ("Confirmation & Continuation Challenge", "Select the two strongest clues."): "Select the two clues that survive the mixed continuation test.",
        ("Confirmation & Continuation Challenge", "How should this be interpreted?"): "Which interpretation best resolves the mixed continuation evidence?",
        ("Confirmation & Continuation Challenge", "Mark the structure that provides location for the order flow read."): "Connect the structural anchors relevant to this continuation read.",
        ("Confirmation & Continuation Challenge", "What matters most here?"): "Which continuation evidence should carry the most weight?",
        ("Confirmation & Continuation Challenge", "Which price behavior supports the read?"): "Which live response confirms that trend pressure returned?",
        ("Confirmation & Continuation Challenge", "Match each clue."): "Match each continuation clue with the conclusion it supports.",
    }

    order_book_challenge = [
        {"type": "multiple_choice", "question": "What does Level II add to the inside bid and ask?", "options": ["Resting depth across multiple price levels", "Only the last completed trade", "Guaranteed future orders"], "correct": 0, "explanation": "Level II adds visible resting depth from the relevant feed."},
        {"type": "book_compare", "question": "Which book has thinner nearby depth?", "options": ["Book B", "Book A", "Both are equal"], "correct": 0, "explanation": "Book B has smaller size and gaps near price."},
        {"type": "book_drag", "order": "market_sell", "question": "Route the market sell to its fill side.", "explanation": "A market sell executes against the bid."},
        {"type": "replay_compare", "event": "wall_challenge", "question": "Which replay shows a wall holding rather than pulling?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A trades, replenishes, and holds price."},
        {"type": "aggressor", "event": "lift", "question": "Offers are being consumed. Who is aggressive?", "explanation": "Buyers are lifting the offer."},
        {"type": "evidence_select", "question": "Select the three parts of a complete book read.", "options": ["Aggressor activity", "Resting liquidity behavior", "Price response", "Candle color alone"], "targets": [0, 1, 2], "explanation": "A complete read combines action, liquidity, and response."},
        {"type": "orderflow_sim", "event": "seller_absorption", "question": "Buyers stay aggressive, the offer refreshes, and price stalls. What's strongest?", "options": ["The refreshing offer is containing aggressive buying", "Price is gaining clean acceptance above the offer", "Buyer urgency is clearly fading"], "correct": 0, "explanation": "The beginner observation is that replenishing liquidity contains active buying. Unit 4 later names this behavior absorption."},
    ]
    node = 1
    for section_index, specs in enumerate(structures):
        for title, sources, target in specs:
            screens = select_screens(sources, target)
            if title == "Order Book Challenge":
                screens = [dict(screen) for screen in order_book_challenge]
            if "Challenge" in title:
                for screen in screens:
                    override = challenge_prompt_overrides.get((title, screen.get("question")))
                    if override:
                        screen["question"] = override
                    if screen["type"] == "replay_compare":
                        event = screen.get("event") or "acceptance"
                        if not event.endswith("_challenge"):
                            screen["event"] = event + "_challenge"
            if title == "What Is Order Flow?":
                replacement = evidence("Select the three parts of a complete order flow read.",
                                       ["Aggressor activity", "Available liquidity", "Price response", "Candle color alone"],
                                       "A complete read combines who acts, where liquidity sits, and how price responds.")
                replacement["targets"] = [0, 1, 2]
                replace_index = next((i for i, screen in enumerate(screens)
                                      if screen.get("question") in {"What does order flow reveal?", "Select the three parts of a complete order flow read."}),
                                     min(4, len(screens) - 1))
                screens[replace_index] = replacement
            if title in continuation_evidence:
                question, options = continuation_evidence[title]
                for screen in screens:
                    if screen.get("question") == "Select the two continuation clues.":
                        screen.update({"question": question, "options": options, "targets": [0, 1],
                                       "explanation": "Continuation needs lesson specific structure and confirming execution."})
            minimum = 4 if "Practice Replay" in title else 5
            screens = extend_short_lesson(title, screens, minimum)

            # Every scored conclusion must expose the order flow evidence it
            # depends on rather than asking a candle chart to imply hidden data.
            if title == "What Is Absorption?":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "sideways":
                        screens[index] = {"type": "replay_compare", "event": "absorption_challenge",
                                          "question": "Which replay shows pressure being absorbed?",
                                          "options": ["Replay A", "Replay B", "Neither"], "correct": 0,
                                          "explanation": "Replay A keeps aggression active while replenishment prevents progress."}
            if title in {"Reading Time & Sales", "Speed & Size", "Buyer vs. Seller Initiated Prints", "Repeated Prints & Sequence Breaks", "Acceleration, Slowdown & False Urgency", "Tape at Key Levels"}:
                tape_response_events = {
                    "Reading Time & Sales": "conflict", "Speed & Size": "seller_absorption",
                    "Buyer vs. Seller Initiated Prints": "conflict", "Repeated Prints & Sequence Breaks": "breakout",
                    "Acceleration, Slowdown & False Urgency": "breakout", "Tape at Key Levels": "seller_absorption",
                }
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("question") == "Did price confirm the tape?":
                        replacement = dict(screen)
                        replacement.update({"type": "orderflow_sim", "event": tape_response_events[title]})
                        replacement.pop("chart", None)
                        replacement["explanation"] = "The composite view shows both executed pressure and the price response used to judge confirmation."
                        screens[index] = replacement
            if title == "Buyer vs. Seller Absorption":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "supportBounce":
                        screens[index] = {"type": "orderflow_sim", "event": "buyer_absorption", "question": "Sellers keep hitting a refreshing bid while support holds. What's strongest?", "options": ["Possible buyer absorption", "Seller continuation remains favored", "Seller exhaustion is proven"], "correct": 0, "explanation": "Active selling makes little progress while the bid replenishes."}
                    elif screen["type"] == "multiple_choice" and screen.get("chart") == "resistanceRejection":
                        screens[index] = {"type": "orderflow_sim", "event": "seller_absorption", "question": "Buyers keep lifting a refreshing offer while resistance holds. What's strongest?", "options": ["Possible seller absorption", "Buyer continuation remains favored", "Buyer exhaustion is proven"], "correct": 0, "explanation": "Active buying makes little progress while the offer replenishes."}
            if title == "Repeated Tests & Hidden Liquidity":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "doubleBottom":
                        screens[index] = {"type": "orderflow_sim", "event": "buyer_absorption", "question": "Repeated selling tests the level, the bid replenishes, and price still holds. What's strongest?", "options": ["Possible absorption at the defended level", "A downside break is confirmed", "The visible bid proves every hidden order"], "correct": 0, "explanation": "Repeated execution with replenishment and weak downward progress supports possible absorption."}
            if title == "What Is Exhaustion?":
                for index, screen in enumerate(screens):
                    if screen["type"] == "footprint":
                        screens[index] = {"type": "time_sales", "event": "stall", "question": "Which tape change would support exhaustion?", "options": ["Initiated pace and size fade near the extreme", "Aggression accelerates with price progress", "Displayed depth alone guarantees reversal"], "correct": 0, "explanation": "Exhaustion is visible as aggressive activity itself fades."}
            if title == "Buyer vs. Seller Exhaustion":
                for index, screen in enumerate(screens):
                    if screen["type"] == "footprint":
                        screens[index] = {"type": "time_sales", "event": "stall", "question": "Which tape change supports seller exhaustion near a low?", "options": ["Aggressive seller prints lose pace and size", "Seller prints accelerate through support", "Buyer initiated prints disappear completely"], "correct": 0, "explanation": "Seller exhaustion means the initiating sellers themselves lose urgency."}
            if title == "Absorption Practice Replays":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") in {"rejectionWickDown", "resistanceRejection", "supportBounce"}:
                        if screen.get("chart") == "rejectionWickDown":
                            screens[index] = {"type": "replay_compare", "event": "absorption_challenge", "question": "Which replay shows sustained pressure being contained rather than pressure fading?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A keeps aggression active against replenishment. Replay B shows exhaustion."}
                            continue
                        event = "buyer_absorption" if screen.get("chart") == "supportBounce" else "seller_absorption"
                        if event == "seller_absorption":
                            screens[index] = {"type": "orderflow_sim", "event": event, "question": "Buying remains active, the offer refreshes, and price cannot clear resistance. What's strongest?", "options": ["Possible seller absorption", "Buyer continuation is confirmed", "Buying has completely stopped"], "correct": 0, "explanation": "The simulation exposes active buying, replenishment, and weak upward response."}
                        else:
                            screens[index] = {"type": "orderflow_sim", "event": event, "question": "Selling remains active, the bid refreshes, and price cannot break support. What's strongest?", "options": ["Possible buyer absorption", "Seller continuation is confirmed", "Selling has completely stopped"], "correct": 0, "explanation": "The simulation exposes active selling, replenishment, and weak downward response."}
            if title == "Reading Footprints & Imbalances":
                duplicate_seen = False
                for screen in screens:
                    if screen.get("question") == "What comparison defines the imbalance?":
                        if duplicate_seen:
                            screen.update({"question": "Why isn't the largest same price difference automatically a diagonal imbalance?",
                                           "options": ["A conventional imbalance compares diagonally adjacent executions by ratio", "The largest cell always determines direction", "Only total candle volume matters"],
                                           "correct": 0,
                                           "explanation": "Diagonal imbalance uses adjacent prices and a defined ratio rather than one same price difference."})
                            screen.pop("chart", None)
                        duplicate_seen = True
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "sideways":
                        screens[index] = {"type": "footprint", "event": "balanced",
                                          "question": "What information does this balanced footprint provide?",
                                          "options": ["Executed bid and ask volume at each price", "Resting orders that have not traded", "Only the candle's final direction"],
                                          "correct": 0,
                                          "explanation": "A footprint displays completed executions separated by side and price."}
            if title == "Buyer vs. Seller Imbalances":
                for index, screen in enumerate(screens):
                    if screen.get("question") == "What best connects the evidence?":
                        screens[index] = {"type": "footprint", "event": "lift", "question": "What does this ask heavy footprint support?", "options": ["Buyer imbalance", "Seller imbalance", "Balanced execution"], "correct": 0, "explanation": "Ask side execution dominates across the relevant prices."}
                    elif screen.get("question") == "Which read needs fewer assumptions?":
                        screens[index] = {"type": "footprint", "event": "hit", "question": "What does this bid heavy footprint support?", "options": ["Seller imbalance", "Buyer imbalance", "Balanced execution"], "correct": 0, "explanation": "Bid side execution dominates across the relevant prices."}
            if title == "Positive vs. Negative Delta Divergence":
                replacements = [
                    {"type": "footprint", "event": "delta_positive", "question": "Price falls while footprint delta remains positive. What's strongest?", "options": ["Possible seller absorption or trapped buyers", "Positive delta guarantees higher prices", "The footprint should be ignored"], "correct": 0, "explanation": "Aggressive buying is failing to produce the expected upward response."},
                    {"type": "footprint", "event": "delta_negative", "question": "Price rises while footprint delta remains negative. What's strongest?", "options": ["Possible buyer absorption or trapped sellers", "Negative delta guarantees lower prices", "Price and execution cannot disagree"], "correct": 0, "explanation": "Aggressive selling is failing to produce the expected downward response."},
                ]
                replacement_index = 0
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") in {"bearishEngulfing", "bullishEngulfing"}:
                        screens[index] = replacements[replacement_index]
                        replacement_index += 1
                    elif screen["type"] == "sequence_builder" and screen.get("chart"):
                        screens[index] = {"type": "sequence_builder", "question": "Build the divergence reading process.",
                                          "items": ["Measure executed delta", "Compare the price response", "Inspect location and liquidity", "Form the divergence hypothesis"],
                                          "correct_order": ["Measure executed delta", "Compare the price response", "Inspect location and liquidity", "Form the divergence hypothesis"],
                                          "explanation": "Divergence starts by comparing executed pressure with the response it actually produced."}
            if title == "Delta vs. Volume":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "volatile":
                        screens[index] = {"type": "footprint", "event": "balanced", "question": "Which quantity measures net aggressive buying minus selling?", "options": ["Delta", "Total volume", "Displayed depth"], "correct": 0, "explanation": "Volume totals execution while delta nets ask and bid side execution."}
            if title == "Thin vs. Thick Liquidity":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "gapUp":
                        screens[index] = {"type": "book_compare", "question": "Which book lets price travel with less incoming pressure?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Book B has thinner nearby depth and gaps."}
            if title == "Icebergs & Hidden Replenishment":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "sideways":
                        screens[index] = {"type": "orderflow_sim", "event": "iceberg", "question": "Displayed size repeatedly refills after same price executions. What's strongest?", "options": ["A possible iceberg is replenishing hidden size", "The candle proves a breakout", "Every cancelled order is spoofing"], "correct": 0, "explanation": "Repeated fills plus replenishment may indicate hidden liquidity."}
                    elif screen["type"] == "time_sales_tap":
                        screens[index] = {"type": "replay_compare", "event": "absorption_challenge", "question": "Which replay shows repeated execution against replenishing displayed size?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A keeps executing into liquidity that returns while price remains pinned."}
            if title == "Upside vs. Downside Sweeps":
                for index, screen in enumerate(screens):
                    if screen["type"] == "tap_candle" and screen.get("chart") == "rejectionWickDown":
                        screen["question"] = "Tap the rejection after the downside sweep."
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "hammer":
                        screens[index] = {"type": "orderflow_sim", "event": "downside_sweep", "question": "Price trades below the prior low and immediately reclaims it. Is this a downside sweep or acceptance?", "options": ["Possible downside sweep", "Accepted breakdown", "Seller continuation remains favored"], "correct": 0, "explanation": "The breach takes liquidity but fails to gain acceptance below."}
                    elif screen["type"] == "multiple_choice" and screen.get("chart") == "rejectionWickUp":
                        screen["question"] = "Which upside sweep interpretation is best supported?"
            if title == "Buy Stops vs. Sell Stops":
                for screen in screens:
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "breakdown":
                        screen["question"] = "How can inferred sell stops below support affect a breakdown?"
            if title == "Breakout vs. Breakdown Pressure":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "breakdown":
                        screens[index] = {"type": "orderflow_sim", "event": "breakdown_pressure", "question": "Seller initiated prints persist as bids thin and price accepts below support. What's strongest?", "options": ["Breakdown pressure is producing acceptance", "A downside sweep has already rejected", "Buyer absorption is confirmed"], "correct": 0, "explanation": "The simulation shows selling, weakening bids, and sustained trade below support."}
                    elif screen["type"] == "evidence_select" and screen.get("question") == "Select the two acceptance clues.":
                        screens[index] = {"type": "evidence_select", "question": "Select the two clues supporting breakdown pressure.", "options": ["Seller execution persists", "Bids thin or get consumed", "Price immediately reclaims support", "Buying accelerates above the level"], "targets": [0, 1], "explanation": "Breakdown pressure combines active selling with weakening bid liquidity."}
            if title == "Chasing, Confirmation & Common Misconceptions":
                for index, screen in enumerate(screens):
                    if screen["type"] == "true_false" and screen.get("question") == "Fast tape guarantees a breakout.":
                        screens[index] = {"type": "orderflow_sim", "event": "conflict", "question": "Fast buying appears, but the offer refreshes and price stalls. Is breakout acceptance confirmed?", "options": ["No. Fast tape still needs price acceptance", "Yes. Speed alone confirms it", "Yes. Positive delta guarantees it"], "correct": 0, "explanation": "Fast tape is urgency, not confirmation."}
                    elif screen["type"] == "multiple_choice" and screen.get("chart") == "shootingStar":
                        screens[index] = {"type": "orderflow_sim", "event": "seller_absorption", "question": "Footprint delta stays positive while a refreshing offer prevents higher prices. What's strongest?", "options": ["Buying may be absorbed by passive sellers", "Positive delta guarantees delayed upside", "The execution data should be ignored"], "correct": 0, "explanation": "Positive delta with weak price progress can support possible seller absorption."}
            if title == "Exhaustion Reversals":
                for index, screen in enumerate(screens):
                    if index == 0 and screen["type"] == "time_sales":
                        screens[index] = {"type": "time_sales", "event": "stall", "question": "At the low, which tape change supports a seller exhaustion reversal?", "options": ["Seller initiated prints lose pace and size", "Seller aggression accelerates lower", "Buyer pressure disappears"], "correct": 0, "explanation": "Fading seller aggression can prepare a bullish control change."}
                    elif index == 1 and screen["type"] == "footprint":
                        screens[index] = {"type": "footprint", "event": "balanced", "question": "At the high, which footprint change supports a buyer exhaustion reversal?", "options": ["Buyer execution loses directional dominance", "Ask execution accelerates higher", "Every row becomes strongly ask heavy"], "correct": 0, "explanation": "Fading buyer dominance can prepare a bearish control change."}
            if title == "Volume Context: Chop vs. Low Volume Trend":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "range":
                        screens[index] = {"type": "orderflow_sim", "event": "chop", "question": "Heavy two sided execution produces little price progress. What's strongest?", "options": ["Possible high volume chop", "Clean directional momentum", "No meaningful trading occurred"], "correct": 0, "explanation": "High execution volume without directional progress can reflect two sided absorption."}
                    elif screen["type"] == "multiple_choice" and screen.get("chart") == "ascendingChannel":
                        screens[index] = {"type": "orderflow_sim", "event": "low_volume_trend", "question": "Price trends steadily while the opposing book stays thin. What's strongest?", "options": ["Thin opposition can allow a low volume trend", "High volume is required for every trend", "The tape proves absorption"], "correct": 0, "explanation": "Price can travel efficiently when little liquidity opposes it."}
            if title == "Slippage & Thin Liquidity Risk":
                for index, screen in enumerate(screens):
                    if screen["type"] == "multiple_choice" and screen.get("chart") == "bandsWidening":
                        screens[index] = {"type": "book_compare", "question": "Which book requires more cautious risk sizing?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Thin, unstable depth can increase execution risk."}
                    elif screen["type"] == "multiple_choice" and screen.get("chart") == "volatile":
                        screens[index] = {"type": "orderflow_sim", "event": "thin_risk", "question": "Nearby depth is sparse and the spread widens during execution. What's strongest?", "options": ["Slippage risk is elevated", "The fill price is guaranteed", "Delta removes execution risk"], "correct": 0, "explanation": "Sparse depth and a widening spread can move the fill away from the intended price."}
            new_nodes.append({"num": node, "svg": NODE_SVGS[section_index % len(NODE_SVGS)],
                              "title": title, "sectionIndex": section_index})
            new_lessons.append({"node": node, "title": title, "celebration": title + " complete.",
                                "lessonType": "PRACTICE_REPLAY" if "Practice Replay" in title else "STANDARD",
                                "screens": screens})
            node += 1
        # apply_boss_structure replaces this explicit final placeholder.
        new_nodes.append({"num": node, "svg": NODE_SVGS[section_index % len(NODE_SVGS)],
                          "title": "Boss Battle", "sectionIndex": section_index})
        new_lessons.append({"node": node, "title": "Boss Battle", "celebration": "Boss complete.",
                            "lessonType": "BOSS_BATTLE", "screens": []})
        node += 1
    course["nodes"] = new_nodes
    course["lessons"] = new_lessons
    assert len(new_lessons) == 77


def apply_boss_structure(course):
    """Convert each existing final review into one tier-appropriate Boss."""
    boss_specs = {
        0: ("Boss Battle: Foundations Under Pressure", [
            {"type": "aggressor", "event": "lift", "question": "Who is aggressive?", "correct": 0, "explanation": "Buyers are lifting offers."},
            {"type": "book_drag", "order": "market_buy", "question": "Where does a market buy execute?", "correct": 1, "explanation": "Market buys take the ask."},
            {"type": "book_drag", "order": "market_sell", "question": "Where does a market sell execute?", "correct": 0, "explanation": "Market sells hit the bid."},
            {"type": "multiple_choice", "question": "Which order is passive?", "options": ["A limit order resting at price", "A market order crossing now", "A completed execution"], "correct": 0, "explanation": "Passive orders rest as liquidity."},
            {"type": "evidence_select", "question": "Select the complete market read.", "options": ["Aggressor", "Liquidity", "Price response", "Candle color"], "targets": [0, 1, 2], "explanation": "A complete read combines action, liquidity, and response."},
            {"type": "multiple_choice", "question": "What does the spread measure?", "options": ["The distance between best bid and ask", "The last candle range", "Total traded volume"], "correct": 0, "explanation": "The spread separates the best resting bid and ask."},
            {"type": "sequence_builder", "question": "Build the order to price chain.", "items": ["Aggressor crosses the spread", "Resting liquidity trades", "Available price changes", "Chart records the response"], "correct_order": ["Aggressor crosses the spread", "Resting liquidity trades", "Available price changes", "Chart records the response"], "explanation": "Aggression interacts with liquidity before price records the result."},
        ]),
        1: ("Boss Battle: Read the Book", [
            {"type": "multiple_choice", "question": "What does Level II add?", "options": ["Depth across price levels", "Only the last trade", "Future orders with certainty"], "correct": 0, "explanation": "Level II displays resting depth across prices."},
            {"type": "book_compare", "question": "Which book should move more easily?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Book B is thinner and contains gaps."},
            {"type": "book_compare", "event": "wall", "question": "Which book has the larger wall?", "options": ["Book A", "Book B", "Neither book"], "correct": 0, "explanation": "Book A concentrates unusually large size at one level."},
            {"type": "replay_compare", "event": "wall", "question": "Which wall absorbed selling?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A replenishes while trading and price holds."},
            {"type": "multiple_choice", "question": "What happened when the bid vanished?", "options": ["Liquidity was pulled", "Selling was absorbed", "The spread closed"], "correct": 0, "explanation": "The displayed bid disappeared before trading."},
            {"type": "evidence_select", "question": "Select the holding wall clues.", "options": ["Repeated fills", "Replenishing size", "Price holds", "Wall pulls"], "targets": [0, 1, 2], "explanation": "Trading, replenishment, and response distinguish a holding wall."},
            {"type": "sequence_builder", "question": "Build the wall validation process.", "items": ["Locate unusual resting size", "Watch executions reach it", "Check whether size replenishes", "Judge the price response"], "correct_order": ["Locate unusual resting size", "Watch executions reach it", "Check whether size replenishes", "Judge the price response"], "explanation": "A wall matters only after its behavior and price response are observed."},
        ]),
        2: ("Boss Battle: Read the Tape", [
            {"type": "time_sales", "event": "lift", "question": "Who initiates these prints?", "options": ["Buyers", "Sellers", "Neither"], "correct": 0, "explanation": "Trades at the ask are buyer initiated."},
            {"type": "time_sales_tap", "event": "accelerating", "target": 4, "question": "Tap where pace accelerates.", "explanation": "Print intervals shorten here."},
            {"type": "time_sales_tap", "event": "large_print", "target": 6, "question": "Tap the unusually large print.", "explanation": "This print is much larger than surrounding trades."},
            {"type": "time_sales", "event": "lift", "question": "What does the sequence show?", "options": ["Persistent buyer aggression", "Persistent seller aggression", "No executions"], "correct": 0, "explanation": "Buyer initiated prints dominate."},
            {"type": "time_sales_tap", "event": "sequence_break", "target": 5, "question": "Tap the sequence break.", "explanation": "This opposing print interrupts the dominant side."},
            {"type": "orderflow_sim", "event": "breakout", "question": "Persistent buyer prints clear offers and price holds higher. Did price confirm the buying?", "options": ["Yes. Price advanced and held", "No. Price stalled against replenishment", "The price response remains inconclusive"], "correct": 0, "explanation": "The composite evidence shows both persistent buying and higher accepted prices."},
            {"type": "replay_compare", "event": "absorption", "question": "Which replay shows false urgency?", "options": ["Replay B", "Replay A", "Both"], "correct": 0, "explanation": "Replay B shows aggression fading rather than continuing control."},
        ]),
        3: ("Boss Battle: Absorption or Exhaustion?", [
            {"type": "replay_compare", "event": "absorption", "question": "Which replay shows absorption?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Aggression remains strong while price stalls."},
            {"type": "time_sales", "event": "stall", "question": "What does fading pace suggest?", "options": ["Exhaustion", "Absorption", "Acceptance"], "correct": 0, "explanation": "Exhaustion means aggression itself fades."},
            {"type": "orderflow_sim", "event": "buyer_absorption", "question": "Selling stays aggressive while support holds. What's strongest?", "options": ["Possible buyer absorption", "Seller continuation remains favored", "Seller exhaustion is developing"], "correct": 0, "explanation": "Selling remains active while support holds."},
            {"type": "orderflow_sim", "event": "seller_absorption", "question": "Buying stays aggressive while resistance holds. What's strongest?", "options": ["Possible seller absorption", "Buyer continuation remains favored", "Buyer exhaustion is developing"], "correct": 0, "explanation": "Buying remains active while resistance holds."},
            {"type": "time_sales", "event": "stall", "question": "Which side loses urgency?", "options": ["The aggressive side", "The passive side", "Neither side"], "correct": 0, "explanation": "Exhaustion appears as initiating activity fades."},
            {"type": "evidence_select", "question": "Select seller absorption clues.", "options": ["Refreshing offer", "Stalled price", "Fading buy pace", "Price accepts higher"], "targets": [0, 1], "explanation": "Replenishment and stalled response support absorption."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is a clear read confirmed?", "options": ["Not enough evidence", "Buyer absorption", "Seller exhaustion"], "correct": 0, "explanation": "Conflicting evidence does not confirm either interpretation."},
        ]),
        4: ("Boss Battle: Footprint & Momentum", [
            {"type": "footprint", "event": "balanced", "question": "What does each row show?", "options": ["Bid and ask executions by price", "Only resting orders", "Only candle volume"], "correct": 0, "explanation": "Footprints split executed volume at each price."},
            {"type": "footprint_tap", "event": "diagonal_ask", "target": 2, "question": "Tap the diagonal ask imbalance.", "explanation": "Ask volume exceeds the adjacent lower bid by ratio."},
            {"type": "footprint_tap", "event": "lift", "target": 4, "question": "Tap the strongest ask advantage.", "explanation": "This row has the strongest aggressive buying."},
            {"type": "footprint_tap", "event": "hit", "target": 1, "question": "Tap the strongest bid advantage.", "explanation": "This row has the strongest aggressive selling."},
            {"type": "footprint_tap", "event": "stacked_ask", "target": 2, "question": "Tap where stacked pressure begins.", "explanation": "Three consecutive ask imbalances start here."},
            {"type": "multiple_choice", "question": "How do volume and delta differ?", "options": ["Volume totals trades; delta nets aggression", "They are identical", "Delta shows resting depth"], "correct": 0, "explanation": "Delta compares ask and bid executions."},
            {"type": "orderflow_sim", "event": "seller_absorption", "question": "Positive delta, stalled price. Why?", "options": ["Possible seller absorption", "Buyer control remains favored", "Buyer exhaustion is developing"], "correct": 0, "explanation": "Buying can be absorbed despite positive delta."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is momentum confirmed?", "options": ["No. Price and pressure diverge", "Yes. Delta is enough", "Yes. Volume is high"], "correct": 0, "explanation": "Conflicting response warns of momentum failure."},
        ]),
        5: ("Boss Battle: Sweep or Acceptance?", [
            {"type": "mark_level", "chart": "breakout", "level_kind": "resistance", "question": "Mark inferred buy stops.", "explanation": "Buy stops may cluster beyond resistance."},
            {"type": "mark_level", "chart": "breakdown", "level_kind": "support", "question": "Mark inferred sell stops.", "explanation": "Sell stops may cluster beyond support."},
            {"type": "replay_compare", "event": "sweep", "question": "Which replay gains acceptance?", "options": ["Replay B", "Replay A", "Both"], "correct": 0, "explanation": "Replay B holds beyond the level."},
            {"type": "multiple_choice", "chart": "rejectionWickUp", "question": "What does the rejection suggest?", "options": ["Possible upside sweep", "Accepted breakout", "Buyer exhaustion at the level"], "correct": 0, "explanation": "Price trades above and returns inside."},
            {"type": "multiple_choice", "chart": "rejectionWickDown", "question": "What does this rejection suggest?", "options": ["Possible downside sweep", "Accepted breakdown", "Seller continuation remains favored"], "correct": 0, "explanation": "Price trades below and returns inside."},
            {"type": "book_compare", "question": "Which book should move more easily?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Thin depth lets price travel more easily."},
            {"type": "orderflow_sim", "event": "iceberg", "question": "The offer keeps refilling. Why?", "options": ["Possible iceberg", "Buyer exhaustion", "Breakout acceptance"], "correct": 0, "explanation": "Repeated replenishment can indicate hidden size."},
            {"type": "orderflow_sim", "event": "sweep", "question": "What's the strongest read?", "options": ["Liquidity taken; acceptance failed", "Breakout confirmed", "No stops triggered"], "correct": 0, "explanation": "The breach rejects instead of holding."},
        ]),
        6: ("Boss Battle: Breakout or Failure?", [
            {"type": "replay_compare", "event": "trap", "question": "Which replay shows acceptance?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A holds beyond resistance."},
            {"type": "replay_compare", "event": "trap", "question": "Which replay traps buyers?", "options": ["Replay B", "Replay A", "Neither"], "correct": 0, "explanation": "Replay B falls back inside."},
            {"type": "multiple_choice", "chart": "breakdown", "question": "What supports a breakdown?", "options": ["Persistent selling and acceptance", "One red candle", "A large distant offer"], "correct": 0, "explanation": "Pressure must produce trade below support."},
            {"type": "evidence_select", "question": "Select acceptance clues.", "options": ["Persistent execution", "Price holds beyond", "Immediate return inside", "Refreshing opposition"], "targets": [0, 1], "explanation": "Execution and holding response support acceptance."},
            {"type": "multiple_choice", "chart": "resistanceRejection", "question": "What invalidates the breakout?", "options": ["Price returns below resistance", "Tape stays fast", "Delta stays positive"], "correct": 0, "explanation": "Returning inside shows failed acceptance."},
            {"type": "multiple_choice", "chart": "supportBounce", "question": "What invalidates the breakdown?", "options": ["Price returns above support", "Tape stays fast", "Delta stays negative"], "correct": 0, "explanation": "Returning inside shows failed acceptance."},
            {"type": "multiple_choice", "question": "Why wait for a retest?", "options": ["To observe continued acceptance", "To guarantee profit", "To avoid all slippage"], "correct": 0, "explanation": "A retest can reveal whether the level now holds."},
            {"type": "orderflow_sim", "event": "breakout", "question": "What's the strongest read?", "options": ["Accepted breakout", "Liquidity sweep", "Not enough trading"], "correct": 0, "explanation": "Pressure persists and price holds beyond."},
        ]),
        7: ("Boss Battle: Continue, Fail, or Wait?", [
            {"type": "evidence_select", "question": "Select bullish continuation clues.", "options": ["Shallow pullback", "Buyer pressure returns", "Support fails", "Selling accelerates"], "targets": [0, 1], "explanation": "Structure and returning pressure support continuation."},
            {"type": "evidence_select", "question": "Select bearish continuation clues.", "options": ["Lower high holds", "Seller pressure returns", "Resistance fails", "Buying accelerates"], "targets": [0, 1], "explanation": "Bearish structure and selling support continuation."},
            {"type": "multiple_choice", "chart": "priceAboveVWAP", "question": "What matters at VWAP?", "options": ["Execution response at the level", "VWAP guarantees support", "Candle color alone"], "correct": 0, "explanation": "VWAP gives location; flow gives the read."},
            {"type": "multiple_choice", "chart": "priceAboveMA", "question": "What matters at the average?", "options": ["Execution response at the level", "The average guarantees support", "One print alone"], "correct": 0, "explanation": "The average is location, not confirmation."},
            {"type": "time_sales", "event": "stall", "question": "Trend pressure fades. Now what?", "options": ["Continuation is weakening", "Continuation is confirmed", "Location is irrelevant"], "correct": 0, "explanation": "Fading pressure weakens the continuation case."},
            {"type": "footprint", "event": "balanced", "question": "Heavy volume, little progress. Why?", "options": ["Possible high volume chop", "Directional pressure is cleanly one sided", "The quieter side has already lost control"], "correct": 0, "explanation": "Heavy two sided execution can produce chop."},
            {"type": "orderflow_sim", "event": "conflict", "question": "What's the best conclusion?", "options": ["No clear read yet", "Bullish continuation", "Bearish continuation"], "correct": 0, "explanation": "The evidence conflicts."},
            {"type": "evidence_select", "question": "Select pullback failure clues.", "options": ["Counter pressure accelerates", "Key structure fails", "Trend pressure returns", "Price holds the level"], "targets": [0, 1], "explanation": "Growing counter pressure and lost structure signal failure."},
        ]),
        8: ("Boss Battle: Trap or Reversal?", [
            {"type": "replay_compare", "event": "trap", "question": "Which replay traps buyers?", "options": ["Replay B", "Replay A", "Neither"], "correct": 0, "explanation": "Replay B fails above resistance."},
            {"type": "replay_compare", "event": "sweep", "question": "Which replay traps sellers?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "The rejected breach traps the initiating side."},
            {"type": "time_sales", "event": "stall", "question": "What supports exhaustion reversal?", "options": ["Aggression fades", "Aggression stays strong", "Price accepts lower"], "correct": 0, "explanation": "Exhaustion begins with fading aggression."},
            {"type": "orderflow_sim", "event": "buyer_absorption", "question": "What supports buyer absorption reversal?", "options": ["Selling stalls at support", "Selling accepts lower", "No bids replenish"], "correct": 0, "explanation": "Repeated selling fails to make progress."},
            {"type": "multiple_choice", "chart": "doubleTop", "question": "What matters on the second high test?", "options": ["Weaker buying and stronger defense", "The shape alone", "Equal candle colors"], "correct": 0, "explanation": "Compare execution and response across tests."},
            {"type": "multiple_choice", "chart": "doubleBottom", "question": "What matters on the second low test?", "options": ["Weaker selling and stronger defense", "The shape alone", "Equal candle colors"], "correct": 0, "explanation": "Compare execution and response across tests."},
            {"type": "evidence_select", "question": "Select reversal confirmation clues.", "options": ["Control changes", "Price confirms", "One rejection wick", "Mixed tape"], "targets": [0, 1], "explanation": "A reversal needs control change and response."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is a reversal confirmed?", "options": ["Not enough evidence", "Yes. The wick is enough", "Yes. Neutral delta confirms it"], "correct": 0, "explanation": "Mixed tape and balanced execution remain inconclusive."},
            {"type": "multiple_choice", "question": "When should entry wait?", "options": ["Until control and response align", "Until one large print", "Until any wick appears"], "correct": 0, "explanation": "Expert reversal reads require confirmation."},
        ]),
        9: ("FINAL BOSS: The Complete Order Flow Read", [
            {"type": "orderflow_sim", "event": "championship", "question": "Who is aggressive?", "options": ["Buyers", "Sellers", "Neither"], "correct": 0, "explanation": "Buyer initiated prints dominate."},
            {"type": "orderflow_sim", "event": "championship", "question": "Where is liquidity defending?", "options": ["At the refreshing offer", "Below the distant bid", "Nowhere"], "correct": 0, "explanation": "The offer replenishes after fills."},
            {"type": "orderflow_sim", "event": "championship", "question": "Is price responding?", "options": ["No. Price stalls", "Yes. Price accepts higher", "Response is irrelevant"], "correct": 0, "explanation": "Aggression makes little progress."},
            {"type": "orderflow_sim", "event": "championship", "question": "Which evidence conflicts?", "options": ["Positive delta and stalled price", "Fast tape and positive delta", "VWAP and resistance"], "correct": 0, "explanation": "Positive delta conflicts with weak price progress."},
            {"type": "orderflow_sim", "event": "championship", "question": "What's the strongest read?", "options": ["Possible seller absorption", "Buyer continuation remains favored", "Buyer exhaustion is developing"], "correct": 0, "explanation": "Refreshing offers and stalled price support absorption."},
            {"type": "orderflow_sim", "event": "championship", "question": "What invalidates the read?", "options": ["Price accepts above resistance", "Another buy print", "Stable spread"], "correct": 0, "explanation": "Acceptance higher invalidates seller absorption."},
            {"type": "orderflow_sim", "event": "championship", "question": "What execution risk is present?", "options": ["Slippage near changing depth", "Stable displayed depth should limit most slippage", "The current spread is more important than depth changes"], "correct": 0, "explanation": "Fast activity and changing depth increase slippage."},
            {"type": "book_compare", "question": "Which book shows thinner liquidity?", "options": ["Book B", "Book A", "Both"], "correct": 0, "explanation": "Book B has small size and gaps."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is direction confirmed?", "options": ["Not enough evidence", "Buyers fully control", "Sellers fully control"], "correct": 0, "explanation": "Conflicting evidence prevents confirmation."},
            {"type": "evidence_select", "question": "Select what to review afterward.", "options": ["Book behavior", "Tape response", "Footprint delta", "Trade profit only"], "targets": [0, 1, 2], "explanation": "Review each evidence source separately from outcome."},
        ]),
    }

    # Practice simulations remain ordinary replay lessons.
    for lesson_item in course["lessons"]:
        lesson_item["lessonType"] = "STANDARD"
        if (("Simulation" in lesson_item["title"] and lesson_item["title"] != "Comprehensive Order Flow Simulation")
                or "Practice Replay" in lesson_item["title"]):
            lesson_item["lessonType"] = "PRACTICE_REPLAY"
            lesson_item["title"] = lesson_item["title"].replace("Simulation", "Practice Replay")

    for section_index, (boss_title, screens) in boss_specs.items():
        section_nodes = [node for node in course["nodes"] if node["sectionIndex"] == section_index]
        boss_node = max(section_nodes, key=lambda node: node["num"])
        boss_lesson = next(item for item in course["lessons"] if item["node"] == boss_node["num"])
        boss_lesson.update({"title": boss_title, "lessonType": "BOSS_BATTLE",
                            "celebration": boss_title + " complete.", "screens": screens})
        boss_node["title"] = boss_title
        section = next(item for item in course["sections"] if item["index"] == section_index)
        section.update({"unitId": f"orderflow_{section_index + 1}", "difficulty": section["tier"].lower(),
                        "testOutEnabled": True, "testOutQuestionCount": 8 if section_index < 2 else (9 if section_index < 4 else 10),
                        "testOutPassingScore": 7 if section_index < 2 else (8 if section_index < 5 else 8),
                        "bossLessonId": f"orderflow_{section_index + 1}_boss",
                        "finalBossRequiredForCourseMastery": section_index == 9})


def dedupe_exact_question_blocks(course):
    """Keep repeated skills while preventing identical prompt and scenario blocks."""
    seen = set()
    for lesson_item in course["lessons"]:
        for screen in lesson_item["screens"]:
            key = (screen["type"], screen.get("question"), screen.get("chart"), screen.get("event"),
                   tuple(screen.get("options", [])), tuple(tuple(pair) for pair in screen.get("pairs", [])))
            if key not in seen:
                seen.add(key)
                continue
            title = lesson_item["title"]
            question = screen.get("question", "Read the evidence.")
            rewrites = {
                "Tap the aggressor.": f"In {title}, identify the side consuming resting liquidity.",
                "Tap the side this sell fills against.": f"Route the sell used in {title} to its execution side.",
                "Which book should move more easily?": f"Which depth profile in {title} should let price travel more easily?",
                "Select both confirmation clues.": f"Select both confirmation clues for {title}.",
                "Tap where fast activity begins losing follow through.": f"Tap where activity starts losing follow through in {title}.",
                "Build the read.": f"Build the {title.lower()} read.",
                "Tap the clearest price response.": f"Tap the price response that matters most for {title}.",
                "Build the decision sequence.": f"Build the decision sequence for {title}.",
                "Which price behavior supports the read?": f"Which live price behavior supports {title}?",
                "What changed in price response?": f"What changed in the {title.lower()} response?",
                "Which replay traps buyers?": f"Which replay creates the buyer trap in {title}?",
            }
            screen["question"] = rewrites.get(question, f"In this {title.lower()} setup, {question[0].lower() + question[1:] if question else 'read the evidence.'}")
            if screen["type"] == "replay_compare" and screen.get("event") == "trap":
                screen["event"] = "trap_challenge"
            if screen["type"] == "book_compare" and screen.get("event") is None:
                screen["event"] = "thin_variant"
            new_key = (screen["type"], screen.get("question"), screen.get("chart"), screen.get("event"),
                       tuple(screen.get("options", [])), tuple(tuple(pair) for pair in screen.get("pairs", [])))
            if new_key in seen:
                raise AssertionError(f"Could not deduplicate question in {title}: {screen.get('question')}")
            seen.add(new_key)


def validate_visual_alignment(course):
    """Reject chart-only questions whose answer requires invisible order-flow data."""
    invisible = re.compile(r"\b(delta|absorb|absorption|iceberg|hidden liquidity|slippage|level ii|tape|"
                           r"bids? (?:are )?(?:consumed|withdrawn)|offers? (?:are )?(?:consumed|withdrawn)|"
                           r"high volume|low volume|thin liquidity|replenish)\b", re.IGNORECASE)
    chart_only_types = {"multiple_choice", "true_false", "sequence_builder", "tap_candle", "draw_trendline", "live_chart"}
    errors = []
    for lesson_item in course["lessons"]:
        for screen in lesson_item["screens"]:
            if not screen.get("chart") or screen["type"] not in chart_only_types:
                continue
            correct = ""
            if screen.get("options"):
                correct = screen["options"][screen.get("correct", 0)]
            blob = f"{screen.get('question', '')} {correct}"
            if invisible.search(blob):
                errors.append(f"{lesson_item['title']}: {screen.get('question')}")
    if errors:
        raise AssertionError("Chart-only order-flow evidence mismatch:\n" + "\n".join(errors))


def apply_remaining_fix_list(course):
    """Apply the final evidence and wording QA pass without changing lesson size."""
    lessons = {item["node"]: item for item in course["lessons"]}

    def replace(node, index, screen):
        screens = lessons[node]["screens"]
        if not 1 <= index <= len(screens):
            raise AssertionError(f"Missing order flow question n{node}.q{index}")
        screens[index - 1] = screen

    def update(node, index, **changes):
        lessons[node]["screens"][index - 1].update(changes)

    # Venue/feed language and intent based spoofing language.
    update(6, 1, options=["Available depth across price levels from the relevant venue or feed.",
                           "Only the best bid and ask.", "Every trade already executed."],
           explanation="Level II shows available resting depth across prices from the relevant venue or feed.")
    update(6, 3, options=["Only the best bid and ask.",
                           "Available depth across prices from the relevant venue or feed.",
                           "The day's executed trades."])
    update(6, 5, pairs=[["Level I", "Best bid and ask"],
                         ["Level II", "Available depth from the relevant venue or feed"],
                         ["Time & Sales", "Executed trades"]],
           explanation="These lenses show top of book, available feed depth, and completed trades.")
    update(7, 2, question="A book with large displayed size at every nearby level...",
           options=["Shows greater displayed liquidity.", "Proves every order will remain.", "Guarantees low volatility."],
           explanation="Large displayed size suggests greater displayed liquidity, but orders can change or cancel.")
    update(7, 3, text="A thin book can move on less incoming pressure than a thick book.", correct=True,
           explanation="Sparse nearby depth can allow less incoming pressure to move price farther.")
    update(9, 4, pairs=[["Pulled order", "Cancelled before filling"],
                         ["Refreshed order", "Replenished after filling"],
                         ["Spoofing", "Deceptive order placement intended to mislead"]],
           explanation="Cancellation alone is not spoofing. Intent to mislead is central to the definition.")

    # Replace a redundant large print task with a genuine sequence break.
    replace(13, 5, {"type": "time_sales_tap", "event": "buyer_sequence_break", "target": 3,
                    "question": "Tap the buyer initiated print that breaks the seller sequence.",
                    "explanation": "This ask side execution interrupts the seller initiated sequence."})

    update(23, 2, question="Tap where activity starts losing follow through in What Is Exhaustion.")
    update(24, 1, event="buyer_fading", target=4, question="Which side is losing urgency?",
           options=["Aggressive buyers", "Aggressive sellers", "Neither initiating side"],
           explanation="Buyer initiated prints at the ask visibly lose pace and size.")

    # Delta questions must display both execution pressure and price response.
    update(33, 2, question="How do volume and delta differ?",
           explanation="Volume totals executed activity while delta nets aggressive buying against aggressive selling.")
    update(33, 5, question="What does net aggression compare?",
           explanation="Net aggression compares aggressive buying with aggressive selling.")
    replace(34, 1, {"type": "orderflow_sim", "event": "seller_absorption",
                    "question": "Positive delta builds while price stalls at resistance. What best explains the disagreement?",
                    "options": ["Possible seller absorption or trapped buyers", "Positive delta guarantees delayed upside", "The price response should be ignored"],
                    "correct": 0, "explanation": "Aggressive buying is visible, but it is not producing the expected upward response."})
    replace(35, 1, {"type": "orderflow_sim", "event": "conflict",
                    "question": "Positive execution pressure grows while upward price progress fades. What's strongest?",
                    "options": ["Price and pressure disagreement warns of weakness", "Positive delta confirms continuation", "The refreshing offer is irrelevant"],
                    "correct": 0, "explanation": "The multi source view makes the execution and price contradiction visible."})
    update(35, 2, question="Rising price is shown beside this footprint. Tap the negative delta row opposing it.",
           explanation="The selected negative delta row conflicts with the stated rising price context.")
    update(35, 3, question="What does price pressure disagreement suggest?")
    update(36, 5, question="Rising price is shown beside this footprint. Tap the negative delta row that conflicts with it.",
           explanation="The selected row shows aggressive selling even as price rises.")
    update(36, 6, options=["Delta matters most when price produces the expected response",
                            "Positive delta is sufficient confirmation for higher prices",
                            "The largest footprint row determines the next move",
                            "Price response can be ignored when delta is persistent"],
           explanation="Delta and the corresponding price response must be interpreted together.")

    # A failure requires an actual breach followed by a reclaim.
    replace(50, 2, {"type": "orderflow_sim", "event": "downside_sweep",
                    "question": "Price breaks support, fails to hold below it, and quickly reclaims it. What's strongest?",
                    "options": ["The breakdown failed", "Downside acceptance is established", "The initial breach guarantees continuation"],
                    "correct": 0, "explanation": "Trading below support followed by an immediate reclaim shows failed acceptance."})
    replace(50, 5, {"type": "orderflow_sim", "event": "sweep",
                    "question": "Price trades above resistance, fails to hold, and returns below it. What's strongest?",
                    "options": ["The breakout failed", "Upside acceptance is established", "Positive delta guarantees continuation"],
                    "correct": 0, "explanation": "The visible breach and return inside show failed acceptance."})
    replace(50, 7, {"type": "replay_compare", "event": "trap",
                    "question": "Which replay shows a breakout attempt failing back below resistance?",
                    "options": ["Replay B", "Replay A", "Neither replay"], "correct": 0,
                    "explanation": "Replay B first trades above resistance, then loses the level and returns inside."})
    replace(54, 3, {"type": "orderflow_sim", "event": "breakdown_pressure",
                    "question": "What supports the breakdown?",
                    "options": ["Persistent seller execution and acceptance below support", "One bearish candle", "A distant resting offer"],
                    "correct": 0, "explanation": "Tape, Level II, footprint, and price all support sustained downside acceptance."})
    replace(54, 5, {"type": "orderflow_sim", "event": "sweep", "question": "What invalidates the breakout?",
                    "options": ["Price returns below resistance after trading above it", "Buyer prints remain visible", "Positive delta appears during the breach"],
                    "correct": 0, "explanation": "The break is visible before price loses the level and returns inside."})
    replace(54, 6, {"type": "orderflow_sim", "event": "downside_sweep", "question": "What invalidates the breakdown?",
                    "options": ["Price returns above support after trading below it", "Seller prints remain visible", "Negative delta appears during the breach"],
                    "correct": 0, "explanation": "The break below support fails when price quickly reclaims the level."})

    update(58, 7, event="vwap_target", question="Tap the busiest footprint row aligned with VWAP.",
           explanation="The VWAP badge identifies the relevant price row, which also carries the highest total execution.")
    update(59, 3, event="hit", options=["Seller initiated prints accelerate at the bid", "Buyer pressure regains control", "The spread proves continuation"],
           explanation="Accelerating seller initiated execution is the counterpressure invalidating the bullish continuation attempt.")
    replace(60, 2, {"type": "orderflow_sim", "event": "conflict", "question": "What contradicts the fast buyer tape?",
                    "options": ["Positive delta and price response diverge", "The largest footprint cell decides direction", "Tape speed guarantees acceptance"],
                    "correct": 0, "explanation": "The tape is aggressive, but the footprint, refreshing offer, and fading price response conflict with it."})
    replace(61, 1, {"type": "orderflow_sim", "event": "chop", "question": "What defines this high volume chop?",
                    "options": ["Fast two sided execution with little price progress", "Measured one sided tape with efficient travel", "Sparse opposing depth and low activity"],
                    "correct": 0, "explanation": "Heavy alternating execution produces volume without directional progress."})
    replace(61, 2, {"type": "orderflow_sim", "event": "low_volume_trend", "question": "What defines this low volume trend?",
                    "options": ["Measured execution and thin opposition allow steady travel", "Fast two sided execution pins price", "Heavy opposing depth blocks every move"],
                    "correct": 0, "explanation": "Sparse opposition allows modest execution to move price efficiently."})
    replace(61, 4, {"type": "orderflow_sim", "event": "low_volume_trend", "question": "Is execution strongly directional?",
                    "options": ["No. Modest pressure travels through thin opposing depth", "Yes. A large directional footprint proves it", "No. Price is not moving"],
                    "correct": 0, "explanation": "Level II shows thin opposition while execution remains modest and price still travels."})
    update(62, 6, question="What's the strongest conclusion from the conflicting continuation evidence?")
    update(62, 7, question="Which live response fails to confirm that trend pressure returned?")

    # Reversal evidence now shows the transition, relevant level, and response.
    replace(64, 1, {"type": "orderflow_sim", "event": "seller_loses_control", "question": "What changed in control?",
                    "options": ["Seller aggression stopped moving price and buyer pressure emerged", "Seller control strengthened through support", "One opposing print guaranteed reversal"],
                    "correct": 0, "explanation": "The sequence shows selling, stalled downside progress, fading seller pace, and an opposing response."})
    replace(64, 3, {"type": "orderflow_sim", "event": "seller_loses_control", "question": "Which reversal read is best supported?",
                    "options": ["A visible control change is developing", "The bullish candle alone confirms reversal", "Seller aggression guarantees continuation"],
                    "correct": 0, "explanation": "Tape, liquidity, and price response show the prior side losing control and opposition emerging."})
    replace(65, 1, {"type": "orderflow_sim", "event": "sweep", "question": "What shows buyers became trapped?",
                    "options": ["Buying above resistance fails and price returns below", "Buyer prints appear above resistance", "Positive delta remains visible"],
                    "correct": 0, "explanation": "The attempted break fails to hold and reverses back below the level."})
    replace(65, 2, {"type": "orderflow_sim", "event": "downside_sweep", "question": "What shows sellers became trapped?",
                    "options": ["Selling below support fails and price reclaims above", "Seller prints appear below support", "Negative delta remains visible"],
                    "correct": 0, "explanation": "The attempted breakdown fails to hold and reverses above the level."})
    replace(65, 3, {"type": "orderflow_sim", "event": "sweep", "question": "What contradicts the positive delta?",
                    "options": ["Price returns below resistance", "Buyer initiated prints appear", "Offers briefly thin"],
                    "correct": 0, "explanation": "Positive delta fails to produce acceptance and price returns inside."})
    replace(65, 4, {"type": "orderflow_sim", "event": "downside_sweep", "question": "What contradicts the negative delta?",
                    "options": ["Price returns above support", "Seller initiated prints appear", "Bids briefly thin"],
                    "correct": 0, "explanation": "Negative delta fails to produce acceptance and price reclaims support."})
    replace(67, 1, {"type": "orderflow_sim", "event": "buyer_absorption", "question": "What shows pressure being absorbed?",
                    "options": ["Heavy seller prints make little downward progress", "Seller execution disappears before support", "Negative delta guarantees a breakdown"],
                    "correct": 0, "explanation": "Strong selling is visible while price barely declines against a replenishing bid."})
    replace(67, 2, {"type": "orderflow_sim", "event": "buyer_absorption", "question": "What supports possible passive defense?",
                    "options": ["The bid replenishes as repeated selling stalls", "One ask heavy footprint row", "A lower wick without execution evidence"],
                    "correct": 0, "explanation": "Repeated executions, replenishment, and stalled price jointly support possible passive defense."})
    replace(67, 3, {"type": "orderflow_sim", "event": "buyer_absorption", "question": "Which explanation fits best?",
                    "options": ["Possible buyer absorption can support a reversal", "The lower wick alone proves absorption", "Negative delta guarantees continuation"],
                    "correct": 0, "explanation": "Tape, Level II, and price response support possible buyer absorption without making it certain."})
    replace(68, 1, {"type": "replay_compare", "event": "double_top_flow", "question": "How does the second high test differ?",
                    "options": ["Replay B shows weaker buyer urgency", "Replay A shows weaker buyer urgency", "The tests show identical execution"], "correct": 0,
                    "explanation": "The second panel shows buying weakening while seller response strengthens."})
    replace(68, 2, {"type": "replay_compare", "event": "double_bottom_flow", "question": "Which side weakens on the second low test?",
                    "options": ["Aggressive sellers", "Aggressive buyers", "Neither side"], "correct": 0,
                    "explanation": "The second panel shows seller pace and size fading before buyers respond."})
    replace(68, 3, {"type": "replay_compare", "event": "double_top_flow", "question": "What changes on the second high test?",
                    "options": ["Seller response strengthens", "Buyer acceptance strengthens", "Execution remains identical"], "correct": 0,
                    "explanation": "The comparison shows stronger seller response on the retest."})
    replace(68, 4, {"type": "replay_compare", "event": "double_bottom_flow", "question": "What changes on the second low test?",
                    "options": ["Buyer response strengthens", "Seller acceptance strengthens", "Execution remains identical"], "correct": 0,
                    "explanation": "The comparison shows stronger buyer response on the retest."})
    replace(68, 5, {"type": "replay_compare", "event": "double_top_flow", "question": "What is the strongest conclusion from both high tests?",
                    "options": ["Repeated failure with weaker buying can shift control toward sellers", "The double top shape confirms a reversal by itself", "Both tests show identical buyer pressure"],
                    "correct": 0, "explanation": "The comparison shows weaker buying, stronger seller response, and failed acceptance on the second test."})
    replace(68, 6, {"type": "replay_compare", "event": "double_bottom_flow", "question": "What is the strongest conclusion from both low tests?",
                    "options": ["Repeated failure with weaker selling can shift control toward buyers", "The double bottom shape confirms a reversal by itself", "Both tests show identical seller pressure"],
                    "correct": 0, "explanation": "The comparison shows weaker selling, stronger buyer response, and a reclaim on the second test."})
    for question, prompt in [(1, "What confirms the reversal?"), (4, "What completes the reversal read?"), (6, "What verifies that aggressive control changed?")]:
        replace(69, question, {"type": "orderflow_sim", "event": "seller_loses_control", "question": prompt,
                               "options": ["The prior side stalls, opposing pressure strengthens, and price responds", "One opposing print appears", "A candle pattern forms without execution confirmation"],
                               "correct": 0, "explanation": "The full transition from prior control to opposing follow through is visible."})
    replace(69, 5, {"type": "orderflow_sim", "event": "seller_loses_control", "question": "Which reversal entry needs fewer assumptions?",
                    "options": ["Waiting for control change and confirming price response", "Entering from the candle pattern alone", "Entering after one opposing print"],
                    "correct": 0, "explanation": "Visible execution and price confirmation reduce reliance on pattern assumptions."})
    replace(69, 7, {"type": "orderflow_sim", "event": "seller_loses_control", "question": "What matters most before treating this as a reversal?",
                    "options": ["Control change and confirming price response", "The chart structure alone", "One large opposing execution"],
                    "correct": 0, "explanation": "A reversal requires the prior side to lose control and the opposing side to produce a confirming response."})
    update(70, 1, question="Which replay creates the buyer trap in Boss Battle: Trap or Reversal?")
    replace(70, 5, {"type": "replay_compare", "event": "double_top_flow", "question": "What matters on the second high test?",
                    "options": ["Replay B shows weaker buying and stronger defense", "The double top shape alone", "Both tests have the same execution"],
                    "correct": 0, "explanation": "The side by side execution comparison reveals weakening buying and firmer defense."})
    replace(70, 6, {"type": "replay_compare", "event": "double_bottom_flow", "question": "What matters on the second low test?",
                    "options": ["Replay B shows weaker selling and stronger defense", "The double bottom shape alone", "Both tests have the same execution"],
                    "correct": 0, "explanation": "The side by side execution comparison reveals weakening selling and firmer defense."})

    # Every Unit 10 order type candidate now tests the execution tradeoff.
    replace(71, 4, {"type": "multiple_choice", "question": "When urgency matters more than exact price control, which order best fits?",
                    "options": ["A market order", "A distant limit order", "An unsubmitted order"], "correct": 0,
                    "explanation": "A market order prioritizes immediate execution while accepting less price control."})
    update(73, 3, question="Where should the read be invalidated?")
    replace(75, 1, {"type": "orderflow_sim", "event": "exit_liquidity", "question": "What does the evidence support?",
                    "options": ["Visible opposing depth can help plan an exit area", "The exit price is guaranteed", "Resistance predicts the next trend"],
                    "correct": 0, "explanation": "Level II shows potential counterparties near the planned exit, but displayed liquidity can change."})
    update(75, 3, question="Mark the area where opposing liquidity may be expected.",
           explanation="The chart marks a potential exit area near resistance, not directly observed resting orders.")

    # Delta appears before its formal Unit 5 lesson only as clearly labeled,
    # nonessential context. Questions and correct answers remain solvable from
    # price, book, and tape evidence already taught in Units 1 through 4.
    node_sections = {node["num"]: node["sectionIndex"] for node in course["nodes"]}
    for lesson in course["lessons"]:
        if node_sections[lesson["node"]] >= 4:
            continue
        for item in lesson["screens"]:
            if item["type"] == "orderflow_sim":
                item["footprintPreview"] = True


def validate_remaining_fix_list(course):
    """Regression checks for the final review's named evidence defects."""
    lessons = {item["node"]: item for item in course["lessons"]}
    screen = lambda node, question: lessons[node]["screens"][question - 1]
    assert screen(24, 1).get("event") == "buyer_fading"
    assert screen(58, 7).get("event") == "vwap_target"
    assert screen(59, 3).get("event") == "hit"
    assert screen(62, 7).get("direction") == "sideways" and "fails to confirm" in screen(62, 7)["question"]
    assert screen(71, 4)["type"] == "multiple_choice" and "order" in screen(71, 4)["question"]
    assert screen(75, 1).get("event") == "exit_liquidity"
    assert screen(33, 5)["question"] == "What does net aggression compare?"
    assert screen(35, 2)["question"].startswith("Rising price is shown")
    assert screen(35, 3)["question"] == "What does price pressure disagreement suggest?"
    for node, question in [(64, 3), (69, 5), (69, 7)]:
        assert screen(node, question)["type"] == "orderflow_sim"
    for node, question in [(68, 5), (68, 6)]:
        assert screen(node, question)["type"] == "replay_compare"
    # Before formal footprint instruction, footprint data may be supplemental
    # inside simulations but cannot be necessary to answer a scored prompt.
    node_sections = {node["num"]: node["sectionIndex"] for node in course["nodes"]}
    for lesson in course["lessons"]:
        if node_sections[lesson["node"]] >= 4:
            continue
        for item in lesson["screens"]:
            correct = item.get("options", [""])[item.get("correct", 0)] if item.get("options") else ""
            required = f"{item.get('question', '')} {correct}".lower()
            if re.search(r"\b(footprint|delta|stacked imbalance)\b", required):
                raise AssertionError(f"Early footprint evidence is required in node {lesson['node']}: {item.get('question')}")
            if item["type"] == "orderflow_sim" and item.get("footprintPreview") is not True:
                raise AssertionError(f"Early simulation lacks supplemental delta preview in node {lesson['node']}")


def validate_test_out_semantics(course):
    """Verify scoped pools and guard known side-specific competencies."""
    semantic_rules = {
        "u1.aggressive_buyer": ["offers are getting eaten"], "u1.aggressive_seller": ["bids are getting eaten"],
        "u1.market_buy_routing": ["market buy"], "u1.market_sell_routing": ["market sell"],
        "u3.buyer_initiated": ["buyer initiated trades", "buyer initiated execution"],
        "u3.seller_initiated": ["seller initiated trades", "seller initiated execution"],
        "u3.large_print": ["unusually large participation", "unusually large executed trade"],
        "u3.tape_speed": ["arrive faster", "begins accelerating"],
        "u3.sequence_break": ["breaks the dominant side sequence", "sequence break important"],
        "u5.buyer_imbalance": ["strongest ask side advantage", "ask heavy footprint"],
        "u5.seller_imbalance": ["strongest bid side advantage", "bid heavy footprint"],
        "u5.momentum_failure": ["directional pressure disappears", "response suggest"],
        "u6.buy_stops": ["buy stops may cluster", "upside trigger"],
        "u6.sell_stops": ["sell stops can fuel", "sell stops may sit below", "sell stops below support"],
        "u6.upside_sweep": ["upside sweep"], "u6.downside_sweep": ["downside sweep"],
        "u7.breakdown_pressure": ["seller initiated prints persist", "clues supporting breakdown pressure"],
    }
    all_ids = {q["questionId"] for test in course["testOuts"] for q in test["questionPool"]}
    for test in course["testOuts"]:
        unit = test["unitIndex"]
        for competency in test["competencyBlueprint"]:
            eligible = test["competencyEligibleQuestionIds"].get(competency, [])
            if not eligible or not set(eligible).issubset(all_ids):
                raise AssertionError(f"Missing eligible questions for {competency}")
            questions = [q for q in test["questionPool"] if q["competencyId"] == competency]
            if {q["questionId"] for q in questions} != set(eligible):
                raise AssertionError(f"Eligible ID mismatch for {competency}")
            if any(q["sourceUnit"] != unit for q in questions):
                raise AssertionError(f"Future or cross-unit leak in {competency}")
            declared_nodes = set(test["competencySourceNodes"].get(competency, []))
            if {q["sourceNode"] for q in questions} != declared_nodes:
                raise AssertionError(f"Source node mismatch for {competency}")
            if competency in semantic_rules:
                for question in questions:
                    prompt = question.get("question", "").lower()
                    if not any(term in prompt for term in semantic_rules[competency]):
                        raise AssertionError(f"{competency} includes semantically wrong question {question['questionId']}: {prompt}")


def add_skill_tags_and_test_outs(course):
    """Tag every question and build larger assessment pools per unit."""
    footprint_taps = [screen for lesson_item in course["lessons"] for screen in lesson_item["screens"]
                      if screen["type"] == "footprint_tap"]
    for index, screen in enumerate(footprint_taps):
        screen["target"] = index % 7
    competency_blueprints = [
        ["aggressive_buyer", "aggressive_seller", "market_buy_routing", "market_sell_routing", "spread", "aggressive_vs_passive", "order_price_chain", "combined_read"],
        ["level_two", "resting_sides", "thick_liquidity", "thin_liquidity", "wall", "wall_behavior", "spoofing", "combined_book_read"],
        ["buyer_initiated", "seller_initiated", "large_print", "tape_speed", "persistent_aggression", "sequence_break", "false_urgency", "price_confirmation", "combined_tape_read"],
        ["absorption", "buyer_absorption", "seller_absorption", "repeated_tests", "hidden_liquidity", "buyer_exhaustion", "seller_exhaustion", "absorption_vs_exhaustion", "combined_absorption_read"],
        ["footprint_basics", "diagonal_imbalance", "buyer_imbalance", "seller_imbalance", "stacked_pressure", "momentum_failure", "delta_vs_volume", "positive_delta_divergence", "negative_delta_divergence", "combined_footprint_read"],
        ["liquidity_pool", "stop_cluster", "buy_stops", "sell_stops", "upside_sweep", "downside_sweep", "sweep_vs_acceptance", "book_depth", "iceberg", "combined_liquidity_read"],
        ["breakout_pressure", "breakdown_pressure", "acceptance_above", "acceptance_below", "failed_breakout", "failed_breakdown", "breakout_retest", "breakdown_retest", "sweep_vs_breakout", "combined_breakout_read"],
        ["healthy_pullback", "pullback_depth", "continuation_trigger", "bearish_continuation", "flow_at_vwap", "flow_at_average", "pullback_failure", "conflicting_signals", "volume_context", "no_clear_read"],
        ["reversal_pressure", "buyer_trap", "seller_trap", "buyer_exhaustion_reversal", "seller_exhaustion_reversal", "absorption_reversal", "double_top_flow", "double_bottom_flow", "reversal_confirmation", "insufficient_evidence"],
        ["entry_plan", "order_type", "slippage", "invalidation", "thin_liquidity_risk", "no_clear_read", "exit_liquidity", "review_process", "multi_source_evidence", "combined_execution_read"],
    ]
    competency_sources = [
        ["Lifting the Offer & Hitting the Bid", "Lifting the Offer & Hitting the Bid", "Aggressive vs. Passive Orders", "Aggressive vs. Passive Orders", "The Bid, Ask & Spread", "Aggressive vs. Passive Orders", "What Is Order Flow?", "What Is Order Flow?"],
        ["Reading the Order Book", "Reading the Order Book", "Size & Liquidity", "Size & Liquidity", "Large Orders as Walls", "Large Orders as Walls", "Pulling, Replenishment & Spoofing", "Order Book Challenge"],
        ["Buyer vs. Seller Initiated Prints", "Buyer vs. Seller Initiated Prints", "Speed & Size", "Speed & Size", "Repeated Prints & Sequence Breaks", "Repeated Prints & Sequence Breaks", "Acceleration, Slowdown & False Urgency", "Tape at Key Levels", "Reading Time & Sales"],
        ["What Is Absorption?", "Buyer vs. Seller Absorption", "Buyer vs. Seller Absorption", "Repeated Tests & Hidden Liquidity", "Repeated Tests & Hidden Liquidity", "Buyer vs. Seller Exhaustion", "Buyer vs. Seller Exhaustion", "Absorption vs. Exhaustion", "Absorption Practice Replays"],
        ["Reading Footprints & Imbalances", "Reading Footprints & Imbalances", "Buyer vs. Seller Imbalances", "Buyer vs. Seller Imbalances", "Stacked Pressure", "Momentum Continuation & Failure", "Delta vs. Volume", "Positive vs. Negative Delta Divergence", "Positive vs. Negative Delta Divergence", "Footprint & Momentum Challenge"],
        ["Liquidity Pools & Stop Clusters", "Liquidity Pools & Stop Clusters", "Buy Stops vs. Sell Stops", "Buy Stops vs. Sell Stops", "Upside vs. Downside Sweeps", "Upside vs. Downside Sweeps", "Sweep vs. Breakout Acceptance", "Thin vs. Thick Liquidity", "Icebergs & Hidden Replenishment", "Liquidity Challenge"],
        ["Breakout vs. Breakdown Pressure", "Breakout vs. Breakdown Pressure", "Acceptance Above vs. Below", "Acceptance Above vs. Below", "Failed Breakouts vs. Failed Breakdowns", "Failed Breakouts vs. Failed Breakdowns", "Breakout and Breakdown Retests", "Breakout and Breakdown Retests", "Chasing, Confirmation & Common Misconceptions", "Breakout Challenge"],
        ["Healthy Pullbacks & Pullback Depth", "Healthy Pullbacks & Pullback Depth", "Continuation Triggers", "Bullish vs. Bearish Pullbacks", "Order Flow at VWAP & Moving Averages", "Order Flow at VWAP & Moving Averages", "Pullback Failure", "Conflicting Signals", "Volume Context: Chop vs. Low Volume Trend", "Confirmation & Continuation Challenge"],
        ["Reversal Pressure", "Buyer Traps vs. Seller Traps", "Buyer Traps vs. Seller Traps", "Exhaustion Reversals", "Exhaustion Reversals", "Absorption Reversals", "Double Top vs. Double Bottom Flow", "Double Top vs. Double Bottom Flow", "Reversal Confirmation & Insufficient Evidence", "Reversal Confirmation & Insufficient Evidence"],
        ["Planning the Entry & Choosing the Order Type", "Planning the Entry & Choosing the Order Type", "Slippage & Thin Liquidity Risk", "Order Flow Invalidation", "Slippage & Thin Liquidity Risk", "No Clear Read", "Exiting Into Liquidity", "Reviewing the Full Order Flow Read", "Reviewing the Full Order Flow Read", "Reviewing the Full Order Flow Read"],
    ]
    explicit_eligible_ids = {
        "u1.aggressive_buyer": ["orderflow.u1.n4.q2"], "u1.aggressive_seller": ["orderflow.u1.n4.q3"],
        "u1.market_buy_routing": ["orderflow.u1.n2.q3"], "u1.market_sell_routing": ["orderflow.u1.n2.q4"],
        "u1.spread": ["orderflow.u1.n3.q1", "orderflow.u1.n3.q2", "orderflow.u1.n3.q3"],
        "u1.aggressive_vs_passive": ["orderflow.u1.n2.q1", "orderflow.u1.n2.q2", "orderflow.u1.n2.q6"],
        "u1.order_price_chain": ["orderflow.u1.n1.q6"], "u1.combined_read": ["orderflow.u1.n1.q5"],
        "u2.level_two": ["orderflow.u2.n6.q1"], "u2.resting_sides": ["orderflow.u2.n6.q2", "orderflow.u2.n6.q4"],
        "u2.thick_liquidity": ["orderflow.u2.n7.q2"], "u2.thin_liquidity": ["orderflow.u2.n7.q3", "orderflow.u2.n7.q4"],
        "u2.wall": ["orderflow.u2.n8.q1", "orderflow.u2.n8.q2"], "u2.wall_behavior": ["orderflow.u2.n8.q3", "orderflow.u2.n8.q4", "orderflow.u2.n8.q5"],
        "u2.spoofing": ["orderflow.u2.n9.q2", "orderflow.u2.n9.q3"], "u2.combined_book_read": ["orderflow.u2.n11.q6", "orderflow.u2.n11.q7"],
        "u3.buyer_initiated": ["orderflow.u3.n15.q1", "orderflow.u3.n15.q3"], "u3.seller_initiated": ["orderflow.u3.n15.q2", "orderflow.u3.n15.q4"],
        "u3.large_print": ["orderflow.u3.n14.q2", "orderflow.u3.n14.q4"], "u3.tape_speed": ["orderflow.u3.n14.q1", "orderflow.u3.n14.q3"],
        "u3.persistent_aggression": ["orderflow.u3.n16.q1", "orderflow.u3.n16.q4"], "u3.sequence_break": ["orderflow.u3.n16.q2", "orderflow.u3.n16.q5"],
        "u3.false_urgency": ["orderflow.u3.n17.q2", "orderflow.u3.n17.q4"], "u3.price_confirmation": ["orderflow.u3.n18.q3", "orderflow.u3.n18.q4"],
        "u3.combined_tape_read": ["orderflow.u3.n13.q1", "orderflow.u3.n13.q6"],
        "u4.absorption": ["orderflow.u4.n20.q1", "orderflow.u4.n20.q3", "orderflow.u4.n20.q4"],
        "u4.buyer_absorption": ["orderflow.u4.n21.q1", "orderflow.u4.n21.q2", "orderflow.u4.n21.q4"],
        "u4.seller_absorption": ["orderflow.u4.n21.q3", "orderflow.u4.n21.q5"],
        "u4.repeated_tests": ["orderflow.u4.n22.q1", "orderflow.u4.n22.q2", "orderflow.u4.n22.q4"],
        "u4.hidden_liquidity": ["orderflow.u4.n22.q3", "orderflow.u4.n22.q5"],
        "u4.buyer_exhaustion": ["orderflow.u4.n24.q1"], "u4.seller_exhaustion": ["orderflow.u4.n24.q3"],
        "u4.absorption_vs_exhaustion": ["orderflow.u4.n25.q1", "orderflow.u4.n25.q2", "orderflow.u4.n25.q3"],
        "u4.combined_absorption_read": ["orderflow.u4.n26.q1", "orderflow.u4.n26.q2", "orderflow.u4.n26.q4"],
        "u5.footprint_basics": ["orderflow.u5.n28.q1", "orderflow.u5.n28.q5"],
        "u5.diagonal_imbalance": ["orderflow.u5.n28.q2", "orderflow.u5.n28.q4", "orderflow.u5.n28.q6"],
        "u5.buyer_imbalance": ["orderflow.u5.n29.q3", "orderflow.u5.n29.q5"], "u5.seller_imbalance": ["orderflow.u5.n29.q4", "orderflow.u5.n29.q6"],
        "u5.stacked_pressure": ["orderflow.u5.n32.q2", "orderflow.u5.n32.q4", "orderflow.u5.n32.q5"],
        "u5.momentum_failure": ["orderflow.u5.n31.q3", "orderflow.u5.n31.q5"],
        "u5.delta_vs_volume": ["orderflow.u5.n33.q2", "orderflow.u5.n33.q4", "orderflow.u5.n33.q6"],
        "u5.positive_delta_divergence": ["orderflow.u5.n34.q2", "orderflow.u5.n34.q4"],
        "u5.negative_delta_divergence": ["orderflow.u5.n34.q3", "orderflow.u5.n34.q5"],
        "u5.combined_footprint_read": ["orderflow.u5.n36.q1", "orderflow.u5.n36.q5", "orderflow.u5.n36.q6"],
        "u6.liquidity_pool": ["orderflow.u6.n38.q1"], "u6.stop_cluster": ["orderflow.u6.n38.q2", "orderflow.u6.n38.q4", "orderflow.u6.n38.q6"],
        "u6.buy_stops": ["orderflow.u6.n39.q1", "orderflow.u6.n39.q3"], "u6.sell_stops": ["orderflow.u6.n39.q2", "orderflow.u6.n39.q6"],
        "u6.upside_sweep": ["orderflow.u6.n41.q3", "orderflow.u6.n41.q5"], "u6.downside_sweep": ["orderflow.u6.n41.q2", "orderflow.u6.n41.q4"],
        "u6.sweep_vs_acceptance": ["orderflow.u6.n42.q1", "orderflow.u6.n42.q2", "orderflow.u6.n42.q4", "orderflow.u6.n42.q5"],
        "u6.book_depth": ["orderflow.u6.n43.q1", "orderflow.u6.n43.q2", "orderflow.u6.n43.q4"],
        "u6.iceberg": ["orderflow.u6.n44.q1", "orderflow.u6.n44.q2", "orderflow.u6.n44.q3", "orderflow.u6.n44.q4"],
        "u6.combined_liquidity_read": ["orderflow.u6.n45.q1", "orderflow.u6.n45.q2", "orderflow.u6.n45.q6"],
        "u7.breakout_pressure": ["orderflow.u7.n47.q1"], "u7.breakdown_pressure": ["orderflow.u7.n47.q2", "orderflow.u7.n47.q3"],
        "u7.acceptance_above": ["orderflow.u7.n48.q1", "orderflow.u7.n48.q2"], "u7.acceptance_below": ["orderflow.u7.n48.q4", "orderflow.u7.n48.q6"],
        "u7.failed_breakout": ["orderflow.u7.n50.q1", "orderflow.u7.n50.q5", "orderflow.u7.n50.q7"],
        "u7.failed_breakdown": ["orderflow.u7.n50.q2", "orderflow.u7.n50.q4"],
        "u7.breakout_retest": ["orderflow.u7.n51.q1", "orderflow.u7.n51.q5"], "u7.breakdown_retest": ["orderflow.u7.n51.q2", "orderflow.u7.n51.q7"],
        "u7.sweep_vs_breakout": ["orderflow.u7.n52.q3", "orderflow.u7.n52.q4"],
        "u7.combined_breakout_read": ["orderflow.u7.n53.q1", "orderflow.u7.n53.q2", "orderflow.u7.n53.q8"],
        "u8.healthy_pullback": ["orderflow.u8.n55.q1", "orderflow.u8.n55.q3"], "u8.pullback_depth": ["orderflow.u8.n55.q2", "orderflow.u8.n55.q4"],
        "u8.continuation_trigger": ["orderflow.u8.n57.q2", "orderflow.u8.n57.q3", "orderflow.u8.n57.q5"],
        "u8.bearish_continuation": ["orderflow.u8.n56.q1", "orderflow.u8.n56.q2", "orderflow.u8.n56.q4"],
        "u8.flow_at_vwap": ["orderflow.u8.n58.q1", "orderflow.u8.n58.q5", "orderflow.u8.n58.q7"],
        "u8.flow_at_average": ["orderflow.u8.n58.q2", "orderflow.u8.n58.q4"],
        "u8.pullback_failure": ["orderflow.u8.n59.q1", "orderflow.u8.n59.q3", "orderflow.u8.n59.q4", "orderflow.u8.n59.q5"],
        "u8.conflicting_signals": ["orderflow.u8.n60.q1", "orderflow.u8.n60.q2", "orderflow.u8.n60.q3"],
        "u8.volume_context": ["orderflow.u8.n61.q1", "orderflow.u8.n61.q2", "orderflow.u8.n61.q3", "orderflow.u8.n61.q4", "orderflow.u8.n61.q5", "orderflow.u8.n61.q6"],
        "u8.no_clear_read": ["orderflow.u8.n62.q3", "orderflow.u8.n62.q6"],
        "u9.reversal_pressure": ["orderflow.u9.n64.q1", "orderflow.u9.n64.q2", "orderflow.u9.n64.q4", "orderflow.u9.n64.q5"],
        "u9.buyer_trap": ["orderflow.u9.n65.q1", "orderflow.u9.n65.q3", "orderflow.u9.n65.q5"],
        "u9.seller_trap": ["orderflow.u9.n65.q2", "orderflow.u9.n65.q4", "orderflow.u9.n65.q6"],
        "u9.buyer_exhaustion_reversal": ["orderflow.u9.n66.q2"],
        "u9.seller_exhaustion_reversal": ["orderflow.u9.n66.q1"],
        "u9.absorption_reversal": ["orderflow.u9.n67.q1", "orderflow.u9.n67.q2", "orderflow.u9.n67.q4", "orderflow.u9.n67.q5"],
        "u9.double_top_flow": ["orderflow.u9.n68.q1", "orderflow.u9.n68.q3", "orderflow.u9.n68.q5"],
        "u9.double_bottom_flow": ["orderflow.u9.n68.q2", "orderflow.u9.n68.q4", "orderflow.u9.n68.q6"],
        "u9.reversal_confirmation": ["orderflow.u9.n69.q1", "orderflow.u9.n69.q3", "orderflow.u9.n69.q5", "orderflow.u9.n69.q6"],
        "u9.insufficient_evidence": ["orderflow.u9.n69.q2", "orderflow.u9.n69.q7"],
        "u10.entry_plan": ["orderflow.u10.n71.q1", "orderflow.u10.n71.q3", "orderflow.u10.n71.q5"],
        "u10.order_type": ["orderflow.u10.n71.q2", "orderflow.u10.n71.q4", "orderflow.u10.n71.q6"],
        "u10.slippage": ["orderflow.u10.n72.q1", "orderflow.u10.n72.q3", "orderflow.u10.n72.q5"],
        "u10.invalidation": ["orderflow.u10.n73.q2", "orderflow.u10.n73.q3", "orderflow.u10.n73.q5"],
        "u10.thin_liquidity_risk": ["orderflow.u10.n72.q2", "orderflow.u10.n72.q4"],
        "u10.no_clear_read": ["orderflow.u10.n74.q1", "orderflow.u10.n74.q2", "orderflow.u10.n74.q3", "orderflow.u10.n74.q4", "orderflow.u10.n74.q5"],
        "u10.exit_liquidity": ["orderflow.u10.n75.q1", "orderflow.u10.n75.q2", "orderflow.u10.n75.q3", "orderflow.u10.n75.q5"],
        "u10.review_process": ["orderflow.u10.n76.q1"],
        "u10.multi_source_evidence": ["orderflow.u10.n76.q2", "orderflow.u10.n76.q4", "orderflow.u10.n76.q6", "orderflow.u10.n76.q7"],
        "u10.combined_execution_read": ["orderflow.u10.n76.q5", "orderflow.u10.n76.q8"],
    }
    def skill_for(title, screen):
        kind = screen["type"]
        title_key = re.sub(r"[^a-z0-9]+", "_", title.lower()).strip("_")
        mechanic_skills = {
            "time_sales": "tape_reading", "time_sales_tap": "tape_interaction",
            "footprint": "footprint_reading", "footprint_tap": "footprint_interaction",
            "book_compare": "book_depth", "mark_level": "liquidity_location",
            "replay_compare": "scenario_comparison", "orderflow_sim": "multi_signal_read",
            "evidence_select": "evidence_synthesis", "aggressor": "aggressor_side",
            "book_drag": "order_routing", "sequence_builder": "market_sequence",
        }
        title_skills = {
            "The Bid, Ask & Spread": "bid_ask_spread",
            "Lifting the Offer & Hitting the Bid": "lifting_offer_hitting_bid",
            "Pulling, Replenishment & Spoofing": "pulling_and_spoofing",
        }
        return mechanic_skills.get(kind, title_skills.get(title, title_key[:48]))

    node_sections = {node["num"]: node["sectionIndex"] for node in course["nodes"]}
    expected_competencies = {f"u{unit + 1}.{competency}" for unit, blueprint in enumerate(competency_blueprints) for competency in blueprint}
    if set(explicit_eligible_ids) != expected_competencies:
        raise AssertionError(f"Explicit competency manifest mismatch: missing={sorted(expected_competencies - set(explicit_eligible_ids))}, extra={sorted(set(explicit_eligible_ids) - expected_competencies)}")
    pools = {index: [] for index in range(10)}
    for lesson_item in course["lessons"]:
        section_index = node_sections[lesson_item["node"]]
        for screen_index, screen in enumerate(lesson_item["screens"]):
            screen["skillId"] = skill_for(lesson_item["title"], screen)
            if lesson_item["lessonType"] != "BOSS_BATTLE":
                pools[section_index].append({**screen, "sourceLesson": lesson_item["title"],
                                             "sourceUnit": section_index, "sourceNode": lesson_item["node"],
                                             "questionId": f"orderflow.u{section_index + 1}.n{lesson_item['node']}.q{screen_index + 1}"})

    course["testOuts"] = []
    for section in course["sections"]:
        index = section["index"]
        count = section["testOutQuestionCount"]
        blueprint = [f"u{index + 1}.{competency}" for competency in competency_blueprints[index]]
        assessment_pool = []
        # Each competency maps to questions from the lesson that actually teaches
        # it. The explicit manifest prevents mirrored or adjacent skills from
        # leaking into one another after future lesson merges.
        for competency, source_title in zip(blueprint, competency_sources[index]):
            allowed_ids = set(explicit_eligible_ids.get(competency, []))
            candidates = [question for question in pools[index]
                          if question["sourceLesson"] == source_title and question["questionId"] in allowed_ids]
            if not candidates:
                raise AssertionError(f"No assessment questions for {competency} from {source_title}")
            if {question["questionId"] for question in candidates} != allowed_ids:
                missing = allowed_ids - {question["questionId"] for question in candidates}
                raise AssertionError(f"Missing explicit question IDs for {competency}: {sorted(missing)}")
            for question in candidates:
                assessment_pool.append({**question, "competencyId": competency})
        competency_mappings = {
            competency: sorted({q["skillId"] for q in assessment_pool if q["competencyId"] == competency})
            for competency in blueprint
        }
        eligible_question_ids = {
            competency: [q["questionId"] for q in assessment_pool if q["competencyId"] == competency]
            for competency in blueprint
        }
        competency_source_nodes = {
            competency: sorted({q["sourceNode"] for q in assessment_pool if q["competencyId"] == competency})
            for competency in blueprint
        }
        course["testOuts"].append({
            "unitIndex": index, "unitId": section["unitId"], "lessonType": "TEST_OUT",
            "questionCount": count, "passingScore": section["testOutPassingScore"],
            "noHearts": True, "revealAnswersAtEnd": True,
            "questionPool": assessment_pool,
            "competencyBlueprint": blueprint,
            "competencyMappings": competency_mappings,
            "competencyEligibleQuestionIds": eligible_question_ids,
            "competencySourceUnits": {competency: [index] for competency in blueprint},
            "competencySourceNodes": competency_source_nodes,
        })

    jump_lengths = [0, 8, 10, 12, 14, 14, 16, 16, 18, 20]
    for target_index in range(1, 10):
        test = course["testOuts"][target_index]
        total = jump_lengths[target_index]
        prerequisite_count = total // 2
        target_count = total - prerequisite_count
        prerequisite_slots = []
        # Start with one representative from every prior unit, then fill the
        # remaining slots from additional prior competencies. This guarantees
        # broad cumulative coverage rather than oversampling the nearest unit.
        representative_indices = [2, 2, 7, 7, 6, 6, 5, 6, 8]
        for prior_index in range(target_index):
            prior_blueprint = course["testOuts"][prior_index]["competencyBlueprint"]
            slot_index = min(representative_indices[prior_index], len(prior_blueprint) - 1)
            prerequisite_slots.append({"unitIndex": prior_index, "competencyId": prior_blueprint[slot_index]})
        if len(prerequisite_slots) < prerequisite_count:
            synthesis_blueprint = course["testOuts"][target_index - 1]["competencyBlueprint"]
            prerequisite_slots.append({"unitIndex": target_index - 1, "competencyId": synthesis_blueprint[-1]})
        fill_round = 0
        while len(prerequisite_slots) < prerequisite_count:
            prior_index = fill_round % target_index
            prior_blueprint = course["testOuts"][prior_index]["competencyBlueprint"]
            slot_index = (fill_round // target_index + 1) % len(prior_blueprint)
            slot = {"unitIndex": prior_index, "competencyId": prior_blueprint[slot_index]}
            if slot not in prerequisite_slots:
                prerequisite_slots.append(slot)
            fill_round += 1
        target_blueprint = test["competencyBlueprint"][:target_count]
        if target_index == 7:  # Unit 8 combines the two location variants.
            target_blueprint = [test["competencyBlueprint"][i] for i in [0, 1, 2, 3, 4, 6, 7, 9]]
        test.update({
            "jumpAheadQuestionCount": total,
            "jumpPassingScore": (total * 4 + 4) // 5,
            "jumpPrerequisiteMinimum": (prerequisite_count * 3 + 3) // 4,
            "jumpTargetMinimum": (target_count * 3 + 3) // 4,
            "jumpPrerequisiteBlueprint": prerequisite_slots[:prerequisite_count],
            "jumpTargetBlueprint": target_blueprint,
        })


def main():
    data = json.loads(DATA_PATH.read_text())
    course = next(c for c in data["courses"] if c["id"] == "orderflow")

    # Preserve the handcrafted foundation lessons by title so this remains
    # idempotent after renumbering and generated curriculum updates.
    authored_titles = [
        "What Is Order Flow?", "Aggressive vs. Passive Orders", "The Bid, Ask & Spread",
        "Lifting the Offer & Hitting the Bid", "Order Flow Foundations Review",
        "What the Order Book Shows", "Bid Side vs. Ask Side", "Size & Liquidity",
        "Large Orders as Walls", "Pulling & Spoofing", "The Order Book Review",
        "What Actually Moves Price",
    ]
    existing = {item["title"]: item for item in course["lessons"]}
    authored_aliases = {
        "Order Flow Foundations Review": "Boss Battle: Foundations Under Pressure",
        "What the Order Book Shows": "Reading the Order Book",
        "Bid Side vs. Ask Side": "Reading the Order Book",
        "Pulling & Spoofing": "Pulling, Replenishment & Spoofing",
        "The Order Book Review": "Order Book Challenge",
    }
    authored = {title: existing.get(title) or existing[authored_aliases[title]] for title in authored_titles}
    original_sections = course["sections"][:2]
    original_sections[0]["tier"] = "Beginner"
    original_sections[1]["tier"] = "Beginner"
    course["sections"] = original_sections
    course["nodes"] = []
    course["lessons"] = []

    unit_one = authored_titles[:5]
    unit_two = authored_titles[5:11]
    node = 1
    def add_authored(title, section_index):
        nonlocal node
        item = authored[title]
        course["nodes"].append({"num": node, "svg": NODE_SVGS[section_index], "title": title, "sectionIndex": section_index})
        normalized = {**item, "node": node, "title": title}
        normalized.pop("lessonType", None)
        course["lessons"].append(normalized)
        node += 1

    for title in unit_one:
        add_authored(title, 0)
    for title in unit_two:
        add_authored(title, 1)
    add_authored("What Actually Moves Price", 1)
    mixed = lesson("Foundations and Book Mixed Review", "sideways", "neutral", "aggression liquidity and response", "A complete read combines who acts where liquidity rests and how price responds")
    course["nodes"].append({"num": node, "svg": NODE_SVGS[1], "title": mixed["title"], "sectionIndex": 1})
    course["lessons"].append({"node": node, "title": mixed["title"], "celebration": mixed["title"] + " complete.", "screens": screens_for(mixed, node, 1)})
    node += 1

    for section_index, unit in enumerate(UNITS, start=2):
        tier = "Intermediate" if section_index <= 3 else ("Advanced" if section_index <= 7 else "Expert")
        course["sections"].append({
            "index": section_index,
            "eyebrow": unit["eyebrow"],
            "title": unit["title"],
            "bg": unit["bg"],
            "slab": unit["slab"],
            "tier": tier,
        })
        for lesson_index, meta in enumerate(unit["lessons"]):
            course["nodes"].append({
                "num": node,
                "svg": NODE_SVGS[section_index % len(NODE_SVGS)],
                "title": meta["title"],
                "sectionIndex": section_index,
            })
            course["lessons"].append({
                "node": node,
                "title": meta["title"],
                "celebration": meta["title"] + " complete.",
                "screens": screens_for(meta, node, section_index),
            })
            node += 1

    replace_fill_questions(course)
    apply_difficulty_progression(course)
    condense_course(course)
    apply_boss_structure(course)
    apply_remaining_fix_list(course)
    validate_visual_alignment(course)
    validate_remaining_fix_list(course)
    dedupe_exact_question_blocks(course)
    add_skill_tags_and_test_outs(course)
    validate_test_out_semantics(course)

    assert len(course["sections"]) == 10
    assert len(course["nodes"]) == 77
    assert len(course["lessons"]) == len(course["nodes"])
    expected_nodes = list(range(1, len(course["nodes"]) + 1))
    assert [node["num"] for node in course["nodes"]] == expected_nodes
    assert [item["node"] for item in course["lessons"]] == expected_nodes
    all_screens = [screen for item in course["lessons"] for screen in item["screens"]]
    assert not any(screen["type"] == "fill_blank" for screen in all_screens)
    visual_screens = [
        screen for screen in all_screens
        if screen["type"] in {"aggressor", "book_drag", "book_compare", "evidence_select", "replay_compare", "live_chart", "time_sales", "time_sales_tap", "footprint", "footprint_tap", "orderflow_sim"} or "chart" in screen
    ]
    # The handcrafted foundation includes a few essential nonvisual checks.
    # Later units remain overwhelmingly visual despite shorter lesson lengths.
    assert len(visual_screens) / len(all_screens) >= 0.75
    cleaned_course = remove_text_dashes(course)
    data["courses"][data["courses"].index(course)] = cleaned_course
    DATA_PATH.write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n")
    write_markdown(cleaned_course)


if __name__ == "__main__":
    main()
