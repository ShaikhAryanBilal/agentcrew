# Code Review

## Need
- PR with code changes (feature branch → main)
- Tech spec (context for what it should do)
- Coding standards doc (to verify compliance)
- Codebase map (context for insertion points)

## Instructions

### 1. Pre-Read (Context)

- [ ] Read PR description — what does this do? why this approach?
- [ ] Read linked ticket/story — what's the acceptance criteria?
- [ ] Check CI status — if CI is red, STOP. Author must fix first.
- [ ] Check branch name — matches convention? (feat/, fix/, refactor/)

### 2. Correctness

- [ ] Logic matches acceptance criteria? (tick every AC)
- [ ] Edge cases handled? (null, empty, duplicates, concurrency, overflow, timeout, partial data, missing config)
- [ ] Error paths: does every failure path return a proper error?
- [ ] State changes: does DB/state end up correct on success AND failure?

### 3. Security (SG2 Check)

- [ ] All input validated?
- [ ] Parameterized queries (no string concatenation in SQL)
- [ ] Auth check on every endpoint? Authorization check (not just auth)?
- [ ] No hardcoded secrets, keys, tokens, connection strings
- [ ] No eval/exec/dynamic code execution
- [ ] Output encoded for context?
- [ ] Rate limiting on auth-related endpoints?
- [ ] PII not logged? Debug code removed?
- [ ] SAST scan + secret scan + dependency scan pass in CI?

### 4. Code Quality

- [ ] Readable? Self-documenting names?
- [ ] No magic numbers/strings — extracted to named constants
- [ ] No duplicate code (>3 occurrences = extract)
- [ ] No dead code, no import of unused modules
- [ ] No function > 40 lines, no file > 400 lines
- [ ] No TODO/FIXME/XXX in committed code
- [ ] Error messages helpful: not "error" or "failed"

### 5. Tests

- [ ] Happy path tested? Error paths tested? Edge cases tested?
- [ ] Tests independent? (no shared mutable state)
- [ ] Tests describe behaviour? (not implementation)
- [ ] No test testing the framework/library
- [ ] New code coverage ≥ 80%?

### 6. Performance

- [ ] N+1 queries? (check loops with DB calls inside)
- [ ] Missing indexes? (check WHERE/JOIN/ORDER BY columns)
- [ ] Unnecessary loops or nested iterations?
- [ ] Large data loaded into memory without pagination?
- [ ] Caching opportunity missed?

### 7. Review Output

Tag severity: 🔴 Blocking / 🟡 Suggest / 🟢 Nitpick / ❓ Question

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Review only the diff | Check the whole file context. Bug might be outside changed lines. |
| Approve with "fix later" comments | Blocking = change request. Non-blocking = suggest. |
| Nitpick style if linter passes | If linter accepts it, it's fine. Don't override automation. |
| Review for hours | 30-60 min for medium PR. Longer = PR is too big. |
| Ignore tests | Tests are half the review. Test quality matters as much as code. |
| Skip CI check | Red CI = not ready. Don't review until green. |

## Review Speed
| PR Size | Time Budget | Response SLA |
|---------|------------|-------------|
| < 50 lines | 10 min | < 4 hours |
| 50-200 lines | 20-30 min | < 8 hours |
| 200-400 lines | 40-60 min | < 24 hours |
| 400+ lines | Split PR | — |

## Done
- Review completed with comments tagged by severity
- SG2 gate passed (or failed with reasons)
- Decision: Approve / Conditional / Changes requested
- All blocking comments addressed before merge

→ Next: `06-unit-testing.md` (if new tests needed) OR `07-integration.md` (if passes)
Blockers unresolved? Revert to implementation. SG2 fail? Fix scans first.
