---
extends: ../workflow.md
role: Backend/API-Express
trigger: Route contracts + DB design + service interface available.
process:
  - Scaffold — Express app, middleware stack, error handler
  - Routes — per-resource Router, validation middleware, controller
  - Database — Prisma schema, migrations, service layer
  - Auth — JWT middleware, role guards, error on missing/invalid token
  - Error handling — centralized error middleware, AppError class
  - Testing — supertest integration tests per route
  - Docs — swagger-jsdoc + swagger-ui
done_when: All routes implemented, auth enforced, tests passing, OpenAPI docs auto-generated
needs:
  - what: Route contracts + DB design
    from: Architect
  - what: Service-layer interface
    from: Tech Lead
  - what: Coding standards
    from: Tech Lead
gives:
  - what: Express API endpoints + middleware
    to: Frontend, QA
  - what: DB schema + migrations
    to: DevOps
  - what: Integration tests + OpenAPI spec
    to: QA, Frontend
quality_checklist:
  - Every route has zod/Joi validation on params + body + query
  - Auth middleware on all protected routes — integration test confirms 401 for unauthenticated
  - Standard error shape: { error, message, requestId } — no stack traces
  - All DB queries use parameterized input — no string interpolation
  - Rate limiting on public endpoints
  - OpenAPI spec at /docs reflects actual routes (verify with test)
  - Logs include request ID and user ID for every request
---

## Trigger
Route contracts + DB design + service interface available.

## Instructions
1. Scaffold — create Express app, compose middleware stack (security headers, body parsing, logging, auth, routes, error handler), configure CORS.
2. Routes — one Router per resource. Mount at `/api/v1/resource`. Apply validation middleware. Wire controller.
3. Database — define Prisma schema from DB design, generate migrations, create service layer, configure connection pool.
4. Auth — JWT verification middleware on protected routes. Role-based guard middleware for admin-only endpoints.
5. Error handling — AppError class with status + code + message. Error middleware catches and returns structured JSON.
6. Testing — supertest for each route: happy path + validation error + auth error + not found. nock for external HTTP calls.
7. OpenAPI — annotate routes with swagger-jsdoc, mount swagger-ui-express at `/docs`.
8. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/backend-api-express.md`
9. Update `.crewmarkdown/state/workflow.json`

## Done When
All routes implemented, auth enforced, tests passing, OpenAPI docs auto-generated.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Route contracts + DB design | Architect | Express API endpoints + middleware | Frontend, QA |
| Service-layer interface | Tech Lead | DB schema + migrations | DevOps |
| Coding standards | Tech Lead | Integration tests + OpenAPI spec | QA, Frontend |

## Quality Checklist
- Every route has zod/Joi validation on params + body + query
- Auth middleware on all protected routes — integration test confirms 401 for unauthenticated
- Standard error shape: { error, message, requestId } — no stack traces
- All DB queries use parameterized input — no string interpolation
- Rate limiting on public endpoints
- OpenAPI spec at /docs reflects actual routes (verify with test)
- Logs include request ID and user ID for every request
