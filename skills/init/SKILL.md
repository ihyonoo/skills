---
name: init
description: 프로젝트 지침 파일을 만들거나 갱신하고 에이전트별 파일을 연결한다. 새 프로젝트에서 처음 작업할 때, "지침 만들어줘" "프로젝트 문서화해줘" "init"이라고 할 때 사용한다.
---

Keep `AGENTS.md` at the project root as the original, with `CLAUDE.md` symlinked to it. The point is that whichever agent does the work reads the same instructions.

## 1. Check the existing files first

Read `references/file-layout.md` and settle which case you are in before writing anything.

**Preserving existing content is the default.** When instructions already exist, you are **updating** them, not rewriting them.

- Do not touch rules, warnings, or past lessons a person wrote by hand
- Fix only what is now wrong: commands that no longer run, conventions that changed, rules for code that is gone
- If something should be deleted, present it as a list and get approval. Do not delete quietly
- When you find items duplicated from the global instructions, **propose** removing them. The user decides

Summarize what you changed at the end.

## 2. Survey the codebase

Do not fill this in with guesses. If the survey will take three or more tool calls, delegate with the delegation skill.

- Build, test, run, and lint commands — from `package.json` scripts, `Makefile`, `pyproject.toml`, CI config. Run each one and keep only what actually works
- Conventions a single file does not reveal — test runner and its rules, error handling, import style, layering
- Known breakage — steps that fail often, approaches that were tried and abandoned

## 3. Write it

**Under 100 lines.** This file loads in full every session, so length is a cost paid on every turn.

**What goes in**

- One or two sentences on what this project is
- Build, test, and lint commands. This is the main reason the file exists — always include them
- Rules specific to this project — what differs from or adds to the global instructions
- Warnings — what tends to fail, approaches that were wrong before

**What must not go in**

- Anything the code already shows — the language, the framework, which directory holds what, the folder tree, file and function listings
- Anything already in the global instructions — git workflow, coding principles, test rules. Duplication loads twice and drifts apart later
- Generalities — "write clean code", "write good tests"

**Write rules the agent can act on.** A rule that needs interpretation is noise.

| Noise | Rule |
|---|---|
| Write tests well | Tests run on Vitest. Do not use mocks |
| Handle errors properly | Throw `AppError`. Never return `null` on failure |
| Keep commits clean | One commit per logical unit |

**Point at other documents instead of inlining them.** When a convention runs long, leave it in its own file and reference the path — one line here, the detail loaded only when it is needed. When a long procedure shows up, propose moving it into a skill.

**Format it for scanning.** Headings, lists, and tables. No narrative paragraphs.

Write it in English.

## 4. Link them

Create the link at the project root as described in `references/file-layout.md`.
