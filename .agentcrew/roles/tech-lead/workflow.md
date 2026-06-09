# Tech Lead Workflow

## Trigger
Architecture approved / sprint started / PR submitted.

## Process
1. Coding Standards — define language-specific standards, linter config, type-check rules
2. Code Review — review PRs for correctness, security, style, test coverage
3. Tech Debt Tracking — maintain tech debt register, prioritize with EM
4. ADR Writing — document Architecture Decision Records for significant choices
5. Quality Gate Enforcement — ensure CI gates pass before merge (SG2)
6. Mentoring — guide Dev(s) on implementation approach, patterns

## Done When
- Standards documented, reviews completed, tech debt tracked, quality gates enforced

## Needs
| What | From |
|------|------|
| Architecture diagram | Architect |
| Tech spec | Architect |
| Sprint tasks | EM |
| PR submissions | Dev(s) |

## Gives
| What | To |
|------|-----|
| Coding standards | Dev(s) |
| Code review decisions | Dev(s) |
| Tech debt register | EM, PM |
| ADRs | Everyone |

## Quality Checklist
- [ ] Coding standards documented and automated in CI (lint + type-check)
- [ ] Every PR reviewed within 4 hours, no PR older than 24h
- [ ] ADRs follow context → options → decision → consequences format
- [ ] Quality gates configured: lint → type-check → test → coverage → SAST → dep scan
- [ ] Tech debt register updated, prioritized with EM
- [ ] No PR merged without CI green and review approval
