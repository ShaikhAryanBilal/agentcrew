# Objective: Verify Quality

## Goal
Execute complete test coverage (functional, non-functional, security, regression), track bugs through resolution, and produce QA sign-off.

## Squad
| Role | Responsibility |
|------|---------------|
| QA Engineer | Test planning, execution, bug tracking, sign-off |
| Security Engineer | Penetration testing, DAST, security gate |
| Dev(s) | Bug fixes, test support |

## Schedule
```
QA:  Plan ──> Cases ──> Functional ──> Non-Functional ──> Regression ──> UAT ──> Sign-off
Sec:                     Pentest ─────> (parallel with QA non-functional)
Dev:                                               Bug fixes (ongoing)
```

**Parallel**: Security pentest runs concurrently with non-functional testing. Dev fixes bugs throughout.  
**Sequential**: Test cases need plan. Functional needs cases. Regression needs all prior. Sign-off needs all.

## Dependencies
- **Needs**: Build artifact from Build Feature (or CI)
- **Blocks**: Ship Release
- **Also needs**: Test environment (DevOps), PRD + acceptance criteria (PM)

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| QA | Test plan (scope, priority, exit criteria) | Markdown |
| QA | Test cases (TC-xxx per requirement) | Markdown |
| QA | Functional test results | Markdown |
| QA | Non-functional test results | Markdown |
| QA | Regression test results | Markdown |
| QA | Bug reports (severity + priority) | Markdown |
| QA | UAT results + sign-off | Markdown |
| QA | QA sign-off document | Markdown |
| Security | SAST/DAST scan results | Reports |
| Security | Dependency scan findings | Reports |
| Security | Pentest report | Markdown |
| Security | Security gate result (SG3) | Markdown |
| Dev | Bug fixes | Commits |

## Acceptance
- All P0 test cases pass
- No Critical/High bugs open (all verified as fixed)
- Non-functional tests meet NFR targets (P95 response time, throughput, etc.)
- Security gates SG3: DAST + pentest — no Critical/High findings
- UAT complete with sign-off (or issues documented)
- QA sign-off: Pass or Conditional (documented)
- Regression scope covers changed areas + fixed bugs

## Procedure References
- QA: `procedures/04-qa/01-test-planning.md`, `procedures/04-qa/02-test-case-development.md`
- QA: `procedures/04-qa/03-functional-testing.md`, `procedures/04-qa/04-non-functional-testing.md`
- QA: `procedures/04-qa/05-regression-testing.md`, `procedures/04-qa/06-bug-tracking.md`
- QA: `procedures/04-qa/07-uat.md`, `procedures/04-qa/08-qa-signoff.md`
- Security: `procedures/04-qa/09-security-pentest.md`

## Security Gates
- **SG3**: Before QA sign-off — DAST + pentest must have no Critical/High findings

## Debate Triggers
- Test strategy (automation vs manual) → QA + Dev debate
- Bug severity classification dispute → QA + PM resolve
- "Ship with known bug?" → PM decides, QA documents

## Solo Invocation
- "QA, write test plan for [feature]" → QA writes plan only
- "QA, run functional tests on build [num]" → QA runs functional only
- "Security, run pentest on [feature]" → Security runs pentest only
- "QA, track bugs from [session]" → QA documents bugs only
- "QA, give sign-off for release [ver]" → QA runs sign-off only
