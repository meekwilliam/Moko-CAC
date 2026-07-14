# Moko Design System

`Moko/MarketDesignSystem.swift` is the visual source of truth for the app.
It expresses the product as a premium interactive market-training game: dark,
technical, immersive, and market-led. It contains no character or mascot roles.

## Rules

- Product screens use semantic tokens, not raw hex colors or one-off dimensions.
- Teal, blue, violet, and magenta are brand/progression roles.
- Bullish green and bearish red are reserved for market direction.
- Assessment success uses brand teal. Assessment mistakes use warning amber.
- All trade-decision choices are neutral before selection. Long, wait, and short
  receive bullish, warning, and bearish color only after selection or reveal.
- Sora is limited to display type, section hierarchy, major metrics, and mastery.
- Plus Jakarta Sans is used for normal UI, body copy, controls, and explanations.
- Monospaced type is reserved for market numbers and technical data.
- All-caps is reserved for overlines, compact categories, and technical headers.
- Cards use surface layering, one-pixel borders, restrained shadow, and optional
  focus glow. They do not use cartoon slab shadows.
- Motion uses the shared fast, normal, and deliberate ease timings. No bounce or
  exaggerated spring is part of the system.

## Token groups

- `MarketDesign.Colors`: backgrounds, surfaces, text, brand roles, borders, and
  four-state semantic market palettes with full, muted, border, and contrast roles.
- `MarketDesign.TextStyle`: display, headline, title, body, caption, overline,
  metric, market-number, and button styles.
- `MarketDesign.Spacing`: 4, 8, 12, 16, 20, 24, 32, 40, and 48 points.
- `MarketDesign.Radius`: 8, 12, 16, and 20 points.
- `MarketDesign.Elevation`: base, raised, modal, and focus levels.
- `MarketDesign.Motion`: 140ms, 220ms, and 360ms shared timings.
- `MarketDesign.IconSize`: small, medium, and large mobile-safe icon sizes.

## Reusable presentation APIs

- `.marketText(_:)`
- `.marketIcon(size:color:)`
- `.marketCard(elevation:border:radius:accent:)`
- `MarketButtonStyle`
- `TradeDecisionButtonStyle`

## Representative implementation sample

The system is currently proven in three deliberately different surfaces:

1. `SkillMapView`: display hierarchy, HUD metrics, focus cards, borders, spacing,
   and primary/secondary actions.
2. `FeedbackBanner`: success/warning semantics, explanation hierarchy, and action
   controls.
3. `OrderFlowSimulationView`: neutral-before-selection Long / Wait / Short buttons
   with directional color applied only after the learner chooses.

Legacy `Theme` properties remain as aliases so existing lesson mechanics keep
working during migration. New screen work should use `MarketDesign` directly.
