# Landing, marketing, and portfolio only

**This file is for landing pages, marketing pages, and portfolios only. If you are building product UI, admin screens, or a dashboard, leave now.**

The rules below come from patterns observed repeatedly in real output. Treat them as prohibitions unless the brief explicitly asks otherwise.

---

## 1. The hero

**It fits in the first screen.** Headline within 2 lines, subtext within 20 words and 4 lines, the primary button visible without scrolling. When it overflows, reduce the type scale or cut the copy. If you cannot get the subtext under 20 words, the value proposition is not settled — the rule is not too tight.

**Plan type size and image size together.** When the headline runs past 6 words and the image is large, do not start at the largest step. Use the largest step only when the headline is 3 to 5 words. A headline that folds to 4 lines is a size mistake, not a copy-length problem.

**Cap the top padding.** Hero top padding stays at or under 6rem at desktop. More than that leaves the content floating mid-viewport, reading as a layout bug rather than intentional space.

**Four text elements maximum.** The hero is one moment, not a feature list.

1. A small label **or** a brand strip (neither is fine)
2. The headline
3. The subtext
4. Buttons (one primary, at most one secondary)

Not in the hero: a small tagline under the buttons, a trust strip ("used by teams at..."), a pricing teaser, feature bullets, a row of user avatars. All of these move to their own section directly below.

**The logo wall goes outside the hero.** The "used by" logo row is its own section below. Do not push it into the same row as the hero copy.

**The hero needs a real visual.** Text plus a gradient blob is a placeholder, not a hero.

## 2. Small labels (eyebrows)

The small uppercase label that sits above a section heading. Putting one above every section is the most common AI pattern.

**At most one per three sections.** The hero counts as one. Nine sections allow at most three labels. If section A has one, the next two cannot.

**How to count** — count the small uppercase, wide-tracking labels. Exceeding `ceil(section count / 3)` is a failure.

**What to do instead** — drop it. The heading alone is enough. The section's position on the page already says what it is.

**Do not number them** — no `00 / INDEX`, `001 · Features`, `06 · How it works`. No `01 / 4` pagination on images or tiles either. Do not count things the reader can count.

**Do not add an explanatory sentence under the label** — label, heading, body is enough. Nothing wedged between them like "these ship today, not on a roadmap."

## 3. Section layout

**Do not use the same layout family twice.** A 3-column image card row, a full-width quote, a left-right split — one appearance each per page. Eight sections means at least four distinct families.

**Left-right zigzag runs at most twice.** Alternating image-and-text splits fails on the third consecutive one. Break it with a full-width section, a vertical stack, or a different family.

**No split headers** — do not use "large headline left, small explanatory paragraph right" as a section header. One message per section. When you genuinely need both, stack them vertically. Split only when the right column carries a real visual or interactive element.

**Do not float a small paragraph at the top right of a heading** — a small explainer sitting in the corner with no alignment to anything is the tell.

## 4. Grids and tiles

**The cell count equals the content count.** Three items means three cells. An empty cell in the middle or at the end means the grid was planned wrong. Reshape the grid rather than filling the blank.

**Tile backgrounds cannot all be identical.** Six white cards with only text is dull. Give at least two or three cells real visual variation — a real image, a pattern, a differently toned background.

**Long lists become something other than a list.** Past 5 items, do not render a default list with rules. Use a 2-column split, a card grid with images, tabs or an accordion, horizontal scrolling, or a carousel. A 10-row table with a rule under every row is the laziest default.

**Do not rule both above and below every row.** Pick one — a rule between rows, or a rule above the group.

## 5. Content density

Landing pages are decided on the first impression.

**The default section shape** — a short heading (within 8 words), a short paragraph (within 25 words), and one visual **or** one button. Anything more must be justified by that section's job.

**Do not build a section that dumps data.** A 20-row table, a 30-item award list, an enormous pricing matrix — the layout is wrong. Show the top 3 to 5 with a "view all" link, use a carousel or marquee for breadth, or move it to its own page if the data is the product.

**One voice per page.** Do not mix technical notation, lyrical prose, and marketing copy on one screen.

## 6. Quotes and testimonials

- Body within **3 lines**. Cut a long original. A landing-page quote is an excerpt, not the full text
- Attribution is name plus role (plus company). Never a bare name
- Use real typographic quotation marks, or none at all

## 7. Images

**A text-only landing page is unfinished, not minimal.** Even a restrained brief needs a hero, a product or environment shot, and a supporting image.

**Priority**
1. **Use an image generation tool if one is available.** Generate per section at the right aspect ratio
2. Otherwise use a real photo source. `https://picsum.photos/seed/{descriptive-seed}/{w}/{h}`, with the section described in the seed
3. If neither is possible, leave a labeled placeholder comment (`<!-- TODO: hero product photo 1600x1200 -->`) and, at the end of the response, say which slots need which images

**Do not do this**
- Build a fake product screen out of `div`s — fake dashboards, fake terminals, fake task lists. The strongest signal there is
- Draw decorative SVGs by hand
- Lay tag badges over images (`Brand · 02` and the like)
- Add a photo-credit caption when there is no real photographer (`Frame XII · 35mm`)

**Logo walls** — use real SVG logos (Simple Icons, `https://cdn.simpleicons.org/{slug}/{color}`). For an invented brand, build a simple monogram. A row of plain text wordmarks reads as AI. Do not put industry labels under the logos — the logo itself is the credibility. Confirm they render in both light and dark mode.

## 8. Navigation

- **One line** at desktop. If it does not fit at 1024px, shorten labels, drop items, or collapse to a hamburger. A two-line nav is broken
- 80px tall or less. 64 to 72px by default

## 9. Motion

**It must move as much as it claims.** When `MOTION_INTENSITY` is 4 or higher, actually implement hero entry, scroll reveal on key sections, and button response. If you cannot, drop the value to 3 and build a proper static screen. Half-built animation — cut-off scroll triggers, jumpy entries, uncleaned listeners — is the worst outcome.

**At most one marquee per page.** Two or more horizontally scrolling text or logo strips read as lazy filler.

**For stacked-card scroll effects**, pin to the top of the viewport before the sequence advances. Starting the pin at the middle of the viewport makes it begin after a half-scroll and feel wrong.

**Glassmorphism** suits premium consumer work and media overlays, not admin screens or public services. When used, do not stop at a blur — build the edge with a 1px inner border and a faint inner shadow. Fall back to an opaque background when transparency is reduced.

## 10. Decorative strings

All of these recur in real output.

- **Version labels in the hero** — `V0.6`, `BETA`, `EARLY ACCESS`. Only when the brief is about launch status
- **`Brand · No. 01` style sublabels**
- **Overusing the middle dot (`·`)** — at most one per line. Not the default separator for "A · B · C · D"
- **Decorative colored dots** — on every nav item, every list row, every badge. Only when they carry real state (server status, availability)
- **Locale, time, and weather strips** — `Seoul 14:23 · 18°C`, a city name in the header. Only for a genuinely multi-timezone team or a place-focused brand. A single address line in the footer is fine
- **Scroll cues** — `Scroll`, `↓`, mouse-wheel icons. Someone who has not scrolled yet is looking at the hero. They know what scrolling is
- **Vertically rotated text** — only when the brief is explicitly an experimental portfolio
- **Decorative crosshairs and grid lines** — drop them unless they align real content
- **A word strip at the bottom of the hero** — small caps reading `BRAND. MOTION. SPATIAL.`
- **Version footers on a marketing page** — `v1.4.2`, `Build 0048`, `synced 4s ago`
- **Fake stock counters** — `412 of 800 reserved`. Only with real data
- **Score bars with a filled background track** — a number plus a small icon communicates a comparison better
- **Generic step labels** — `Step 1 / Step 2 / Step 3`, `Phase 01`. The step's content is the label. Write "설치", "설정", "배포"
- **Headlines broken with `<br>` and italicized** — only when the brief asks for it
- **Precious section labels** — "현장에서", "작업 노트", "책상 위에서". Use plain functional labels

---

Adapted and condensed from Leonxlnx/taste-skill (MIT).
