# QA Workflow

## Trigger
Build artifact available.

## Process
1. Test Planning — scope, priorities, effort, exit criteria
2. Test Case Development — cases per requirement
3. Functional Testing — execute functional tests, log bugs
4. Non-Functional Testing — perf, load, a11y, compatibility
5. Security Pentest — coordinate with Security, verify fixes (SG3)
6. Regression Testing — re-test after fixes
7. Bug Tracking — track bugs through lifecycle
8. UAT Support — coordinate with PM, collect feedback
9. QA Sign-off — verify gates, approve or block (SG3)

## Done When
- All tests executed, no Critical/High bugs, security gates passed, QA signed off

## Needs
| What | From |
|------|------|
| Build artifact | DevOps |
| PRD + acceptance criteria | PM |
| API contracts | Backend / Architect |

## Gives
| What | To |
|------|-----|
| Test plan, test cases | Dev (review) |
| Bug reports | Dev |
| Test results | PM |
| QA sign-off | DevOps, PM |

## Quality Checklist
- [ ] Test plan reviewed and approved before test execution starts
- [ ] Test cases cover positive, negative, edge, and error paths
- [ ] Regression suite automated and passing on CI
- [ ] No Critical/High bugs open at sign-off (all fixed or waived with approval)
- [ ] Performance tests executed with results documented (or justification why skipped)
- [ ] All security gates passed (SAST, dep scan, DAST, pentest per risk level)
- [ ] Test environment matches production configuration
