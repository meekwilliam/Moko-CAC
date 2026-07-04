#!/usr/bin/env python3
import json, re, sys, random

# Deterministic shuffle so answer positions are mixed (correct answer is NOT
# always first) but the build stays reproducible.
random.seed(20260704)

def shuffle_choices(options, wrong=None, correct_idx=0):
    """Shuffle answer options, returning (new_options, new_wrong, new_correct)."""
    order = list(range(len(options)))
    random.shuffle(order)
    new_opts = [options[i] for i in order]
    new_wrong = [wrong[i] for i in order] if wrong else None
    new_correct = order.index(correct_idx)
    return new_opts, new_wrong, new_correct

DOC = "/Users/williammeek/Derm/DermApp_v2/ARCHIVED_COURSES/LESSONS_FILLED.md"
GAME = "/Users/williammeek/Derm/DermApp_v2/DermApp/GameData.json"

META_PREFIXES = ("TITLE:", "CELEBRATION:", "TEXT:", "CHART:", "WHY:", "ANSWER:",
                 "QUESTION:", "CONCERN:", "BLANK1:", "BLANK2:", "BLANK3:", "WRONG (")

def parse_doc(text):
    """Returns (lessons, units).

    `units` is a list of {"title": str|None, "size": int} in document order,
    built from optional "UNIT n — Title" headers. Each NODE under a UNIT
    header may use per-unit local numbering (e.g. "NODE 1" restarting inside
    every unit) — only the ORDER lessons appear in matters; local NODE
    numbers are just human-readable labels and are discarded in favor of a
    sequential global node id. If the doc has no UNIT headers at all, `units`
    is empty and the caller falls back to fixed-size grouping (legacy docs).
    """
    lines = text.split("\n")
    lessons = []
    units = []           # [{"title": str|None, "size": int}]
    cur_unit = None       # the units[] entry currently being filled
    cur = None          # current lesson dict
    intro = False       # inside INTRO block
    q = None            # current question dict being built
    qtype = None
    global_node = 0

    def flush_q():
        nonlocal q, qtype
        if q is not None:
            cur["_questions"].append((qtype, q))
        q = None; qtype = None

    def flush_lesson():
        nonlocal cur
        if cur is not None:
            flush_q()
            lessons.append(cur)
        cur = None

    for raw in lines:
        line = raw.rstrip()
        s = line.strip()
        um = re.match(r"^#*\s*UNIT\s+(\d+)\s*(?:[—\-:]\s*(.*))?$", s)
        if um:
            flush_lesson()
            cur_unit = {"title": (um.group(2).strip() or None) if um.group(2) else None, "size": 0}
            units.append(cur_unit)
            continue
        m = re.match(r"^#*\s*NODE\s+(\d+)", s)
        if m:
            flush_lesson()
            global_node += 1
            if cur_unit is not None:
                cur_unit["size"] += 1
            cur = {"node": global_node, "title": "", "celebration": "",
                   "introTitle": "", "introText": "", "introChart": None, "_questions": []}
            intro = False
            continue
        if cur is None:
            continue
        if s == "INTRO":
            flush_q(); intro = True; continue
        if s.startswith("TITLE:"):
            val = s[len("TITLE:"):].strip()
            if intro and q is None: cur["introTitle"] = val
            elif q is None: cur["title"] = val
            continue
        if s.startswith("CELEBRATION:"):
            cur["celebration"] = s[len("CELEBRATION:"):].strip(); continue
        if s.startswith("TEXT:"):
            cur["introText"] = s[len("TEXT:"):].strip(); intro = True; continue
        if s.startswith("CHART:") and q is None:
            cur["introChart"] = s[len("CHART:"):].strip(); continue

        qm = re.match(r"^\[([A-Z0-9]+)\]\s*(.*)$", s)
        if qm:
            flush_q(); intro = False
            qtype = qm.group(1)
            q = {"head": qm.group(2).strip(), "opts": [], "meta": {}, "wrongs": {}}
            continue
        if q is None:
            continue
        # meta lines within a question
        if s.startswith("CHART:"):
            q["meta"]["chart"] = s[len("CHART:"):].strip(); continue
        if s.startswith("ANSWER:"):
            q["meta"]["answer"] = s[len("ANSWER:"):].strip(); continue
        if s.startswith("WHY:"):
            q["meta"]["why"] = s[len("WHY:"):].strip(); continue
        if s.startswith("QUESTION:"):
            q["meta"]["question"] = s[len("QUESTION:"):].strip(); continue
        if s.startswith("CONCERN:"):
            q["meta"]["concern"] = s[len("CONCERN:"):].strip(); continue
        if s.startswith("TARGETS:"):
            q["meta"]["targets"] = s[len("TARGETS:"):].strip(); continue
        if s.startswith("TARGET:"):
            q["meta"]["target"] = s[len("TARGET:"):].strip(); continue
        if s.startswith("LEVEL:"):
            q["meta"]["level"] = s[len("LEVEL:"):].strip(); continue
        m2 = re.match(r"^BLANK(\d):\s*(.*)$", s)
        if m2:
            q["meta"].setdefault("blanks", {})[int(m2.group(1))] = m2.group(2).strip(); continue
        wm = re.match(r"^WRONG\s*\((.*?)\):\s*(.*)$", s)
        if wm:
            q["wrongs"][wm.group(1).strip()] = wm.group(2).strip(); continue
        if s == "":
            continue
        # otherwise: an option / pair / order-item line
        q["opts"].append(s)
    flush_lesson()
    return lessons, units

def build_screen(qtype, q):
    why = q["meta"].get("why")
    head = q["head"]
    opts = q["opts"]

    def wrong_arr(options):
        # align WRONG(...) notes to options; correct (index 0) -> None
        arr = []
        for i, o in enumerate(options):
            arr.append(q["wrongs"].get(o))
        # only include if any present
        return arr if any(x is not None for x in arr) else None

    if qtype == "TF":
        ans = q["meta"].get("answer", "").lower().startswith("t")
        s = {"type": "true_false", "question": head, "correct": ans}
        if why: s["explanation"] = why
        return s
    if qtype == "TAPCANDLE":
        # Interactive: the learner taps a candle on the attached chart. TARGET is
        # the 1-based candle number; stored 0-based to match the chart's indexing.
        tgt = int(q["meta"].get("target", "1")) - 1
        s = {"type": "tap_candle", "question": head, "target": tgt}
        if why: s["explanation"] = why
        return s
    if qtype == "TAPCANDLES":
        # Interactive multi-select: tap every candle matching a criterion.
        # TARGETS is a 1-based list (e.g. "2, 4"); stored 0-based.
        tg = sorted(int(x) - 1 for x in re.split(r"[,\s]+", q["meta"].get("targets", "").strip()) if x)
        s = {"type": "tap_candles", "question": head, "targets": tg}
        if why: s["explanation"] = why
        return s
    if qtype == "MARKLEVEL":
        # Interactive: drag a horizontal line to the support/resistance level.
        # The true level comes from the chart at render time; author just says which.
        kind = q["meta"].get("level", "support").strip().lower()
        s = {"type": "mark_level", "question": head, "level_kind": kind}
        if why: s["explanation"] = why
        return s
    if qtype == "MC":
        o2, wa, c2 = shuffle_choices(opts, wrong_arr(opts), 0)
        s = {"type": "multiple_choice", "question": head, "options": o2, "correct": c2}
        if wa: s["wrong_explanations"] = wa
        if why: s["explanation"] = why
        return s
    if qtype == "FILL":
        o2, wa, c2 = shuffle_choices(opts, wrong_arr(opts), 0)
        s = {"type": "fill_blank", "question": head, "options": o2, "correct": c2}
        if wa: s["wrong_explanations"] = wa
        if why: s["explanation"] = why
        return s
    if qtype == "SPOT":
        o2, wa, c2 = shuffle_choices(opts, wrong_arr(opts), 0)
        s = {"type": "spot_mistake", "scenario": head,
             "question": q["meta"].get("question", "What is the mistake?"),
             "options": o2, "correct": c2}
        if wa: s["wrong_explanations"] = wa
        if why: s["explanation"] = why
        return s
    if qtype == "FILL2":
        template = head.replace("[1]", "[__1__]").replace("[2]", "[__2__]")
        blanks = []
        bmap = q["meta"].get("blanks", {})
        for i in sorted(bmap):
            parts = [p.strip() for p in bmap[i].split("|")]
            correct = 0
            clean = []
            for j, p in enumerate(parts):
                if p.startswith("*"):
                    correct = j; p = p[1:].strip()
                clean.append(p)
            o2, _, c2 = shuffle_choices(clean, None, correct)
            blanks.append({"options": o2, "correct": c2})
        s = {"type": "fill_blank_multi", "template": template, "blanks": blanks}
        if why: s["explanation"] = why
        return s
    if qtype == "MATCH":
        pairs = []
        for o in opts:
            if "=>" in o:
                l, r = o.split("=>", 1)
                pairs.append([l.strip(), r.strip()])
        s = {"type": "matching", "question": head, "pairs": pairs}
        if why: s["explanation"] = why
        return s
    if qtype == "ORDER":
        items = [re.sub(r"^\d+\.\s*", "", o).strip() for o in opts]
        s = {"type": "sequence_builder", "question": head,
             "items": items, "correct_order": items}
        if why: s["explanation"] = why
        return s
    if qtype in ("INGREDIENT", "PICK"):
        options = []
        for i, o in enumerate(opts):
            parts = [p.strip() for p in o.split("|")]
            label = parts[0]
            detail = None; wrong = None
            for p in parts[1:]:
                if p.lower().startswith("detail:"): detail = p.split(":", 1)[1].strip()
                elif p.lower().startswith("wrong:"): wrong = p.split(":", 1)[1].strip()
            entry = {"label": label, "correct": (i == 0)}
            if detail: entry["detail"] = detail
            if wrong: entry["wrong_explanation"] = wrong
            options.append(entry)
        random.shuffle(options)   # correct flag + wrong note travel with each option
        s = {"type": "ingredient_match", "question": head, "options": options}
        if q["meta"].get("concern"): s["concern"] = q["meta"]["concern"]
        if why: s["explanation"] = why
        return s
    raise SystemExit(f"Unknown type [{qtype}] in node question: {head!r}")

def main():
    lessons_raw, _units = parse_doc(open(DOC).read())
    game = json.load(open(GAME))
    # Icons + section colors come from the 45-node backup so nodes 21-40 keep icons.
    icons = json.load(open(GAME + ".bak"))
    old_nodes = {n["num"]: n for n in icons["nodes"]}
    old_sections = {s["index"]: s for s in icons["sections"]}

    # Unit themes for the full 8-unit course. Only the first N are used,
    # where N = number of 5-lesson unit groups actually present.
    section_titles = {
        0: "Skin Foundations",
        1: "Hydration Science",
        2: "Cleansing & pH",
        3: "Actives 101",
        4: "Sun & Aging",
        5: "Common Concerns",
        6: "Routines & Layering",
        7: "Lifestyle & Myths",
    }

    lessons = []
    nodes = []
    for L in lessons_raw:
        intro_screen = {"type": "intro", "title": L["introTitle"], "text": L["introText"]}
        if L.get("introChart"):
            intro_screen["chart"] = L["introChart"]
        screens = [intro_screen]
        for qtype, q in L["_questions"]:
            screens.append(build_screen(qtype, q))
        lessons.append({
            "node": L["node"], "title": L["title"],
            "celebration": L["celebration"], "screens": screens,
        })
        # node icon reused from the previous curriculum (same position)
        old = old_nodes.get(L["node"], {})
        nodes.append({"num": L["node"], "svg": old.get("svg", ""),
                      "title": L["title"], "sectionIndex": (L["node"] - 1) // 5})

    n_sections = (len(lessons) + 4) // 5
    sections = []
    for i in range(n_sections):
        old = old_sections.get(i, {})
        sections.append({
            "index": i,
            "eyebrow": f"UNIT {i+1}",
            "title": section_titles.get(i, old.get("title", f"Section {i+1}")),
            "bg": old.get("bg", "#2B70C9"),
            "slab": old.get("slab", "#1C4A85"),
        })

    game["lessons"] = lessons
    game["nodes"] = nodes
    game["sections"] = sections
    json.dump(game, open(GAME, "w"), ensure_ascii=False, indent=1)

    # summary + validation
    print(f"Lessons: {len(lessons)}  Nodes: {len(nodes)}  Sections: {len(sections)}")
    from collections import Counter
    tc = Counter()
    for l in lessons:
        qs = [s for s in l['screens'] if s['type'] != 'intro']
        tc[len(qs)] += 1
        # sanity: each node has an svg
        if not old_nodes.get(l['node'], {}).get('svg'):
            print(f"  WARN node {l['node']} missing icon")
    print("Questions per lesson:", dict(sorted(tc.items())))
    # validate every screen has required fields
    problems = 0
    for l in lessons:
        for s in l['screens']:
            t = s['type']
            if t in ('multiple_choice','fill_blank','spot_mistake') and (not s.get('options') or 'correct' not in s):
                print("  BAD", l['node'], t); problems += 1
            if t == 'fill_blank_multi' and not s.get('blanks'):
                print("  BAD blanks", l['node']); problems += 1
            if t == 'matching' and not s.get('pairs'):
                print("  BAD pairs", l['node']); problems += 1
            if t == 'ingredient_match' and not any(o['correct'] for o in s['options']):
                print("  BAD ingredient no-correct", l['node']); problems += 1
    print("Validation problems:", problems)

main()
