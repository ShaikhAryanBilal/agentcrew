# Build Feature

## System
You are executing objective: Build Feature. Implement, review, unit test, and integrate working code for a feature according to approved design and coding standards.

## Instructions
1. Assemble squad: Frontend Developer, Backend Developer, Tech Lead, Technical Writer (assign based on feature scope; not all roles needed for every feature)
2. Dev runs codebase analysis to identify insertion points and patterns (procedures/03-development/02-codebase-analysis.md)
3. Dev implements code following coding standards (procedures/03-development/04-implementation.md); FE + BE work in parallel on separate concerns
4. Dev writes unit tests (coverage ≥ 80%) and integration tests
5. Dev opens PR; Tech Lead reviews (procedures/03-development/05-code-review.md)
6. Tech Lead merges after SG2 passes (SAST + secret scan + dep scan clean)
7. Dev runs integration (procedures/03-development/07-integration.md) to main
8. Technical Writer writes API reference docs and user guides
9. Verify acceptance criteria
10. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
11. Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| Frontend Developer | UI implementation, component tests |
| Backend Developer | API, services, data layer, business logic |
| Tech Lead | Code review, standards enforcement, merge approval |
| Technical Writer | API documentation, user-facing feature docs |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Approved design + codebase-map.md | Architect + existing project | Codebase analysis (insertion points, patterns) (Markdown) | Dev |
| Design + coding standards | Architect + Tech Lead | Implementation code (source files) | PR |
| Implementation | Dev | Unit tests (coverage ≥ 80%) (test files) | Dev |
| Implementation | Dev | Integration tests (API, DB, auth) (test files) | CI |
| Implementation + tests | Dev | Code review comments (Markdown/PR) | Tech Lead |
| Approved code | Tech Lead | Merge commit (Git) | Main branch |
| API + features | Dev + PRD | API reference docs / user guides (Markdown/OpenAPI) | Technical Writer |

## Acceptance
- Code follows coding standards (lint + format pass)
- All acceptance criteria from user stories met
- Unit test coverage ≥ 80%
- Integration tests pass
- Code review: all 🔴 items resolved, 🟡 items acknowledged
- SG2 gate: SAST + secret scan + dep scan clean
- Feature branch merged to main

## Gates
- **SG2**: Before merge to main — SAST, secret detection, dependency scan must pass

## Procedures
- Dev: `procedures/03-development/02-codebase-analysis.md`
- Dev: `procedures/03-development/04-implementation.md`
- Tech Lead: `procedures/03-development/05-code-review.md`
- Dev: `procedures/03-development/06-unit-testing.md`
- Dev: `procedures/03-development/07-integration.md`

## Debate Triggers
- Implementation approach (library choice, pattern) → Tech Lead facilitates
- Test strategy (unit vs integration focus) → debate/01-debate-trigger.md
- Refactor vs. build new → Tech Lead + Architect debate
