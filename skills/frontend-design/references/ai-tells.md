# Why it reads as AI-made

Almost always because **the defaults were left in place**. The option the tool offers most easily is the shape that appears most often.

This file applies to any kind of screen. For landing and marketing pages, read `landing.md` alongside it.

---

## 1. Color

**The tell**
- Purple-to-indigo gradient (`from-purple-500 to-indigo-500`). The strongest signal there is
- Every color taken from the `500` step of the default Tailwind palette
- Too many colors — blue button, green badge, orange warning, red delete
- Neon glows, pure black (`#000000`)

**Instead**
- **One** accent plus neutrals. Status colors (warning, error) are the exception
- Lower the saturation. Real brand colors are not pure hues
- Skip gradients, or keep them to a lightness shift within one hue
- Use an off-black like `zinc-950` rather than pure black
- Tint shadows toward the background hue. Never a pure-black shadow on a light background

**Lock the accent** — once chosen, it is that color everywhere. A blue button appearing in a warm-gray scheme, or a teal badge in the footer of a rose-accented screen, breaks it.

**Do not repeat a palette** — do not reach for the same palette family as the screen you built last, even when the brief looks similar. Reusing the same combination makes the brand invisible.

## 2. Corners and shadows

**The tell**
- `rounded-xl` plus `shadow-lg` on everything. When it all floats, hierarchy disappears
- A card inside a card inside a card

**Instead**
- Shadows only on things that **actually float** — modals, dropdowns, tooltips
- Separate cards with a 1px `border` or a background shift
- Use cards only when elevation reflects real hierarchy. Otherwise group with whitespace or rules

**Lock the radius** — pick one radius system for the whole screen. All sharp (0), all soft (12 to 16px), or pill-shaped for interactive elements only. To mix, fix a rule ("buttons are pills, cards are 16px, inputs are 8px") and follow it everywhere. Round buttons in an angular layout is broken.

## 3. Layout

**The tell**
- Centered hero with a 3-column card grid below it. That is the landing template itself
- Everything centered on the screen
- Content spanning the full viewport width

**Instead**
- Left-aligned by default. Center only short phrases
- Do not fear asymmetry — 2:1, sidebar plus body
- Cap reading measure around 65 characters per line
- Build multi-column layouts with grid, not flex percentage math (`w-[calc(33%-1rem)]`)
- Write down how each multi-column layout collapses at narrow widths, in the same place. Do not leave it to "it will probably work"

## 4. Whitespace

**The tell**
- The same gap everywhere (`p-6`, `gap-6`). Nothing shows what belongs together

**Instead**
- **Pull related things together and push groups apart.** A heading sits close to its description; the next section sits far away
- Limit spacing to 4 to 6 steps and choose only from those

## 5. Typography

**The tell**
- Hierarchy expressed by size alone
- Every heading at `font-bold`
- Body and headings in the same color
- Large headings rendered as gradient text

**Instead**
- Use size, weight, and **color** together. Drop the body to gray and the heading rises on its own
- 4 to 5 size steps is enough
- Tighten tracking as headings get larger (`tracking-tight`)

**Do not reach for a serif by default** — "it feels creative" and "it feels premium" are not reasons to pick a serif. That instinct is the most common AI default. Use a serif when the brief names the typeface, or when the genre is unmistakable: publication, heritage, magazine. Otherwise go sans display. Do not use `Fraunces` or `Instrument Serif` as defaults. If you do use a serif, do not reuse the one from the last project.

**When emphasizing one word inside a heading**, do not drop in a different typeface. Use italic or weight within the same family. A serif word jammed into a sans headline is an amateur signal.

**Italic descenders** — when an italic word contains `y g j p q`, `leading-none` clips it. Set line height to at least 1.1 and reserve room below.

## 6. Icons

**The tell**
- Emoji standing in for icons. The loudest tell of all
- Sizes and stroke weights varying icon to icon
- Drawing a missing icon by hand as an SVG path

**Instead**
- Pick one icon set and stay in it. Choose from Phosphor, HugeIcons, Radix, Tabler
- Do not use lucide by default. It is the shadcn/ui default set, so shipping it as-is reads as AI. Use it when explicitly requested or when the project already depends on it
- Fix size and stroke weight globally
- If a glyph is missing, install a second set. Do not draw it
- Confirm the screen still makes sense with the icons removed

## 7. Copy

**The tell**
- "Seamlessly", "Effortlessly", "Supercharge", "손쉽게", "혁신적인", "차세대"
- Exclamation marks
- Buttons reading "지금 시작하기" or "더 알아보기"

**Instead**
- Be concrete. Not "빠르게 배포하세요" but "3초 만에 배포"
- Put what the button actually does on the button — "리포트 내보내기"

**Do not place two buttons that mean the same thing** — when "문의하기" and "상담 신청" sit on one screen, merge them. One intent, one label.

**Re-read every visible sentence before finishing** — headings, buttons, captions, empty-state text, error text. Find the awkward metaphors, the sentences whose referent is unclear, the sentences written to sound thoughtful, and replace them with plain ones. Clever copy is worse than dull copy.

## 8. Fake data

Demo data is where the tell shows most.

**The tell**
- Sample names like "홍길동", "John Doe", "Jane Smith"
- Invented startup names like "Acme", "Nexus", "SmartFlow", "Cloudly"
- Suspiciously round numbers — `99.99%`, `50%`, `1,234,567`, `10,000+`
- A gray person icon or an initial circle where an avatar goes
- Dates all on the same day, or exactly one day apart

**Instead**
- Use realistic names that fit the context. Korean names for a Korean service, a regional mix for a global one
- Invent brand names that could plausibly exist in that industry
- Rough up the numbers — `47.2%`, `1,284`, `3.6배`
- Use a believable photo placeholder for avatars, or drop avatars entirely
- List data must vary in length, time, and state. Rows that all look alike read as fake

**Do not invent numbers** — use precise-looking figures (`4.1배`, `99.9% 가동률`) only when there is a source. Without one, mark them as placeholders in a comment or build without them.

## 9. Animation

**The tell**
- `hover:scale-105 transition-all` on everything
- A staggered fade-in on page entry
- An infinite loop on every card

**Instead**
- Only where state actually changes. Open, close, loading
- 150 to 200ms. Longer than that feels slow
- Name the properties that change instead of `transition-all`

**You must be able to justify motion in one sentence before adding it.** There are only four valid reasons — hierarchy (moving the eye), sequence (revealing content in order), feedback (acknowledging an action), and state transition (showing something changed). "It looked cool" is not one.

## 10. The missing states

**The tell**
- No loading indicator, nothing in an empty list, a white screen on error
- A single spinner for loading

**Instead**
- Always build these three. This is what separates a real service from a demo
- Make loading a skeleton shaped like the final layout
- Put the next action inside the empty state
- Errors go beside the input for forms, in a toast when they are transient

## 11. Forms

- Labels go **above** the input. Do not use the placeholder as the label
- Reserve space for helper text in the markup. Error text goes **below** the input
- Check that inputs, placeholders, focus rings, and labels clear contrast against the background. A pale gray placeholder on a near-white form is invisible

## 12. Buttons

- Confirm the button text is readable on the button background. White on white and borderless transparent buttons are the common accidents
- Give ghost buttons over photos a scrim or a border
- If a button label wraps to two lines at desktop, shorten the label or widen the button. Primary buttons stay within 3 words

---

## Before finishing

Run the checklist in `preflight.md`. Every item is counted or seen, so it is faster than eyeballing.

---

Some items — fake data, serif discipline, locking the accent — are adapted from Leonxlnx/taste-skill (MIT).
