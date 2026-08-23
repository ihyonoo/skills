---
name: init
description: 프로젝트 지침 파일을 만들거나 갱신하고 에이전트별 파일을 연결한다. 새 프로젝트에서 처음 작업할 때, "지침 만들어줘" "프로젝트 문서화해줘" "init"이라고 할 때 사용한다.
---

Keep `AGENTS.md` at the project root as the original, with `CLAUDE.md` symlinked to it. The point is that whichever agent does the work reads the same instructions.

## 1. Check the existing files first

There are four cases and they are handled differently.

- **Neither exists** → create them
- **Only `CLAUDE.md` exists** → move the content into `AGENTS.md` and replace `CLAUDE.md` with a link. **Back it up before replacing**
- **Only `AGENTS.md` exists** → add the `CLAUDE.md` link
- **Both are real files** → compare the content. If they differ, propose a merge and get approval. **Never overwrite on your own**

**Preserving existing content is the default.** When instructions already exist, you are **updating** them, not rewriting them.

- Do not touch rules, warnings, or past lessons a person wrote by hand
- Fix only what is now wrong: commands that no longer exist, changed structure, directories that are gone
- If something should be deleted, present it as a list and get approval. Do not delete quietly
- When you find items duplicated from the global instructions, **propose** removing them. The user decides

Summarize what you changed at the end.

## 2. Survey the codebase

Do not fill this in with guesses. If the survey will take three or more tool calls, delegate with the delegation skill.

- Build, test, run, and lint commands — find them in `package.json` scripts, `Makefile`, `pyproject.toml`, CI config
- The directory structure and what each directory is for
- Language, framework, main dependencies and versions
- Conventions already in place — naming, test locations, import style

## 3. Write it

**What goes in**

- One paragraph of overview — what this project does
- Frequently used commands — only ones you actually confirmed work
- Structure — the main directories and their roles
- Rules specific to this project — what differs from or adds to the global instructions
- Warnings — what tends to fail, approaches that were wrong before

**What must not go in**

- Anything already in the global instructions — git workflow, coding principles, test rules. Duplication loads twice and drifts apart later
- Anything you learn by reading the code — function lists, file listings
- Generalities — "write clean code", "keep it readable"

Write it in English, and keep it short. **This file loads in full every session.** When a procedure gets long, propose moving it into a skill.

## 4. Link them

Create the link at the project root.

```
ln -s AGENTS.md CLAUDE.md
```

Do not add it to `.gitignore`. The instructions travel with the repo.

If this is not a solo repo and several people clone it, say so first. Symlinks committed to git can break on Windows, and in that case ask whether to keep both as real files instead of a link.
