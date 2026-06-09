# Functional Testing

## Need
- Test case suite (TC-xxx with steps + expected results)
- Build deployed to staging environment
- Test data seeded (DB, config, accounts)
- Access to: staging URL, admin panel, API docs

## Decision Tree

```
What phase of testing?
├── First pass → Execute P0 tests first. Ship-blockers only.
├── Second pass → Execute P1 tests. Important but not blocking.
└── Polish pass → Execute P2 tests. Edge cases, UI details.

Test result?
├── Pass → Move to next test
├── Fail → Log bug (see bug tracking), continue if non-blocking
├── Blocked → Note blocker, skip, return when unblocked
└── Skipped → Document why (environment issue, not applicable)
```

## Do

### 1. Execution Order

```
Phase 1 — P0 Tests (ship blockers)
  Run: All P0 automated tests (CI pipeline)
  Run: Critical manual P0 tests (smoke test: login, main CRUD, main flow)
  Gate: If any P0 fails → bug logged, fix before P1

Phase 2 — P1 Tests (important)
  Run: All P1 automated tests
  Run: Manual tests for features without automation coverage
  Gate: If P1 pass rate < 95% → review: fix bugs or accept with PM approval

Phase 3 — P2 Tests (nice to have)
  Run: Edge cases, UI polish, low-priority scenarios
  Gate: Not a release blocker. Document findings.
```

- [ ] Execute in priority order. Never start P2 while P0 is failing.
- [ ] Automated tests run first, manual tests run second.
- [ ] Each phase gates the next.

### 2. Bug Logging During Execution

When a test fails:

```
1. Confirm: reproduce the failure (not a test environment issue)
2. Classify severity:
   Critical: core flow broken, data loss, auth bypass
   High: feature unusable, major regression
   Medium: feature partially broken, workaround exists
   Low: cosmetic, typo, minor UI glitch
3. Write bug:
   Title: "Export returns 500 when invoice has null customer_id"
   Steps: exact steps from test case
   Expected: what should happen (from test case)
   Actual: what happened (from observation)
   Environment: staging, DB version, browser
   Attachments: screenshot, log excerpt, API response
4. Assign: to dev (if root cause known) or to PM (if need triage)
5. Continue: unless bug blocks further testing
```

- [ ] Every bug has: title, steps, expected, actual, severity, environment
- [ ] No "this doesn't work" bugs. Always: "Expected X, got Y, when Z."

### 3. Test Status Tracking

```
| ID | Description | Priority | Status | Bug | Notes |
|----|-------------|----------|--------|-----|-------|
| TC-001 | Export CSV successfully | P0 | ✅ Pass | — | — |
| TC-002 | Export with date filter | P0 | ❌ Fail | BUG-012 | Customer_id null → 500 |
| TC-003 | Export with no invoices | P1 | ⏳ Pending | — | Waiting for bug fix |
| TC-004 | Export unauthorized | P0 | ✅ Pass | — | — |
| TC-005 | Rate limiting | P1 | ⏸ Blocked | — | Need rate limit config from DevOps |
```

Statuses: Pass / Fail / Pending (waiting on fix) / Blocked (external dependency) / Skipped

### 4. Re-Testing Fixes

- [ ] After dev fixes a bug, re-run the failed test case
- [ ] Re-run related test cases (the bug might be deeper than the fix)
- [ ] Mark bug as Verified if re-test passes, or Re-open if still failing
- [ ] If 3 re-test cycles fail → escalate to PM + Tech Lead

### 5. Output Format

```
FUNCTIONAL TEST REPORT — Invoice Export Feature
Tester: [Name]
Date: 2026-06-10
Build: v1.2.3-rc1 (staging)

Summary:
  Total: 35 | ✅ Pass: 28 | ❌ Fail: 2 | ⏳ Pending: 3 | ⏸ Blocked: 1 | Skipped: 1

  P0: 12/12 pass (100%)   ← RELEASE GATE MET
  P1: 14/18 pass (78%)    ← BELOW 95% TARGET
  P2: 2/4 pass (50%)      ← NICE-TO-HAVE

Bugs Logged:
  BUG-012: Export 500 on null customer_id (Critical) — fixed, verified
  BUG-013: Date filter inclusive/exclusive mismatch (High) — in progress

Risks:
  - P1 pass rate below target (78% vs 95%). PM aware, acceptable for this release.
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Test without a case | Write case first, then execute. No ad-hoc testing without documentation. |
| Ignore failed tests | Every failure = bug or test case error. Resolve before release. |
| Test only happy path | Error paths are where production breaks. Test them. |
| Skip bug reproduction | "It worked on my machine" — reproduce in test env, log exact steps. |
| Retest without confirming fix | Wait for dev confirmation + CI green, then retest. |
| Test everything manually | Automate P0, manual for edge cases. |

## Time Budget

| Test Cases | Automated Run | Manual Execution | Bug Logging | Retest | Total |
|-----------|--------------|-----------------|-------------|--------|-------|
| < 20 | 5 min | 2 hr | 30 min | 30 min | 3+ hr |
| 20-40 | 10 min | 4 hr | 1 hr | 1 hr | 6+ hr |
| 40+ | 15 min | 6 hr | 2 hr | 2 hr | 10+ hr |

## Done
- Test execution report (pass/fail/blocked per test case)
- P0 pass rate = 100% (ship gate met)
- P1 pass rate recorded (≥ 95% target or documented exception)
- Bugs logged for all failures (with steps, expected, actual, severity)
- Fixed bugs re-tested and verified

## Next → `04-non-functional-testing.md`
P0 test fails? Block release. Escalate to PM + Tech Lead.
