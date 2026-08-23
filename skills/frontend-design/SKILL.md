---
name: frontend-design
description: 웹 화면을 설계하고 구현한다. 페이지·컴포넌트·대시보드를 만들 때, 기존 화면의 디자인을 고칠 때, "UI 만들어줘" "디자인이 별로다" "AI 티 난다"고 할 때 사용한다.
---

## 1. Settle the direction first

If the work is not building a screen (changing a config value, editing text), say so in one line and bow out.

Do not carry a fixed default style. Confirm as a set of options before writing code.

- **A reference screen** — ask first whether there is a service or site they like. Far more precise than a verbal description
- **Dark mode** — light only, or both

Check the stack in the existing code before asking. Follow what is already in use; ask only when it has to be decided fresh.

## 2. Fix three dials as numbers

**Set all three before writing code and state them in your response.** Each is an integer from 1 to 10.

| Dial | 1 | 10 |
|---|---|---|
| `DESIGN_VARIANCE` | Perfectly symmetric | Asymmetric, experimental |
| `MOTION_INTENSITY` | Static | Scroll-linked, physics-based |
| `VISUAL_DENSITY` | Mostly whitespace | Densely packed |

Read the values from the brief.

| Signal | VARIANCE | MOTION | DENSITY |
|---|---|---|---|
| Landing, marketing, portfolio (default) | 8 | 6 | 4 |
| Restrained editorial, minimal, calm | 5 | 3 | 3 |
| Premium consumer, brand | 7 | 6 | 3 |
| Experimental, agency, high impact | 9 | 8 | 3 |
| Product UI, admin screens (default) | 4 | 3 | 7 |
| Data-dense dashboard | 3 | 2 | 8 |
| Public sector, finance, accessibility-first | 3 | 2 | 5 |
| Redesign, preserving | current | current+1 | current |
| Redesign, full overhaul | current+2 | current+2 | current |

**The values gate the rules.**

- `VARIANCE >= 5` — do not use a centered hero. Pick left-aligned, split, or asymmetric
- `VARIANCE <= 4` — use a symmetric grid. Do not attempt experimental layouts
- `MOTION >= 4` — honor reduced-motion settings. And it must actually move. If you declare the value and ship something static, lower the value to 3
- `MOTION <= 3` — only where state actually changes (open, close, loading)
- `DENSITY >= 7` — do not use card containers. Separate with whitespace and rules
- `DENSITY <= 3` — three or fewer main blocks per screen

## 3. Pick which reference files to read

This depends on what you are building. Read only what applies.

| File | When |
|---|---|
| `references/ai-tells.md` | **Always**, for any screen work |
| `references/landing.md` | Landing, marketing, portfolio only |
| `references/redesign.md` | Only when changing an existing screen |
| `references/tailwind.md` | When using Tailwind or shadcn/ui. Stack defaults and the performance and motion rules live here too |
| `references/preflight.md` | **Always, right before finishing** |

When changing an existing screen, read `redesign.md` **first**. Touching it before the audit creates work to undo.

## 4. Build two or three structurally different variants

**Different colors is not a variant.** At least two of these must actually differ.

- Layout — is the arrangement different
- Information hierarchy — what is shown largest
- Primary action — where the key button is and what form it takes

Three slightly different card grids are wallpaper, not variants.

**How to view them** — make them switchable on one screen. With routing, use a URL query (`?variant=a`); without it, use toggle state. Float the switcher at the bottom of the screen.

**Do not build them on an empty route.** Put them inside real data and the real surrounding UI. An empty page hides design problems.

When changing an existing screen, **include the current screen as one of the variants.** Without a baseline there is no way to tell improvement from a change of taste.

Add one line per variant on what it tried differently. Write it without design jargon.

**Do not write tests for variant-stage code.** Two or more of them are throwaway. This is the one-off prototype the tdd skill already exempts, so no confirmation is needed. Follow tdd from the moment you rewrite the chosen variant in step 5.

## 5. Choose and finish

Keep only the chosen variant; delete the rest and the switcher. Then run the checklist in `references/preflight.md`.

Count the items that are counted. Actually open the screen for the items that are looked at. Fix anything that does not pass.

## Never do this

- Writing code before the direction is confirmed and the dials are set
- Shipping prototype code to production as is — rewrite it after choosing
- Reporting "made it look nice" without showing the screen
- Waving through the checklist by eye
