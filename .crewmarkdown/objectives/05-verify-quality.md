# Verify Quality

## System
You are executing objective: Verify Quality. Execute complete test coverage (functional, non-functional, security, regression), track bugs through resolution, and produce QA sign-off.

## Instructions
1. Assemble squad: QA Engineer, Security Engineer, Dev(s)
2. QA writes test plan (scope, priority, exit criteria) (procedures/04-qa/01-test-planning.md)
3. QA develops test cases (procedures/04-qa/02-test-case-development.md) mapped to requirements
4. Run in parallel: QA executes functional tests (procedures/04-qa/03-functional-testing.md), Security runs pentest (procedures/04-qa/09-security-pentest.md)
5. QA runs non-functional tests (procedures/04-qa/04-non-functional-testing.md)
6. QA runs regression tests (procedures/04-qa/05-regression-testing.md)
7. Dev fixes bugs throughout; QA tracks (procedures/04-qa/06-bug-tracking.md)
8. QA runs UAT (procedures/04-qa/07-uat.md) and obtains sign-off (procedures/04-qa/08-qa-signoff.md)
9. Verify acceptance criteria (including SG3)
10. **Save confirmation**: Ask user "Save artifacts & log this session? [Y/n]" (ref: `procedures/00-save-confirmation.md`). Y→persist, N→in-memory only.
11. If persist: Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
12. If persist: Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| QA Engineer | Test planning, execution, bug tracking, sign-off |
| Security Engineer | Penetration testing, DAST, security gate |
| Dev(s) | Bug fixes, test support |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Build artifact + PRD | Dev + PM | Test plan (scope, priority, exit criteria) (Markdown) | QA |
| Test plan + PRD | QA + PM | Test cases (TC-xxx per requirement) (Markdown) | QA |
| Test cases + build | QA + Dev | Functional test results (Markdown) | QA |
| NFR targets + build | PM + Dev | Non-functional test results (Markdown) | QA |
| All prior tests | QA | Regression test results (Markdown) | QA |
| Test failures | QA | Bug reports (severity + priority) (Markdown) | Dev |
| Fixed bugs + build | Dev + QA | UAT results + sign-off (Markdown) | QA |
| All passed | QA | QA sign-off document (Markdown) | PM |
| Build | Dev | SAST/DAST scan results (Reports) | Security |
| Dependencies | Build | Dependency scan findings (Reports) | Security |
| Application | Dev | Pentest report (Markdown) | Security |
| All scans | Security | Security gate result (SG3) (Markdown) | QA |
| Bug reports | QA | Bug fixes (Commits) | Dev |

## Acceptance
- All P0 test cases pass
- No Critical/High bugs open (all verified as fixed)
- Non-functional tests meet NFR targets (P95 response time, throughput, etc.)
- Security gates SG3: DAST + pentest — no Critical/High findings
- UAT complete with sign-off (or issues documented)
- QA sign-off: Pass or Conditional (documented)
- Regression scope covers changed areas + fixed bugs

## Gates
- **SG3**: Before QA sign-off — DAST + pentest must have no Critical/High findings

## Procedures
- QA: `procedures/04-qa/01-test-planning.md`
- QA: `procedures/04-qa/02-test-case-development.md`
- QA: `procedures/04-qa/03-functional-testing.md`
- QA: `procedures/04-qa/04-non-functional-testing.md`
- QA: `procedures/04-qa/05-regression-testing.md`
- QA: `procedures/04-qa/06-bug-tracking.md`
- QA: `procedures/04-qa/07-uat.md`
- QA: `procedures/04-qa/08-qa-signoff.md`
- Security: `procedures/04-qa/09-security-pentest.md`

## Debate Triggers
- Test strategy (automation vs manual) → QA + Dev debate
- Bug severity classification dispute → QA + PM resolve
- "Ship with known bug?" → PM decides, QA documents
