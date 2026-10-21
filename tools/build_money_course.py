#!/usr/bin/env python3
"""Build the Money Basics course into GameData.json.

Lesson content lives in tools/money_course/unit*.py, one unit per file, each
defining UNIT = {"title", "bg", "slab", "lessons": [...]}. A lesson is
{"title", "symbol" (SF Symbol), "screens": [...]}; the last lesson of a unit
is its boss. Screens use the same JSON shapes as the rest of GameData.json.

This script derives everything structural — node numbers, unit banners, skill
ids, boss ids and Test Out pools — and inserts the course first, so it becomes
the default. Re-running replaces the previous build.
"""

import importlib.util
import json
import math
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = ROOT / "Moko" / "GameData.json"
UNITS_DIR = Path(__file__).resolve().parent / "money_course"

COURSE_ID = "money"
COURSE_NAME = "Money Basics"
COURSE_COLOR = "#22C55E"
CIRCLE_SVG = '<svg viewBox="0 0 32 32" fill="white"><circle cx="16" cy="16" r="9"/></svg>'

QUESTION_TYPES = {"multiple_choice", "true_false", "matching", "sequence_builder",
                  "fill_blank", "number_slider"}


def load_units():
    units = []
    for path in sorted(UNITS_DIR.glob("unit*.py"), key=lambda p: int(re.sub(r"\D", "", p.stem))):
        spec = importlib.util.spec_from_file_location(path.stem, path)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        units.append(mod.UNIT)
    return units


def slug(text):
    return re.sub(r"[^a-z0-9]+", "_", text.lower()).strip("_")


def check_screen(screen, where):
    t = screen["type"]
    if t == "intro":
        assert screen.get("text"), where
        return
    assert t in QUESTION_TYPES, f"{where}: unknown type {t}"
    assert screen.get("question") and screen.get("explanation"), where
    if t in ("multiple_choice", "fill_blank"):
        assert 0 <= screen["correct"] < len(screen["options"]), where
        if t == "fill_blank":
            assert "[___]" in screen["question"], where
    elif t == "true_false":
        assert isinstance(screen["correct"], bool), where
    elif t == "matching":
        assert all(len(p) == 2 for p in screen["pairs"]), where
    elif t == "sequence_builder":
        assert sorted(screen["items"]) == sorted(screen["correct_order"]), where
    elif t == "number_slider":
        lo, hi, ans = screen["number_min"], screen["number_max"], screen["number_correct"]
        assert lo <= ans <= hi, where


def build_course(units):
    sections, nodes, lessons, test_outs = [], [], [], []
    num = 0
    for u_index, unit in enumerate(units):
        unit_id = f"{COURSE_ID}_{u_index + 1}"
        pool = []
        for l_index, lesson in enumerate(unit["lessons"]):
            num += 1
            is_boss = l_index == len(unit["lessons"]) - 1
            skill = slug(lesson["title"])
            screens = []
            for q_index, screen in enumerate(lesson["screens"]):
                where = f"{unit['title']} / {lesson['title']} #{q_index + 1}"
                check_screen(screen, where)
                screen = dict(screen)
                if screen["type"] != "intro":
                    screen["skillId"] = skill
                    if not is_boss:
                        pool.append({**screen,
                                     "sourceLesson": lesson["title"],
                                     "sourceUnit": u_index,
                                     "sourceNode": num,
                                     "questionId": f"{COURSE_ID}.u{u_index + 1}.n{num}.q{q_index + 1}"})
                screens.append(screen)
            nodes.append({"num": num, "svg": CIRCLE_SVG, "title": lesson["title"],
                          "sectionIndex": u_index, "symbol": lesson["symbol"]})
            lessons.append({"node": num, "title": lesson["title"],
                            "celebration": f"{lesson['title']} complete.",
                            "lessonType": "BOSS_BATTLE" if is_boss else "STANDARD",
                            "screens": screens})
        count = min(8, len(pool))
        passing = math.ceil(count * 0.85)
        sections.append({"index": u_index,
                         "eyebrow": f"MONEY BASICS · UNIT {u_index + 1}",
                         "title": unit["title"], "bg": unit["bg"], "slab": unit["slab"],
                         "tier": "Beginner", "unitId": unit_id, "difficulty": "beginner",
                         "testOutEnabled": True, "testOutQuestionCount": count,
                         "testOutPassingScore": passing,
                         "bossLessonId": f"{unit_id}_boss",
                         "finalBossRequiredForCourseMastery": False})
        test_outs.append({"unitIndex": u_index, "unitId": unit_id, "lessonType": "TEST_OUT",
                          "questionCount": count, "passingScore": passing,
                          "noHearts": True, "revealAnswersAtEnd": True, "questionPool": pool})
    return {"id": COURSE_ID, "name": COURSE_NAME, "color": COURSE_COLOR, "level": None,
            "sections": sections, "nodes": nodes, "lessons": lessons, "testOuts": test_outs}


def main():
    units = load_units()
    course = build_course(units)
    data = json.loads(DATA_PATH.read_text())
    data["courses"] = [course] + [c for c in data["courses"] if c["id"] != COURSE_ID]
    DATA_PATH.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
    questions = sum(1 for l in course["lessons"] for s in l["screens"] if s["type"] != "intro")
    print(f"{COURSE_NAME}: {len(units)} units, {len(course['lessons'])} lessons, {questions} questions")


if __name__ == "__main__":
    main()
