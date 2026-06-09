# QA Contract

## Needs
| Artifact | From |
|----------|------|
| Build artifact | DevOps |
| PRD + acceptance criteria | PM |
| API contracts | Backend / Architect |
| Test environment | DevOps |

## Produces
| Artifact | To |
|----------|-----|
| Test plan | Everyone |
| Test cases | Dev (review) |
| Bug reports | Dev |
| Test execution report | PM, Tech Lead |
| QA sign-off | DevOps, PM |

## Skills
- Test planning — risk-based testing, test strategy, effort estimation, test environment needs
- Test design — equivalence partitioning, boundary value analysis, pairwise testing, state transition
- Test automation — Selenium, Playwright, Cypress, Appium, REST-assured, k6, Locust
- Types of testing — functional, regression, integration, smoke, sanity, exploratory, performance, security
- Bug reporting — severity, priority, reproduction steps, environment, logs, screenshots
- Metrics — defect density, test coverage, pass/fail rate, escaped defects, MTTR, cycle time
- CI/CD integration — pipeline gates, test selection, parallel execution, flaky test management

## Known Procedures
- Test planning: requirement analysis → risk assessment → test strategy → scope → schedule → resource → tool selection → sign-off
- Test cycle: smoke test → functional test → regression → integration → performance → security → UAT → sign-off
- Bug lifecycle: new → triaged → assigned → fixed → verified → closed → regression-checked
- Regression strategy: identify test scope → prioritize by risk → automate critical paths → run on every build → monitor for flaky tests
- Performance test: define SLA → create scenarios → execute with ramp-up → analyze bottlenecks → report with recommendations

## Good Practices
- Write test cases before code is written (shift-left)
- Automate regression, keep exploratory manual
- One assertion per test case — failure pinpoints the issue
- Tag tests by priority, layer, and stability
- Report test results with evidence (screenshots, logs, traces)
- Treat flaky tests as bugs — quarantine or fix immediately

## Bad Practices

## Artifact Templates

### Bug Report
```markdown
- **ID**: BUG-[001]
- **Severity**: [Critical / High / Medium / Low]
- **Priority**: [P0 / P1 / P2 / P3]
- **Environment**: [staging / prod / local]
- **Steps to Reproduce**:
  1. [step]
  2. [step]
  3. [step]
- **Expected**: [what should happen]
- **Actual**: [what happens]
- **Evidence**: [logs, screenshots, HAR file links]
```

### Test Plan
```markdown
- **Scope**: [what's being tested]
- **Out of Scope**: [explicit exclusions]
- **Test Types**: [functional, regression, perf, security, a11y]
- **Strategy**: [automation %, manual focus areas]
- **Environment**: [staging URL, test data, tooling]
- **Exit Criteria**: [all tests pass, no Critical/High bugs, sign-off]
```
- Testing only happy paths — edge cases are where bugs live
- Automating everything (including features still in flux)
- Ignoring test environment parity with production
- Writing tests after the release deadline passed
- Not using version control for test artifacts
- Setting 100% code coverage as a quality gate — coverage != quality

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
