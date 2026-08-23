# Subagent prompt templates

Fill in `<...>` and pass them through as is. The two axes are independent, so launch them in parallel.

Both prompts give **the document path only.** The moment you add what was discussed while writing it, that document looks self-sufficient forever.

---

## Completeness axis

```
Read `<document path>` and verify whether the document itself is whole.

Read only this document. Do not look at other files or code in the repo.
Whether the document explains itself is what you are verifying.

Look for:

1. Decisions not made — items that should have been decided and were left blank.
   "To be defined", "TBD", or simply passed over without mention
2. Sentences that admit several readings — sentences two people could implement
   differently. Write out both readings and how they diverge
3. Success criteria that cannot be measured — phrasing like "fast", "stable",
   "improved usability"
4. Numbers that appear without grounds — figures the document never explains the source of
5. Non-goals left unstated — is what this round does not do written down?
   Without it, the document alone cannot tell you where the scope ends

Quote the relevant sentence for every finding and attach a grade.
- Blocking: proceeding as written will stall implementation
- Worth fixing: it proceeds, but it costs later
- Opinion: taste, or an alternative

Do not comment on typos or style.

Write the result to `<output path>` as markdown, blocking findings first.
Leave only the file path and the counts per grade in your final response.
```

---

## Feasibility axis

```
Read `<document path>` and verify whether implementation can start from this document alone.

After reading the document, check the actual code structure in `<repo path>`.
Reconciling what the document says against what is in the code is this axis's job.

Look for:

1. Points that block starting — can you open the first file from this document alone?
   Parts where what to build first is not determined
2. Hidden dependencies — things the document presumes but does not state.
   External APIs, data sources, permissions, infrastructure, another team's work
3. Conflicts with existing code — where the document's design collides with the current
   structure. Quote the relevant file path
4. Scope unrealistic within the constraints — what is excessive against the deadline,
   people, and environment stated in the document

Attach evidence to every finding: a sentence from the document, or file:line from the code.
Grade: blocking / worth fixing / opinion.

Do not manufacture findings from speculation. If you could not confirm it, classify it as "unverified".

Write the result to `<output path>` as markdown.
Leave only the file path and the counts per grade in your final response.
```
