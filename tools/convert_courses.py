#!/usr/bin/env python3
import json, sys
sys.path.insert(0, __import__("os").path.dirname(__import__("os").path.abspath(__file__)))
from convert_lessons import parse_doc, build_screen

GAME = "/Users/williammeek/Derm/DermApp_v2/DermApp/GameData.json"
BACKUP = GAME + ".bak"   # original 45-node file: icons + legal

icons = json.load(open(BACKUP))
icon_nodes = {n["num"]: n for n in icons["nodes"]}
icon_sections = {s["index"]: s for s in icons["sections"]}
legal = icons.get("legal", {})

def default_icon(num):
    # cycle through the available icons if a course has more nodes than icons
    return icon_nodes.get(((num - 1) % len(icon_nodes)) + 1, {}).get("svg", "")

DOC = "/Users/williammeek/Derm/DermApp_v2/LESSONS_DAYTRADING.md"

def build_lesson(L):
    intro = {"type": "intro", "title": L["introTitle"], "text": L["introText"]}
    if L.get("introChart"):
        intro["chart"] = L["introChart"]
    screens = [intro]
    for qtype, q in L["_questions"]:
        screen = build_screen(qtype, q)
        if q["meta"].get("chart"):
            screen["chart"] = q["meta"]["chart"]
        screens.append(screen)
    return screens

def build_level(cid, name, level_num, unit_indices, bg, slab, raw, doc_units, lesson_unit):
    """Build one difficulty level as a self-contained course: the given units,
    with node numbers and section indices restarting at 1/0 within the level."""
    idx_map = {u: i for i, u in enumerate(unit_indices)}
    unit_titles = [u["title"] for u in doc_units]
    lessons, nodes, node_i = [], [], 0
    for k, L in enumerate(raw):
        if lesson_unit[k] not in idx_map:
            continue
        node_i += 1
        lessons.append({"node": node_i, "title": L["title"],
                        "celebration": L["celebration"], "screens": build_lesson(L)})
        nodes.append({"num": node_i, "svg": default_icon(node_i),
                      "title": L["title"], "sectionIndex": idx_map[lesson_unit[k]]})
    sections = [{"index": i, "eyebrow": f"SECTION {level_num} · UNIT {i+1}",
                 "title": unit_titles[u], "bg": bg, "slab": slab}
                for i, u in enumerate(unit_indices)]
    return {"id": cid, "name": name, "level": level_num, "color": bg,
            "sections": sections, "nodes": nodes, "lessons": lessons}

# Parse the Day Trading doc once, then slice its units into 4 gated levels.
raw, doc_units = parse_doc(open(DOC).read())
unit_sizes = [u["size"] for u in doc_units]
lesson_unit, ui, rem = [], 0, unit_sizes[0] if unit_sizes else 0
for _ in raw:
    while rem == 0:
        ui += 1; rem = unit_sizes[ui]
    lesson_unit.append(ui); rem -= 1

# Level membership is by unit TITLE (robust as units are added). Units must
# appear in the doc grouped by level and in level order (Beginner→Expert).
BEGINNER_UNITS = [
    "Trading Terminology", "Market Foundations", "Candlesticks", "Orders & Execution", "Market Mechanics",
]
INTERMEDIATE_UNITS = [
    "Trends & Structure", "Support & Resistance",
    "Double Tops & Bottoms",
    "Head & Shoulders",
    "Triangles",
    "Flags & Pennants",
    "Wedges & Channels",
    "Trendlines",
    "Ranges & Consolidation",
    "Breakouts & Retests",
    "Pullbacks & Continuation",
    "Momentum & Exhaustion",
    "Confluence",
    "Gaps",
    "Multi-Timeframe Basics",
    "Chart-Reading Mastery",
]
ADVANCED_UNITS = [
    "Risk Management", "Strategy Types",
    "Position Sizing & R", "Expectancy & Edge", "Market Condition Classification",
    "Moving Averages", "Oscillators: RSI & MACD", "Trade Planning & Process",
    "VWAP & Bollinger Bands", "Drawdowns & Losing Streaks", "Journaling & Review",
]
EXPERT_UNITS = [
    "Trading Psychology", "Full Simulation Training",
]

# (id, display name, unit-title list, bg, slab)
LEVELS = [
    ("dt_beginner",     "Beginner",     BEGINNER_UNITS,     "#22C55E", "#15803D"),
    ("dt_intermediate", "Intermediate", INTERMEDIATE_UNITS, "#3B82F6", "#1D4ED8"),
    ("dt_advanced",     "Advanced",     ADVANCED_UNITS,     "#8B5CF6", "#6D28D9"),
    ("dt_expert",       "Expert",       EXPERT_UNITS,       "#F59E0B", "#B45309"),
]

unit_title_to_index = {u["title"]: i for i, u in enumerate(doc_units)}
courses = []
for i, (cid, name, titles, bg, slab) in enumerate(LEVELS):
    idxs = [unit_title_to_index[t] for t in titles if t in unit_title_to_index]
    courses.append(build_level(cid, name, i + 1, idxs, bg, slab, raw, doc_units, lesson_unit))

out = {"courses": courses, "legal": legal}
json.dump(out, open(GAME, "w"), ensure_ascii=False, indent=1)

for c in courses:
    print(f"{c['id']:16} L{c['level']}  {len(c['lessons']):3} lessons, {len(c['sections'])} units, "
          f"icons ok: {all(n['svg'] for n in c['nodes'])}")
