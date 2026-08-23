<!--
Original of the global agent instructions.
~/.claude/CLAUDE.md and ~/.codex/AGENTS.md symlink to this file.
Always edit this file. Use scripts/link.sh to recreate and verify the links.
-->

## Git

- Never commit on your own. Draft a commit message and propose it. Run the commit only when the user explicitly says so.
- Always get confirmation before anything that changes repository structure: creating or switching worktrees, creating, switching, or deleting branches.
- Do not do development work directly on the default branch (main/master). Follow the `branch-flow` skill for branch, commit, and PR procedure, naming, and PR body format.
- The user merges PRs on GitHub. The agent does not merge on their behalf.
- Do not put `Co-Authored-By` signatures or AI-generated markers in commit messages or PR bodies.

## Design

- For anything beyond a bug fix or a small edit within one file, settle the design with the `design` skill before implementing.
- Do not start implementing on guesses while requirements are still thin.

## Delegating to subagents

- Follow the `delegation` skill to decide whether to delegate heavy work such as exploration, review, and verification, whether to run it in parallel, and which model tier to use.
- The main agent synthesizes delegated results and concentrates on decisions, keeping its context clean.

## Writing documents

- Write in English: design documents, PRDs, TRDs, progress records, review records, and everything else under `docs/`.
- Write in Korean: `README.md`, PR bodies, and commit messages. People read these.

## Keeping instruction files in sync

A project's instruction file is either `CLAUDE.md` or `AGENTS.md`. Below, "instruction file" means whichever one that project uses.

- After a structural change (adding or removing a module or directory, changing architecture or conventions, changing config keys), check whether the instruction file for that scope (root or the relevant subdirectory) is still accurate, and fix it if it is stale.
- When instruction files are split per directory, a change inside a directory makes that subdirectory's file the first review target, not the root.
- When an approach failed, or the user pointed out a repeated mistake, propose adding one line to that project's instruction file recording the cause and the lesson. If such a section already exists, add to it. If not, ask first whether to create one.
- A project instruction file keeps `AGENTS.md` as the original with `CLAUDE.md` symlinked to it. Follow the `init` skill when creating or reorganizing them.
- The global instructions (this file) live in `~/dev/claude-skills/global-instructions.md`. Each harness's global instruction file only links to it. Edit the original, and do not name a specific agent in the body.

## Tests

- Write the test first for new features, bug fixes, and refactoring. Follow the `tdd` skill for the procedure and for deciding when an integration test is warranted.
- When you conclude a test should be skipped, always confirm with the user first.

## Comment style in code and config files

- Keep code comments terse. Do not write them as narrative paragraphs.
- When several facts must be conveyed, write several one-line comments in a row (a list, not a paragraph).
- This applies to inline comments in code and config files only, not to prose documents like READMEs and design documents.

## Coding principles

- **Confirm first**: state your assumptions before implementing. When something is uncertain or admits several readings, do not guess — present all of them and ask. When a simpler alternative exists, say so even if it contradicts the request.
- **Simplicity first**: write the minimum code that solves the request. Do not add capability beyond what was asked, single-use abstractions, flexibility or configurability nobody requested, or error handling for scenarios that cannot occur.
- **Precise edits**: do not touch code, comments, or formatting unrelated to the request. Do not delete unrelated dead code — mention it instead. Do remove imports, variables, and functions that this change itself made unused.
