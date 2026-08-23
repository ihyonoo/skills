# Stack guidance

**Follow what is already in use. Everything below is the default for fresh decisions.** This caveat is not repeated on individual items.

Check `package.json` before importing any library. If it is missing, state the install command first. Do not assume it exists.

## Do not ship the shadcn/ui default theme

The code is copied into your own repo, so it can be changed. Left at defaults it reads as "shadcn".

At minimum, adjust these tokens in `globals.css`.

- `--primary` — the accent. Do not leave the default black or blue
- `--radius` — defaults to `0.5rem`. Tune it to the project and align everything else to it
- `--muted-foreground` — secondary body text. Check that it has enough contrast

## Fix the scales first

Decide before drawing screens. Fixing them removes the per-decision deliberation and produces consistency.

- **Spacing** — use 4 to 6 steps only (for example `2 / 4 / 8 / 12 / 20`)
- **Type sizes** — 4 to 5 steps (for example `sm / base / lg / 2xl / 4xl`)
- **Radius** — one
- **Color** — 1 accent, 4 to 5 neutral steps, 3 status colors (success, warning, error)

When you need a value outside these lists, the scale is wrong. Suspect the scale before adding an arbitrary value like `p-[13px]`.

## Fonts

The system default looks flat, and Inter is already everywhere. Pick one.

- Body and UI — Geist, IBM Plex Sans, Pretendard (Korean)
- When Korean is in the mix, choose the Korean face first and match the Latin one to it. Doing it the other way around breaks the Korean
- Use `tabular-nums` when numbers are listed in a table
- Use the framework's font optimization (`next/font` and equivalents) or self-host with `font-display: swap`. Do not pull web fonts with a `<link>` in production

## Responsive

Build from the narrow width up. Tailwind's `md:` and `lg:` add as it widens.

- Two breakpoints are enough
- Put tables in a horizontally scrolling container at narrow widths. The page itself must never scroll sideways
- Touch targets 44px or larger
- Use `min-h-[100dvh]` instead of `h-screen` for full-height sections. The mobile browser address bar makes the layout jump
- Build multi-column layouts with grid, not flex percentage math (`w-[calc(33%-1rem)]`)

## Dark mode

Do not maintain two sets of colors. **Define tokens as CSS variables and swap the values.** Components reference only token names like `bg-background` and `text-foreground`.

Scattering the `dark:` prefix across components means opening every file to change one color later.

## Accessibility floor

Miss these and real people cannot use it.

- Body contrast 4.5:1 or better. Gray text left too light is the common mistake
- Do not remove focus rings. When the design suffers, switch to `focus-visible`
- `aria-label` on icon-only buttons
- Do not signal state by color alone — pair it with an icon or text

## Versions and libraries

Defaults for fresh decisions.

- **Tailwind** — v4. v3 only when an existing project requires it. On v4, use `@tailwindcss/postcss` in the PostCSS config rather than `tailwindcss`, or use the bundler plugin
- **Animation** — Motion (`motion/react`). `framer-motion` is the old name; import from `motion/react` in new code
- **Icons** — one of Phosphor, HugeIcons, Radix, Tabler. Do not use lucide as the default (`ai-tells.md`, section 6)
- One icon set per project. One design system per project. Do not mix

## Implementing motion

- **Animate `transform` and `opacity` only.** `top`, `left`, `width`, and `height` recalculate layout every frame
- Use `will-change` sparingly, only on elements that actually move
- **Do not use `window.addEventListener("scroll", ...)`.** It runs every scroll frame with no batching. Pick a library scroll hook, `IntersectionObserver`, or CSS scroll-driven animation (`animation-timeline: view()`)
- **Do not track continuously changing values in component state.** Mouse position, scroll progress, pointer physics — putting these in state redraws the whole tree on every change and collapses on mobile. Use the library's motion values
- Do not touch state inside a `requestAnimationFrame` loop
- Do not skip cleanup. Release scroll triggers and listeners when the element leaves the screen
- **Honor reduced-motion settings.** Infinite loops, parallax, and scroll hijacking must collapse to static
- Apply noise and grain filters only to a fixed overlay layer. On a scrolling container they repaint continuously

## Performance

- Give the first-screen image priority. Reserve space for fonts, images, and embeds so the layout does not shift
- Load heavy things below the fold late. Animation libraries are not small
- Do not sprinkle `z-index` everywhere. Use it only where layering is real (sticky headers, modals, overlays) and record the scale in one place

## Common mistakes

- `transition-all` — specify only the properties that change
- Fixed height on a container — content that overflows gets clipped
- Papering over layout problems with `overflow-hidden` — find the cause
- A class string growing long is the signal to split out a component

---

Some stack rules are adapted from Leonxlnx/taste-skill (MIT).
