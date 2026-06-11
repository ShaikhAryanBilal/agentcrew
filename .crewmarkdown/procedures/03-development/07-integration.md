# Integration

## Need
- Feature branches passing code review (approved PRs)
- All unit tests passing on feature branches
- CI pipeline configured and working
- Main branch in deployable state

## Instructions

### 1. Pre-Merge Checks

- [ ] CI green on feature branch? If red, author must fix first.
- [ ] PR approved? (code review passed, blocking comments resolved)
- [ ] Branch up-to-date with main? (rebased or merged latest main)
- [ ] SG2 check passed? (SAST + secret scan + dependency scan clean)
- [ ] No merge conflicts? If conflicts → rebase and re-review conflicted areas

### 2. Merge Strategy

| Strategy | When | How |
|----------|------|-----|
| Squash merge | Single-commit feature | `git merge --squash feature-branch` |
| Rebase merge | Multiple meaningful commits | `git rebase main && git merge` |
| Merge commit | Complex changes, preserve history | `git merge --no-ff feature-branch` |

Default: squash merge for simple features, rebase for multi-commit branches.

- [ ] Choose strategy based on branch history
- [ ] Merge in dependency order (if feature A depends on B, merge B first)
- [ ] After merge: verify main is still green

### 3. CI Pipeline

Pipeline stages (in order):
```
1. Lint → Block. Fix formatting/style issues.
2. Type-check → Block. Fix type errors.
3. Unit tests → Block. Fix failing tests.
4. Build → Block. Fix compilation.
5. SAST scan → Block. Fix security issue.
6. Secret scan → Block. Rotate leaked secret.
7. Dependency scan → Block or accept.
8. Integration tests → Block. System-level failure.
9. Artifact build → Block. Can't deploy.
```

- [ ] All stages must pass for CI to be green
- [ ] No manual skip of CI stages (except dep scan acceptance)
- [ ] CI time target: < 10 minutes for full pipeline

### 4. Integration Tests

| Test | What it checks | Example |
|------|---------------|---------|
| Component interaction | Service A → Service B | invoice service calls payment service |
| API contract | Request → response matches spec | POST /invoices returns 201 |
| DB integration | Schema, queries, migrations | migration runs, data round-trips |
| Auth integration | Login → token → protected endpoint | valid token 200, expired 401 |
| Error propagation | Error in A → correct error in API | payment timeout → 503 |

- [ ] Run integration tests against real dependencies
- [ ] Use testcontainers or Docker Compose for ephemeral test environments
- [ ] Each test requires: setup → execute → assert → teardown (no test pollution)

### 5. Regression Check

- [ ] Run existing test suite (unit + integration): no regressions
- [ ] Manual smoke test of critical flows (if automated coverage is thin)
- [ ] Compare performance: if change affects hot path, run perf comparison

### 6. Version Tagging

```
Version format: semantic versioning (MAJOR.MINOR.PATCH)
When to bump: MAJOR (breaking API), MINOR (new feature, backward compatible), PATCH (bug fix)
Tagging: git tag v1.2.3 && git push origin v1.2.3
```

- [ ] Tag the merge commit, not a branch
- [ ] Update CHANGELOG.md

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Merge into red main | Fix main first. Never stack on broken. |
| Skip CI because "it's a small change" | Small changes break things too. CI always. |
| Deploy from a branch | Merge to main, tag, deploy from tag. |
| Manual integration steps | Every step automated. No "click deploy" by hand. |
| Ignore flaky integration tests | Fix or disable. Red CI is always broken. |

## Time Budget
| Branches | Pre-merge | CI run | Integration tests | Tagging | Total |
|----------|-----------|--------|------------------|---------|-------|
| 1 branch, simple | 5 min | 5-10 min | 5 min | 5 min | 20 min |
| 2-3 branches | 15 min | 10 min | 15 min | 5 min | 45 min |
| 4+ branches (staging) | 30 min | 15 min | 30 min | 5 min | 1.25 hr |

## Done
- Feature branch(es) merged to main
- CI pipeline green (lint → type-check → unit tests → build → scans → integration tests)
- No regressions (existing tests + smoke tests pass)
- Build artifact created (Docker image, binary, or package)
- Version tag applied
- CHANGELOG updated

→ Next: `04-qa/01-test-planning.md`
CI red? Fix or revert merge. Regression found? Investigate and rollback if critical.
