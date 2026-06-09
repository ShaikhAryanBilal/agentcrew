# QA Sign-off

## Need
- Functional test report (P0 and P1 pass rates, test execution summary)
- Non-functional test report (performance, load, security baseline)
- Regression test report (regression pass rate, regression bugs)
- Security pentest report (SG3 pass required)
- Bug tracker status (all Critical/High resolved or accepted)
- UAT sign-off (or known issues list)
- Known issues list (accepted Medium/Low bugs and UX gaps)

## Instructions

### 1. Data Collection

Gather all reports into single sign-off document:

```
QA SIGN-OFF — Invoice Export Feature (v1.2.3)

1. Functional Testing
   - P0: 12/12 pass (100%)
   - P1: 16/18 pass (89%) — below 95% target
   → ⚠️ P1 below target, 2 P1 bugs documented and accepted by PM

2. Non-Functional Testing
   - Performance: P95 320ms ✅
   - Load: 100 req/s sustained ✅
   - Security Baseline: All headers present ✅
   → Pass

3. Regression Testing
   - P0: 12/12 pass (100%)
   → Pass

4. Security Pentest (SG3)
   - Critical: 0, High: 0
   → ✅ SG3 Pass

5. UAT
   - 3/4 scenarios pass
   - PM signed off: Conditional
   → Conditional Pass

6. Bug Status
   - Critical: 0 open ✅
   - High: 0 open ✅
   → Pass (no blockers)
```

- [ ] Collect all 7 data points
- [ ] Every section has a pass/fail/conditional verdict
- [ ] Known issues list is complete and signed by PM

### 2. Sign-off Decision

```
QA SIGN-OFF DECISION
☐ ✅ PASS — All gates passed. Recommend release.
☑ ⚠️ CONDITIONAL PASS — Minor issues noted. PM accepts risk.
☐ ❌ FAIL — Blocker exists. Do not release.
```

- [ ] QA recommends pass/fail/conditional
- [ ] PM accepts or rejects recommendation
- [ ] Tech Lead confirms: no technical blockers

### 3. Release Recommendation

| Decision | Meaning | Action |
|----------|---------|--------|
| Pass | Ship it | Route to release planning |
| Conditional | Ship with known issues | Route to release planning with issue list |
| Fail | Don't ship | Route back to bug fixes or design |

Known issues shipped with conditional pass:
  - Must be documented in release notes
  - Must have owner + scheduled fix sprint
  - Must not be Critical/High severity

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Sign off without all reports | Gather every report. Missing data = incomplete sign-off. |
| Accept Critical/High bugs in known issues | Critical/High = blocker. Fix or defer feature. |
| Ignore P1 pass rate | Below 95% = conditional. PM must explicitly accept. |
| Skip SG3 check | Even if "no sensitive data," run automated scans. |
| Verbal sign-off | Written. Signatures (or thread approval) required. |

## Time Budget
| Data Collection | Review | Decision | Total |
|----------------|--------|----------|-------|
| 15 min | 20 min | 5 min | 40 min |

## Done
- QA sign-off document (all 7 data points)
- Verdict: Pass / Conditional / Fail
- Known issues list (all accepted, with PM approval)
- Signatures: QA, PM, Tech Lead
- Release recommendation: proceed or blocked

→ Next: `05-deployment/01-release-planning.md`
Fail? Route to bug fixes. SG3 fail? Route to security pentest.
