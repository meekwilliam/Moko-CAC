#!/usr/bin/env python3
"""Expand the Order Flow course with a deterministic visual curriculum."""

import json
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
    question = questions[node % len(questions)]
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
        if title == "False Urgency":
            chart_answer = "No. Price failed to follow through"
            chart_options = [chart_answer, "Yes. Speed confirmed acceptance", "No. The spread was too narrow"]
        elif meta["bias"] == "up":
            chart_answer = "Yes. Price made upward progress"
            chart_options = [chart_answer, "No. Price rejected the buying", "Not enough trades appeared"]
        elif meta["bias"] == "down":
            chart_answer = "Yes. Price made downward progress"
            chart_options = [chart_answer, "No. Price absorbed the selling", "The chart cannot show response"]
        else:
            chart_answer = "Price response remains inconclusive"
            chart_options = [chart_answer, "Price fully confirms buyers", "Price fully confirms sellers"]
        response_chart = "uptrend" if meta["bias"] == "up" else ("downtrend" if meta["bias"] == "down" else "sideways")
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
            {"type": "time_sales", "event": "lift", "question": "The offer refills after buy prints. Why?", "options": ["A possible sell iceberg is replenishing hidden size", "Buyers have already secured a breakout", "The tape is showing canceled orders", "Displayed size cannot change after a fill"], "correct": 0, "explanation": "Repeated execution against refreshing displayed size is consistent with an iceberg."},
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
                {"type": "time_sales", "event": "hit" if meta["bias"] == "up" else "lift", "question": tape_question, "options": [tape_answer, "Pressure and price accelerate together", "No aggressive executions appear"], "correct": 0, "explanation": "Absorption requires pressure plus a weak corresponding price response."},
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
        return "Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels."
    if kind == "evidence_select":
        return "Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination."
    if kind == "replay_compare":
        replay_visuals = {
            "wall": "Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.",
            "sweep": "Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.",
            "trap": "Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.",
            "absorption": "Replay A keeps strong buying against a replenishing offer with stalled price. Replay B shows buying pace itself fading as price stalls.",
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
        }
        detail = tape_details.get(screen.get("event"), "mixed buyer and seller initiated executions")
        return f"An animated Time and Sales table lists time, execution price, and trade size, with {detail}."
    if kind in {"footprint", "footprint_tap"}:
        event = screen.get("event", "balanced")
        detail = {"lift": "one target row carrying the largest ask side execution advantage", "hit": "one target row carrying the largest bid side execution advantage", "balanced": "similar bid and ask volume across the price rows", "balanced_target": "one target row with the smallest bid ask execution difference", "total_target": "one target row with the largest combined executed volume", "diagonal_ask": "ask volume at the target price exceeding bid volume at the diagonally adjacent lower price by a clear ratio", "stacked_ask": "three consecutive rows showing ask side execution imbalances", "delta_positive": "one row contributing the largest positive ask minus bid delta", "delta_negative": "one row contributing the largest negative ask minus bid delta"}.get(event, "bid and ask execution volume by price")
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
            "championship": "A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.",
        }
        return scenarios.get(screen.get("event"), scenarios["championship"])
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
        "  [REPLAY_COMPARE] Compare acceptance with replenishment and rejection.",
        "  [TAP_CANDLE] Select a candle directly on a chart.",
        "  [TRENDLINE] Connect two candles on a chart.",
        "  [LIVE_CHART] Read pressure while candles update.",
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
                replacement = {"type": "book_compare", "question": question, "options": options, "correct": 0, "explanation": "Nearby depth changes how much pressure price needs to travel."}
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
        if any(screen["type"] == replacement["type"] and screen.get("question") == replacement.get("question") for screen in screens):
            return
        for index, screen in enumerate(screens):
            if screen["type"] in kinds:
                screens[index] = replacement
                return
        raise AssertionError(f"No {kinds} screen to replace in {title}")

    # Unit 2 peaks in direct book use and bridges into absorption.
    replace_first("Large Orders as Walls", {"multiple_choice"}, {
        "type": "book_compare", "question": "Which book shows the larger wall?",
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
        "options": ["Fast buy executions", "Refreshing offer", "Positive delta", "Stalled price"],
        "targets": [1, 3],
        "explanation": "Replenishment plus weak price progress are the strongest hidden liquidity clues."})
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


def apply_boss_structure(course):
    """Convert each existing final review into one tier-appropriate Boss."""
    boss_specs = {
        0: ("Boss Battle: Foundations Under Pressure", [
            {"type": "aggressor", "event": "lift", "question": "Who is aggressive?", "correct": 0, "explanation": "Buyers are lifting offers."},
            {"type": "book_drag", "order": "market_buy", "question": "Where does a market buy execute?", "correct": 1, "explanation": "Market buys take the ask."},
            {"type": "book_drag", "order": "market_sell", "question": "Where does a market sell execute?", "correct": 0, "explanation": "Market sells hit the bid."},
            {"type": "multiple_choice", "question": "Which order is passive?", "options": ["A limit order resting at price", "A market order crossing now", "A completed execution"], "correct": 0, "explanation": "Passive orders rest as liquidity."},
            {"type": "evidence_select", "question": "Select the complete market read.", "options": ["Aggressor", "Liquidity", "Price response", "Company logo"], "targets": [0, 1, 2], "explanation": "A complete read combines action, liquidity, and response."},
        ]),
        1: ("Boss Battle: Read the Book", [
            {"type": "multiple_choice", "question": "What does Level II add?", "options": ["Depth across price levels", "Only the last trade", "Future orders with certainty"], "correct": 0, "explanation": "Level II displays resting depth across prices."},
            {"type": "book_compare", "question": "Which book should move more easily?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Book B is thinner and contains gaps."},
            {"type": "book_compare", "question": "Which book has thicker liquidity?", "options": ["Book A", "Book B", "Neither book"], "correct": 0, "explanation": "Book A shows more nearby resting size."},
            {"type": "replay_compare", "event": "wall", "question": "Which wall absorbed selling?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Replay A replenishes while trading and price holds."},
            {"type": "multiple_choice", "question": "What happened when the bid vanished?", "options": ["Liquidity was pulled", "Selling was absorbed", "The spread closed"], "correct": 0, "explanation": "The displayed bid disappeared before trading."},
            {"type": "evidence_select", "question": "Select the holding wall clues.", "options": ["Repeated fills", "Replenishing size", "Price holds", "Wall pulls"], "targets": [0, 1, 2], "explanation": "Trading, replenishment, and response distinguish a holding wall."},
        ]),
        2: ("Boss Battle: Read the Tape", [
            {"type": "time_sales", "event": "lift", "question": "Who initiates these prints?", "options": ["Buyers", "Sellers", "Neither"], "correct": 0, "explanation": "Trades at the ask are buyer initiated."},
            {"type": "time_sales_tap", "event": "accelerating", "target": 4, "question": "Tap where pace accelerates.", "explanation": "Print intervals shorten here."},
            {"type": "time_sales_tap", "event": "large_print", "target": 6, "question": "Tap the unusually large print.", "explanation": "This print is much larger than surrounding trades."},
            {"type": "time_sales", "event": "lift", "question": "What does the sequence show?", "options": ["Persistent buyer aggression", "Persistent seller aggression", "No executions"], "correct": 0, "explanation": "Buyer initiated prints dominate."},
            {"type": "time_sales_tap", "event": "sequence_break", "target": 5, "question": "Tap the sequence break.", "explanation": "This opposing print interrupts the dominant side."},
            {"type": "multiple_choice", "chart": "uptrend", "question": "Did price confirm the buying?", "options": ["Yes. Price advanced", "No. Price stalled", "Price cannot confirm tape"], "correct": 0, "explanation": "Price made upward progress with the tape."},
            {"type": "replay_compare", "event": "absorption", "question": "Which replay shows false urgency?", "options": ["Replay B", "Replay A", "Both"], "correct": 0, "explanation": "Replay B shows aggression fading rather than continuing control."},
        ]),
        3: ("Boss Battle: Absorption or Exhaustion?", [
            {"type": "replay_compare", "event": "absorption", "question": "Which replay shows absorption?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "Aggression remains strong while price stalls."},
            {"type": "time_sales", "event": "stall", "question": "What does fading pace suggest?", "options": ["Exhaustion", "Absorption", "Acceptance"], "correct": 0, "explanation": "Exhaustion means aggression itself fades."},
            {"type": "orderflow_sim", "event": "buyer_absorption", "question": "What's the strongest read?", "options": ["Possible buyer absorption", "Seller continuation confirmed", "No selling occurred"], "correct": 0, "explanation": "Selling remains active while support holds."},
            {"type": "orderflow_sim", "event": "seller_absorption", "question": "What's the strongest read?", "options": ["Possible seller absorption", "Buyer continuation confirmed", "No buying occurred"], "correct": 0, "explanation": "Buying remains active while resistance holds."},
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
            {"type": "orderflow_sim", "event": "seller_absorption", "question": "Positive delta, falling price. Why?", "options": ["Possible seller absorption", "Buyer control is confirmed", "Delta is invalid"], "correct": 0, "explanation": "Buying can be absorbed despite positive delta."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is momentum confirmed?", "options": ["No. Price and pressure diverge", "Yes. Delta is enough", "Yes. Volume is high"], "correct": 0, "explanation": "Conflicting response warns of momentum failure."},
        ]),
        5: ("Boss Battle: Sweep or Acceptance?", [
            {"type": "mark_level", "chart": "breakout", "level_kind": "resistance", "question": "Mark inferred buy stops.", "explanation": "Buy stops may cluster beyond resistance."},
            {"type": "mark_level", "chart": "breakdown", "level_kind": "support", "question": "Mark inferred sell stops.", "explanation": "Sell stops may cluster beyond support."},
            {"type": "replay_compare", "event": "sweep", "question": "Which replay gains acceptance?", "options": ["Replay B", "Replay A", "Both"], "correct": 0, "explanation": "Replay B holds beyond the level."},
            {"type": "multiple_choice", "chart": "rejectionWickUp", "question": "What does the rejection suggest?", "options": ["Possible upside sweep", "Accepted breakout", "Guaranteed reversal"], "correct": 0, "explanation": "Price trades above and returns inside."},
            {"type": "multiple_choice", "chart": "rejectionWickDown", "question": "What does this rejection suggest?", "options": ["Possible downside sweep", "Accepted breakdown", "No liquidity traded"], "correct": 0, "explanation": "Price trades below and returns inside."},
            {"type": "book_compare", "question": "Which book should move faster?", "options": ["Book B", "Book A", "Both equally"], "correct": 0, "explanation": "Thin depth lets price travel more easily."},
            {"type": "time_sales", "event": "lift", "question": "The offer keeps refilling. Why?", "options": ["Possible iceberg", "Buyer exhaustion", "Spread collapse"], "correct": 0, "explanation": "Repeated replenishment can indicate hidden size."},
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
            {"type": "footprint", "event": "balanced", "question": "Heavy volume, little progress. Why?", "options": ["Possible high volume chop", "Strong trend confirmed", "No trading occurred"], "correct": 0, "explanation": "Heavy two sided execution can produce chop."},
            {"type": "orderflow_sim", "event": "conflict", "question": "What's the best conclusion?", "options": ["No clear read yet", "Bullish continuation", "Bearish continuation"], "correct": 0, "explanation": "The evidence conflicts."},
            {"type": "evidence_select", "question": "Select pullback failure clues.", "options": ["Counter pressure accelerates", "Key structure fails", "Trend pressure returns", "Price holds the level"], "targets": [0, 1], "explanation": "Growing counter pressure and lost structure signal failure."},
        ]),
        8: ("Boss Battle: Trap or Reversal?", [
            {"type": "replay_compare", "event": "trap", "question": "Which replay traps buyers?", "options": ["Replay B", "Replay A", "Neither"], "correct": 0, "explanation": "Replay B fails above resistance."},
            {"type": "replay_compare", "event": "sweep", "question": "Which replay traps sellers?", "options": ["Replay A", "Replay B", "Neither"], "correct": 0, "explanation": "The rejected breach traps the initiating side."},
            {"type": "time_sales", "event": "stall", "question": "What supports exhaustion reversal?", "options": ["Aggression fades", "Aggression stays strong", "Price accepts lower"], "correct": 0, "explanation": "Exhaustion begins with fading aggression."},
            {"type": "orderflow_sim", "event": "buyer_absorption", "question": "What supports buyer absorption reversal?", "options": ["Selling stalls at support", "Selling accepts lower", "No bids replenish"], "correct": 0, "explanation": "Repeated selling fails to make progress."},
            {"type": "multiple_choice", "chart": "doubleTop", "question": "What matters on the second test?", "options": ["Weaker buying and stronger defense", "The shape alone", "Equal candle colors"], "correct": 0, "explanation": "Compare execution and response across tests."},
            {"type": "multiple_choice", "chart": "doubleBottom", "question": "What matters on the second test?", "options": ["Weaker selling and stronger defense", "The shape alone", "Equal candle colors"], "correct": 0, "explanation": "Compare execution and response across tests."},
            {"type": "evidence_select", "question": "Select reversal confirmation clues.", "options": ["Control changes", "Price confirms", "One rejection wick", "Mixed tape"], "targets": [0, 1], "explanation": "A reversal needs control change and response."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is a reversal confirmed?", "options": ["Not enough evidence", "Yes. The wick is enough", "Yes. Neutral delta confirms it"], "correct": 0, "explanation": "Mixed tape and balanced execution remain inconclusive."},
            {"type": "multiple_choice", "question": "When should entry wait?", "options": ["Until control and response align", "Until one large print", "Until any wick appears"], "correct": 0, "explanation": "Expert reversal reads require confirmation."},
        ]),
        9: ("FINAL BOSS: The Complete Order Flow Read", [
            {"type": "orderflow_sim", "event": "championship", "question": "Who is aggressive?", "options": ["Buyers", "Sellers", "Neither"], "correct": 0, "explanation": "Buyer initiated prints dominate."},
            {"type": "orderflow_sim", "event": "championship", "question": "Where is liquidity defending?", "options": ["At the refreshing offer", "Below the distant bid", "Nowhere"], "correct": 0, "explanation": "The offer replenishes after fills."},
            {"type": "orderflow_sim", "event": "championship", "question": "Is price responding?", "options": ["No. Price stalls", "Yes. Price accepts higher", "Response is irrelevant"], "correct": 0, "explanation": "Aggression makes little progress."},
            {"type": "orderflow_sim", "event": "championship", "question": "Which evidence conflicts?", "options": ["Positive delta and stalled price", "Fast tape and positive delta", "VWAP and resistance"], "correct": 0, "explanation": "Positive delta conflicts with weak price progress."},
            {"type": "orderflow_sim", "event": "championship", "question": "What's the strongest read?", "options": ["Possible seller absorption", "Buyer continuation confirmed", "Guaranteed reversal"], "correct": 0, "explanation": "Refreshing offers and stalled price support absorption."},
            {"type": "orderflow_sim", "event": "championship", "question": "What invalidates the read?", "options": ["Price accepts above resistance", "Another buy print", "Stable spread"], "correct": 0, "explanation": "Acceptance higher invalidates seller absorption."},
            {"type": "orderflow_sim", "event": "championship", "question": "What execution risk is present?", "options": ["Slippage near changing depth", "No execution risk", "Guaranteed fill price"], "correct": 0, "explanation": "Fast activity and changing depth increase slippage."},
            {"type": "book_compare", "question": "Which side shows thin liquidity?", "options": ["Book B", "Book A", "Both"], "correct": 0, "explanation": "Book B has small size and gaps."},
            {"type": "orderflow_sim", "event": "conflict", "question": "Is direction confirmed?", "options": ["Not enough evidence", "Buyers fully control", "Sellers fully control"], "correct": 0, "explanation": "Conflicting evidence prevents confirmation."},
            {"type": "evidence_select", "question": "Select what to review afterward.", "options": ["Book behavior", "Tape response", "Footprint delta", "Trade profit only"], "targets": [0, 1, 2], "explanation": "Review each evidence source separately from outcome."},
        ]),
    }

    # Practice simulations remain ordinary replay lessons.
    for lesson_item in course["lessons"]:
        lesson_item["lessonType"] = "STANDARD"
        if "Simulation" in lesson_item["title"] and lesson_item["title"] != "Comprehensive Order Flow Simulation":
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


def add_skill_tags_and_test_outs(course):
    """Tag every question and build larger assessment pools per unit."""
    def skill_for(title, screen):
        kind = screen["type"]
        title_key = title.lower().replace(" ", "_").replace(":", "")
        mechanic_skills = {
            "time_sales": "tape_reading", "time_sales_tap": "tape_interaction",
            "footprint": "footprint_reading", "footprint_tap": "footprint_interaction",
            "book_compare": "book_depth", "mark_level": "liquidity_location",
            "replay_compare": "scenario_comparison", "orderflow_sim": "multi_signal_read",
            "evidence_select": "evidence_synthesis", "aggressor": "aggressor_side",
            "book_drag": "order_routing", "sequence_builder": "market_sequence",
        }
        return mechanic_skills.get(kind, title_key[:48])

    node_sections = {node["num"]: node["sectionIndex"] for node in course["nodes"]}
    pools = {index: [] for index in range(10)}
    for lesson_item in course["lessons"]:
        section_index = node_sections[lesson_item["node"]]
        for screen in lesson_item["screens"]:
            screen["skillId"] = skill_for(lesson_item["title"], screen)
            if lesson_item["lessonType"] != "BOSS_BATTLE":
                pools[section_index].append({**screen, "sourceLesson": lesson_item["title"]})

    course["testOuts"] = []
    for section in course["sections"]:
        index = section["index"]
        count = section["testOutQuestionCount"]
        pool_size = min(len(pools[index]), max(count + 4, count * 2))
        course["testOuts"].append({
            "unitIndex": index, "unitId": section["unitId"], "lessonType": "TEST_OUT",
            "questionCount": count, "passingScore": section["testOutPassingScore"],
            "noHearts": True, "revealAnswersAtEnd": True,
            "questionPool": pools[index][:pool_size],
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
    authored_aliases = {"Order Flow Foundations Review": "Boss Battle: Foundations Under Pressure"}
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
    apply_boss_structure(course)
    add_skill_tags_and_test_outs(course)

    assert len(course["sections"]) == 10
    assert 80 <= len(course["nodes"]) <= 120
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
