# Is this worth a skill?

A skill costs its description on every turn of every session, forever, whether or not it fires. The body is free until it loads; the description is not. That is the whole price, and it is what the verdict weighs against.

## Five questions

A skill needs a yes to all five. One no is a rejection.

1. **Does it repeat?** Something done once is a request, not a skill. If you cannot name a second occasion it will fire, there is none.
2. **Is it a procedure?** A skill encodes *steps in an order*. A single fact — a rule, a preference, a path — is a line of instruction, not a skill.
3. **Does the model get it wrong by default?** Write down what happens with no skill at all. If that is already what you want, the skill buys nothing. Skills exist to override a default, not to describe it.
4. **Are its triggers distinguishable?** Say the phrases out loud against the descriptions of the skills already installed. If an existing skill would reasonably fire on them, this one steals its triggers instead of adding coverage.
5. **Is it too big for one clause?** If the whole thing fits as a section inside a skill that already exists, that is where it goes. A new skill is warranted when the addition would blur what the host skill is for.

## What a rejection turns into

Say which one, and why it fits better. Then stop — this skill does not carry it out.

| The request is really | Goes to | Tell the user |
|---|---|---|
| One rule, always in effect | The global instructions | Which section, and the exact line to add |
| A step missing from a procedure that exists | A clause in that skill | Which skill, which section, what the clause says |
| A fact true of one project only | That project's instruction file, through the init skill | Which project, and that init owns the edit |
| A one-off | Nothing | Do it now instead of encoding it |

## Signals that the verdict is no

- The request describes a *topic* rather than an occasion — "a skill for databases", "a skill for testing". A skill fires on a moment, not a subject
- The trigger phrase is a synonym pile. Needing five ways to say the same thing usually means the boundary is not real
- It exists to make the model "be careful about X". Carefulness is not a procedure
- The body would be a list of facts with no order between them. That is reference material — put it in an existing skill's `references/`

## When the verdict is yes but the shape is wrong

Two skills sharing most of their steps is one skill with a branch, or two skills calling a shared primitive. Never copy the shared part into both — the copies drift, and the repo has no check that catches it.

A skill that would need a routing table in the body to pick between branches is a routing skill; that is the only case that earns a word-limit exception, and granting one requires a human edit to `scripts/check-skills.sh`.
