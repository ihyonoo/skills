---
name: design
description: 구현 전에 설계를 확정한다. 새 기능·리팩터링·구조 변경·신규 모듈 요청을 받았을 때, "설계부터 하자", "어떻게 만들지 정하자"고 할 때, 또는 무엇을 만들지는 정해졌지만 어떻게 만들지가 안 정해졌을 때 사용한다.
argument-hint: [만들려는 것]
---

## 1. Assess the scope and confirm it

Assess first.

- **S** — a bug fix, an edit inside one file, work whose behavior is already settled
- **M** — one feature added, two to five files, solved within the existing structure
- **L** — a new module or service, structural change, a new external dependency, or a decision that is hard to reverse

State the assessment and its reason in one line, and confirm it as a set of options. If the user picks a different path, take it.

**When this skill does not fit** (a plain question, work whose design is already settled), say so in one line and bow out.

## 2. Follow the path for the scope

**S** — no design document. Three-line summary of what, why, and how → approval → implement.

**M** — deep-interview (the frontier usually empties in one or two rounds) → one-page design memo → spec-review → approval → implement.

**L** — deep-interview until the frontier is empty → prd → trd → implement. **Do not write a separate design memo.** The settled decisions from the interview become the PRD's material directly, and the rejected alternatives and assumptions become the PRD's constraints and open-questions sections. When three documents say the same thing, they start to diverge.

When hidden complexity surfaces mid-work, **raise the level.** Stop, say so, then raise it. Never lower it.

## 3. When research is needed

If you do not know the current code structure, existing patterns, or dependencies, delegate exploration with the delegation skill. While waiting on results, ask the questions that do not depend on them.

## The design memo — M path only

Path: `docs/design/YYYY-MM-DD-<kebab-slug>.md`

L does not get one; the PRD and TRD play this role.

What goes in:

- **Problem** — the problem, not the symptom. Why it must be done now
- **Decisions** — what is settled and on what grounds
- **Rejected alternatives** — what was considered and not taken, and why. Recorded so the same discussion does not repeat
- **Non-goals** — state explicitly what this round does not do
- **Assumptions** — what is left open, and what breaks if it is wrong
- **Blast radius** — the files and modules to be touched

Write it in English. Code is capped at interface signatures.

## Never do this

- Drafting the design before the interview — it drags the user into your assumptions
- Moving to implementation without approval
