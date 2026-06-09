# Test Case Development

## Need
- Test plan (scope, priorities, exit criteria)
- PRD with acceptance criteria
- API contracts (OpenAPI spec)
- UI mockups (if UI changes)

## Instructions

### 1. Test Case Template

```markdown
TC-001: Export invoices as CSV successfully
Priority: P0
Type: Functional (API)
Requirement: FR-003 (CSV Export)
Automated: Yes

Preconditions:
  - At least 3 invoices exist in DB with varying statuses
  - User is authenticated with valid token

Steps:
  1. Send GET /api/v1/invoices/export?format=csv
  2. Verify response status: 200
  3. Verify Content-Type: text/csv
  4. ...

Expected Result:
  - Response 200 with valid CSV file
```

- [ ] Every test has: ID, priority, type, linked requirement, preconditions, steps, expected result
- [ ] P0 tests have explicit test data (not "use any data")
- [ ] P0 tests are repeatable (same data, same environment, same result)

### 2. Coverage Map

- [ ] Every P0 requirement has at least 1 test case
- [ ] Every requirement has at least 1 test case (P1 = nice to have)
- [ ] No orphan test cases (every test maps to a requirement)

### 3. Test Case Patterns Per Type

**API Endpoint — checklist per endpoint:**
☐ Valid request → 2xx + correct response body
☐ Invalid input (missing field) → 4xx + validation error
☐ Invalid input (wrong type) → 4xx + validation error
☐ Invalid input (boundary value) → 4xx or correct handling
☐ Unauthenticated → 401
☐ Unauthorized (wrong role) → 403
☐ Not found → 404
☐ Rate limit exceeded → 429
☐ Internal error → 500 (no stack trace in response)

**UI Screen — checklist per screen:**
☐ Loading state renders
☐ Empty state renders (no data)
☐ Error state renders (API failure)
☐ Data state renders correctly
☐ User interaction works (click, type, navigate)
☐ Keyboard navigation works
☐ Error messages shown for invalid input
☐ Responsive: desktop, tablet, mobile

**Integration — checklist per component boundary:**
☐ Service A → Service B: valid input flows through correctly
☐ Service B returns error → Service A handles it gracefully
☐ Timeout in Service B → Service A times out with clean error
☐ Service B down → Service A returns 503, not 500

### 4. Review Gates

- [ ] Dev reviews test cases for accuracy (does the behavior match spec?)
- [ ] PM reviews test cases for coverage (are all requirements tested?)
- [ ] If test case expects different behavior than code → spec is wrong OR code is wrong. Resolve before testing.

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Write test cases for obvious behavior | "Login with valid creds succeeds" — skip. Focus on edge cases. |
| One test case per requirement | Multiple scenarios: happy path, error path, edge case |
| Vague expected results ("should work") | Exact: "returns 200 with { status: 'pending' }" |
| Skip preconditions | Without setup steps, test can't be reproduced |
| Test cases that assume specific DB state | Document what data to set up or generate seeds |
| Write tests in isolation from dev | Review with dev. Catch wrong expectations early. |

## Time Budget
| Test Cases | Per case | Review | Total |
|-----------|----------|--------|-------|
| < 20 | 5-10 min | 15 min | 1.5-3 hr |
| 20-50 | 5-8 min | 30 min | 2-5 hr |
| 50+ | 3-5 min (batch similar cases) | 45 min | 3-5 hr |

## Done
- Test case suite (TC-xxx) with IDs, priorities, types, linked requirements
- Coverage map (every P0 requirement → at least 1 test case)
- Preconditions + test data documented for P0 cases
- Reviewed by dev (accuracy) + PM (coverage)

→ Next: `03-functional-testing.md`
Coverage gaps? Add cases before starting execution.
