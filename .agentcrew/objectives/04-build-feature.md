# Objective: Build Feature

## Goal
Implement, review, unit test, and integrate working code for a feature according to the approved design and coding standards.

## Squad
| Role | Responsibility |
|------|---------------|
| Frontend Developer | UI implementation, component tests |
| Backend Developer | API, services, data layer, business logic |
| Full Stack Developer | End-to-end implementation (both FE + BE) |
| Tech Lead | Code review, standards enforcement, merge approval |

**Note**: Assign specific developer role(s) based on feature scope. Not all dev roles are needed for every feature.

## Schedule
```
Dev:  Codebase Analysis ──> Implementation ──> (self-review) ──> PR
                                                                ↓
Tech Lead:                                           Code Review ──> Merge
                                                                ↓
Dev:                                              Unit Tests ──> Integration
```

**Sequential**: Analysis → Implementation → Review → Unit tests → Integration.  
**Parallel**: Frontend + Backend can work simultaneously on separate concerns.

## Dependencies
- **Needs**: Approved design, coding standards, sprint plan
- **Blocks**: Verify Quality
- **Also needs**: Codebase-map.md for context (if existing project)

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| Dev | Codebase analysis (insertion points, patterns) | Markdown |
| Dev | Implementation code | Source files |
| Dev | Unit tests (coverage ≥ 80%) | Test files |
| Dev | Integration tests (API, DB, auth) | Test files |
| Tech Lead | Code review comments | Markdown/PR |
| Tech Lead | Merge commit | Git |

## Acceptance
- Code follows coding standards (lint + format pass)
- All acceptance criteria from user stories met
- Unit test coverage ≥ 80%
- Integration tests pass
- Code review: all 🔴 items resolved, 🟡 items acknowledged
- SG2 gate: SAST + secret scan + dep scan clean
- Feature branch merged to main

## Procedure References
- Dev: `procedures/03-development/02-codebase-analysis.md` (context gathering)
- Dev: `procedures/03-development/04-implementation.md` (implementation order)
- Tech Lead: `procedures/03-development/05-code-review.md` (review checklist)
- Dev: `procedures/03-development/06-unit-testing.md` (test patterns)
- Dev: `procedures/03-development/07-integration.md` (merge + CI)

## Security Gates
- **SG2**: Before merge to main — SAST, secret detection, dependency scan must pass

## Debate Triggers
- Implementation approach (library choice, pattern) → Tech Lead facilitates debate
- Test strategy (unit vs integration focus) → debate/trigger
- Refactor vs. build new → Tech Lead + Architect debate

## Solo Invocation
- "Frontend Dev, implement the [component] UI" → FE implements, reviews, tests
- "Backend Dev, implement the [endpoint] API" → BE implements, reviews, tests
- "Tech Lead, review PR #[num]" → Tech Lead reviews only
- "Dev, write unit tests for [module]" → Dev writes tests only
