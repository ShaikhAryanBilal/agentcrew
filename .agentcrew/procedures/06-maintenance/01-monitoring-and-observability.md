# Monitoring & Observability

## Need
- Application deployed to production
- Infrastructure in place (k8s/ECS/VMs, load balancer, DB)
- Access to: cloud console, logging platform, metrics platform

## Decision Tree

```
New system or existing?
├── New → Full observability setup: metrics, logs, traces, dashboards, alerts
├── Existing (new feature only) → Add feature-specific metrics + alerts. Reuse existing dashboards.
└── Existing (no observability) → Baseline first: error rate, latency, resource usage. Then add.

What's the criticality?
├── Customer-facing, revenue-critical → Full observability. PagerDuty alerts. 24h on-call.
├── Internal tool, business-critical → Logs + metrics. Slack alerts. Business-hours on-call.
└── Internal tool, low criticality → Basic logs. No alerts. Best-effort.

Who responds to alerts?
├── Dedicated SRE/DevOps → Full setup with escalation paths
├── Dev team on-call → Simpler setup, clear runbooks, minimize false alarms
└── No on-call → Log-based monitoring only. Check dashboards proactively.
```

## Do

### 1. The Three Pillars

```markdown
### 1. Logging

Structure:
  All logs in JSON format with these fields:
  {
    "level": "info" | "warn" | "error",
    "timestamp": "2026-06-08T12:00:00Z",
    "service": "accounting-api",
    "env": "production",
    "trace_id": "uuid",
    "message": "invoice created",
    "data": { "invoice_id": "uuid", "customer_id": "uuid" },
    "error": { "message": "...", "stack": "..." }  // error level only
  }

Levels:
  debug: Development only. Never on in production.
  info: Normal operations (request start/end, state changes)
  warn: Anomaly detected, auto-recovered (retry succeeded, rate limit approaching)
  error: Failure requiring attention (DB down after retries, payment failed)
  
  No fatal level — log error, then panic/exit. Let the orchestrator restart.

What to log:
  ✅ Every HTTP request: method, path, status, duration, user_id
  ✅ Every external call: service, endpoint, status, duration
  ✅ Every state change: entity created/updated/deleted
  ✅ Every error: error message, stack trace, context
  ❌ Never log: passwords, tokens, PII, request bodies > 1KB
  ❌ Never log: full stack traces in response body (log server-side only)

### 2. Metrics

Golden Signals (USE / RED method):

| Signal | Metric | Example |
|--------|--------|---------|
| Rate | Requests/sec | req_count{method, path, status} |
| Errors | Error count/rate | req_errors_total{status_class="5xx"} |
| Duration | Latency (p50, p95, p99) | req_duration_ms{method, path} |

Resource (USE method):
  CPU: utilization, saturation (load), errors
  Memory: utilization, swap usage
  Disk: utilization (%), I/O latency, I/O errors
  Network: bandwidth, errors, drops

Business (custom):
  invoice_created_total{status, type}
  invoice_export_total{format}
  export_duration_seconds{format}

### 3. Tracing

  Every request gets a trace_id at the ingress point.
  Pass trace_id across all internal service calls (HTTP header: X-Trace-ID).
  Log trace_id in every log line.

  Distributed tracing through all hops:
    Browser → API Gateway → App Service → DB / External API

  For high-volume: sample 1% of requests. For errors: sample 100%.
```

- [ ] Structured logging implemented (JSON format, correlation ID per request)
- [ ] Metrics defined per golden signals + business metrics
- [ ] Tracing: trace_id propagated across service boundaries

### 2. Dashboards

```markdown
### Dashboard 1: Overview
- Request rate (per endpoint)
- Error rate (5xx, 4xx)
- P50/P95/P99 latency
- CPU/Memory/Network per pod/instance

### Dashboard 2: Feature-Specific (Invoice Export)
- Export requests/min
- Export success/error rate
- Export duration P95
- Average rows per export

### Dashboard 3: Dependencies
- DB query rate, slow queries, connection count
- External API rate, errors, latency
- Queue depth (if applicable)
```

- [ ] Create or update dashboards for this service
- [ ] Include at least: overview, feature-specific, dependency health
- [ ] Pin to team channel (Slack/Teams)

### 3. Alerts

```markdown
### Immediate (PagerDuty/call)

| Condition | Severity | Response SLA |
|-----------|----------|-------------|
| Error rate > 5% for 2 min | Critical | 5 min |
| Service down (health check 503) | Critical | 5 min |
| P95 latency > 2s for 5 min | High | 15 min |
| Disk > 90% | High | 30 min |

### Warning (Slack)

| Condition | Severity | Channel |
|-----------|----------|---------|
| Error rate > 1% for 5 min | Warning | #alerts |
| P95 latency > 1s for 5 min | Warning | #alerts |
| DB connection pool > 80% | Warning | #alerts |
| Certificate expires in < 30 days | Warning | #ops |

### Info (Slack, low noise)

| Condition | Channel |
|-----------|---------|
| Deploy completed | #releases |
| Dependency scan new Critical CVE | #security |
| Error rate recovered after alert | #alerts |
```

- [ ] Alerts configured for: error rate, latency, service health, resource thresholds
- [ ] Each alert has: condition, severity, channel, runbook link
- [ ] Alert fatigue = too many alerts. Review and tune monthly.

### 4. Runbook

Per common incident pattern:

```markdown
## Runbook: High Error Rate

Symptoms: Error rate alert fires, users report errors

Steps:
  1. Check Overview dashboard: which endpoint? which error code?
  2. Check logs for that endpoint: search trace_id of failing requests
  3. Is error a new pattern or existing? (compare to last 24h)
  4. Is error related to recent deploy? (check deploy time vs error start)
  5. If deploy-related → rollback
  6. If not deploy-related → check dependencies (DB, external API)
  7. If DB → check slow queries, connection pool, replication lag
  8. If external API → check rate limits, API health, credentials

Rollback: see release-plan.md for current version

Escalation: If not resolved in 15 min → escalate to Tech Lead
```

- [ ] One runbook per common incident pattern
- [ ] Runbook includes: symptoms, diagnosis steps, resolution steps, escalation path
- [ ] Store runbooks accessible to on-call (not in someone's head)

### 5. On-Call Rotation

```markdown
Schedule: Weekly rotation (Mon → Mon)
Team: [Names, 4 people]
Tools: PagerDuty/Opsgenie for alert routing
Handoff: Every Monday, 30 min (review open incidents, known issues, recent changes)

Escalation:
  L1: On-call engineer (15 min response, triage + resolve or escalate)
  L2: Tech Lead (30 min response for unresolved L1)
  L3: Engineering Manager (60 min response for major incidents)
```

- [ ] On-call rotation defined and active
- [ ] Escalation paths documented
- [ ] Handoff process documented

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Log everything at info level | Log levels have meaning. Info = normal. Error = needs attention. |
| No dashboards | Dashboards make patterns visible. Always create overview + feature dashboards. |
| Alert on everything | Alert fatigue kills response. Only alert on actionable conditions. |
| No runbooks | On-call shouldn't guess. Every alert has a runbook. |
| PII in logs | PII in logs = compliance violation. Filter before logging. |
| No on-call rotation | One person becomes the "expert" and burns out. Rotate. |

## Time Budget

| Scope | Setup | Dashboards | Alerts | Runbooks | Total |
|-------|-------|-----------|--------|----------|-------|
| Add to existing | 30 min | 30 min | 20 min | 20 min | 1.5 hr |
| Full setup (new) | 2 hr | 1 hr | 1 hr | 1 hr | 5 hr |
| Full + compliance | 3 hr | 1.5 hr | 1.5 hr | 2 hr | 8 hr |

## Done
- Structured logging implemented (JSON, levels, trace_id)
- Metrics configured (golden signals + business metrics)
- Distributed tracing (trace_id propagation)
- Dashboards created (overview, feature, dependencies)
- Alerts configured with severity + channel + runbook links
- Runbooks written for common incident patterns
- On-call rotation defined and active

## Next → `02-hotfix-process.md` (if incident occurs) OR (ongoing reference)
Update as system evolves. Review alert thresholds monthly.
