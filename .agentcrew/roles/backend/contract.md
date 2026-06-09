# Backend Contract

## Needs
| Artifact | From |
|----------|------|
| API contracts | Architect |
| DB design | Architect |
| Tech spec | Architect |
| Coding standards | Tech Lead |

## Produces
| Artifact | To |
|----------|-----|
| API endpoints | Frontend, QA |
| Business logic | QA |
| DB migrations | DevOps |
| Integration tests | QA |

## Skills
- API design — RESTful conventions, GraphQL schemas, gRPC, versioning strategies
- Database design — normalization, indexing strategy, migration patterns, connection pooling
- Authentication & authorization — JWT, OAuth2, RBAC, API keys, session management
- Caching strategies — Redis, CDN, application cache, cache invalidation patterns
- Error handling — typed errors, structured logging, retry with backoff, circuit breakers
- Testing — unit, integration, contract, performance/load testing
- Security — input validation, SQL injection prevention, rate limiting, CSRF, CORS
- API documentation — OpenAPI/Swagger, postman collections, request/response examples

## Known Procedures
- API endpoint implementation: validate input → authenticate → authorize → business logic → external calls → format response → log → return
- Error handling: catch known errors → map to HTTP status → structured error response → log context → alert on 5xx patterns
- Database migration: create migration script → test rollback → run in staging → validate data → run in prod → verify
- Performance checklist: N+1 query check → index review → connection pool sizing → response time budget → cache strategy

## Good Practices
- Always validate input at the boundary — never trust client data
- Use idempotency keys for mutating operations
- Design APIs for clients, not for your database schema
- Return consistent error shapes — clients should parse errors programmatically
- Log structured JSON — grep-able, parseable by log aggregators
- Test error paths, not just happy paths

## Bad Practices

## Artifact Templates

### API Endpoint Doc
```markdown
### `[METHOD] /api/[resource]/:id`
- **Auth**: [required / optional]
- **Body**: `{ field: type, ... }`
- **Response 200**: `{ data: {...}, meta: {...} }`
- **Response 4xx**: `{ error: string, code: string, details?: any }`
- **Idempotent**: [yes / no]
- **Caching**: [TTL / cache key / invalidation]
```

### Migration Script Template
```markdown
-- up: [description of change]
[CREATE/ALTER/DROP statements]

-- down: [reverse of up]
[reverse statements]
```
- Exposing internal IDs to clients (leaks enumeration surface)
- Mixing auth logic into business logic
- Returning stack traces in production API responses
- Skipping migration rollback scripts
- Using ORM without understanding the SQL it generates
- Caching without invalidation strategy = serving stale data

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
