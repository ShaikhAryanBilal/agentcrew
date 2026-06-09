# Code Review

## Need
- PR with code changes (feature branch → main)
- Tech spec (context for what it should do)
- Coding standards doc (to verify compliance)
- Codebase map (context for insertion points)

## Decision Tree

```
PR size?
├── < 200 lines changed → Standard review
├── 200-400 lines → Be thorough. Ask for split if possible.
└── 400+ lines → Ask author to split into multiple PRs before reviewing.

What type of change?
├── Logic change → Focus: correctness, edge cases, test coverage
├── Refactor → Focus: behavior preserved, test coverage, naming
├── Dependency upgrade → Focus: breaking changes, test changes, changelog
├── Configuration → Focus: secrets exposed? defaults reasonable?
└── Migration → Focus: reversible? zero-downtime? data loss?

Does change touch auth/payments/PII?
├── Yes → Thorough security review. SG2 check mandatory.
└── No → Standard security check.
```

## Do

### 1. Pre-Read (Context)

- [ ] Read PR description — what does this do? why this approach?
- [ ] Read linked ticket/story — what's the acceptance criteria?
- [ ] Check CI status — if CI is red, STOP. Author must fix first.
- [ ] Check branch name — matches convention? (feat/, fix/, refactor/)

### 2. Correctness

- [ ] Logic matches acceptance criteria? (tick every AC)
- [ ] Edge cases handled?
  ```
  ┌────────────────┬──────────────────────────────┐
  │ Edge case      │ Check                        │
  ├────────────────┼──────────────────────────────┤
  │ Null/nil       │ Guard before dereference     │
  │ Empty          │ Empty list → empty result?   │
  │ Duplicates     │ Idempotency or deduplication │
  │ Concurrency    │ Race conditions? Locks?      │
  │ Overflow       │ Pagination? Bounded results? │
  │ Timeout        │ ctx deadline? configurable?  │
  │ Partial data   │ Partial save → rollback?     │
  │ Missing config │ Fails with clear error?      │
  └────────────────┴──────────────────────────────┘
  ```
- [ ] Error paths: does every failure path return a proper error?
- [ ] State changes: does DB/state end up correct on success AND failure?

### 3. Security (SG2 Check)

- [ ] All input validated? (type, length, range, format)
- [ ] Parameterized queries (no string concatenation in SQL)
- [ ] Auth check on every endpoint? Authorization check (not just auth)?
- [ ] No hardcoded secrets, keys, tokens, connection strings
- [ ] No eval/exec/dynamic code execution
- [ ] Output encoded for context (HTML, JSON, URL)?
- [ ] Rate limiting on auth-related endpoints?
- [ ] PII not logged? Debug code/log statements removed?
- [ ] File uploads: type check, size limit, no direct path access
- [ ] SAST scan + secret scan + dependency scan pass in CI?

### 4. Code Quality

- [ ] Readable? Self-documenting names? (not `a`, `tmp`, `data`)
- [ ] No magic numbers/strings — extracted to named constants
- [ ] No duplicate code (>3 occurrences = extract)
- [ ] No dead code (commented-out blocks, unused functions)
- [ ] No import of unused modules
- [ ] No function > 40 lines? (if yes, ask to extract)
- [ ] No file > 400 lines? (if yes, ask to split)
- [ ] No TODO/FIXME/XXX in committed code (unless tracked in ticket)
- [ ] Error messages helpful: not "error" or "failed" — "failed to create invoice: duplicate number"

### 5. Tests

- [ ] Happy path tested? (expected input → expected output)
- [ ] Error paths tested? (invalid input → proper error)
- [ ] Edge cases tested? (null, empty, boundary)
- [ ] Tests independent? (no shared mutable state, no test order dependency)
- [ ] Tests describe behaviour? (not implementation)
  ```
  ✅ "returns 400 when invoice amount is negative"
  ❌ "calls validateAmount function" (implementation detail)
  ```
- [ ] No test testing the framework/library
- [ ] New code coverage ≥ 80%?

### 6. Performance

- [ ] N+1 queries? (check loops with DB calls inside)
- [ ] Missing indexes? (check WHERE/JOIN/ORDER BY columns)
- [ ] Unnecessary loops or nested iterations?
- [ ] Large data loaded into memory without pagination/throttling?
- [ ] Caching opportunity missed? (same query repeated with same params?)

### 7. Review Output

```
PR: #142 — feat(invoices): add CSV export
Reviewer: [Name]
Date: 2026-06-08
Decision: Approve / Changes requested / Conditional

CI: ✅ Green

SG2: ✅ Pass (all scans clean)

Comments:

🔴 Blocking (must fix before merge):
  1. src/services/export-service.ts:45 — SQL string concatenation. Use parameterized query.
  2. src/routes/exports.ts:12 — Missing auth check. Add `requireAuth` middleware.

🟡 Suggest (consider fixing):
  1. src/services/export-service.ts:80 — Function is 65 lines. Extract CSV row builder.

🟢 Nitpick (optional):
  1. src/routes/exports.ts:5 — Rename `handler` to `exportInvoices` (descriptive).

❓ Question:
  1. What happens when export takes > 30s? Is there a timeout?
```

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

## Next → `06-unit-testing.md` (if new tests needed) OR `07-integration.md` (if passes)
Blockers unresolved? Revert to implementation. SG2 fail? Fix scans first.
