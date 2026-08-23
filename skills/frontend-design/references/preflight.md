# Pre-ship checklist

**Everything here is counted or seen immediately.** If even one item does not pass, it is not done.

Judgments like "is it harmonious" or "was it well derived from the brief" are not here. Those are not checklist items.

---

## Common — every screen

- [ ] Are all **three dial values** written as numbers in the response?
- [ ] `MOTION_INTENSITY` is 4 or higher — is there actually at least one animation?
- [ ] Is there **exactly one accent color**, used the same way across the whole screen?
- [ ] Is there **one corner-radius system**? No round buttons inside an angular layout?
- [ ] Is there **one theme**? No dark section wedged into the middle of a light screen?
- [ ] **Is button text readable against its own background?** No white-on-white, no borderless transparent buttons?
- [ ] Does every **button label fit on one line** at desktop?
- [ ] Are there **two or more buttons meaning the same thing**?
- [ ] Do **form inputs, placeholders, focus rings, and labels** clear contrast against the background?
- [ ] Do **loading, empty, and error** states all exist?
- [ ] Does it work **by keyboard alone**? Is focus visible?
- [ ] Does it hold up at **narrow widths**? Is the collapse behavior written down for every multi-column layout?
- [ ] Is there **one icon set**? No hand-drawn SVG? No emoji standing in for icons?
- [ ] Is the **fake data** believable? No sample names (홍길동 / John Doe), no fake brands (Acme), no suspiciously round numbers (99.99%)?
- [ ] Are there **precise-looking figures with no source**? If so, are they marked as placeholders?
- [ ] Did you **re-read every visible sentence**? No awkward metaphors, no sentences that do not parse?
- [ ] Are **italic descenders** (`y g j p q`) not being clipped?
- [ ] Can you justify **each animation** in one sentence?

## Additional — landing, marketing, portfolio

Skip this section for product UI and dashboards.

- [ ] Does the **hero fit in the first screen**? Headline within 2 lines, subtext within 20 words and 4 lines, button visible without scrolling?
- [ ] Is **hero top padding** 6rem or less?
- [ ] Are there **4 or fewer text elements in the hero**? No tagline under the buttons, no trust strip?
- [ ] Is the **logo wall outside the hero**? No industry labels under the logos?
- [ ] Did you **count the small labels (eyebrows)**? Is it at most `ceil(section count / 3)`?
- [ ] Are there **numbered labels** (`00 / INDEX`, `001 · Features`)?
- [ ] Is any **layout family used twice**? With 8 sections, are there 4 or more distinct families?
- [ ] Does an **image-plus-text split** run 3 times consecutively?
- [ ] Is there a **split header** (large headline left, small explanatory paragraph right)?
- [ ] Does the **grid cell count match the content count**? No empty cells?
- [ ] Do **at least 2 or 3 tiles** carry real visual variation?
- [ ] Is a **list of more than 5 items** rendered as a plain list with rules?
- [ ] Are **real images** in place? No fake product screens built from `div`s?
- [ ] Are **quotes within 3 lines**, with both name and role in the attribution?
- [ ] Is the **navigation on one line**? Height 80px or less?
- [ ] Is there **at most one marquee** on the page?
- [ ] Are the **decorative strings** gone — scroll cues, locale/time/weather strips, version footers, decorative status dots, the word strip at the bottom of the hero, `Step 1 / Step 2` labels, tag badges laid over images?

## Additional — after changing an existing screen

- [ ] Did **page URLs and routes** stay unchanged?
- [ ] Did **form field names and their order** stay unchanged?
- [ ] Did **primary nav labels** stay unchanged?
- [ ] Was **existing accessibility work** (focus, alt text, keyboard) left intact?
- [ ] Were the **brand colors and logo** left alone?
- [ ] If you concluded something on this list must change, **did you say so instead of changing it**?

---

## When an item does not pass

Fix it. Do not do "mostly fine, moving on". Count the items that are counted, and actually open the screen for the items that are looked at.

---

Adapted and condensed from Leonxlnx/taste-skill (MIT).
