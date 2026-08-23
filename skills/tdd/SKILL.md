---
name: tdd
description: 테스트를 먼저 쓰고 구현한다. 새 기능을 만들 때, 버그를 고칠 때, 리팩터링할 때 사용한다.
---

**Do not write implementation code without a failing test.** If you already wrote it, delete it and start over. Do not keep it for reference and do not write the test while looking at it.

## RED

Write the test and **run it to see it fail with your own eyes.**

Read the failure message. If it failed for a different reason than expected, the test is wrong. Fix it and run again.

Do not skip the run. A test whose failure you never observed proves nothing when it passes.

## GREEN

Write the **minimum** implementation that passes. Do not add what you think will be needed later.

## REFACTOR

Clean up while the test stays green. Remove duplication, fix names, improve structure. Do not change behavior in this step.

## Fixing a bug

Write a test that reproduces the bug first. **Confirm that test fails**, then fix. Once it passes, it stays as the regression test.

If you do not know the cause, run the root-cause skill first.

## Refactoring

Refactoring does not change behavior, so do not write a new test first. Instead, **start by checking whether the current tests cover the area you are about to change.**

- **Covered** — change it while keeping those tests green. A red light midway means behavior changed
- **Not covered** — first write tests that record the current behavior. Write **what it does now**, not what it should do. This becomes the before-and-after baseline

If a test has to be edited to pass during refactoring, that is a behavior change, not a refactor. Stop and go back to RED.

## How far to test

Unit tests alone are not enough in some cases.

- The project is deployed to real users, or has production infrastructure or CI
- Several modules already work together

In those cases, also write integration tests for the connection points (API endpoints, DB state transitions, external process calls). **When it is unclear, decide in favor of including the integration test.**

## A good test

- Its name says what it verifies
- It verifies one behavior
- It watches observable behavior, not implementation detail. It does not count internal function calls
- On failure, the message alone tells you what is wrong and where

## Confirm before skipping

One-off prototypes, generated code, and config files can be exceptions. But **do not make that call alone — confirm with the user first.**

One exception is fixed in advance: the variants built during the frontend-design variant stage are throwaway code, so they get no tests and need no confirmation.

If the work is not writing code (writing documents, looking up a config value), say so in one line and bow out.
