# Moko — context for AI assistants

Moko is a Duolingo-style money-management app for teens on iOS: SwiftUI hosted
in a UIKit shell. Lessons on budgeting, saving, credit, investing, and spotting
hype/scams sit on a gamified path — hearts, streaks, XP, treats (currency). It
is the user's 2026 Congressional App Challenge entry (TX-26).

## Repo location — read this first

The repo is `/Users/williammeek/CongressionalAppChallenge/Moko/` (remote
`github.com/meekwilliam/Moko`). `gh` is authenticated, so `git push` works
from the CLI. Commit locally after every change; push only when asked.

## Build & validate

```bash
cd /Users/williammeek/CongressionalAppChallenge/Moko
xcodebuild -project Moko.xcodeproj -scheme Moko \
  -destination 'generic/platform=iOS Simulator' -configuration Debug build \
  2>&1 | grep -E "BUILD SUCCEEDED|BUILD FAILED|error:"
```

Content lives in one big JSON file, not compiled — always validate it after
editing:

```bash
cd /Users/williammeek/CongressionalAppChallenge/Moko/Moko
python3 -c "import json; json.load(open('GameData.json'))"
```

## Architecture

- **`AppDelegate.swift`** — registers bundled fonts (`.otf`/`.ttf` in
  `Moko/fonts/`) at launch and starts Haptics.
- **No backend.** Progress lives on-device (`ProgressStore`, UserDefaults).
  Firebase and the cloud-sync layer were removed; the onboarding Apple/Google
  buttons just continue. The app is completely free — no purchases.
- **`ProgressStore.swift`** — the game loop: XP, treats, streak (weekly
  Mo–Su calendar), hearts (25 to start, 1 spent per wrong original answer,
  regenerates hourly; refill with treats or by inviting a friend).
- **`PathStore` / `PathModels.swift`** — the home learning-path map: sections
  (units) and nodes (lessons), decoded from `GameData.json`. `PathStore` is
  an `ObservableObject`; node colors come from each section's `bg`/`slab` hex
  (NOT from `Theme.unitColor`, which is only a fallback for missing data).
- **`LessonPlayer` (in `LessonView.swift`)** — the lesson state machine: one
  `@Published` array of `LessonScreen`, an index, per-question-type
  interaction state (`selectedIndex`, `selectedSet`, `markedLevel`,
  `trendStart`/`trendEnd`, etc.). A missed question gets re-appended to the
  queue — you must get it right to finish.
- **`LessonScreenRouter` (in `LessonScreenViews.swift`)** — switches on
  `screen.type` to pick the SwiftUI view per question type.
- **`CandlestickChart.swift`** — from-scratch chart renderer. `ChartScenario`
  enum (~line 295) lists every renderable chart preset (uptrend, doji,
  hammer, bullFlag, ascendingChannel, ...). `model(seed:)` (~line 619+)
  generates that scenario's candles deterministically-by-index (magnitudes
  are seeded-random, but which candle is up/down/the-answer is fixed by
  index for most scenarios — this is what makes `tap_candle` targets safe to
  reuse).
- **`LessonTheme.swift`** (`Theme` enum) — fonts, colors, the 3D "chunky
  button" style used everywhere (`Chunky3DStyle`, `SinkButtonStyle`,
  `OptionSurface`).

## Content: `Moko/GameData.json`

One course: **`money` (Money Basics)** — 5 units, 27 lessons, 142 questions
on budgeting, saving, credit, long-term investing (trends, dips, volatility),
and hype/crypto/gambling for teens. It is generated, never hand-edited:
edit `tools/money_course/unit*.py` and run `python3 tools/build_money_course.py`.
The builder validates every screen and derives node numbers, unit banners,
boss lessons and Test Out pools. (The old Order Flow day-trading course was
removed for the CAC pitch; its leftover trade-decision code paths in
`LessonView.swift` are unreachable.)

Question `type`s used: `intro` (optional `chart`), `multiple_choice`,
`true_false`, `fill_blank`, `matching`, `sequence_builder`, `number_slider`,
`tap_candle`. No trading concepts (support/resistance, gaps, patterns) — the
pitch is long-term wealth and avoiding gambling-style behavior. Any question can show a `chart` above it. The
engine also supports `tap_candles`, `draw_trendline`, `mark_consolidation`,
`ohlc_label`, `fill_blank_multi`, `ingredient_match`. Field names per type
are in `LessonModels.swift`'s `LessonScreen` `CodingKeys`.

**Chart-question safety:** only use `(chart, target/level_kind)` pairs whose
answer `CandlestickChart.model(seed:)` fixes by construction. The builder
enforces an allow-list (`SAFE_TAPS`, `SAFE_LEVELS`, `KNOWN_CHARTS`); verify
against `model(seed:)` before adding to it. `sideways`/`volatile` have no
deterministic target. `draw_trendline` grading is ±1 candle per end, so
avoid it unless any reasonable line passes.

## Content style

- **Questions are short instructions/questions only** — no restated
  teaching or parenthetical hints. Any "why" goes in `explanation`.
- **Distractors must be plausible confusables**, not nonsense.
- **Matching cards must be unique** on each side (the builder rejects
  duplicates).
- Audience is teens; plain words, concrete teen examples, factually careful
  ("historically", "most states"); educational, not financial advice.

## Design system

- **Fonts** (bundled `.ttf`/`.otf` in `Moko/fonts/`, registered in
  `AppDelegate.swift`):
  - `Theme.font(_:_:)` → **Sora** (weight-mapped: Regular/Medium/SemiBold/
    Bold/ExtraBold) — chrome: buttons, titles, instructional labels.
  - `Theme.questionFont(_:_:)` → **Plus Jakarta Sans SemiBold** — section
    titles, quiz question prompts, and their answer choices.
  - `Theme.bodyFont(_:_:)` → **Plus Jakarta Sans Regular** — body copy,
    subtitles, supporting/detail text.
- **Colors**: `Theme.swift` has the full palette. Unit banner colors live in
  `GameData.json`'s per-course `sections[].bg`/`.slab` (source of truth for
  real path buttons); `Theme.unitColor(_:)` is only a fallback. Current unit
  hues are each original bright Tailwind-500 color scaled to ~90% brightness
  (a deliberate "10% dimmer" pass, not a full muted-palette redesign — a
  fully desaturated pass was tried and reverted as "too dark").
- **3D chunky button style**: `Chunky3DStyle`/`SinkButtonStyle` — a fill +
  darker "slab" drawn as a fixed offset shape underneath; on press the face
  sinks flush onto the slab. Always keep `fill`/`slab` as a matched color
  pair (same hue) — a past bug had a blue fill with an orange slab.

## Working conventions

- **Always commit after code changes** (project house rule). Push only when
  the user asks.
- Validate `GameData.json` with `python3 -c "import json; json.load(...)"`
  after every edit, and run the `xcodebuild` command above before
  considering a change done — must see `BUILD SUCCEEDED`.
- For large content sweeps across `GameData.json` (rebalancing question
  types, bulk text edits), write a Python script rather than hand-editing —
  the file is too large to hold in context at once. Preserve
  `explanation`/`options`/other fields when converting a screen's `type`;
  don't `dict.clear()` and forget to re-add fields.
