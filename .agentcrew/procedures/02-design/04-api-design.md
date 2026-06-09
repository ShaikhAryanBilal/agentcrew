# API Design

## Need
- API contracts from tech spec (endpoints, methods, request/response)
- Data models (entities and fields)
- User stories (to validate each endpoint covers the story)
- Error handling strategy

## Decision Tree

```
Who consumes this API?
├── Public (external developers) → Version from day 1. Full docs. Deprecation policy.
├── Internal (own frontend) → Version when breaking change needed. Documented.
└── Internal (other backend services) → gRPC or REST, versioned.

Request volume per endpoint?
├── < 100/min → Standard REST. Rate limiting nice-to-have.
├── 100-1000/min → Rate limiting required. Caching beneficial.
└── 1000+/min → Rate limiting mandatory. Aggressive caching. Consider async.

Real-time needed?
├── Yes → WebSocket or Server-Sent Events
└── No → REST or gRPC
```

## Do

### 1. Endpoint Inventory

Group by resource/domain. Table per group.

```markdown
### Invoices

| Method | Path | Auth | Rate Limit | Idempotent? | Page? |
|--------|------|------|-----------|-------------|-------|
| POST   | /api/v1/invoices | User | 30/min | Yes (key) | — |
| GET    | /api/v1/invoices | User | 60/min | Yes | Yes |
| GET    | /api/v1/invoices/{id} | User | 60/min | Yes | — |
| PATCH  | /api/v1/invoices/{id} | User | 30/min | Yes (key) | — |
| DELETE | /api/v1/invoices/{id} | Admin | 10/min | Yes | — |

### Customers

| Method | Path | Auth | Rate Limit | Idempotent? | Page? |
|--------|------|------|-----------|-------------|-------|
| POST   | /api/v1/customers | Admin | 20/min | Yes (key) | — |
| GET    | /api/v1/customers | User | 60/min | Yes | Yes |
```
- [ ] Every user story maps to at least one endpoint
- [ ] No endpoint without a story justification
- [ ] Auth level defined per endpoint (public, user, admin, system)

### 2. Request/Response Schemas

```jsonc
// POST /api/v1/invoices
// Request
{
  "customer_id": "uuid",
  "amount": 150.00,
  "due_date": "2026-07-01",
  "notes": "Optional notes",
  "line_items": [
    { "description": "Consulting", "quantity": 10, "unit_price": 15.00 }
  ],
  "idempotency_key": "unique-key-from-client"
}

// Response 201
{
  "id": "uuid",
  "number": "INV-001",
  "customer_id": "uuid",
  "amount": 150.00,
  "status": "pending",
  "due_date": "2026-07-01",
  "line_items": [/* ... */],
  "created_at": "2026-06-08T12:00:00Z"
}

// Response 400
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "amount must be positive",
    "details": [
      { "field": "amount", "message": "must be ≥ 0", "code": "INVALID_VALUE" }
    ]
  }
}
```

- [ ] All field types, constraints, and descriptions documented
- [ ] Request/response examples for every endpoint
- [ ] Consistent error format across all endpoints
- [ ] Idempotency key supported for mutating endpoints

### 3. Error Response Format

```jsonc
// All errors follow this structure
{
  "error": {
    "code": "ERROR_CODE",         // machine-readable, stable
    "message": "Human-readable",  // developer-facing
    "details": [],                // validation errors per field
    "request_id": "uuid"          // traceability
  }
}

// Standard HTTP status codes
200 OK              — Success
201 Created         — Resource created
204 No Content      — Delete success
400 Bad Request     — Validation error
401 Unauthorized    — No auth or invalid auth
403 Forbidden       — Authenticated but not allowed
404 Not Found       — Resource doesn't exist
409 Conflict        — Duplicate, state conflict
422 Unprocessable   — Business rule violation
429 Too Many Requests — Rate limit exceeded
500 Internal Server Error — Unexpected failure
503 Service Unavailable   — Downstream dependency down
```

- [ ] Never return 500 with stack trace
- [ ] Never return 200 with error body — use correct status code
- [ ] Machine-readable error codes (not "An error occurred")

### 4. Pagination

```
| Criteria | Cursor-based | Offset-based |
|----------|-------------|-------------|
| Stable order | Yes | No (inserts shift pages) |
| Large datasets | Efficient | Slow (OFFSET skip) |
| Real-time data | Stable | Duplicates/skips possible |
| UI (page numbers) | Hard | Easy |

Decision: Use cursor-based for most endpoints. Offset for admin panels.
```

```jsonc
// Request
GET /api/v1/invoices?cursor=eyJsYXN0X2lkIjoxMDB9&limit=50

// Response
{
  "data": [/* items */],
  "pagination": {
    "next_cursor": "eyJsYXN0X2lkIjoxNTB9",
    "has_more": true,
    "limit": 50
  }
}
```

- [ ] Pagination strategy documented per endpoint
- [ ] Default limit + max limit defined
- [ ] Cursor encoding: base64url (opaque to client)

### 5. Versioning

```
Strategy: URL path versioning (/api/v1/, /api/v2/)

When to bump version:
  - Removing a field
  - Changing a field type
  - Making a required field optional (or vice versa)
  - Changing error response format

When NOT to bump:
  - Adding a field (backwards compatible)
  - Adding a new endpoint
  - Changing internal error messages

Deprecation:
  - Announce deprecation in response header: Deprecation: true
  - Set sunset date: Sunset: Sat, 31 Dec 2027 23:59:59 GMT
  - Old version supported for 6 months minimum
```

- [ ] Versioning strategy documented
- [ ] Deprecation policy documented
- [ ] Sunset header returned on deprecated endpoints

### 6. Webhooks (if applicable)

```
| Event | Trigger | Payload | Deliver To |
|-------|---------|---------|------------|
| invoice.paid | Payment confirmed | { invoice_id, amount } | Customer webhook URL |
| invoice.overdue | Due date passed + unpaid | { invoice_id, days_overdue } | Customer webhook URL |

Delivery: POST to registered URL, retry 3x with backoff, dead-letter after 24h.
Signature: HMAC-SHA256 header X-Webhook-Signature for verification.
```

- [ ] Events defined with triggers and payload schema
- [ ] Retry + dead-letter policy
- [ ] Signature verification documented for consumers

### 7. OpenAPI Spec

- [ ] Write OpenAPI 3.0 spec for all endpoints
- [ ] Include: paths, methods, request schemas, response schemas, error responses, auth
- [ ] Generate from code or write by hand — whichever the project already does
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

## Next → `06-threat-modeling.md`
Missing endpoints? Revert to tech spec. API conflicts with existing system? Flag to architect.
