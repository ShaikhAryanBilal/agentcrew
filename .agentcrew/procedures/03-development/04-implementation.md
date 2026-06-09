# Implementation

## Need
- Tech spec / design docs
- Codebase map (insertion points known)
- Current branch off main

## Instructions

### 1. Branch + Commit Discipline

```
Branch: feat/TICKET-123-short-description
        fix/TICKET-123-what-broke
        refactor/TICKET-123-what
Commits: conventional commits, squash NOT allowed on branch
  feat: add payment webhook handler
  fix: handle null memo in invoice export
Commit body — answer WHY, not what
```

### 2. Implementation Order (priority)

- [ ] **Schema/migration first** (if any) — write down, then code up
- [ ] **Core logic** — pure functions, no I/O. Testable in isolation
- [ ] **I/O layer** — DB calls, API calls, file reads. Thin wrappers
- [ ] **Handler/controller** — wires logic + I/O. Keep < 30 lines
- [ ] **Error handling** per layer
- [ ] **Input validation** — validate at boundary, not inside logic
- [ ] **Edge cases per type**:
  ```
  Null/nil      → guard early, make impossible via types if you can
  Empty         → is empty a valid state? document it
  Duplicates    → idempotency key or upsert
  Concurrency   → optimistic lock or serial queue
  Overflow      → bounded collections, pagination
  Timeout       → context deadline, configurable timeout
  Partial fail  → transaction or compensating action
  ```

### 3. Tests

- [ ] Match existing test framework + patterns (look at 3 existing tests first)
- [ ] File naming: `*.test.ts` / `*_test.go` — whatever project uses
- [ ] Coverage expectation: new code ≥ 80%, existing uncovered code NOT required
- [ ] Mock external services, NOT internal logic

### 4. Self-Review Checklist

- [ ] No `console.log`, `print()`, `debugger`, `TODO`, `FIXME`, `XXX` in committed code
- [ ] No commented-out code blocks
- [ ] No magic strings/numbers — extracted to named constant or config
- [ ] No function > 40 lines (if yes, extract)
- [ ] No file > 400 lines (if yes, split)
- [ ] No import of unused modules
- [ ] No secrets, keys, tokens, connection strings in code
- [ ] Public API documented
- [ ] Logs use structured format (JSON), not string interpolation
- [ ] Breaking change in shared interface? Flag in PR description
- [ ] CI passes locally (lint + typecheck + test)

### 5. PR Output

- [ ] PR title: `type(scope): description`
- [ ] PR body template:
  ```
  Closes TICKET-123
  ## What
  3-line summary
  ## Why
  Why this approach, not alternatives considered
  ## Test plan
  - `npm test regression`
  ## Breaking changes
  None / List them
  ```
- [ ] Add reviewer(s) per ownership matrix
- [ ] Link to any related issues, designs, or discussions

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Mix refactor + feature in same PR | Separate PRs or commits (clear boundary) |
| Add dead code "for later" | Delete it. Git has history |
| Copy-paste 3+ times | Extract to shared function/module |
| Silently swallow errors | Log + rethrow or return error type |
| Write test that tests framework | Test YOUR logic, not the ORM/HTTP client |
| Over-abstract (FactoryFactory) | Wait until 3rd usage to abstract |
| Giant PR (> 400 lines changed) | Split into stacked PRs |

## Time Budget
| Size | Implementation | Tests | Self-Review | Total |
|------|---------------|-------|-------------|-------|
| Tiny (< 50 lines, 1 file) | 15 min | 10 min | 5 min | 30 min |
| Medium (50-200 lines, 2-3 files) | 1-2 hr | 30 min | 15 min | 2-3 hr |
| Large (200-500 lines, 4-8 files) | 3-5 hr | 1-2 hr | 30 min | 5-8 hr |
| X-Large (500+ lines, 8+ files) | 1-2 days | 3-4 hr | 1 hr | Split into sub-tasks |

## Done
- Feature branch with conventional commits
- Tests passing (new + no regressions)
- CI green (lint + typecheck + test)
- PR open with description + reviewer
- Migration scripts committed (if schema change)

→ Next: `05-code-review.md`
Blocked? Design gap → revert to design/review. External dependency issue → flag in PR.
