# Skill authoring rules for this repo

## Structure

```
skills/<name>/SKILL.md          Required. 1000-word limit (exceptions below)
skills/<name>/references/*.md   What overflows the body. Loaded only when needed
```

When `SKILL.md` exceeds 1000 words, cut it and move the excess into `references/`. Principles and judgment criteria go in the body; long examples, templates, and checklists go in reference files. A complex procedure is not the problem. A complex procedure that loads **every time** is the problem.

### Limit exceptions

Only **routing skills, where the reference files to read depend on the kind of work**, get an exception. The branch conditions and the routing table must be in the body to pick which reference to read, and that cannot be moved into a reference file.

**Having many rules is not grounds for an exception.** Move those into `references/`.

Grant an exception by naming the skill in `skill_word_limit()` in `scripts/check-skills.sh`. Editing the script is required, so exceptions do not grow quietly.

Current exception: `frontend-design` (2000 words).

## frontmatter

Use exactly two fields: `name` and `description`. Optionally `argument-hint`.

**The description is a trigger spec, not a workflow summary.** When a description summarizes the procedure, the model follows the description and never reads the body (observed and measured in superpowers).

Format: `<one sentence on what it does>. <list of when to use it>`

**Write descriptions in Korean.** Triggers must contain the Korean phrases the user actually says. One trigger per branch — do not pile up synonyms.

## Body

- English. Imperative and direct
- Every skill can be invoked by the model. Do not use `disable-model-invocation`
- Step 1 of an orchestrator skill is **scope assessment plus user confirmation**. A false trigger then costs one question
- Include one line stating the condition under which the skill bows out

## Match sentence form to the failure mode

- **Discipline failures** (doing what must not be done) → prohibitions. Attach no exception clause. The moment "do not X" gains "unless it matters," the negotiation reopens
- **Output-shape failures** (wrong format) → positive recipes. State what to do

Write prohibitions as `Do not` or `Never`. Do not soften them into `avoid`, `try not to`, or `should not`.

## Connecting skills

Do not use `@` imports. They force an immediate load and burn context.

Call skills by name: `delegate with the delegation skill`.

One-directional pipeline calls are allowed (`design` → `prd` → `trd` → `implement`). **Never create a cycle.**

Writing or reworking a skill goes through `skill-writer`, not `design`. It carries its own worthiness judgment and its own interview, so routing through `design` runs the interview twice.

When two skills share logic, extract it into a primitive skill and have each call that.

## Handing work to subagents

Do not paste conversation history. Pass a file path and receive a file back.

## Harness neutrality

Skills in this repo are **shared as the same files** by Claude Code (`~/.claude/skills`) and Codex (`~/.codex/skills`). Both read only `name` and `description` from frontmatter, so the format stays compatible.

Do not write harness-specific things in the body.

- Write **behavior** instead of tool names — `ask with AskUserQuestion` (X) → `ask as a set of options` (O)
- Write models as **tiers** — small and fast / standard / top-tier reasoning. Name specific models only as parenthetical examples
- Do not instruct harness-specific slash commands — phrase it as `use the <capability> the running agent provides`
- Do not put `Co-Authored-By` signatures or AI-generated markers in commits or PRs

Do not scatter branching phrases (`in Claude Code do X, in Codex do Y`) through the body. Describing behavior removes the need to branch and cuts length.

When a harness-specific path or tool name must be written down, move it into `references/`. Even superpowers names a harness in the body of only 3 of its 14 skills and splits the rest into files like `references/codex-tools.md`.

## Global instructions

`global-instructions.md` is the original; `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` symlink to it. **Always edit the original.**

Do not name a specific agent in the body — `Claude does not merge on your behalf` (X) → `the agent does not merge on your behalf` (O).

For this rules document, `AGENTS.md` is the original and `CLAUDE.md` links to it. This matches the direction the `init` skill applies to projects — whichever agent does the work reads the same rules.

## Language

Write skill bodies, reference files, `global-instructions.md`, this document, and everything under `docs/` in English.

Keep these in Korean:

- **`description` in frontmatter.** It is the trigger and must match what the user says
- **`README.md`**, and PR bodies and commit messages. People read these
- **Korean examples embedded in the body.** Korean marketing-copy tells, commit message examples, trigger phrases. These are rules about Korean output, so English examples would break them

## After editing a skill

`scripts/check-skills.sh` — checks the machine-verifiable parts of these rules: frontmatter fields, body word count, `@` imports, reference file existence, README listing. Fix any FAIL.

`scripts/link.sh` — creates a symlink in each installed harness's skill directory. Run it again after adding or renaming a skill. It leaves non-symlink entries alone and clears this repo's links whose source is gone.

**When the edit touched a `description`, test that the skill still fires.** A description is the only thing that decides whether a skill loads, and no script can check it. The `skill-writer` skill holds the procedure.

After adding a skill, add it to the skill table in the README.
