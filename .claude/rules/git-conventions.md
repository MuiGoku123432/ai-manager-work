# Git Conventions

## Conventional Commits

All commits must follow the conventional commits format:

```
<type>(<scope>): <description>

[optional body]
```

**Types:**

| Type | When to Use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `chore` | Maintenance, tooling, config updates |
| `style` | Formatting, whitespace (no logic change) |
| `test` | Adding or updating tests |
| `build` | Build system or dependency changes |
| `ci` | CI/CD configuration |
| `perf` | Performance improvement |

**Scope:** Optional. Use the domain or feature name.
- `feat(recursive-research): add iteration scoring`
- `fix(brain): correct obsidian-cli path in CLAUDE.md`
- `docs(project-init): update scaffold recipes`
- `chore: update context files`

**Description rules:**
- Imperative mood ("add", not "added" or "adds")
- Lowercase
- No trailing period
- 72 characters max on the subject line

**Body:** Optional. Separate from subject with a blank line. Use to explain the why, not the what.

## No Co-Authored-By

Never append `Co-Authored-By` trailers to commit messages. Omit them entirely.

## Git Worktrees

Prefer worktrees over switching branches when working on parallel or experimental changes.

**Common commands:**
```bash
# Create a worktree on a new branch
git worktree add ../ai-projects-<feature> -b <branch-name>

# List active worktrees
git worktree list

# Remove when done (branch must be merged or no longer needed)
git worktree remove ../ai-projects-<feature>
```

**Rules:**
- Never commit feature work directly to `master` -- use a branch via worktree
- Clean up worktrees after merging: `git worktree remove` then `git branch -d <branch>`
- Worktree directories live alongside the main repo (e.g., `../ai-projects-feat-xyz/`)
