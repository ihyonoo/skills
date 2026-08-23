---
name: implement
description: 확정된 설계 문서나 PRD·TRD를 코드로 옮긴다. 문서 승인이 끝나고 구현을 시작할 때, "이제 만들자" "구현하자"고 할 때, 작업 도중 어느 요구사항까지 됐는지 확인할 때 사용한다.
---

## 1. Actually open the document

Find the document for this work in `docs/design/`, `docs/prd/`, or `docs/trd/` and **read it.** Do not rely on memory or on the conversation — if the session changed or context was compacted, that memory is already gone.

If there is no document, go back to the design skill. Proceed without one **only when you directly confirmed an S assessment in this session.** If it is not in front of you, do not assume it was S.

After reading, lay it out once before starting.

- The requirement IDs to implement this round
- Which file or module each ID maps to (copy the TRD's mapping as is)
- The order and the reason for it

Create the working branch with the branch-flow skill before touching code.

**Order the work so a thin slice goes end to end first.** Finishing one ID must leave something that runs and can be seen. Completing one layer at a time (all the DB, then all the API, then all the UI) means nothing works until the last layer lands, so stopping midway leaves an unverified half.

## 2. One ID is one unit of work

Do not mix several requirements at once. Finish one, then move on.

Each unit follows the tdd skill. Use frontend-design when UI is involved, and root-cause when a bug of unknown origin appears.

Record progress **in a file.** Under the same slug as the document, keep `docs/progress/<slug>.md` updated with each requirement ID's state (done, in progress, not started). Kept only in the conversation, it is the first thing lost when context is compacted.

## 3. Stop when reality contradicts the document

Implementation reveals that the design was wrong. This is normal, not rare.

When it happens, **do not quietly implement something different.** Stop and ask as a set of options.

- Fix the document and follow the new design
- Follow the document, and handle the discovered problem separately

Either way, **update the document first**, then continue. The moment code runs ahead of the document, that document becomes a lie and the next person believes it.

## 4. Reconcile at the end

Walk the requirement IDs one by one.

- **Implemented** — in which file
- **Not done** — why, and when it will be
- **Built but not in the document** — why it was needed

Do not call it complete while a single MUST remains.

Once reconciled, move to commits and the PR with the branch-flow skill.

## Never do this

- Adding a feature that is not in the document because "it seemed useful"
