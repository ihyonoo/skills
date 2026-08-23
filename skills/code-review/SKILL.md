---
name: code-review
description: 코드 변경을 리뷰해 결함과 규약 위반을 찾는다. 구현이 끝났을 때, PR을 올리기 전, 사용자가 "코드 리뷰해줘" "이 변경 봐줘" "괜찮은지 봐줘"라고 할 때 사용한다. 문서·PRD·TRD 리뷰는 spec-review를 쓴다.
---

## Delegate the review. Never review your own code

Hand the review to a subagent that did not write this code. The context that produced the bug is the same context that hides it.

Give the reviewer the change and the standards, nothing else. **Do not pass why you wrote it that way.** Pass the diff range, the relevant document path, and the instruction file path.

Whether the code explains itself is the point of the review. A reviewer who hears the author's excuses first will accept that code forever.

## Split into two axes

They are independent, so run them in parallel (use the delegation skill to decide). Prompts are in `references/review-prompts.md`.

One exception: when the chosen reviewer is an external agent from another vendor, the two axes merge into a single call. The delegation skill defines that branch.

**Correctness** — does this code do what it intends

- Boundary conditions — empty input, zero, maximum, a single element
- Error paths — are resources released on failure, is partial state left behind
- Trust boundaries — does external input flow inward unvalidated
- Order and concurrency dependence — does it break when run twice or reordered
- Conditional side effects — writes that happen only inside a branch

**Consistency** — does this change match the documents and the rules

- Requirement IDs with no corresponding code
- Things that arrived without being in the document
- Points that conflict with the instruction file or the global instructions
- Imports, variables, and functions this change itself made unused

## Attach evidence

**"Looks fine" is not a review result.** If you judged something safe, quote the line that makes it safe. If you could not confirm it, classify it as "unverified".

Do not wave things through with "it is probably handled" or "there is probably a test". Confirm it, or write that you could not.

## Assign a grade

- **Blocking** — merging breaks behavior or corrupts data
- **Worth fixing** — it works now, but it costs later
- **Opinion** — taste, or an alternative

If even one blocking finding stands, do not open the PR.

## Handle the results

Do not flatter the review. For each item, state one of three:

- Accept — fix it
- Rebut — write why it is not a problem. The reviewer may have misread the code
- Defer — write why it is not being fixed now, and when it will be

When "the reviewer lacked context" is the repeated rebuttal, that is **a signal the context is missing from the code or the document.**

After fixing, re-review only what changed. Do not rerun the whole thing.

## Never do this

- Letting the author review their own code — the same context that produced the bug hides it
- Filling the page with formatting and naming notes. That is the linter's job
- Flagging existing code unrelated to this change — if you find some, report it as a separate list
- Opening the PR with a blocking finding left standing
