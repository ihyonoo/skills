---
name: trd
description: 기술 요구사항 문서를 작성한다. PRD가 확정된 뒤 어떻게 만들지 정할 때, 아키텍처·데이터 모델·인터페이스를 확정할 때, 사용자가 "TRD 쓰자"고 할 때 사용한다.
argument-hint: [기능 이름]
---

Write **how** it gets built. What and why are in the PRD.

## Check first

Read the matching PRD. If there is none, ask whether to write the PRD first. Without a PRD there is no way to verify what the design is for.

If you do not know the existing code structure, delegate exploration with the delegation skill before starting.

## Path

`docs/trd/YYYY-MM-DD-<kebab-slug>.md` — use the same slug as the PRD.

## Structure

**1. Overview**
Which PRD and which of its requirements this covers. The approach in three or four lines.

**2. Architecture**
The components and the flow between them. Add a diagram if it helps, but if the diagram needs a paragraph to be understood, redraw it.

**3. Data model**
Schema, key fields, relationships, indexes. For changes to existing tables, include the migration direction.

**4. Interfaces**
API endpoints, function signatures, events. Request and response shapes, and error cases. Signatures are the ceiling — do not write implementation bodies.

**5. Requirement mapping**
A table showing which component satisfies each `R-n` from the PRD. **An unmapped requirement means the design is not finished.**

**6. Dependencies**
External services, libraries, infrastructure. Versions and why each was introduced. For each, record the alternatives considered and the reason for the choice.

**7. Non-functional requirements**
Performance targets, load assumptions, security and permissions, logging and observability.

**8. Test strategy**
What gets verified by unit tests and what by integration tests. How the PRD's success criteria will be confirmed.

**9. Risks**
Assumptions that are expensive when wrong, and the countermeasures.

## After writing

Always run spec-review. Look especially for holes in the requirement mapping.

Once approved, move to implement. **Implementation starts by actually opening and reading this document.**

## Never do this

- Adding a feature in the TRD that is not in the PRD. Fix the PRD instead
