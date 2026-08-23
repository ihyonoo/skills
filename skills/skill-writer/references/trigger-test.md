# Trigger test

A skill that never fires is dead code that still bills its description on every turn. `check-skills.sh` cannot detect it. This is the step that can.

The test runs **after** `scripts/link.sh` has installed the symlink. A subagent resolves skills from the installed skill directory, not from this repo, so before that the skill does not exist as far as the test is concerned.

## Build five scenarios

**Three fire phrases.** Sentences a user would actually type to reach this skill, in Korean, phrased differently from each other. Take them from the description's trigger clause — that is what the clause is for. If you cannot write three that differ, the trigger boundary is too narrow to be worth a skill.

**Two misfire phrases.** Triggers belonging to the *nearest* existing skills — the ones whose descriptions came closest when you checked question 4 of the worthiness judgment. Not nonsense, and not phrases unrelated to the repo: the failure being hunted is a new description stealing a neighbor's triggers, and only a real neighbor's phrase can expose it.

List the five with their expected outcome before running anything. Writing the expectation after seeing the result is not a test.

## The prompt

One subagent per phrase, launched together. Small and fast tier is enough — the subagent is being measured, not consulted.

```
<phrase>

Before doing anything else, answer this: which skill, if any, does this request
call for? Answer with the skill name alone, or "none". Then stop. Do not perform
the request, do not read any file, do not explain your reasoning.
```

**The phrase and nothing else.** No file path, no mention of a new skill, no summary of what was just written. Any of them leaks the answer and turns a fire into a false pass.

## Pass criteria

**3/3 fire and 0/2 misfire.** No partial credit.

- A fire phrase answering "none", or naming a different skill, is a fail
- A misfire phrase naming the new skill is a fail — it is stealing a neighbor's trigger
- A misfire phrase naming a third skill is fine. This test does not adjudicate between two existing skills

## On failure

The description is what fires a skill, so the description is what changes. The body is not involved.

| Symptom | Fix |
|---|---|
| A fire phrase missed | The trigger clause lacks the words the user actually says. Add that phrasing — one trigger per branch, not a pile of synonyms |
| A misfire phrase captured | The trigger clause is too broad, or it overlaps a neighbor's. Narrow it, or state the boundary the neighbor's description already implies |
| Everything answers "none" | The description does not read as a trigger spec. Check it against that rule before touching anything else |

Revise and re-run the whole set of five. **After two failed runs, stop and bring it to the user** — a third revision is guessing, and the boundary itself is probably wrong.

## If the subagent cannot see the skill

The assumption that a symlink created mid-session is visible to a subagent holds or it does not; find out on the first run. If every phrase — fire and misfire alike — answers "none" or names only pre-existing skills, and the symlink is confirmed present, the harness is enumerating skills at startup. Say so, and run the test in a fresh session rather than declaring a pass.
