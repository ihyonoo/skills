---
name: post-merge
description: PR 머지 후 로컬 저장소를 정리한다. 사용자가 머지했다고 알릴 때, 이미 머지된 브랜치가 로컬에 남아 있을 때 사용한다.
---

## 1. Confirm the merge

Before cleaning up, confirm the merge actually happened. Use `gh pr view <number> --json state,mergedAt,mergeCommit`, or read the log of the remote default branch.

**Remember what you found here.** Step 2 depends on it.

If the merge is not confirmed, **do not clean up.** Report that it could not be confirmed.

## 2. Clean up

Once the merge is confirmed, do not ask for approval. Clean up and report the result.

```
git checkout <default branch>
git pull origin <default branch>
git branch -d <merged branch>
git push origin --delete <merged branch>
```

If the remote branch is already gone, the last command fails. Leave it and move on.

If `-d` refuses, the answer depends on what step 1 found. **The refusal alone is not evidence that the branch was never merged** — squash and rebase merges create new commits, so the original commits stay unreachable from the default branch and `-d` sees only that.

- **Step 1 confirmed the merge** → it was a squash or rebase merge. Say so and delete with `-D`
- **Step 1 did not confirm it** → it really was not merged. Do not force. Report the remaining commits and hand the decision back

## 3. Check what is left

- If other merged branches remain, clean those up too. Confirm the merge separately for each one
- If stashes or uncommitted changes remain, report them. Do not delete them

## Never do this

- Force-delete with `-D` without the step 1 confirmation
- "Clean up" with destructive commands like `git reset --hard` or `git clean`
