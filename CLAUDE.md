# Moko — context for AI assistants

Moko is a Duolingo-style day-trading education app for iOS: SwiftUI hosted in a
UIKit shell. You learn to read candlestick charts and order flow by answering
questions on a gamified path — hearts, streaks, XP, treats (currency).

## Repo location — read this first

The **live repo** is `/Users/williammeek/Moko/` (git-tracked, remote
`github.com/xoshr/Moko`). The user pushes via **GitHub Desktop**, not `git
push` from the CLI (CLI push will fail — no credentials configured there).
Commit locally after every change; don't try to push.

If you ever see a similarly-named directory elsewhere (e.g. under
`~/Derm/`), treat it as a stale scratch copy unless proven otherwise — verify
`git remote -v` and `git log` before trusting any location.

## Build & validate

```bash
cd /Users/williammeek/Moko
xcodebuild -project Moko.xcodeproj -scheme Moko \
  -destination 'generic/platform=iOS Simulator' -configuration Debug build \
  2>&1 | grep -E "BUILD SUCCEEDED|BUILD FAILED|error:"
```

Content lives in one big JSON file, not compiled — always validate it after
editing:

```bash
cd /Users/williammeek/Moko/Moko
python3 -c "import json; json.load(open('GameData.json'))"
```

## Architecture

- **`AppDelegate.swift`** — registers bundled fonts (`.otf`/`.ttf` in
  `Moko/fonts/`) at launch, wires Firebase, starts Haptics.
- **`Backend.swift`** — protocol seam for auth/sync. `FirebaseBackend.swift`
  is the *only* file that imports Firebase; everything else talks to the
  protocol so the backend could be swapped wholesale.
- **`ProgressStore.swift`** — the game loop: XP, treats, streak (weekly
  Mo–Su calendar), hearts (25 to start, 1 spent per wrong original answer,
  regenerates hourly, mock "unlimited hearts" subscription).
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
- **`OrderFlowViews.swift`** — order-book mechanics (`aggressor`,
  `book_drag`, and other order-flow-specific interactions), separate from
  the candlestick chart mechanics.
- **`LessonTheme.swift`** (`Theme` enum) — fonts, colors, the 3D "chunky
  button" style used everywhere (`Chunky3DStyle`, `SinkButtonStyle`,
  `OptionSurface`).

## Content: `Moko/GameData.json`

The bundled catalog currently contains one course: `orderflow`, with 10
units, 77 lessons, and 479 questions. Retired course sources and generated
lesson data have been removed; do not restore them when regenerating content.

Shape: `{ "courses": [Course...], "legal": {...} }`. Each course has
`sections` (unit banners: `index`, `title`, `bg`/`slab` hex, `tier`, plus
newer `testOutEnabled`/`testOutQuestionCount`/`testOutPassingScore`/
`bossLessonId` fields) and `lessons` (each: `node`, `title`, `celebration`,
`screens[]`).

Question `type`s in use: `intro`, `multiple_choice`, `true_false`,
`fill_blank`, `fill_blank_multi`, `matching`, `ingredient_match`,
`sequence_builder`/`drag_order`, `tap_candle`, `tap_candles`,
`draw_trendline`, `mark_level`, `mark_consolidation`, `ohlc_label`,
`number_slider`, and order-flow-specific ones: `aggressor`, `book_drag`,
`book_compare`, `evidence_select`, `footprint`, `footprint_tap`,
`live_chart`, `orderflow_sim`, `replay_compare`, `time_sales`,
`time_sales_tap`. Field names per type are in `LessonModels.swift`'s
`LessonScreen` `CodingKeys` (~line 107-125).

**Safety rule for chart-interaction questions** (`tap_candle`, `tap_candles`,
`mark_level`, `draw_trendline`, `mark_consolidation`): only use
`(chart, target/level_kind)` combos that are already proven correct
elsewhere in the file (grep for existing usages of that `chart` scenario
with that interaction type), or verify fresh against `CandlestickChart.swift`
`model(seed:)`/`highlightIndex` before inventing a new one. Getting this
wrong marks a genuinely-correct tap as wrong for real users. `sideways` and
`volatile`-style scenarios with randomized candle direction generally have
NO safe deterministic target — don't use them for new tap questions unless
you've verified determinism.

## Content style (established through user feedback this session)

- **Questions must be short instructions/questions only** — no restated
  teaching, no parenthetical hints like "(green)" or "(tiny body, wicks on
  both sides)". Any "why" belongs in the `explanation` field (shown after
  answering), never in the question.
- **Distractors must be plausible confusables**, not nonsense a learner can
  eliminate without understanding the concept. Banned family: "the color of
  the candles", "calendar", "company earnings", "guaranteed profit", "market
  is closed". "Overstates certainty" traps ARE legitimate (the course
  deliberately teaches "descriptive, not a guarantee").
- **Question-type mix targets** (current, as of 2026-07-10): Multiple Choice
  ~35%, Chart interactions "the rest" (top priority, keep growing — was
  ~29.3% last measured), Matching ~8% cap (don't grow), Fill in Blank ~10%
  (shrink further when safe), True/False and PICK/ingredient_match: keep at
  current levels, don't touch. Order-book mechanics (`aggressor`/
  `book_drag`) are a growth area the user wants expanded into the main 4
  courses (currently siloed in the small `orderflow` course).

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

- **Always commit after code changes** (project house rule) — on `main`,
  don't push (user pushes via GitHub Desktop).
- Validate `GameData.json` with `python3 -c "import json; json.load(...)"`
  after every edit, and run the `xcodebuild` command above before
  considering a change done — must see `BUILD SUCCEEDED`.
- For large content sweeps across `GameData.json` (rebalancing question
  types, bulk text edits), write a Python script rather than hand-editing —
  the file is too large to hold in context at once. Preserve
  `explanation`/`options`/other fields when converting a screen's `type`;
  don't `dict.clear()` and forget to re-add fields.
