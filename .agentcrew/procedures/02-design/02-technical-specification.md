# Technical Specification

## Need
- Architecture diagram + component responsibilities
- Data flow diagrams for major stories
- Tech stack decisions (from arch step)

## Instructions

### 1. Per-Component Spec

For each component in architecture diagram, write:

```
### Invoice Service

**Inputs:**
| Source | Data | Format | Frequency |
|--------|------|--------|-----------|
| API Gateway | Create invoice request | JSON | On-demand |

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

**Errors:**
| Error | HTTP code | Retry? | Fallback |
|-------|-----------|--------|----------|
| Invalid input | 400 | No | Return validation errors |
| DB unavailable | 503 | Yes (3x, backoff) | Return 503, log alert |
```

- [ ] One spec per component from architecture diagram
- [ ] If spec is > 1 page for a component → component is too big, split it

### 2. Data Models

- [ ] Entities with fields, types, constraints
- [ ] Relationships: Invoice N:1 Customer, Invoice 1:N LineItem
- [ ] Validation rules per field (min, max, pattern, required, etc.)
- [ ] Index candidates based on query patterns

### 3. Error Handling Strategy

```
| Layer | Strategy |
|-------|----------|
| Validation | Return structured error: { field, message, code } |
| Business logic | Return typed errors |
| I/O (DB/network) | Retry with backoff (3 attempts, exponential, jitter) |
| Third-party | Circuit breaker (5 failures → open → 30s cool-down → half-open) |
| Unhandled | Catch-all → log full, return generic 500. Never leak stack traces. |
| Timeout | context.WithTimeout at handler level. No per-call timeouts. |
```

- [ ] Define retry policy per external call type
- [ ] Define fallback behavior for each critical path
- [ ] Document what happens when ALL retries exhausted

### 4. Configuration Spec

- [ ] Config per environment (dev, staging, prod)
- [ ] Secrets from vault, never from env file committed to repo
- [ ] Feature flags documented (name, purpose, owner, removal criteria)

### 5. Observability Spec

```
Metrics (Prometheus):
  invoice_created_total{status, type}
Logs (structured JSON):
  event: "invoice.created"
  invoice_id: "uuid"
Traces (OpenTelemetry):
  Span per: HTTP request, DB query, external call, queue publish
Alerts:
  | Condition | Severity | Channel |
  |-----------|----------|---------|
  | P95 latency > 1s for 5 min | Warning | Slack |
```

- [ ] Define what to log: entry/exit of each major function, errors, decisions
- [ ] Define what NOT to log: passwords, tokens, PII, request bodies > 1KB
- [ ] Define alert thresholds with severity levels

### 6. Migration Path (if replacing existing system)

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

→ Next: `03-database-design.md`
Component scope too big? Split. Design gap found? Revert to architecture.
