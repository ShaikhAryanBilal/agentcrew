# Test Case Development

## Need
- Test plan (scope, priorities, exit criteria)
- PRD with acceptance criteria
- API contracts (OpenAPI spec)
- UI mockups (if UI changes)

## Decision Tree

```
What type of test?
├── Functional (API) → Input → Action → Expected output. One endpoint per test group.
├── Functional (UI) → Screen → Action → Expected state change. One screen per test group.
├── Integration → Components → Interaction → Expected result. One flow per test.
└── Security → Vector → Target → Expected protection. One vulnerability per test.

Is this a P0 test?
├── Yes → Write detailed steps + expected results. Must be reproducible by anyone.
└── P1/P2 → Can be high-level. Skips steps OK if domain expert executes.

Is test automatable?
├── Yes → Flag for automation. Write as code test (Jest/Pytest) not manual steps.
└── No → Written as manual test case. Include exact steps, test data, expected screenshots.
```

## Do

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

Test Data:
  - invoices: [ paid, pending, cancelled ]
  - date range: last 30 days

Steps:
  1. Send GET /api/v1/invoices/export?format=csv
     Headers: Authorization: Bearer <token>
  2. Verify response status: 200
  3. Verify Content-Type: text/csv
  4. Verify Content-Disposition: attachment; filename="invoices.csv"
  5. Parse CSV body
  6. Verify header row: invoice_id,number,customer,amount,status,due_date
  7. Verify all 3 invoices present in rows
  8. Verify data matches DB for each invoice

Expected Result:
  - Response 200 with valid CSV file
  - CSV contains correct headers and data
  - No PII exposed (customer names not included if spec says so)
```

- [ ] Every test has: ID, priority, type, linked requirement, preconditions, steps, expected result
- [ ] P0 tests have explicit test data (not "use any data")
- [ ] P0 tests are repeatable (same data, same environment, same result)

### 2. Coverage Map

```markdown
| Requirement | Test Case(s) | P0 | Automated |
|-------------|-------------|-----|-----------|
| FR-001: Invoice model | TC-010, TC-011, TC-012 | Yes | Yes |
| FR-003: CSV Export | TC-001, TC-002, TC-003, TC-004 | Yes | Yes |
| FR-005: Email invoice | TC-020, TC-021 | No | No (manual) |
```

- [ ] Every P0 requirement has at least 1 test case
- [ ] Every requirement has at least 1 test case (P1 = nice to have)
- [ ] No orphan test cases (every test maps to a requirement)

### 3. Test Case Patterns Per Type

**API Endpoint — checklist per endpoint:**

```markdown
For each endpoint:

☐ Valid request → 2xx + correct response body
☐ Invalid input (missing field) → 4xx + validation error
☐ Invalid input (wrong type) → 4xx + validation error
☐ Invalid input (boundary value) → 4xx or correct handling
☐ Unauthenticated → 401
☐ Unauthorized (wrong role) → 403
☐ Not found → 404
☐ Rate limit exceeded → 429
☐ Internal error → 500 (no stack trace in response)
```

**UI Screen — checklist per screen:**

```markdown
For each screen:

☐ Loading state renders
☐ Empty state renders (no data)
☐ Error state renders (API failure)
☐ Data state renders correctly
☐ User interaction works (click, type, navigate)
☐ Keyboard navigation works
☐ Error messages shown for invalid input
☐ Responsive: desktop, tablet, mobile
```

**Integration — checklist per integration point:**

```markdown
For each component boundary:

☐ Service A → Service B: valid input flows through correctly
☐ Service B returns error → Service A handles it gracefully
☐ Timeout in Service B → Service A times out with clean error
☐ Service B down → Service A returns 503, not 500
```

### 4. Review Gates

- [ ] Dev reviews test cases for accuracy (does the behavior match spec?)
- [ ] PM reviews test cases for coverage (are all requirements tested?)
- [ ] Review outcome: no gaps, no incorrect expectations, no ambiguous steps
- [ ] If test case expects different behavior than code → spec is wrong OR code is wrong. Resolve before testing.

### 5. Output Format

```
TEST CASE SUITE — Invoice Export Feature (v1.0)
Total: 35 test cases (P0: 12, P1: 18, P2: 5)
Automated: 22 (63%) | Manual: 13

| ID | Description | Priority | Type | Automated | Requirement |
|----|-------------|----------|------|-----------|-------------|
| TC-001 | Export CSV successfully | P0 | API | Yes | FR-003 |
| TC-002 | Export with date filter | P0 | API | Yes | FR-003 |
| TC-003 | Export with no invoices | P1 | API | Yes | FR-003 |
| TC-004 | Export unauthorized | P0 | API | Yes | NFR-002 |
| ... | ... | ... | ... | ... | ... |

Coverage: 12/12 requirements covered (100%)
```

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

## Next → `03-functional-testing.md`
Coverage gaps? Add cases before starting execution.
