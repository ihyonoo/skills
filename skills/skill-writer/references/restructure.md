# Editing, splitting, and deleting a skill

The worthiness judgment in `references/when-to-make-a-skill.md` asks whether a skill should exist. These three ask something narrower, and each has its own question.

## Edit

**The question: does this change the trigger, or the procedure?**

A procedure change touches the body and runs verification steps 1–3. A trigger change touches the description and runs all four — the description is the only thing that decides whether the skill fires, so any edit to it puts firing back in doubt.

- Preserve what is there. An edit is not a rewrite, and rules a person wrote by hand stay unless they are now wrong
- When a rule looks obsolete, list it and get approval. Do not delete quietly
- Adding to a skill that is near the word limit means moving something out first. Do not let the body cross the limit and plan to fix it after

## Split

**The question: is the body over the limit, or is the skill doing two jobs?**

Over the limit is a packaging problem. Two jobs is a design problem, and splitting the file does not solve it.

Packaging — the body carries content that loads every time and is needed only sometimes:

1. Move examples, templates, checklists, and long tables into `references/<topic>.md`. Keep principles and judgment criteria in the body — the reader needs those to decide *which* reference to open
2. Reference each new file from the body by path. A file nothing references is dead weight, and `check-skills.sh` warns about it
3. Do not split by size alone. One reference per decision the reader makes, not one per 300 words

Two jobs — the skill fires on two unrelated occasions:

1. Extract the shared logic into a primitive skill and have both call it by name. Never copy it into both
2. Both halves need their own trigger phrases and their own trigger test. A split that leaves one half unreachable has removed a skill rather than divided one
3. One-directional calls only. Never create a cycle

A routing table in the body — branch conditions that pick which reference to read — is the one shape that earns a word-limit exception, and the exception requires a human edit to `scripts/check-skills.sh`. Propose it and stop.

## Delete

**The question: is anything still pointing at it?**

Deletion is the only destructive branch here. **Confirm with the user, naming the skill, before removing anything.**

Nothing in the repo catches the leftovers. `check-skills.sh` walks `skills/*/` and warns when a skill is missing from the README; it has no reverse check, so a README row for a skill that no longer exists is never flagged. Work the list by hand:

1. `grep -rn '<name>' skills/ README.md AGENTS.md global-instructions.md docs/` — every other skill that calls it by name, every README table row, the `흐름` section, any mention in the rules
2. Fix each caller first. A skill calling a name that no longer resolves fails silently at the moment it is needed
3. Remove `skills/<name>/`
4. Run `scripts/link.sh`. It prunes this repo's dead symlinks — but it skips a harness whose parent directory is absent, so a harness not installed on this machine keeps its stale link until the script runs there
5. Run `scripts/check-skills.sh`. It will not catch a stale README row; confirm that by eye against step 1's grep

There is no trigger test for a deletion. The check is the grep, and it is done by hand.
