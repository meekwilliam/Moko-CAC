# Lesson Authoring Format

Fill out lessons in this format (see `LESSONS_BLANK.md` for a pre-filled skeleton
of all 45 nodes). When you're done, hand it back and I'll convert it into
`GameData.json` and wire up any new question types.

## Core rules
- **One block per lesson**, starting with `### NODE n`.
- **Target 8–10 questions per lesson** (the INTRO card doesn't count).
- **Mark the correct answer with `*`.** Wrong options start with `-`.
- Every question begins with a **type tag in brackets**: `[TF]`, `[MC]`, etc.
- **`WHY:`** = the explanation shown when the user taps "WHY?". Optional but recommended.
- **`WRONG (option text): ...`** = optional targeted feedback for a specific wrong choice.
- **`<b>...</b>`** is the only markup (renders bold). Use it in intro text and questions.
- Blank lines between questions are fine; the next `[TYPE]` tag starts a new question.

## Lesson header (once per lesson)
```
### NODE 1
TITLE: The Science of Hydration
CELEBRATION: You've mastered hydration!      # short line on the completion screen

INTRO
TITLE: Hydration 101                          # optional small eyebrow title
TEXT: Hydration starts from within... use <b>bold</b> for emphasis.
```

## Question types

```
[TF] A statement the user judges true or false.
ANSWER: True                                  # True or False
WHY: Optional explanation.

[MC] The question text?
* Correct option
- Wrong option
- Wrong option
WHY: Optional explanation.
WRONG (Wrong option): Optional note for that specific pick.

[FILL] A sentence with a [___] blank in it.
* correct choice
- wrong choice
- wrong choice
WHY: ...

[FILL2] A sentence with two blanks [__1__] and [__2__].
BLANK1: *oil | water | acid                   # * marks correct; separate with |
BLANK2: *hydration | cleansing | exfoliation
WHY: ...

[MATCH] The prompt for the matching exercise.
- Left item A => Right match A
- Left item B => Right match B
- Left item C => Right match C
WHY: ...

[SPOT] The scenario the user reads (situation / someone's reasoning).
QUESTION: What is the mistake?
* Correct option (the actual error)
- Wrong option
- Wrong option
WHY: ...

[INGREDIENT] The question?
CONCERN: (optional) the skin concern shown in a callout box
* Salicylic Acid / BHA | detail: Unclogs pores and cuts oil
- Ceramides | detail: Repairs the barrier | wrong: Good, but not for this concern
- Niacinamide | detail: Calms redness
WHY: ...

[ORDER] The prompt for putting things in order.
1. First step
2. Second step
3. Third step
WHY: ...
```

## Type notes
- `[TF]` has the two options built in — just give `ANSWER: True/False`.
- `[MC]` / `[FILL]` / `[SPOT]` — any number of options, exactly one `*`.
- `[FILL]` must contain `[___]`; `[FILL2]` must contain `[__1__]` and `[__2__]`.
- `[MATCH]` / `[ORDER]` — any number of rows.
- `[INGREDIENT]` rows: `label | detail: ... | wrong: ...` (detail & wrong optional).

## New question types
Want a type that isn't here? Describe it in plain English at the top of your doc
(what the user sees, how they answer, what "correct" means) and use a made-up tag
like `[NEWTYPE]`. I'll build the native UI + data model for it. Easy adds:
select-all-that-apply (multi-correct), type-the-word, tap-the-image-area, slider/scale.

## Filled example
```
### NODE 1
TITLE: The Science of Hydration
CELEBRATION: You've mastered hydration!

INTRO
TITLE: Hydration 101
TEXT: Hydration starts from within, but <b>humectants and moisturizers</b> fix surface dryness faster than a glass of water.

[TF] Drinking enough water helps keep your skin barrier balanced and plump.
ANSWER: True
WHY: Internal hydration supports the barrier, but topicals do the surface work.

[MC] What happens when skin doesn't get enough water?
* It produces MORE oil to compensate
- It stops producing oil entirely
- Nothing changes
WHY: Dehydrated skin overproduces sebum to protect itself.
WRONG (Nothing changes): Dehydration always shows up — usually as extra oil or flaking.

[ORDER] Assemble the correct morning routine order:
1. AM Cleanser
2. Lightweight Moisturizer
3. SPF Sunscreen

[FILL2] Dehydrated skin overproduces [__1__], so the real fix is more [__2__].
BLANK1: *oil | water | collagen
BLANK2: *hydration | scrubbing | soap
```
