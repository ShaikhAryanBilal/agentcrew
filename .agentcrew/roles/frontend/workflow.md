# Frontend Workflow

## Trigger
Tech spec + API contracts + UX designs available.

## Process
1. Implementation (UI) — components, pages, state management, API integration
2. Code Review — security, performance, accessibility review (SG2)
3. Unit Testing — component tests, integration with API
4. Integration — connect to API, verify end-to-end flows

## Done When
- All screens implemented, API integrated, tests passing, review approved

## Needs
| What | From |
|------|------|
| UI designs + assets | UX Designer |
| API contracts | Backend / Architect |
| Coding standards | Tech Lead |

## Gives
| What | To |
|------|-----|
| UI code, component tests | Repo, QA |
| Integration | QA (E2E) |

## Quality Checklist
- [ ] All states covered: loading, empty, error, success, edge case
- [ ] Responsive at all breakpoints (320px, 768px, 1440px, 2560px)
- [ ] Keyboard navigable, focus indicators visible
- [ ] Color contrast meets WCAG AA minimum (4.5:1 text, 3:1 large text)
- [ ] Bundle size budget met (no regressions from feature)
- [ ] Lazy loading for below-fold components
- [ ] API errors surface user-friendly message, not raw error
