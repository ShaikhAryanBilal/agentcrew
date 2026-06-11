# Unit Testing

## Need
- Implementation code (on feature branch, before merge)
- Tech spec (expected behavior, edge cases, error conditions)
- Test patterns from codebase analysis (framework, naming, structure)

## Instructions

### 1. Test Structure

```
tests/
  unit/
    invoice-service.test.ts    — mirrors src/services/invoice-service.ts
  integration/
    invoice-api.test.ts        — tests endpoint with real DB
  fixtures/
    invoice-data.ts            — shared test data
```

- [ ] Match existing test directory layout
- [ ] Test file = source file path + `.test.` suffix
- [ ] Fixtures in separate files, reused across tests

### 2. What to Test Per Function

- [ ] Every function gets: happy path, error paths, boundary/edge cases
- [ ] File format matters: test file encoding, line endings if platform-specific
- [ ] Don't test what you can't break (trivial getters, framework internals, third-party)

### 3. Test Patterns

Follow the Arrange-Act-Assert pattern:
```typescript
describe('InvoiceService', () => {
  describe('createInvoice', () => {
    it('creates invoice when all fields valid', async () => {
      // Arrange
      // Act
      // Assert
    })
  })
})
```

### 4. Mocking Rules

```
Mock external, use real internal:
  ✅ Mock: DB repo, HTTP client, file system, message queue
  ❌ Mock: Your own services/classes (inject real instances)
```

### 5. Coverage

```
Target: 80%+ on new/changed code
What counts: lines executed, branch coverage, error paths
What doesn't: boilerplate, generated code, dead code paths
```

### 6. Test Isolation

- [ ] Each test is independent (order doesn't matter)
- [ ] No shared mutable state between tests
- [ ] beforeEach/afterEach resets state
- [ ] Tests use in-memory data, not shared DB
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

## Done
- Test suite using project's test framework and patterns
- Happy path + error paths + edge cases covered per function
- Tests independent, no shared mutable state
- Test names describe behavior (not implementation)
- CI passes all tests
- Coverage ≥ 80% on new code

→ Next: `07-integration.md`
Tests fail? Fix code or fix test (test might be wrong), re-run. Flaky? Investigate and fix.
