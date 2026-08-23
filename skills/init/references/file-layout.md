# File layout

`AGENTS.md` is the original. `CLAUDE.md` is a symlink to it.

## Which case are you in

- **Neither exists** → create them
- **Only `CLAUDE.md` exists** → move the content into `AGENTS.md` and replace `CLAUDE.md` with a link. **Back it up before replacing**
- **Only `AGENTS.md` exists** → add the `CLAUDE.md` link
- **Both are real files** → compare the content. If they differ, propose a merge and get approval. **Never overwrite on your own**

## Creating the link

```
ln -s AGENTS.md CLAUDE.md
```

Do not add it to `.gitignore`. The instructions travel with the repo.

## When several people clone the repo

If this is not a solo repo, say so before creating the link. Symlinks committed to git can break on Windows checkouts. Ask whether to keep both as real files instead.
