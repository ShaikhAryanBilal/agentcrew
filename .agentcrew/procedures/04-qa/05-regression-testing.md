# Regression Testing

## Need
- Build with bug fixes applied (new deployment to staging)
- Existing test suite (all P0 + P1 test cases from this cycle)
- Bug fix list (bugs fixed since last test run, with descriptions)
- Change log (what files changed, what areas were touched)

## Instructions

### 1. Scope Selection

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
Regression: behavior worked before, now broken → higher severity
New bug: behavior never worked → normal severity

Regression response:
  - Critical → Revert the fix. Don't ship broken what was working.
  - High → Fix before release or revert.
  - Medium → Can ship with known issue list, fix next sprint.
  - Low → Fix next sprint, note in known issues.
```

- [ ] Tag regression bugs differently
- [ ] Critical regression = revert candidate even if it means reverting the feature

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

→ Next: `06-bug-tracking.md`
Critical regression? Revert fix and re-run regression. Medium/Low? Document known issues.
