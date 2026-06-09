# Technical Specification

## Need
- Architecture diagram + component responsibilities
- Data flow diagrams for major stories
- Tech stack decisions (from arch step)

## Decision Tree

```
What type of component?
├── New service → Full spec: inputs, processing, outputs, errors, config, observability
├── Library/module → Scope, public API, dependencies, error types
└── Existing component change → Delta spec only: what changes in inputs/outputs/behavior

Will this component be called synchronously?
├── Yes → Define timeout, retry, circuit breaker, fallback
└── No (async only) → Define queue, delivery guarantee, dead-letter

Does it store data?
├── Yes → Data model, migration path, indexing strategy
└── No → Skip data sections
```

## Do

### 1. Per-Component Spec

For each component in architecture diagram, write:

```markdown
### Invoice Service

**Inputs:**
| Source | Data | Format | Frequency |
|--------|------|--------|-----------|
| API Gateway | Create invoice request | JSON | On-demand |
| Payment Service | Payment confirmed event | JSON (async) | Per-payment |
| Scheduler | Monthly export trigger | Cron | Monthly |

**Processing:**
1. Validate input (schema + business rules)
2. Check for duplicate (idempotency key)
3. Write to DB
4. Enqueue notification event
5. Return response

**Outputs:**
| Destination | Data | Format | Trigger |
|-------------|------|--------|---------|
| API Gateway | Invoice created response | JSON | On success |
| Notification Service | Invoice created event | JSON (queue) | After DB write |

**Errors:**
| Error | HTTP code | Retry? | Fallback |
|-------|-----------|--------|----------|
| Invalid input | 400 | No | Return validation errors |
| Duplicate invoice | 409 | No | Return existing invoice |
| DB unavailable | 503 | Yes (3x, backoff) | Return 503, log alert |
```

- [ ] One spec per component from architecture diagram
- [ ] If spec is > 1 page for a component → component is too big, split it

### 2. Data Models

- [ ] Entities with fields, types, constraints:
  ```
  Invoice
    id: UUID (PK)
    number: string (unique, indexed)
    customer_id: UUID (FK → customer.id)
    amount: decimal(10,2)
    status: enum(pending, paid, cancelled)
    due_date: date
    created_at: timestamp
    updated_at: timestamp
    deleted_at: timestamp (nullable, soft delete)
  ```
- [ ] Relationships: Invoice N:1 Customer, Invoice 1:N LineItem
- [ ] Validation rules per field (min, max, pattern, required, etc.)
- [ ] Index candidates based on query patterns

### 3. Error Handling Strategy

```
| Layer | Strategy |
|-------|----------|
| Validation | Return structured error: { field, message, code } |
| Business logic | Return typed errors (InvoiceNotFoundError, DuplicateInvoiceError) |
| I/O (DB/network) | Retry with backoff (3 attempts, exponential, jitter) |
| Third-party | Circuit breaker (5 failures → open → 30s cool-down → half-open) |
| Unhandled | Catch-all → log full, return generic 500. Never leak stack traces. |
| Timeout | context.WithTimeout at handler level. No per-call timeouts. |
```

- [ ] Define retry policy per external call type
- [ ] Define fallback behavior for each critical path
- [ ] Document what happens when ALL retries exhausted

### 4. Configuration Spec

```yaml
# Each config key with source, default, description
APP_PORT:
  source: env var
  default: "8080"
  description: HTTP server port
DATABASE_URL:
  source: env var (from vault)
  default: none (required)
  description: PostgreSQL connection string
FEATURE_PDF_EXPORT:
  source: env var
  default: "false"
  description: Enable PDF export (launch gate)
MAX_EXPORT_ROWS:
  source: env var
  default: "100000"
  description: Max rows per export request
```

- [ ] Config per environment (dev, staging, prod)
- [ ] Secrets from vault, never from env file committed to repo
- [ ] Feature flags documented (name, purpose, owner, removal criteria)

### 5. Observability Spec

```
Metrics (Prometheus):
  invoice_created_total{status, type}
  invoice_export_duration_seconds{format, bucket}
  db_query_duration_seconds{query_name}

Logs (structured JSON):
  event: "invoice.created"
  invoice_id: "uuid"
  customer_id: "uuid"
  duration_ms: 123
  error: null

Traces (OpenTelemetry):
  Span per: HTTP request, DB query, external call, queue publish
  Sample rate: 1% prod, 100% dev

Alerts:
  | Condition | Severity | Channel |
  |-----------|----------|---------|
  | P95 latency > 1s for 5 min | Warning | Slack |
  | Error rate > 5% for 2 min | Critical | PagerDuty |
  | Queue depth > 10k for 1 min | Warning | Slack |
```

- [ ] Define what to log: entry/exit of each major function, errors, decisions
- [ ] Define what NOT to log: passwords, tokens, PII, request bodies > 1KB
- [ ] Define alert thresholds with severity levels

### 6. Migration Path (if replacing existing system)

```
| Phase | Duration | What | Risk |
|-------|----------|------|------|
| 0 | 1 week | Build new system, run in shadow mode | Low — no user impact |
| 1 | 1 day | Migrate 10% of read traffic | Medium — validate correctness |
| 2 | 1 day | Migrate 50% of read traffic | Medium |
| 3 | 1 day | Migrate 100% of read traffic | Low — validated |
| 4 | 1 week | Migrate write traffic gradually | High — data integrity |
| 5 | — | Decommission old system | Low — reads only |
```

- [ ] Rollback plan per phase
- [ ] Validation criteria per phase ("migrated data matches 100%")
- [ ] Communication plan per phase (who needs to know)

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Write implementation details in tech spec | Spec is WHAT and WHY. Code is HOW. |
| Skip error paths | Document what breaks and how it recovers |
| One giant spec file | One file per component, max 2 pages each |
| Vague config ("set appropriate values") | Exact key names, defaults, descriptions |
| No observability plan | Logs/metrics/alerts defined BEFORE code is written |
| Ignoring migration | If replacing something, plan the cutover |

## Time Budget

| Components | Per Component | Error Strategy | Config | Observability | Total |
|-----------|--------------|---------------|-------|--------------|-------|
| 2-3 | 15 min each | 10 min | 5 min | 10 min | ~1 hr |
| 4-6 | 20 min each | 15 min | 10 min | 15 min | ~2.5 hr |
| 7+ | 25 min each | 20 min | 15 min | 20 min | ~4 hr |

## Done
- Per-component spec (inputs, processing, outputs, errors)
- Data models with fields, types, relationships
- Error handling strategy per layer
- Configuration spec with all keys, sources, defaults
- Observability spec (metrics, logs, traces, alerts)
- Migration path (if applicable)
- All unknowns flagged with owner + deadline

## Next → `03-database-design.md`
Component scope too big? Split. Design gap found? Revert to architecture.
