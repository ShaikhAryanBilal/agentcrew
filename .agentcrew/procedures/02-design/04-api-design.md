# API Design

## Need
- API contracts from tech spec (endpoints, methods, request/response)
- Data models (entities and fields)
- User stories (to validate each endpoint covers the story)
- Error handling strategy

## Instructions

### 1. Endpoint Inventory

Group by resource/domain. Table per group.

```
### Invoices
| Method | Path | Auth | Rate Limit | Idempotent? | Page? |
|--------|------|------|-----------|-------------|-------|
| POST   | /api/v1/invoices | User | 30/min | Yes (key) | — |
| GET    | /api/v1/invoices | User | 60/min | Yes | Yes |
```

- [ ] Every user story maps to at least one endpoint
- [ ] No endpoint without a story justification
- [ ] Auth level defined per endpoint (public, user, admin, system)

### 2. Request/Response Schemas

- [ ] All field types, constraints, and descriptions documented
- [ ] Request/response examples for every endpoint
- [ ] Consistent error format across all endpoints
- [ ] Idempotency key supported for mutating endpoints

### 3. Error Response Format

```
Standard HTTP status codes:
200 OK — Success
201 Created — Resource created
400 Bad Request — Validation error
401 Unauthorized — No auth or invalid auth
403 Forbidden — Authenticated but not allowed
404 Not Found — Resource doesn't exist
409 Conflict — Duplicate, state conflict
429 Too Many Requests — Rate limit exceeded
500 Internal Server Error — Unexpected failure
503 Service Unavailable — Downstream dependency down
```

- [ ] Never return 500 with stack trace
- [ ] Never return 200 with error body — use correct status code
- [ ] Machine-readable error codes (not "An error occurred")

### 4. Pagination

- [ ] Pagination strategy documented per endpoint
- [ ] Default limit + max limit defined
- [ ] Cursor encoding: base64url (opaque to client)

### 5. Versioning

Strategy: URL path versioning (`/api/v1/`, `/api/v2/`)

When to bump version:
  - Removing a field, changing a field type, making required field optional (or vice versa), changing error response format

When NOT to bump:
  - Adding a field, adding a new endpoint, changing internal error messages

- [ ] Versioning strategy documented
- [ ] Deprecation policy documented
- [ ] Sunset header returned on deprecated endpoints

### 6. Webhooks (if applicable)

- [ ] Events defined with triggers and payload schema
- [ ] Retry + dead-letter policy
- [ ] Signature verification documented for consumers

### 7. OpenAPI Spec

- [ ] Write OpenAPI 3.0 spec for all endpoints
- [ ] Include: paths, methods, request schemas, response schemas, error responses, auth
- [ ] Spec is source of truth. If code and spec disagree, spec wins.

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| REST endpoints that do RPC (`/invoices/exportCSV`) | `GET /api/v1/invoices/export?format=csv` |
| Different error formats per endpoint | Single error format. Always. |
| Returning 200 with `{ error: "..." }` | Use correct HTTP status code |
| No rate limiting | Every endpoint gets a limit. Default: 60/min per user. |
| Endpoints that return different shapes | One endpoint, one response schema |
| Breaking changes without version bump | Version or don't break. No silent breakage. |

## Time Budget
| Endpoints | Schemas | OpenAPI | Total |
|-----------|---------|---------|-------|
| < 10 | 20 min | 20 min | 45 min |
| 10-20 | 40 min | 30 min | 1.25 hr |
| 20-30 | 1 hr | 45 min | 2 hr |

## Done
- Endpoint inventory with auth + rate limits per endpoint
- Request/response schemas with examples
- Consistent error format
- Pagination + versioning strategy
- Webhook spec (if applicable)
- OpenAPI 3.0 spec file
- Every user story covered by at least one endpoint

→ Next: `06-threat-modeling.md`
Missing endpoints? Revert to tech spec. API conflicts with existing system? Flag to architect.
