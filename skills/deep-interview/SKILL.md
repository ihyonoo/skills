---
name: deep-interview
description: 결정 트리를 라운드 단위로 좁혀가며 질문해 요구사항을 확정한다. 설계·기획·스펙 작성 전 정보가 부족할 때, 사용자가 "딥인터뷰", "요구사항 정리하자", "같이 설계하자"고 할 때 사용한다.
---

Interview until you reach a shared understanding with the user. The output is not a document — it is a **list of settled decisions**.

## The decision tree and the frontier

Treat requirements as a decision tree. Every decision branches into decisions hanging beneath it.

**Frontier** = the questions answerable *right now* because their prerequisite decisions are already settled. A question that requires guessing an answer you have not heard yet is not on the frontier.

1. Compute the frontier
2. Ask the entire frontier in one round. If a multiple-choice question tool exists, use it, and call it repeatedly when the frontier exceeds what one call holds. If not, produce a numbered list of questions
3. Answers restructure the tree. Settled decisions push the frontier outward and blocked questions open up
4. Next round with the new frontier
5. **Stop when the frontier is empty.** Every branch has been visited and nothing was silently assumed

## Rules for writing questions

- **Mark a recommendation on every set of options and put the recommended one first.** The user may not know the domain. Do not just ask them to pick — judge which is better and say so
- Write the **tradeoff** into each option's description. What is gained and what is lost
- Ask only what actually changes the outcome. When a conventional default exists, use it and say so in one line
- One question settles one decision. Ask **which way to go**, not whether to proceed
- Do not put interdependent questions in the same round. The dependent one goes in the next round

## Find facts yourself

Finding facts is your job. Making decisions is the user's job.

Do not ask the user anything you can confirm from files, the codebase, or the web. If the research will take three or more tool calls, delegate with the delegation skill. **Do not stall waiting on research** — defer only the questions that depend on it, and ask the rest of the frontier now.

## Number of rounds

Unlimited. Ending early is far worse than running many rounds. But do not ask about the same axis twice.

## Ending

Compile the settled decisions into a list and confirm it with the user. Anything still unanswered is stated explicitly as an **assumption**, with one line on what breaks if it is wrong.

## Never do this

- Starting implementation mid-interview
