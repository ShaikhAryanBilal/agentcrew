# Monitoring & Observability

## Need
- Application deployed to production
- Infrastructure in place (k8s/ECS/VMs, load balancer, DB)
- Access to: cloud console, logging platform, metrics platform

## Instructions

### 1. The Three Pillars

#### 1. Logging

Structure: All logs in JSON format with level, timestamp, service, env, trace_id, message, data, error

Levels:
  - debug: Development only. Never on in production.
  - info: Normal operations
  - warn: Anomaly detected, auto-recovered
  - error: Failure requiring attention

What to log:
  ✅ Every HTTP request: method, path, status, duration, user_id
  ✅ Every external call: service, endpoint, status, duration
  ✅ Every state change: entity created/updated/deleted
  ✅ Every error: error message, stack trace, context
  ❌ Never log: passwords, tokens, PII, request bodies > 1KB

#### 2. Metrics

Golden Signals (USE / RED method):
  - Rate: Requests/sec
  - Errors: Error count/rate
  - Duration: Latency (p50, p95, p99)

Resource (USE method): CPU, Memory, Disk, Network

Business (custom): invoice_created_total, export_duration_seconds

#### 3. Tracing

Every request gets a trace_id at the ingress point. Pass trace_id across all internal service calls.

- [ ] Structured logging implemented (JSON format, correlation ID per request)
- [ ] Metrics defined per golden signals + business metrics
- [ ] Tracing: trace_id propagated across service boundaries

### 2. Dashboards

- [ ] Create or update dashboards for this service
- [ ] Include at least: overview, feature-specific, dependency health
- [ ] Pin to team channel (Slack/Teams)

### 3. Alerts

| Condition | Severity | Response SLA |
|-----------|----------|-------------|
| Error rate > 5% for 2 min | Critical | 5 min |
| Service down (health check 503) | Critical | 5 min |
| P95 latency > 2s for 5 min | High | 15 min |
| Error rate > 1% for 5 min | Warning | Slack |
| P95 latency > 1s for 5 min | Warning | Slack |

- [ ] Alerts configured for: error rate, latency, service health, resource thresholds
- [ ] Each alert has: condition, severity, channel, runbook link
- [ ] Alert fatigue = too many alerts. Review and tune monthly.

### 4. Runbook

Per common incident pattern:
- [ ] One runbook per common incident pattern
- [ ] Runbook includes: symptoms, diagnosis steps, resolution steps, escalation path
- [ ] Store runbooks accessible to on-call (not in someone's head)

### 5. On-Call Rotation

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

→ Next: `02-hotfix-process.md` (if incident occurs) OR (ongoing reference)
