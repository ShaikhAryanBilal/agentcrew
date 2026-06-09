# Unit Testing

## Need
- Implementation code (on feature branch, before merge)
- Tech spec (expected behavior, edge cases, error conditions)
- Test patterns from codebase analysis (framework, naming, structure)

## Decision Tree

```
Is this new code or testing existing code?
├── New code → Test-first (TDD) for complex logic. Test-after for simple.
└── Existing code → Only test if you touch it. Bug fix → add test for bug scenario.

What type of code?
├── Pure logic (functions, transformations) → Thorough unit tests. Easy to cover.
├── I/O (DB, API, file) → Integration test. Unit test only the boundary (mock I/O).
└── UI component → Component/snapshot test. Test user interaction, not internals.

Coverage gap?
├── New code → Target 80%+ on new code
└── Existing uncovered code → Leave it. Don't add tests for untouched code.
```

## Do

### 1. Test Structure

```
tests/
  unit/
    invoice-service.test.ts    — mirrors src/services/invoice-service.ts
    export-service.test.ts
  integration/
    invoice-api.test.ts        — tests endpoint with real DB
  fixtures/
    invoice-data.ts            — shared test data
```

- [ ] Match existing test directory layout
- [ ] Test file = source file path + `.test.` suffix
- [ ] Fixtures in separate files, reused across tests

### 2. What to Test Per Function

```typescript
// Function: generateCsv(invoices: Invoice[], format: 'simple' | 'detailed'): string

Tests needed:
  ✅ Happy: generates CSV with correct columns for 'simple' format
  ✅ Happy: generates CSV with correct columns for 'detailed' format
  ✅ Edge: empty invoices list → returns header only
  ✅ Edge: single invoice → single row
  ✅ Edge: invoice with special characters (commas, quotes) → properly escaped
  ✅ Error: null invoices → throws ValidationError
  ✅ Error: unknown format → throws ValidationError
  ✅ Edge: very long text fields → truncated? (document behavior)
```

- [ ] Every function gets: happy path, error paths, boundary/edge cases
- [ ] File format matters: test file encoding, line endings if platform-specific
- [ ] Don't test what you can't break (trivial getters, framework internals, third-party)

### 3. Test Template

```typescript
// Follow the Arrange-Act-Assert pattern
describe('InvoiceService', () => {
  describe('createInvoice', () => {
    it('creates invoice when all fields valid', async () => {
      // Arrange
      const input = validInvoiceInput()
      const repo = mockInvoiceRepo()
      const service = new InvoiceService(repo)

      // Act
      const result = await service.createInvoice(input)

      // Assert
      expect(result).toMatchObject({
        status: 'pending',
        amount: 100,
        customerId: 'uuid'
      })
      expect(repo.save).toHaveBeenCalledTimes(1)
    })

    it('throws ValidationError when amount is negative', async () => {
      const input = { ...validInvoiceInput(), amount: -1 }
      const service = new InvoiceService(mockInvoiceRepo())

      await expect(service.createInvoice(input)).rejects.toThrow(ValidationError)
    })
  })
})
```

### 4. Mocking Rules

```
Mock external, use real internal:
  ✅ Mock: DB repo, HTTP client, file system, message queue
  ❌ Mock: Your own services/classes (inject real instances)

Mock setup:
  // Good — mock interface, inject into constructor
  const repo = new MockInvoiceRepo()
  repo.find.mockResolvedValue([invoice])
  const service = new InvoiceService(repo)

  // Bad — mock the entire service (tests nothing)
  jest.mock('./invoice-service')
  const service = new InvoiceService()
```

### 5. Coverage

```
Target: 80%+ on new/changed code

What counts:
  ✅ Lines executed at least once
  ✅ Branch coverage (both if/else paths)
  ✅ Error paths

What doesn't count:
  ❌ Lines that are pure boilerplate (getters, simple delegation)
  ❌ Generated code
  ❌ Dead code paths

Check coverage:
  npm test -- --coverage
  pytest --cov=src
  go test -coverprofile=coverage.out
```

### 6. Test Isolation

- [ ] Each test is independent (order doesn't matter)
- [ ] No shared mutable state between tests
- [ ] beforeEach/afterEach resets state
- [ ] Tests use in-memory data, not shared DB (use testcontainers or transaction rollback)
- [ ] Random data: use deterministically-seeded faker, not truly random

### 7. CI Integration

- [ ] Tests run in CI on every push
- [ ] Tests must pass before merge
- [ ] Flaky tests are disabled or fixed immediately (don't ignore)
- [ ] Test failure = CI red. No exception.

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Test implementation details | Test public behavior. Refactoring shouldn't break tests. |
| One test per function | Multiple scenarios per function (happy, error, edge) |
| Mock everything | Mock external deps only. Use real instances for internal code. |
| Flaky tests ("sometimes passes") | Fix flakiness. CI red means broken. |
| 100% coverage requirement | 80% on new code. Quality > quantity. |
| Test the framework | Don't test that Express calls your handler. Test your handler. |

## Time Budget

| Code Size | Happy Tests | Error Tests | Edge Cases | Total |
|-----------|------------|-------------|------------|-------|
| Small (1-2 functions) | 10 min | 10 min | 10 min | 30 min |
| Medium (3-6 functions) | 20 min | 20 min | 15 min | 55 min |
| Large (7+ functions) | 40 min | 30 min | 25 min | 1.5 hr |

Test time should be ~40-50% of implementation time. If tests take longer, implementation is too complex.

## Done
- Test suite using project's test framework and patterns
- Happy path + error paths + edge cases covered per function
- Tests independent, no shared mutable state
- Test names describe behavior (not implementation)
- CI passes all tests
- Coverage ≥ 80% on new code

## Next → `07-integration.md`
Tests fail? Fix code or fix test (test might be wrong), re-run. Flaky? Investigate and fix.
