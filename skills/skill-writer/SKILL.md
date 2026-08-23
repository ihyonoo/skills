---
name: skill-writer
description: 스킬을 새로 만들고, 기존 스킬을 고치고 나누고 지운다. "스킬 만들어줘" "스킬로 만들자" "이 스킬 고쳐줘"라고 할 때, SKILL.md의 본문이나 description을 손볼 때, 본문이 길어 references로 뺄 때 사용한다. 스킬 작업은 design 대신 이걸 쓴다.
---

The authoring rules live in the root `AGENTS.md`. Read it before writing anything. It holds the rules; this skill holds the procedure. **Never restate a rule from it here.** Point at it.

**Bow out** when the working directory has no `skills/` beside `scripts/check-skills.sh`. This is the skills repo only. Say so in one line and stop.

## 1. Judge whether it deserves a skill

Read `references/when-to-make-a-skill.md` and reach a verdict before anything else. For an edit, split, or delete of a skill that already exists, read `references/restructure.md` for that branch's judgment instead of this section's, then return here and keep going from step 2. The verdict is still stated and confirmed before anything is written.

State the verdict and its grounds, and confirm as a set of options.

**On rejection, the run ends.** Name the alternative — a clause inside an existing skill, one line in the global instructions, a project instruction file — and stop there. Do not carry it out. Each alternative lands in a file with another owner, and a "no" must not quietly edit three of them. If the user takes the recommendation, it comes back as a new request.

## 2. Settle what the skill does

Three things must be stated before a draft exists:

- the trigger phrases a user actually says, in Korean
- the steps of the body
- the condition the skill bows out under

When the user has not stated any one of them, run the deep-interview skill until they have. Never invent a trigger phrase on their behalf — an invented phrase is what the trigger test fails on. When all three are already stated, skip this step.

## 3. Write it

Four rules fail most often even though `AGENTS.md` is loaded every session. Loading them was never the problem; checking is. Open each section, hold the draft against it, and say which ones you checked:

- description as a trigger spec — `AGENTS.md` §frontmatter
- body word count — §Structure
- prohibition form — §Match sentence form to the failure mode
- harness neutrality — §Harness neutrality

## 4. Verify, in this order

The order is load-bearing. A subagent resolves skills from the installed skill directory, so a new skill does not exist for the trigger test until the symlink is installed.

1. `scripts/check-skills.sh` — fix every FAIL before continuing
2. **Body review** — hand the draft to a subagent using `references/body-review-prompt.md`. Follow the spec-review skill's discipline: pass the file path and nothing about how it was written, take findings in three grades, and answer every one with accept, rebut, or defer. Do not use spec-review's own two prompts
3. **Install** — run `scripts/link.sh` with no arguments. `--check` only verifies, and the symlink is what the next step needs
4. **Trigger test** — `references/trigger-test.md`. Three intended phrases must all fire the skill and two adjacent phrases must all fire something else. 3/3 and 0/2, no partial credit

Delegate the body review and the trigger test with the delegation skill.

Scale the verification to what changed:

| Changed | Runs |
|---|---|
| description, or a new skill | all four |
| body only | check, review, install |
| a reference file only | check |

## 5. Finish

- Add the skill to the README skill table, and update the `흐름` section when the new skill calls or is called by another
- When the rules themselves need to change, or a word-limit exception is warranted, **propose it and stop.** Never edit `AGENTS.md` or `scripts/check-skills.sh` from this skill
- Leave the branch, the commit, and the PR to the user

## Never do this

- Never write the draft before the worthiness verdict is confirmed
- Never ship a skill whose trigger test has not passed
- Never pass the authoring context to the trigger-test subagent. It gets the phrase and nothing else
- Never review your own draft
