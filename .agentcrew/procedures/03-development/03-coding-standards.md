# Coding Standards

## Need
- Tech stack (language, framework, DB, infra)
- Existing codebase to derive conventions from (read 5 files)
- Team preferences (linter choices, formatting rules)

## Decision Tree

```
Is this a new project or existing?
├── New → Define standards from scratch. Pick popular defaults.
└── Existing → DERIVE from codebase. Do NOT override existing style.

Do you have a linter/formatter config?
├── Yes → Standards are documented in config. This doc is reference only.
└── No → Define standards now. Automate enforcement ASAP.

Language-specific standards exist (PEP8, gofmt, Prettier)?
├── Yes → Use language standard + project overrides
└── No → Define custom rules
```

## Do

### 1. Language Standards

| Language | Standard | Enforcement |
|----------|----------|-------------|
| Python | PEP 8 + Black | flake8 + black |
| Go | gofmt + golangci-lint | gofmt check in CI |
| TypeScript | ESLint + Prettier | eslint --fix + prettier --check |
| Rust | rustfmt + clippy | cargo fmt --check + cargo clippy |
| Java | Google Java Style | checkstyle |
| C# | .NET built-in | dotnet format |

- [ ] Install + configure formatter
- [ ] Add format check to CI
- [ ] If existing code doesn't match formatter → format whole project in ONE commit, then enforce

### 2. Naming Conventions

```
Files:
  TypeScript: kebab-case (invoice-service.ts)
  Python: snake_case (invoice_service.py)
  Go: snake_case (invoice_service.go)
  Rust: snake_case (invoice_service.rs)
  Java: PascalCase (InvoiceService.java)

Classes/Structs: PascalCase (InvoiceService)
Functions/Methods: camelCase (TS/JS/Java), snake_case (Python/Rust)
Variables: camelCase (TS/JS/Java), snake_case (Python/Rust)
Constants/Magic numbers: UPPER_SNAKE_CASE (MAX_RETRY_COUNT)
Enums: PascalCase enum + UPPER_SNAKE_CASE values
Database: snake_case (invoice_id, created_at)
Environment vars: UPPER_SNAKE_CASE (DATABASE_URL)

Booleans: prefix with is/has/should/can
  ✅ isActive, hasPermission, shouldRetry, canExport
  ❌ active, permission, retry

Files exporting one thing: name matches export
  ✅ invoice-service.ts → class InvoiceService
  ❌ utils.ts → scattered exports
```

- [ ] Document naming per type (files, classes, functions, variables, constants, DB, env)
- [ ] Existing project uses different naming? FOLLOW THE PROJECT

### 3. Function/File Boundaries

```
Function max length: 40 lines
  If > 40 lines → extract helper functions
  Exception: mapping/transformation functions (data in → data out)

File max length: 400 lines
  If > 400 lines → split into multiple files by concern
  Exception: config files, generated code

Parameters max: 3 positional parameters
  If > 3 → use options object / struct parameter

Return type: always explicit
  TypeScript: function foo(): ReturnType { ... }
  Python: def foo() -> ReturnType: ...
  Go: func foo() ReturnType { ... }
  Rust: fn foo() -> ReturnType { ... }

Early returns preferred over nested if/else
  ✅ if (!user) return null
  ❌ if (user) { if (user.active) { ... } }
```

### 4. Error Handling

```
Pattern: Use language-native error handling

  Python: raise SpecificError("message") / try/except
  Go: return error / if err != nil { return fmt.Errorf("context: %w", err) }
  TypeScript: throw new AppError(code, message) / try/catch in handler
  Rust: Result<T, E> / .map_err(|e| ...)? or match

Rules:
  - Never swallow errors: if you catch, you log, wrap, or handle
  - Always wrap errors with context: "failed to create invoice: %w"
  - Distinguish: programmer errors (panic/assert) vs runtime errors (Result/Exception)
  - At service boundary: convert to public error type (AppError with code + message)
  - At HTTP handler: catch-all → structured error response, log full, return generic

Error types:
  Define a small set of project-wide error types (not unique error per function)
  typescript:
    class AppError extends Error {
      constructor(public code: string, message: string, public status: number = 500) {}
    }
    class NotFoundError extends AppError { constructor(msg: string) { super('NOT_FOUND', msg, 404) } }
```

### 5. Testing Standards

```
Framework: whatever project already uses (jest, pytest, go test, cargo test)

Naming: test_{unit}_{condition}_{expected}
  TypeScript: describe('InvoiceService') → it('creates invoice when valid input')
  Python: def test_create_invoice_when_valid_input():
  Go: func TestCreateInvoice_ValidInput(t *testing.T)

Coverage target: 80% on new/changed code
  Existing uncovered code: not required. Don't add tests for untouched code.

What to test:
  ✅ Business logic (pure functions, transformations, validations)
  ✅ Error paths and edge cases
  ✅ Public API of each module (input → output contract)
  ❌ Framework behavior (don't test that Express routes work)
  ❌ Third-party library behavior (don't test that TypeORM saves)
  ❌ Implementation details (test behavior, not internal state)

What to mock:
  ✅ External services (APIs, message queues, file systems)
  ✅ Database (at integration level; for unit tests, mock repo interface)
  ❌ Internal modules (inject real instances when possible)

Structure per test:
  // Arrange: set up inputs, mocks, state
  // Act: call the function under test
  // Assert: check output, side effects, error
```

### 6. Commit Standards

```
Format:
  type(scope): description

  feat(invoices): add CSV export endpoint
  fix(payment): handle null webhook payload
  refactor(export): extract CSV generation to service
  test(invoices): cover export edge cases
  docs(api): update export endpoint docs
  chore(deps): upgrade express to 4.18

Types: feat, fix, refactor, test, docs, chore, style, perf
Scope: module/component name (optional but preferred)
Description: imperative, lowercase, no period, ≤ 50 chars

Body:
  Explain WHY, not WHAT.
  WHAT should be obvious from the diff.
  If WHY is obvious from the subject line → no body needed.

  Good body:
    redis GET returns nil on cache miss, not empty string.
    Previous code treated nil as "cache empty", which is correct,
    but downstream expected empty string.
  
  Bad body:
    Added null check for redis response.
```

### 7. Automation

| Tool | Config | Enforce In |
|------|--------|-----------|
| Formatter | .prettierrc / pyproject.toml / rustfmt.toml | pre-commit + CI |
| Linter | .eslintrc / .flake8 / .golangci.yml | pre-commit + CI |
| Type checker | tsconfig.json / mypy.ini | CI |
| Import sorter | isort / eslint-plugin-import | pre-commit |
| Secret scanner | detect-secrets / trufflehog | CI |
| Dependency audit | npm audit / cargo audit / pip-audit | CI |

- [ ] Set up pre-commit hooks (format + lint)
- [ ] All tools must pass in CI before merge
- [ ] Config files committed to repo (not IDE-dependent)

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Override existing codebase style | Derive from existing code. Consistency > purity. |
| Enforce rules not caught by automation | Unenforceable rules will be ignored. Automate or don't have the rule. |
| 100% test coverage requirement | 80% on new code. Focus on logic, not boilerplate. |
| Bike-shed naming | Pick one, enforce with linter. Move on. |
| Standards doc > 2 pages | Short enough to read. Details live in linter config. |

## Time Budget

| Project | Derive from codebase | Write doc | Configure tools | Total |
|---------|---------------------|-----------|----------------|-------|
| New project | 0 min | 1 hr | 30 min | 1.5 hr |
| Existing project (no standards) | 30 min | 30 min | 1 hr | 2 hr |
| Existing project (has linter) | 15 min | 15 min | 0 min | 30 min |

## Done
- Coding standards document (naming, function/file boundaries, error handling, testing, commits)
- Linter/formatter config files committed
- Pre-commit hooks configured
- CI checks added (format, lint, type-check, audit)
- Team agreed on standards (no surprises during review)

## Next → (reference doc, consulted during implementation + review)
Update as team learns. Major tooling changes should be PR'd and reviewed.
