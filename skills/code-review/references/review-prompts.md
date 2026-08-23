# Subagent prompt templates

Fill in `<...>` and pass them through as is. The two axes are independent, so launch them in parallel.

Neither prompt carries **the author's intent.** Give only the diff and the paths to the standards.

---

## Correctness axis

```
Review the `<base>...<head>` change in `<repo path>`. Look only for defects.

Start by checking the change:
  git -C <repo path> diff <base>...<head>

Work through the following in order. Write "not applicable" and move on when an item does not apply.

1. Boundary conditions — empty input, zero, maximum, a single element, duplicates
2. Error paths — resource cleanup on failure, leftover partial state, missing rollback
3. Trust boundaries — points where external input flows inward unvalidated
4. Order and concurrency — places that break when run twice or reordered
5. Conditional side effects — writes, deletes, or sends that happen only in a specific branch

Every finding must include:
- File path and line number
- The concrete input or state that actually triggers the defect
- Grade: blocking / worth fixing / opinion

Evidence rules:
- "Looks fine" is not a result. If you judged it safe, quote the line that makes it safe
- Do not wave things through with "it is probably handled" or "there is probably a test". Confirm it, or write "unverified"
- Do not invent defects from speculation. If you cannot write the path that reproduces it, drop the item

Do not comment on formatting, naming, or taste.

Write the result to `<output path>` as markdown, sorted by grade, most severe first.
Leave only the file path and the counts per grade in your final response.
```

---

## Consistency axis

```
Verify that the `<base>...<head>` change in `<repo path>` matches the settled documents and the repo rules.

Read:
- The change: git -C <repo path> diff <base>...<head>
- Requirements document: <document path>
- Instruction file: <repo path>/AGENTS.md (or CLAUDE.md)
- Global instructions: <global instructions path>

Verify:

1. Requirement coverage — walk each requirement ID in the document and confirm
   corresponding code exists. Record any ID with no correspondence
2. Scope creep — features, settings, or abstractions that arrived without being in the document
3. Rule violations — points that conflict with the instruction file or the global
   instructions. Quote which rule and which sentence
4. Newly unused — imports, variables, and functions this change cut the references to.
   Exclude anything already unused before the change

Attach a file path, a line number, and evidence (the relevant sentence from the document
or the rules) to every finding. If you cannot quote the evidence, drop the item.

Do not look for code defects. Another reviewer handles those.

Write the result to `<output path>` as markdown.
Put the list of uncovered requirement IDs at the top.
Leave only the file path and the count of uncovered IDs in your final response.
```
