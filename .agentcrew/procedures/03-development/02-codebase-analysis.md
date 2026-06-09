# Codebase Analysis

## Need
- Existing project repo (checked out, up to date)
- Change description (sprint task, feature spec, or bug report)
- Tech stack knowledge (language, framework, DB, infra)

## Instructions

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
```

- [ ] Identify 2-3 reference files that match the task
- [ ] Document: naming conventions, error handling pattern, testing style, imports pattern
- [ ] Note what the codebase does WELL (follow that) and what it does POORLY (don't copy)

### 3. Insertion Point Analysis

- [ ] List exact files to create and files to modify
- [ ] For each modified file: what changes? (add function, add import, add route)

### 4. Dependency Map

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

→ Next: `04-implementation.md`
Breaking changes? Flag to design review first. Blocking dependency? Wait, don't start.
