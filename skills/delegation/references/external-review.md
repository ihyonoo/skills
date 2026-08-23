# External review

A reviewer from a different vendor does not share the running agent's blind spots. Offer it as one of the model options in step 3. It replaces the in-harness reviewer for that run; it is not an extra pass stacked on top.

## Check availability first

Offer the option only when the CLI is installed **and** the login check exits zero. If either fails, drop the option without a word. Do not tell the user to install or log in in the middle of a review.

| Running agent | External CLI | Installed | Logged in |
|---|---|---|---|
| Claude Code | `codex` | `command -v codex` | `codex login status` |
| Codex | `claude` | `command -v claude` | `claude auth status` |

Judge login by exit status. Do not judge it by whether a credentials file exists — both CLIs support environment tokens, keychain storage, and a relocated config home, so a present file proves nothing and an absent one disproves nothing.

## Ask the vendor, then the model

`codex` and `claude` name vendors, not models. Once the user picks the external agent, ask a second question for the model, and pass the answer through `-m` (codex) or `--model` (claude).

**Never skip that question because the user said to go ahead.** "Run the review" approves the review, not a model. Taking the CLI default silently hides which model produced the findings, which is the whole reason the question exists.

Neither CLI can list its models without a terminal. **Never present a hardcoded model list as if it were authoritative** — it goes stale on every release. Offer the CLI default as one option, let the user name a specific model, and pass no model flag when they take the default.

Report the model together with the findings. When the user took the default, report the literal words "CLI default" — neither the discarded stdout nor the output file names the resolved model, so any specific name written there would be a guess.

## One call, not two axes

`code-review` and `spec-review` each split into two axes and run them in parallel. **That split does not carry over.** When the external agent is the chosen model, run one call over the whole change, with both axes in the one prompt.

The parallel split widens coverage inside a single vendor. The external run buys something else — one independent read of the whole change — and splitting it doubles a path that already takes minutes.

## Forbid delegation inside the prompt

On the codex path the external agent reads its own global instructions — the same file the running agent reads — and left alone it applies the delegation rules to itself and stops to ask which model should review. The claude path escapes this through `--safe-mode`, which drops instruction files. Open every prompt with the ban anyway; one prompt text that holds for either vendor beats two:

```
Perform this review yourself, in this session. Do not delegate it, do not ask which
model should run it, and do not ask any clarifying question. Produce the findings directly.
```

## Call shape

Write the prompt to a file and feed it on stdin. Never interpolate prompt text into the command line — it carries paths, quotes, and code, and the shell expands `$`, backticks, and quotes before the CLI ever starts.

```bash
# codex — default model, then explicit model
codex exec --sandbox read-only - -o "$OUT" < "$PROMPT" >/dev/null 2>&1
codex exec --sandbox read-only -m "$MODEL" - -o "$OUT" < "$PROMPT" >/dev/null 2>&1

# claude — default model, then explicit model
claude -p --safe-mode --permission-mode plan < "$PROMPT" > "$OUT" 2>/dev/null
claude -p --safe-mode --permission-mode plan --model "$MODEL" < "$PROMPT" > "$OUT" 2>/dev/null
```

`--sandbox` belongs to `exec` and must come before any subcommand. `codex exec review --sandbox` is a parse error.

`--safe-mode` disables hooks, skills, and instruction files, which would otherwise write outside the permission gate. Do not substitute `--bare`: it forces `ANTHROPIC_API_KEY` and breaks an OAuth login. Codex ships no equivalent flag, which is why the delegation ban above has to live in the prompt text instead.

Name the target inside the prompt — the diff range for code, the file path for a document. Pass the standards the consumer skill tells you to pass, and nothing beyond them.

Point the output at a fresh file in a scratch directory, never at a path inside the reviewed tree. The sandbox governs the agent's own tool use — it does not govern the shell's `>` redirection or codex's `-o` writer, both of which run with your privileges. An output path aimed into the repository overwrites whatever sits there, guard or no guard.

This is the only shape. Codex also ships a built-in `review` subcommand, and its prompt can carry file paths — but not alongside a scope selector: `codex exec review --uncommitted "focus"` exits 2 with `error: the argument '--uncommitted' cannot be used with '[PROMPT]'`. Its usage string lists both, so confirm by running it, not by reading the help. Stripped of the scope selectors it offers nothing this shape lacks, and it needs its own sandbox handling, so do not use it.

## Never do this

- Never run without the read-only guard — `--sandbox read-only` for codex, `--safe-mode --permission-mode plan` for claude. Both CLIs write files by default, and claude's hooks write outside the permission gate unless customizations are off. A reviewer that edits the code is not a reviewer
- Never point the output path inside the reviewed tree. That write goes around the read-only guard, not through it
- Never read stdout from `codex exec`. It carries every tool call the external agent makes plus platform noise, and it stays in context for the rest of the session. Discard it and read the output file
- Never paste the output file into the conversation whole. Extract the findings, drop the rest
- Never fall back to the in-harness reviewer when the external run fails. Report the failure and ask

## Cost

A single-file review took about a minute; two files against the repo rules ran under two; four files with a command-verification mandate ran six. Usage counts against the external vendor's limit, not the running agent's. State both in the option description.
