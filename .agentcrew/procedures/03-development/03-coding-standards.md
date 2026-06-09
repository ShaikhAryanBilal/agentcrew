# Coding Standards

## Need
- Tech stack (language, framework, DB, infra)
- Existing codebase to derive conventions from (read 5 files)
- Team preferences (linter choices, formatting rules)

## Instructions

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
Files: kebab-case (TS), snake_case (Python/Rust/Go), PascalCase (Java)
Classes/Structs: PascalCase
Functions/Methods: camelCase (TS/JS/Java), snake_case (Python/Rust)
Variables: camelCase (TS/JS/Java), snake_case (Python/Rust)
Constants/Magic numbers: UPPER_SNAKE_CASE
Enums: PascalCase enum + UPPER_SNAKE_CASE values
Database: snake_case
Environment vars: UPPER_SNAKE_CASE
Booleans: prefix with is/has/should/can
Files exporting one thing: name matches export
```

- [ ] Document naming per type (files, classes, functions, variables, constants, DB, env)
- [ ] Existing project uses different naming? FOLLOW THE PROJECT

### 3. Function/File Boundaries

```
Function max length: 40 lines (>40 → extract helper)
File max length: 400 lines (>400 → split)
Parameters max: 3 positional (>3 → use options object)
Return type: always explicit
Early returns preferred over nested if/else
```

### 4. Error Handling

```
Pattern: Use language-native error handling
Rules:
  - Never swallow errors: if you catch, you log, wrap, or handle
  - Always wrap errors with context
  - Distinguish: programmer errors vs runtime errors
  - At service boundary: convert to public error type
  - At HTTP handler: catch-all → structured error response, log full, return generic
```

### 5. Testing Standards

```
Framework: whatever project already uses
Naming: test_{unit}_{condition}_{expected}
Coverage target: 80% on new/changed code
What to test: business logic, error paths, public API
What NOT to test: framework behavior, third-party libs, implementation details
What to mock: external services, database (at integration level)
What NOT to mock: internal modules (inject real instances when possible)
```

### 6. Commit Standards

```
Format: type(scope): description
Types: feat, fix, refactor, test, docs, chore, style, perf
Description: imperative, lowercase, no period, ≤ 50 chars
Body: explain WHY, not WHAT
```

### 7. Automation

| Tool | Config | Enforce In |
|------|--------|-----------|
| Formatter | .prettierrc / pyproject.toml | pre-commit + CI |
| Linter | .eslintrc / .flake8 | pre-commit + CI |

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
- Team agreed on standards

→ Next: (reference doc, consulted during implementation + review)
