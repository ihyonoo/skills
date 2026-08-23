---
name: branch-flow
description: 기능 브랜치 생성, 커밋, PR 작성을 정해진 규칙대로 수행한다. 개발 작업을 시작할 때, 커밋이나 PR을 만들 때, 기본 브랜치에서 코드를 수정하려 할 때 사용한다.
---

## Naming

All three share the same type vocabulary: `feat` `fix` `refactor` `docs` `chore` `test` `ci` `build` `perf` `style`

- Branch — `<type>/<kebab-slug>` (lowercase English)
- Commit — `<type>: <Korean summary>`
- PR title — same as the commit

Commit messages and PR bodies are written in Korean. People read them.

## 1. Branch

When the current branch is the default branch (main/master), **always create a new branch.** Propose a name and run `git checkout -b` only after approval.

## 2. Commit

**Never commit on your own.** Propose a draft message and run it only when the user explicitly says to commit.

- Split changes into logical units. Do not mix unrelated changes into one commit
- One line for the summary. When a body is needed, write **why** — the diff already says what changed
- Do not add `Co-Authored-By` signatures or AI-generated markers

## 3. Self-review

Run the code-review skill before pushing. **Do not move to step 4 while a blocking finding remains.**

If the running agent provides its own code review capability, run that too and merge overlapping findings.

When fixes are needed, add commits to the same branch — those messages also go through propose-and-approve.

## 4. PR

Describe the branch to be pushed, get approval, then push. Propose a draft body, get approval, then `gh pr create`.

Items deferred in step 3 go in the **참고** section.

Body structure:

```
## 배경
왜 이 변경이 필요한지. 어떤 문제·요청·근본 원인에서 출발했는지

## 변경 사항
파일 또는 로직 단위 bullet

## 시각 자료
UI·화면 변경이 있을 때만. 캡처 수단이 없으면 자리표시자를 남기고 사용자에게 첨부를 요청한다

## 검증
실제로 실행한 절차와 그 결과. 빌드 출력, 수동 테스트 시나리오, API 호출 결과
앞으로 할 일 체크리스트가 아니라 이미 끝낸 검증의 기록이다

## 참고
남은 이슈, 후속 작업, 리뷰어가 특히 봐야 할 곳 (선택)
```

**PR body style** — Korean, plain declarative form: `~한다`, `~했다`, `~이다`. Do not use `~합니다` or `~해요`. No emoji.

Do not append an AI-generated marker at the end of the body.

## Merging

**The user does it on GitHub.** Do not merge on their behalf. After the merge, follow the post-merge skill for local cleanup.
