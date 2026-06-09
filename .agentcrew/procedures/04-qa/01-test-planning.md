# Test Planning

## Need
- PRD with success criteria + acceptance criteria
- Tech spec + API contracts
- Build artifact (deployed to staging)
- Risk assessment (what's the cost of failure?)

## Decision Tree

```
New feature vs existing?
├── New → Full test plan: functional + non-functional + security + regression
└── Bug fix → Targeted test plan: regression only + test the fix

Risk level?
├── High (auth, payments, PII, public-facing) → Full coverage, P0 mandatory pass
├── Medium (internal tool, non-critical) → Moderate coverage, P0 pass expected
└── Low (cosmetic, admin-only) → Light coverage, smoke test

Test automation exists?
├── Yes → Leverage automated suite, add manual for edge cases
├── Partial → Automate critical flows, manual for complex scenarios
└── No → Manual testing with detailed scripts. Plan automation investment.
```

## Do

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
- [ ] If out of scope → document why (not an explicit "test what makes sense")

### 2. Priority Matrix Per Feature

```
| Feature | P0 (must pass) | P1 (should pass) | P2 (nice to pass) |
|---------|---------------|------------------|------------------|
| CSV Export | Export succeeds with valid data | Export with filter, large dataset | Export progress indicator |
|             | Export fails gracefully on error |    | Cancel export in progress |
| Invoice CRUD | Create, read, update, delete | Batch operations | Soft delete |
| Payment | Payment succeeds, fails, refunds | Partial refund, timeouts | Multi-currency |
```

- [ ] Map requirements → test priority
- [ ] P0 = ship blocker. Must pass before release.
- [ ] P1 = important but has workaround. Must pass except documented exceptions.

### 3. Effort Estimate

```
Test estimation per feature:

| Feature | Test Cases | Automated | Manual | Setup | Total |
|---------|-----------|-----------|--------|-------|-------|
| CSV Export | 8 | 4h | 2h | 1h | 7h |
| Invoice CRUD | 15 | 6h | 3h | 2h | 11h |
| Payment | 12 | 8h | 4h | 3h | 15h |
| Total | 35 | 18h | 9h | 6h | 33h |
```

- [ ] Estimate per feature: test case count, automation time, manual time, setup time
- [ ] Add 20% buffer for unexpected issues
- [ ] If effort > dev time → scope is too broad. Cut P2.

### 4. Exit Criteria

```
Release criteria:

  Functional:
    ✅ All P0 test cases pass
    ✅ P1 pass rate ≥ 95%
    ✅ No Critical/High bugs open (any priority)

  Non-Functional:
    ✅ P95 response time ≤ target (from NFR)
    ✅ Error rate ≤ 1%
    ✅ Accessibility: no Critical violations

  Security (SG3):
    ✅ DAST no Critical/High findings
    ✅ Pentest no Critical/High findings
    ✅ Dependency scan: all Critical/High CVEs have fix or exception

  Coverage:
    ✅ Requirements coverage ≥ 90% (req → at least 1 test case)
    ✅ Code coverage ≥ 80% on new code
```

- [ ] Quantitative criteria only. No "should work well" — define what "well" means.
- [ ] Agreed with PM + Dev + QA before testing starts.

### 5. Output Format

```
TEST PLAN — Invoice Export Feature (v1.0)
Version: 1.0
QA Lead: [Name]
Date: 2026-06-08

Scope:
  In: Functional, Integration, Performance, Security
  Out: Accessibility (internal tool), UX review (no UI change)

Risk Level: Medium (financial data, but internal accounting tool)

Priorities:
  P0: 12 test cases — Critical flows (export works, payments process)
  P1: 18 test cases — Features with workarounds
  P2: 5 test cases — Edge cases, nice-to-haves

Effort Estimate: 33h (18h auto + 9h manual + 6h setup)
Timeline: Jun 9-12 (4 days, 1 QA)

Exit Criteria:
  - All P0 pass, P1 ≥ 95%, no Critical/High bugs
  - P95 < 2s, error rate < 1%
  - DAST no Critical/High, SG3 pass

Risks:
  - Payment service staging environment shared with other team — possible contention
```

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

## Next → `02-test-case-development.md`
Exit criteria disagreement? Resolve with PM before writing cases.
