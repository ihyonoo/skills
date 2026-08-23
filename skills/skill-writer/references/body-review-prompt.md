# Body review prompt

Fill in `<...>` and pass it through as is. One subagent, standard tier or above.

Give the reviewer **the file path only.** Nothing about how the draft came to be, what was discussed, or what it is meant to fix. Whether the skill stands on its own is the thing being measured.

The spec-review skill's own two prompts do not fit here. They ask for success criteria, ungrounded figures, and non-goals — a skill body has none of those, and the reviewer will manufacture findings to fill the shape.

---

```
Read `<path to the draft SKILL.md>` and review it against the authoring rules in
`<repo root>/AGENTS.md`. Read both files. Do not read anything else in the repo,
except the `description` line of the other skills under `<repo root>/skills/*/SKILL.md`
when you check for trigger collisions.

Review on these axes:

1. Description as trigger spec. Does it summarize the workflow instead of naming
   occasions? A description that explains the procedure gets followed in place of
   the body, and the body never loads. Does its trigger clause collide with the
   description of an existing skill?
2. Load cost. What in the body loads every time this skill fires but is needed only
   sometimes? Name what belongs in `references/` instead. What in `references/` is
   load-bearing enough that the skill misbehaves without it?
3. Sentence form. Prohibitions must read `Do not` or `Never`, with no exception
   clause attached. Flag every "avoid", "try not to", "should not", and every
   prohibition softened by "unless". Flag format requirements written as
   prohibitions where a positive recipe would work better.
4. Actionability. Which instructions require interpretation before they can be
   followed? Quote the sentence and give the two readings that diverge.
5. Harness neutrality. Tool names, slash commands, specific model names, or
   "in <agent> do X" branches in the body. These belong in `references/`, or should
   be rewritten as behavior and model tiers.
6. Duplication. Does the body restate a rule that AGENTS.md already carries?
   The body is the procedure; the rules stay in one place.

Quote the relevant sentence for every finding and attach a grade.
- Blocking: shipping as written means the skill misfires, fails to load, or
  cannot be followed
- Worth fixing: it works, but it costs later
- Opinion: taste, or an alternative

Do not comment on typos or prose style. Do not suggest additional content the
skill does not need.

Write the result to `<output path>` as markdown, blocking findings first.
Leave only the file path and the counts per grade in your final response.
```
