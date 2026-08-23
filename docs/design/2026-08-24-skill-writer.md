# skill-writer — a skill for authoring skills

Date: 2026-08-24
Scope: M (per the `design` skill's S/M/L sizing)
Revision: 2 — after spec-review (6 blocking findings resolved). Implemented 2026-08-24; two assumptions verified, see below.

## Problem

This repo already carries the authoring rules in `AGENTS.md`, but nothing enforces them as a *procedure*. Three failures follow.

**Weak skills accumulate.** Every "make this a skill" request currently becomes a skill. Nobody asks whether the thing is instead one line of global instruction, a clause inside an existing skill, or a project instruction. Skills that should not exist compete for triggers with the ones that should.

**Rules that are read are not rules that are applied.** `AGENTS.md` is loaded every session in this repo, yet a freshly written skill still routinely ships with a description that summarizes the workflow (so the body never loads), a body over the word limit, softened prohibitions, or harness-specific tool names. `check-skills.sh` catches the mechanical subset — field names, word count, `@` imports, missing references, README listing. It cannot catch the ones that matter most.

**Nothing verifies a skill fires.** A skill that never triggers is dead code that still costs description tokens on every turn. Today no step tests that.

## Decisions

**D1 — Name and home.** `skills/skill-writer/`. Scoped to this repo only; it may assume `skills/<name>/`, `scripts/check-skills.sh`, `scripts/link.sh`, and the README skill table exist.

**Bow-out.** When the working directory is not this repo — no `skills/` directory with `scripts/check-skills.sh` beside it — say so in one line and stop. Authoring a skill for another project's `.claude/skills/` is out of scope.

**D2 — Scope covers the whole lifecycle.** Creating a new skill, editing an existing one, splitting an overweight one into `references/`, and deleting one. These share the same judgment criteria and the same verification, so one skill holds them.

Deletion always requires explicit confirmation naming the skill. It is the only destructive branch, and `check-skills.sh` has no reverse check that would catch a stale README row afterward — so the cleanup steps are written out in `references/restructure.md`.

**D3 — Step 1 is the skill-worthiness judgment, and rejection ends the run.** Decide whether the request deserves a skill at all. On rejection, state the grounds and name the alternative — absorb into an existing skill, one line in the global instructions, a project instruction file — and **stop there**. The skill does not carry the alternative out.

Rationale: each alternative lands in a file with its own owner. `global-instructions.md` is shared by every project, and a project instruction file belongs to `init`. Writing to them from a rejection branch would make a "no" quietly mutate three files. If the user takes the recommendation, that arrives as a new request.

**D4 — `AGENTS.md` stays the single source of the authoring rules.** The body carries the procedure and points at the root `AGENTS.md` for the rules.

The body does **not** restate the rules, with one exception: the four rules that ambient loading demonstrably fails to enforce become explicit checkpoints in the procedure, phrased as checks rather than as rules — description is a trigger spec and not a workflow summary, body under the word limit, prohibitions written as `Do not`/`Never`, no harness-specific tool names. Checking is what the ambient copy could not do; restating would be the duplication D4 forbids.

**D5 — One procedure plus three reference files.** Body under the 1000-word limit, no exception registered in `skill_word_limit()`.

| File | Holds |
|---|---|
| `references/when-to-make-a-skill.md` | Skill-worthiness criteria, rejection alternatives |
| `references/trigger-test.md` | Fire / misfire scenarios, subagent prompt template, pass criteria |
| `references/restructure.md` | Edit, split, delete procedures and their cleanup |

**D6 — Verification is ordered, and it scales with the change.**

1. `scripts/check-skills.sh` — mechanical rules. Fix every FAIL before continuing
2. Body review — a subagent reads the draft against the authoring rules. Runs through `spec-review`'s discipline (document path only, no authoring context, three grades, accept/rebut/defer on every finding) with a prompt written for a skill body, kept in `references/`. `spec-review`'s own two prompts target design docs and would return noise on success criteria and ungrounded figures
3. `scripts/link.sh` — installs the symlink. A subagent resolves skills from `~/.claude/skills`, so a new skill is invisible until this runs. Verification-only mode is `link.sh --check`; installation needs the plain call
4. Trigger test — see D7

Scaling: a body edit that leaves the description alone skips step 4. A description edit runs all four. A `references/` edit that touches neither runs step 1 only.

**D7 — Trigger test pass criteria.** Three intended-trigger phrases must all fire the skill; two adjacent phrases — triggers belonging to the nearest existing skills — must all fire something else. 3/3 and 0/2, no partial credit. On failure, revise the description and re-run; after two failed runs, stop and bring it to the user.

The subagent is given the phrase only, never the authoring context, and is asked to report which skill it invoked before doing anything else.

**D8 — Called skills and where.** 

| Skill | When | Mandatory? |
|---|---|---|
| `deep-interview` | After D3 approves, when the purpose is thin enough that the trigger phrases and the body's steps cannot be stated | Conditional |
| `delegation` | Before spawning the body review and the trigger test | Mandatory |

`spec-review` is not called as a skill — its discipline is followed with a substituted prompt (D6.2). `branch-flow` is not called: committing and opening a PR stay the user's decision. `init` is not called, since D3 no longer executes the project-instruction alternative.

**D9 — `skill-writer` supersedes `design` for skill work.** The global instructions route anything beyond a small edit through `design` first. Skill work is exempt: `skill-writer` carries its own worthiness judgment and its own conditional interview, so routing through `design` would run an interview twice. One line in `AGENTS.md` records the exemption, alongside the line D10 adds.

**D10 — `AGENTS.md` gains one line, and the skill never edits it.** The `## After editing a skill` section currently prescribes `check-skills.sh` and `link.sh`; a line is added there stating that a touched trigger requires a fire test. Detail stays in the skill. Without this, a hand edit made without the skill gets the weaker procedure.

`skill-writer` itself does not edit `AGENTS.md` or `scripts/check-skills.sh`. Changing the rules, or granting a word-limit exception, is a human decision — the skill proposes and stops.

## Done when

A run of `skill-writer` is complete when all of these hold:

- The worthiness judgment was stated and either approved or the run ended at rejection
- `check-skills.sh` reports no FAIL
- The body review's blocking findings are all resolved or rebutted in writing
- The trigger test scored 3/3 fire and 0/2 misfire, or the description edit was out of scope for this run
- README's skill table and the `흐름` section reflect the change

## Rejected alternatives

- **Copying the authoring rules into the skill body.** Self-contained, but yields two versions of the same rules. Rejected under D4.
- **Moving the rules out of `AGENTS.md` into `references/`.** Would lighten the always-loaded instruction file, but the rules also govern hand edits made without the skill, and the restructuring cost outweighs the token saving.
- **A routing skill with a 2000-word exception.** The four lifecycle branches share most of their procedure, so a routing table buys little. `frontend-design` stays the only exception. *Revisit if the branch-specific steps stop fitting in `references/` — i.e. if the body needs a per-branch table to pick between them.*
- **Splitting authoring and restructuring into two skills.** Would duplicate the rules pointer and the verification procedure on both sides.
- **Trigger-only testing.** Cheaper, but misses the failure that matters here — a new description stealing an existing skill's triggers.
- **`design` routing into `skill-writer`.** Consistent with the existing pipeline, but adds a step and an edit to `design` for no gain. Rejected under D9.
- **Carrying out the rejection alternative in place.** Considered and reversed during review: it made a "no" write to files owned by `global-instructions.md` and `init`. Rejected under D3.

## Non-goals

- Authoring skills for other repositories or a project's own `.claude/skills/`
- Verifying that a skill fires under Codex
- Editing `global-instructions.md`, project instruction files, `AGENTS.md`, or `scripts/check-skills.sh`
- Running the git flow — branch, commit, PR stay with the user
- Going through the `implement` skill for this memo, so no `docs/progress/` file is produced

## Assumptions

- **The trigger test runs on Claude Code subagents only.** If Codex resolves triggers differently, a skill that fires here and not there ships unnoticed. Mitigation is the existing harness-neutrality rule, not a test.
- ~~**A subagent picks up a skill symlinked mid-session.**~~ **Verified during implementation.** A subagent asked to list its skills named `skill-writer` in the same session that created it, and the revised description took effect on a re-run without a restart.
- ~~**The subagent's report names the skill it invoked.**~~ **Verified during implementation.** Ten runs each returned a bare skill name or `none`.
- **A subagent given only the trigger phrase approximates a cold session.** Context leaking from the parent would produce a false fire. Controlled by passing the phrase and nothing else — no file path, no authoring context — and by the 0/2 misfire half, which a leaked context would tend to break.

## Blast radius

| Path | Change |
|---|---|
| `skills/skill-writer/SKILL.md` | new |
| `skills/skill-writer/references/*.md` | new, 3 files (+ the body-review prompt) |
| `AGENTS.md` | two lines — the `design` exemption (D9), the fire-test rule (D10) |
| `README.md` | new `메타` row group in the skill tables; the `흐름` section's caller list |
| `docs/design/2026-08-24-skill-writer.md` | this memo |
| `~/.claude/skills/skill-writer`, `~/.codex/skills/skill-writer` | symlinks created by running `link.sh` |

`scripts/check-skills.sh` is untouched — no word-limit exception is requested.
