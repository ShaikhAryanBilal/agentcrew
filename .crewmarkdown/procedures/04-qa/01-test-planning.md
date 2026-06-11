# Test Planning

## Need
- PRD with success criteria + acceptance criteria
- Tech spec + API contracts
- Build artifact (deployed to staging)
- Risk assessment (what's the cost of failure?)

## Instructions

### 1. Scope Definition

| Test Type | In Scope? | Priority | Approach |
|-----------|-----------|----------|----------|
| Functional (happy path) | Yes | P0 | Automated |
| Functional (error paths) | Yes | P0 | Automated |
| Functional (edge cases) | Yes | P1 | Manual + automated |
| Integration | Yes | P0 | Automated |
| Performance | If NFR exists | P0-P1 | Automated |
| Security (DAST) | If public/PII | P0 | Tool-based |
| Security (pentest) | If auth/payments | P1 | Manual |
| Regression | Yes | P0 | Automated |
| Accessibility | If public | P1-P2 | Tool + manual |
| UX/Design | If new UI | P2 | Manual review |

- [ ] Decision for each row: in scope or out, automated or manual, priority
- [ ] If out of scope → document why

### 2. Priority Matrix Per Feature

- [ ] Map requirements → test priority
- [ ] P0 = ship blocker. Must pass before release.
- [ ] P1 = important but has workaround.

### 3. Effort Estimate

- [ ] Estimate per feature: test case count, automation time, manual time, setup time
- [ ] Add 20% buffer for unexpected issues
- [ ] If effort > dev time → scope is too broad. Cut P2.

### 4. Exit Criteria

Quantitative criteria only. No "should work well" — define what "well" means.

Release criteria:
```
Functional:
  ✅ All P0 test cases pass
  ✅ P1 pass rate ≥ 95%
  ✅ No Critical/High bugs open
Non-Functional:
  ✅ P95 response time ≤ target
  ✅ Error rate ≤ 1%
Security (SG3):
  ✅ DAST no Critical/High findings
  ✅ Pentest no Critical/High findings
```

- [ ] Agreed with PM + Dev + QA before testing starts.

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Test all priorities equally | 80% effort on P0, 15% on P1, 5% on P2 |
| Vague exit criteria ("high quality") | Exact numbers: P0 pass, P1 ≥ 95%, no Critical bugs |
| No risk assessment | Cost of failure drives testing depth |
| Skip test planning for small features | Even 1-page plan aligns expectations |
| Plan in isolation | Review plan with dev + PM before executing |

## Time Budget
| Feature Count | Scope | Effort Estimate | Write Plan | Review | Total |
|--------------|-------|----------------|-----------|--------|-------|
| 1-3 (small) | 10 min | 10 min | 20 min | 10 min | 50 min |
| 4-8 (medium) | 20 min | 20 min | 40 min | 15 min | 1.5 hr |
| 9+ (large) | 30 min | 30 min | 1 hr | 20 min | 2.25 hr |

## Done
- Test plan document (scope, priorities, effort, exit criteria, risks)
- Risk assessment documented
- Exit criteria with quantitative thresholds
- Effort estimate with breakdown
- Plan reviewed with dev + PM

→ Next: `02-test-case-development.md`
Exit criteria disagreement? Resolve with PM before writing cases.
