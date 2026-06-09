# Codebase Analysis

## Need
- Existing project repo (checked out, up to date)
- Change description (sprint task, feature spec, or bug report)
- Tech stack knowledge (language, framework, DB, infra)

## Decision Tree

```
Is this the agent's first interaction with the project?
├── Yes → Full analysis: map entire project structure, identify patterns
└── No → Delta analysis: what changed since last session?

What type of change?
├── New feature → Find insertion points + existing patterns to follow
├── Bug fix → Trace the bug's path: input → processing → output → where it breaks
├── Refactor → Map what calls what, find test coverage gaps, identify risky deps
└── Dependency upgrade → Check breaking changes in changelog + test affected areas

Is codebase-map.md up-to-date?
├── Yes (generated within last session) → Use it. Skip directory scan.
├── No (stale or missing) → Regenerate. Run script.
└── No script exists → Manual scan (see Do section 1)
```

## Do

### 1. Project Map

- [ ] Run codebase map script if available: `.\.agentcrew\scripts\generate-codebase-map.ps1`
- [ ] If no script, manual scan:
  ```
  Top-level directory structure
  Entry point(s): main.rs, main.py, src/index.tsx, etc.
  Config files: package.json, Cargo.toml, pyproject.toml, tsconfig.json, Dockerfile
  Test directory: tests/, __tests__/, spec/
  CI config: .github/workflows/, .gitlab-ci.yml, Jenkinsfile
  ```

### 2. Pattern Discovery

Read 2-3 existing files similar to what you're implementing. Extract:

```
Pattern: API handler
  File: src/routes/invoices.ts
  Structure:
    import { Router } from 'express'
    const router = Router()
    router.get('/', handler)
    export default router
  
  Error handling:
    try/catch → next(error)
    Error type: AppError with code, status, message
    No direct res.send in catch — always next(error)

Pattern: Repository/DB access
  File: src/repos/invoice-repo.ts
  Uses: TypeORM
  Methods: findAll, findById, create, update, softDelete
  Pattern: class-based, injected via constructor

Pattern: Test
  File: tests/invoices.test.ts
  Framework: Jest
  Structure: describe('Invoices') → it('returns 200 when ...')
  Mocks: jest.mock() for external deps
  Setup: beforeAll creates DB fixtures
```

- [ ] Identify 2-3 reference files that match the task
- [ ] Document: naming conventions, error handling pattern, testing style, imports pattern
- [ ] Note what the codebase does WELL (follow that) and what it does POORLY (don't copy)

### 3. Insertion Point Analysis

```
Feature: CSV Export

Where does new code go?
├── New route file? → src/routes/exports.ts (follow invoices.ts pattern)
├── New service? → src/services/export-service.ts (follow invoice-service.ts pattern)
├── New repository? → src/repos/export-repo.ts (or extend existing?)
└── New DB table? → migrations/V00X__create_exports_table.sql

What changes to existing files?
├── src/routes/index.ts — register new route
├── src/entities/ — add Export entity (if DB-backed)
└── src/types/ — add export types
```

- [ ] List exact files to create and files to modify
- [ ] For each modified file: what changes? (add function, add import, add route)

### 4. Dependency Map

```
What does the new feature depend on?
├── Existing models/entities? → Check they have what you need
├── Existing services/APIs? → Verify contracts match
├── External libraries? → Check if already in project (package.json)
└── Existing DB tables? → Migration needed or reuse?

What depends on the new feature (if any)?
├── Future features that depend on this? → Note for design awareness
└── Breaking changes to existing interfaces? → Flag immediately
```

- [ ] Map upstream dependencies (what your code needs)
- [ ] Map downstream impacts (who needs your code)

### 5. Breaking Change Scan

- [ ] Check if change affects: shared types, public APIs, DB schemas, env vars
- [ ] For shared types: are other services consuming them?
- [ ] For DB schema: are there other services with direct DB access?
- [ ] For env vars: any consumer that reads the same config?
- [ ] For public APIs: any external consumers?

### 6. Security Scan (near change area)

- [ ] Change touches auth/permissions? → Check existing auth pattern
- [ ] Change touches user input? → Check existing validation pattern
- [ ] Change touches sensitive data? → Check if PII is handled
- [ ] Change introduces new external calls? → Check if timeout/retry exists

### 7. Output Format

```
CODEBASE ANALYSIS — Invoice CSV Export
Project: accounting-portal
Branch: main (commit: a1b2c3d)
Generated: 2026-06-08

Insertion Points:
  CREATE: src/services/export-service.ts       (follow invoice-service.ts)
  CREATE: src/routes/exports.ts                (follow invoices.ts)
  MODIFY: src/routes/index.ts                  (add router.use('/exports', ...))
  MODIFY: package.json                         (add csv-writer dependency)

Pattern References:
  Router: src/routes/invoices.ts:5-12          (pattern: class-based MVC)
  Service: src/services/invoice-service.ts     (pattern: constructor DI)
  Test: tests/invoices.test.ts:20-30           (pattern: describe/it/mock)

Dependencies:
  Existing: TypeORM, Express, jest
  New: csv-writer (npm package) — check compatibility

Breaking Changes: None

Security Notes:
  - Export endpoint needs auth check (same as list endpoint)
  - No PII in export? Yes — invoice amounts only, no customer names
  - Rate limit recommended (large export can be expensive)

Go: ✅ Ready for implementation
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Analyze every file in the project | Analyze only what's relevant to the change |
| Skip pattern discovery | Read 2-3 reference files. Save review time later. |
| Assume code follows best practices | The codebase has its own style. Follow it. |
| Forget about tests | Check test patterns BEFORE writing code |
| Ignore breaking changes | Flag early. Don't discover during PR. |

## Time Budget

| Project size | First analysis | Delta analysis | Pattern discovery | Total |
|-------------|---------------|---------------|-----------------|-------|
| Small (< 50 files) | 20 min | 5 min | 10 min | 35 min / 15 min |
| Medium (50-200 files) | 40 min | 10 min | 15 min | 1 hr / 25 min |
| Large (200+ files) | 1 hr | 20 min | 25 min | 1.75 hr / 45 min |

## Done
- `codebase-map.md` updated (or confirmed current)
- Insertion points identified (new files + modified files)
- Pattern references documented (2-3 files to follow)
- Dependency map (upstream + downstream)
- Breaking change scan (clean or flagged)
- Security notes for change area
- Go/no-go recommendation

## Next → `04-implementation.md`
Breaking changes? Flag to design review first. Blocking dependency? Wait, don't start.
