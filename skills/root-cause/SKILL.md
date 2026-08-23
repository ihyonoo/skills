---
name: root-cause
description: 버그의 근본 원인을 찾아낸 뒤 고친다. 에러·크래시·오동작을 보고받았을 때, "왜 이런지 모르겠다" "고쳤는데 또 그런다" "이상하게 동작한다"고 할 때 사용한다.
---

**Do not fix a bug you have not reproduced.** A fix made without reproduction cannot be verified, and usually just hides the symptom.

## 1. Pin down the symptom

Write only facts. Keep guesses out.

- Expected behavior and actual behavior
- The exact error message in full. Do not summarize it
- Conditions — always, specific input, or specific environment
- Since when. Whether it lines up with a recent change

## 2. Build a minimal reproduction

Find the smallest case that triggers the bug. Shrink the input, drop steps, remove dependencies.

**This is where most causes surface.** The point at which the bug disappears while shrinking is the location of the cause.

If it does not reproduce, report that. Do not pretend to fix something that does not reproduce.

## 3. Form at least three hypotheses

Form only one and you will believe it is right.

For each hypothesis, write **how to disprove it**. Not "how to check if it is right" — how to show it is wrong.

## 4. Test the cheap ones first

One log line, then printing a value, then flipping a condition. Changing code to check comes last.

If every hypothesis is wrong, go back to step 2 and shrink the reproduction further. Do not improvise new hypotheses.

## 5. Ask why three times

Once you find the direct cause of the symptom, do not stop there.

> Crashed on a null reference → why? The value was missing → why? It was called before initialization → why? The lifecycle assumption differed from the documentation

The third answer is where the fix goes. Fix only the first answer and the same bug returns somewhere else.

## 6. Fix it and prove it

**Before fixing, freeze the minimal reproduction as a failing test.** You already built the reproduction in step 2, so this is just transcribing it. This is the RED of the tdd skill.

- Confirm the test fails, then fix
- Once it passes, it stays as the regression test
- Check other places that could stem from the same cause

## Never do this

- Fixing several places at once — you lose track of what fixed it
- Wrapping in `try/except` to hide the symptom
- Waving it off as "probably an environment issue" without reproducing it
