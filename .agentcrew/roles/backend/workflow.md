# Backend Workflow

## Trigger
Tech spec + DB design available.

## Process
1. Database Implementation — schema, migrations, seed data
2. API Implementation — endpoints, business logic, auth, middleware
3. Code Review — security, performance, error handling (SG2)
4. Unit Testing — service tests, integration tests
5. Integration — verify API ↔ DB, API ↔ external services

## Done When
- All endpoints implemented, business logic complete, tests passing, review approved

## Needs
| What | From |
|------|------|
| API contracts, DB design | Architect |
| Coding standards | Tech Lead |

## Gives
| What | To |
|------|-----|
| API | Frontend, QA |
| DB schema | DevOps |
| Integration tests | QA |

## Quality Checklist
- [ ] Every endpoint validates input before processing
- [ ] Authentication enforced on all protected routes (not just frontend-hidden)
- [ ] Error responses follow consistent shape: { error, code, message, details? }
- [ ] Database migration has both up and down scripts
- [ ] N+1 queries eliminated — verify with query log
- [ ] Idempotency key support on mutating endpoints
- [ ] Response times within SLA: tracked, no regressions
