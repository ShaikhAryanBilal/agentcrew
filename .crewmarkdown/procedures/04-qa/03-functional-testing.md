# Functional Testing

## Need
- Test case suite (TC-xxx with steps + expected results)
- Build deployed to staging environment
- Test data seeded (DB, config, accounts)
- Access to: staging URL, admin panel, API docs

## Instructions

### 1. Execution Order

```
Phase 1 — P0 Tests (ship blockers)
  Run: All P0 automated tests (CI pipeline)
  Run: Critical manual P0 tests (smoke test)
  Gate: If any P0 fails → bug logged, fix before P1

Phase 2 — P1 Tests (important)
  Run: All P1 automated tests
  Run: Manual tests for features without automation coverage
  Gate: If P1 pass rate < 95% → review: fix bugs or accept with PM approval

Phase 3 — P2 Tests (nice to have)
  Gate: Not a release blocker. Document findings.
```

- [ ] Execute in priority order. Never start P2 while P0 is failing.
- [ ] Automated tests run first, manual tests run second.
- [ ] Each phase gates the next.

### 2. Bug Logging During Execution

When a test fails:
1. Confirm: reproduce the failure
2. Classify severity: Critical / High / Medium / Low
3. Write bug with: title, steps, expected, actual, environment, attachments
4. Assign to dev (if root cause known) or PM (if need triage)
5. Continue: unless bug blocks further testing

- [ ] Every bug has: title, steps, expected, actual, severity, environment
- [ ] No "this doesn't work" bugs. Always: "Expected X, got Y, when Z."

### 3. Test Status Tracking

Statuses: Pass / Fail / Pending (waiting on fix) / Blocked (external dependency) / Skipped

### 4. Re-Testing Fixes

- [ ] After dev fixes a bug, re-run the failed test case
- [ ] Re-run related test cases (the bug might be deeper than the fix)
- [ ] Mark bug as Verified if re-test passes, or Re-open if still failing
- [ ] If 3 re-test cycles fail → escalate to PM + Tech Lead

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
- Bugs logged for all failures
- Fixed bugs re-tested and verified

→ Next: `04-non-functional-testing.md`
P0 test fails? Block release. Escalate to PM + Tech Lead.
