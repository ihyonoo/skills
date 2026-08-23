# Changing an existing screen

**Read this when changing a screen that already exists. If you are building something new, leave now.**

Getting the mode wrong is the single largest cause of bad results.

---

## 1. Settle the mode first

- **Preserve** — modernize without breaking the brand. Audit first, extract the existing tokens, improve incrementally
- **Overhaul** — keep the content and the information architecture, build a new visual language. Treat visuals as greenfield

When it is ambiguous, ask **once**. "Should this keep the existing brand, or should the visuals start fresh?"

## 2. Audit before touching anything

Write down the current state before proposing changes.

- **Brand tokens** — primary and accent colors, type stack, logo treatment, corner radii
- **Information architecture** — screen structure, primary navigation, key conversion paths
- **Content blocks** — what exists, what is doing work, what is filler
- **Patterns to keep** — recognizable signature elements, the voice of the copy
- **Patterns to retire** — AI tells (`ai-tells.md`), broken layouts, dead links, performance problems
- **The current dial values** — read this screen's `DESIGN_VARIANCE`, `MOTION_INTENSITY`, and `VISUAL_DENSITY`. **Those values are your starting point.** Do not start from the defaults

If the page has search traffic, add one more — **the current search-traffic state**. Ranking pages, meta titles, structured data, share cards. Breaking search traffic is the largest risk in a redesign.

## 3. Preservation rules

- **Do not change the information architecture.** Unless asked, leave page URLs, anchor IDs, and primary nav labels alone. Search traffic and muscle memory both hang on them
- **Extract the brand colors first.** A brand that is already purple stays purple. "No AI purple" is a default for fresh decisions, not a mandate to overwrite an existing brand
- **Keep the voice of the copy.** Visual modernization is not a content rewrite
- **Do not regress existing accessibility work.** Focus indicators, alt text, keyboard operation, and contrast all stay
- **Respect existing analytics events.** Do not rename buttons, form fields, or section IDs that tracking depends on

## 4. Apply the levers in order

Ordered by effect against risk. Stop when the brief is satisfied.

1. **Typography** — the largest visual lift per unit of risk
2. **Spacing and rhythm** — section spacing, vertical rhythm
3. **Color recalibration** — desaturate, unify the neutrals. Keep the brand accent
4. **Motion** — add responses appropriate to the dial value to existing components
5. **Recomposing the hero and key sections**
6. **Replacing blocks wholesale** — only when they cannot be saved

## 5. Decide how far to go

- Information architecture, content, and search traffic are sound → **partial improvement** (levers 1 to 4). 70% of the value at 40% of the risk
- The visual debt is structural (broken IA, no design system, broken mobile) → **overhaul**, preserving content strictly
- The brand itself is changing → treat it as greenfield

## 6. Never change these silently

Do not touch these without the user's approval.

- Page URLs and route paths
- Primary navigation labels
- Form field names and their order (this breaks analytics tracking and autofill)
- The logo and wordmark
- Legal, consent, and cookie copy

When you conclude one of these must change, do not change it. Say so first.

---

## When building variants

The procedure of building two or three structurally different variants is the same for an existing screen. But **include the current screen as one of the variants.** Without a baseline there is no way to tell improvement from a change of taste.

---

Adapted and condensed from Leonxlnx/taste-skill (MIT).
