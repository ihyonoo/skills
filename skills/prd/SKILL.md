---
name: prd
description: 제품 요구사항 문서를 작성한다. 무엇을 왜 만드는지 확정할 때, 설계가 끝나고 구현 범위를 문서로 못박을 때, 사용자가 "PRD 쓰자"고 할 때 사용한다.
argument-hint: [기능 이름]
---

Write **what** is being built and **why**. How to build it belongs to the TRD.

## Check first

If the design is not settled, run the design skill first. If requirements have gaps, fill them with deep-interview. **Do not fill in blanks with guesses.**

## Path

`docs/prd/YYYY-MM-DD-<kebab-slug>.md`

## Structure

**1. Problem and background**
What hurts right now, and why it must be solved now. Do not put the solution here.

**2. Goals and success criteria**
These must be measurable. "Improve usability" is not a goal. State what changes by how much, as a number or an observable condition.

**3. Users and scenarios**
Who uses this and when. Describe two or three representative scenarios as flows. Write the need, not the screen.

**4. Requirements**
Give every item an ID (`R-1`, `R-2`) and a priority.
- **MUST** — cannot ship without it
- **SHOULD** — needed, but can slip
- **COULD** — only if there is room

The TRD and the tests reference these IDs. Always assign them.

**Actually spread items across the three levels.** If everything is MUST, you have not prioritized.

**5. Non-goals**
What this round does not do. This heads off "why isn't this here" later.

**6. Constraints**
Deadlines, people, existing systems, regulations, budget.

**7. Open questions**
What is still undecided, and by when it must be decided.

## After writing

Always run spec-review. Do not move to an approval request while a blocking finding remains.

Once approved, move to trd.
