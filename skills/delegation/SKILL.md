---
name: delegation
description: 무거운 작업을 서브에이전트에 넘길지, 병렬로 돌릴지, 어떤 모델을 쓸지 추천안과 함께 사용자에게 확인받는다. 탐색·리뷰·검증·조사처럼 도구 호출이 3회 이상 예상되는 작업을 시작하기 직전에 사용한다.
---

Form the judgment first, then confirm that judgment with the user. Do not just throw questions and leave the choice to them.

## 1. Judge first

| Situation | Approach |
|---|---|
| Opening one or two files, one or two greps | **Handle it directly.** Spinning up a subagent costs more |
| Codebase exploration needing three or more queries | One subagent |
| Review, test and build verification, external research | One subagent |
| Two or more independent domains with no file overlap | N in parallel |
| Editing files, committing, pushing, creating branches | **Handle it directly.** Never delegate these |

## 2. Pick a model

| Kind of work | Tier |
|---|---|
| Gathering files, listing, format conversion, plain summarization | Small and fast |
| Codebase exploration, running tests, document drafts, ordinary review | Standard |
| Architecture judgment, hard debugging, final review, subtle tradeoffs | Top-tier reasoning |

Map the models the running agent offers onto these tiers (in Claude Code, haiku / sonnet / opus respectively).

When unclear, use standard. If you will trust the result and move on without checking, go up one tier.

## 3. Confirm

Ask two things as a set of options, but **put your recommendation first and mark the label with (추천).**

- Execution: direct / one subagent / N in parallel — write the time cost and context impact into each option
- Model: recommended model first, the rest with their tradeoff ("faster but may miss things" / "more accurate but slower")

Skip the execution question when: the user already specified the approach, the work is plainly a direct-handling job, another skill already fixed the execution mode (spec-review's two parallel axes, for example), or an interview round is in progress.

Skip the model question when: the user already named a model, the work is handled directly, or an interview round is in progress. **A fixed execution mode does not fix the model** — when another skill pinned the axes, still ask which model runs them.

When you skip, run the recommendation and say so in one line.

## 4. Write the prompt

The subagent knows **nothing** about this conversation. Explain the purpose, the context, and the expected output format self-sufficiently inside the prompt.

**Do not paste conversation history.** What you paste, and what the agent outputs, sit in context for the rest of the session and get re-read every turn. When something must be handed over, write it to a file and pass the path. Take the result back as a file too.

Specify the output format — length cap, sections, and which language to write in.

## 5. Run it and wait

If the next task depends on the result, run it in the foreground; otherwise run it in the background and keep working. When several independent delegations exist, launch them in parallel at once.

**Do not guess at the result of a backgrounded task before the completion notice arrives.** If the user asks, say it is still running.

## 6. Verify the result

Do not take a subagent's report at face value. When the conclusion drives the next step, confirm one or two of its central claims yourself.
