# Regression Testing

## Need
- Build with bug fixes applied (new deployment to staging)
- Existing test suite (all P0 + P1 test cases from this cycle)
- Bug fix list (bugs fixed since last test run, with descriptions)
- Change log (what files changed, what areas were touched)

## Decision Tree

```
How many changes since last regression?
├── Bug fix (1-3 files changed) → Targeted regression: test fixed area + related areas
├── Feature addition (4-10 files) → Full P0 regression + targeted P1 around changes
└── Major refactor/release → Full regression: all P0 + all P1

What was touched?
├── Core logic → Full regression. Core affects everything.
├── UI only → Spot-check affected screens. Don't re-run backend tests.
├── DB migration → Test data integrity + affected queries. Re-run migration-related tests.
├── Configuration → Test config parsing + affected features.
└── Dependencies → Test everything the dependency touches (if critical, full regression).

Time available?
├── Full regression feasible → Run all
├── Partial only → Prioritize: changed areas → core flows → edge cases
└── None → Ship risk. Document known regression risk.
```

## Do

### 1. Scope Selection

```
Fixed bugs this cycle:
  BUG-012: Export null customer_id → ServerError
  BUG-014: Invoice list sort order wrong

Impact areas based on changes:
  Primary: CSV export, invoice list
  Secondary: Any feature using customer_id lookup
  Unaffected: Payments, auth, email

Regression scope:
  ✅ Full P0 suite (12 tests) — all core flows
  ✅ P1 tests for export (TC-003, TC-008) — directly impacted area
  ✅ P1 tests for invoice list (TC-010, TC-011) — directly impacted area
  ❌ P1 tests for payments (TC-020..TC-025) — no code changes in payment area
  ❌ P2 tests — edge cases, time permitting
```

- [ ] Select regression scope based on impact analysis
- [ ] Always include: all P0 tests (safety net)
- [ ] Always include: tests for changed files and their direct dependents

### 2. Execution

- [ ] Run automated regression suite (CI pipeline)
- [ ] Execute selected manual test cases
- [ ] Run in order: P0 impacts → P1 direct → P1 indirect → P2 if time
- [ ] Log any regression bugs immediately (tag with `regression`)

### 3. Regression vs New Bugs

```
Regression: behavior worked before, now broken → higher severity (it's a rollback)
New bug: behavior never worked → normal severity

Regression response:
  - Critical regression → Revert the fix. Don't ship broken what was working.
  - High regression → Fix before release or revert.
  - Medium regression → Can ship with known issue list, fix next sprint.
  - Low regression → Fix next sprint, note in known issues.
```

- [ ] Tag regression bugs differently
- [ ] Critical regression = revert candidate even if it means reverting the feature

### 4. Output Format

```
REGRESSION TEST REPORT — v1.2.3-rc2
Tester: [Name]
Date: 2026-06-11
Build: v1.2.3-rc2 (staging)

Scope: Full P0 + targeted P1 (impacted areas only)

Summary:
  Total: 18 | ✅ Pass: 17 | ❌ Fail: 1

  P0: 12/12 pass — ✅ Release gate met
  P1 (impacted): 5/6 pass

New Bugs:
  BUG-015 (regression): Export with date filter returns empty for valid range — High
    - Customer had date filter that returns no results; customer expects all invoices
    - Root cause: date filter uses inclusive/exclusive boundary mismatch

Previous known issues still open: 2 (BUG-013 Medium, BUG-016 Low)

Recommendation:
  🟡 Conditional release — fix BUG-015 before release. Low risk, isolated to date filter edge case.
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Always run full regression | Target by impact. P0 always. P1/P2 by risk. |
| Skip regression for "trivial" fixes | Trivial fixes break things too. Always at least P0 suite. |
| Ignore regression label | Regression is worse than new bug — it's a step backward. |
| Re-run only failed tests | Re-run the whole impacted area. The fix might break something else. |
| No impact analysis | "What could this change break?" — ask before selecting scope. |

## Time Budget

| Scope | Impact Analysis | Automated Run | Manual Execution | Total |
|-------|----------------|--------------|-----------------|-------|
| Targeted (< 20 tests) | 10 min | 5-10 min | 30 min | 45-50 min |
| Medium (20-40 tests) | 15 min | 10 min | 1 hr | 1.5 hr |
| Full (40+ tests) | 20 min | 15 min | 2-3 hr | 2.5-3.5 hr |

## Done
- Regression test report (pass/fail per test, compared to baseline)
- Regression bugs logged with `regression` tag
- Critical regressions flagged for revert decision
- Release recommendation: go / conditional / no-go

## Next → `06-bug-tracking.md`
Critical regression? Revert fix and re-run regression. Medium/Low? Document known issues.
