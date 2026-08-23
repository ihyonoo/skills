---
name: spec-review
description: 설계 문서·PRD·TRD를 리뷰해 빠진 결정과 실행 불가능한 부분을 찾는다. 문서 초안을 다 쓴 직후, 승인 요청 전, 사용자가 "리뷰해줘" "이거 괜찮은지 봐줘"라고 할 때 사용한다.
---

## Give the reviewer the document and nothing else

When delegating the review to a subagent, **do not pass the context of how it was written.** Pass the document path only.

Whether the document stands on its own is the point of the review. Feed the reviewer background only the author knows and the document will look self-sufficient forever.

## Split into two axes

They are independent, so run them in parallel (use the delegation skill to decide). Prompts are in `references/review-prompts.md`.

One exception: when the chosen reviewer is an external agent from another vendor, the two axes merge into a single call. The delegation skill defines that branch.

**Completeness** — is the document itself whole
- Decisions that should have been made and were not
- Sentences that admit several readings
- Success criteria that cannot be measured ("fast", "stable")
- Numbers that appear without grounds
- Non-goals left unstated

**Feasibility** — can this be built as written
- Can implementation start from this document alone
- Hidden dependencies (external APIs, data, permissions, other teams)
- Scope that is unrealistic inside the stated constraints
- Points that conflict with existing code and structure

## Assign a grade

- **Blocking** — proceeding as written will stall implementation
- **Worth fixing** — it proceeds, but it costs later
- **Opinion** — taste, or an alternative

If even one blocking finding stands, do not move to approval.

## Handle the results

Do not flatter the review. For each item, state one of three:

- Accept — fix the document
- Rebut — write why it is not a problem. The reviewer may have misread the document
- Defer — write why it cannot be decided now, and when it will be

Rebuttals are legitimate. The reviewer saw only the document; you know more. But when "the reviewer lacked context" is the repeated rebuttal, that is **a signal the context is missing from the document.**

## Never do this

- Letting the author review their own document — they share the same blind spots
- Filling the page with typo and style notes. That is not a review
- Moving to an approval request without a review
