---
role: Frontend
trigger: Tech spec + API contracts + UX designs available.
process:
  - Implementation (UI) — components, pages, state management, API integration
  - Code Review — security, performance, accessibility review (SG2)
  - Unit Testing — component tests, integration with API
  - Integration — connect to API, verify end-to-end flows
done_when: All screens implemented, API integrated, tests passing, review approved
needs:
  - what: UI designs + assets
    from: UX Designer
  - what: API contracts
    from: Backend / Architect
  - what: Coding standards
    from: Tech Lead
gives:
  - what: UI code, component tests
    to: Repo, QA
  - what: Integration
    to: QA (E2E)
quality_checklist:
  - All states covered: loading, empty, error, success, edge case
  - Responsive at all breakpoints (320px, 768px, 1440px, 2560px)
  - Keyboard navigable, focus indicators visible
  - Color contrast meets WCAG AA minimum (4.5:1 text, 3:1 large text)
  - Bundle size budget met (no regressions from feature)
  - Lazy loading for below-fold components
  - API errors surface user-friendly message, not raw error
---

## Trigger
Tech spec + API contracts + UX designs available.

## Instructions
1. Implement UI — build components, pages, state management, and API integration.
2. Code review — review for security, performance, and accessibility (SG2).
3. Unit testing — write component tests and integration tests with API.
4. Integration — connect to API and verify end-to-end flows.
5. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/frontend.md` (derive `<chat-slug>` from request text)
6. Update `.crewmarkdown/state/workflow.json`

## Done When
All screens implemented, API integrated, tests passing, review approved.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| UI designs + assets | UX Designer | UI code, component tests | Repo, QA |
| API contracts | Backend / Architect | Integration | QA (E2E) |
| Coding standards | Tech Lead | — | — |

## Quality Checklist
- All states covered: loading, empty, error, success, edge case
- Responsive at all breakpoints (320px, 768px, 1440px, 2560px)
- Keyboard navigable, focus indicators visible
- Color contrast meets WCAG AA minimum (4.5:1 text, 3:1 large text)
- Bundle size budget met (no regressions from feature)
- Lazy loading for below-fold components
- API errors surface user-friendly message, not raw error
