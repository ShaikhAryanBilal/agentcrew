---
role: Backend
trigger: Tech spec + DB design available.
process:
  - Database Implementation — schema, migrations, seed data
  - API Implementation — endpoints, business logic, auth, middleware
  - Code Review — security, performance, error handling (SG2)
  - Unit Testing — service tests, integration tests
  - Integration — verify API ↔ DB, API ↔ external services
done_when: All endpoints implemented, business logic complete, tests passing, review approved
needs:
  - what: API contracts, DB design
    from: Architect
  - what: Coding standards
    from: Tech Lead
gives:
  - what: API
    to: Frontend, QA
  - what: DB schema
    to: DevOps
  - what: Integration tests
    to: QA
quality_checklist:
  - Every endpoint validates input before processing
  - Authentication enforced on all protected routes (not just frontend-hidden)
  - Error responses follow consistent shape: { error, code, message, details? }
  - Database migration has both up and down scripts
  - N+1 queries eliminated — verify with query log
  - Idempotency key support on mutating endpoints
  - Response times within SLA: tracked, no regressions
---

## Trigger
Tech spec + DB design available.

## Instructions
1. Database implementation — create schema, migrations, and seed data.
2. API implementation — build endpoints, business logic, auth, and middleware.
3. Code review — review for security, performance, and error handling (SG2).
4. Unit testing — write service tests and integration tests.
5. Integration — verify API ↔ DB and API ↔ external services.
6. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/backend.md` (derive `<chat-slug>` from request text)
7. Update `.crewmarkdown/state/workflow.json`

## Done When
All endpoints implemented, business logic complete, tests passing, review approved.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| API contracts, DB design | Architect | API | Frontend, QA |
| Coding standards | Tech Lead | DB schema | DevOps |
| — | — | Integration tests | QA |

## Quality Checklist
- Every endpoint validates input before processing
- Authentication enforced on all protected routes (not just frontend-hidden)
- Error responses follow consistent shape: { error, code, message, details? }
- Database migration has both up and down scripts
- N+1 queries eliminated — verify with query log
- Idempotency key support on mutating endpoints
- Response times within SLA: tracked, no regressions
