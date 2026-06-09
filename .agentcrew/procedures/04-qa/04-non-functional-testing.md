# Non-Functional Testing

## Need
- Build deployed to staging (production-equivalent environment)
- Non-functional requirements from PRD (response time targets, throughput, availability)
- Test tools configured (k6, Lighthouse, aXe, etc.)
- Baseline measurements from previous releases (for comparison)

## Decision Tree

```
Are there explicit NFRs with targets?
├── Yes → Test against each target. Pass/fail is binary.
├── Yes but targets are vague ("fast") → Push PM for quantifiable targets before testing.
└── No → Measure baseline only. Document current values, no pass/fail.

What's the environment?
├── Production-like (same CPU, RAM, DB size) → Results are meaningful.
├── Staging (smaller than prod) → Scale results proportionally. Document the proportion.
└── Developer laptop → Only useful for relative comparisons. Not release-gate worthy.

Is this the first NFR test for this feature?
├── Yes → Establish baseline.
└── No → Compare to baseline. Regression = fail.
```

## Do

### 1. Performance Testing

```markdown
### Response Time (P95)
Target: < 500ms for invoice list, < 2s for export

Test: 100 concurrent users, ramp up over 30s
  - GET /api/v1/invoices: P95 = 320ms  ✅ (target: < 500ms)
  - GET /api/v1/invoices/export: P95 = 4.2s  ❌ (target: < 2s)
  - POST /api/v1/invoices: P95 = 180ms  ✅ (target: < 500ms)

### Throughput
Target: 100 req/s sustained for 5 min

Test: Constant load 100 req/s for 5 min
  - Actual: 102 req/s sustained  ✅
  - Error rate: 0.2%  ✅ (target: < 1%)
  - No memory growth over 5 min  ✅

### Resource Usage
Target: CPU < 70%, Memory < 500MB per instance

Test: Peak load (100 req/s)
  - CPU: 45%  ✅
  - Memory: 320MB  ✅
  - DB connections: 12 of 100  ✅
```

- [ ] Measure: P95 response time, throughput, error rate, CPU, memory, DB connections
- [ ] Ramp load: start at 10% → 50% → 100% → 150% (find breaking point)
- [ ] Compare to baseline from last release
- [ ] Document: test config, environment spec, time of day

### 2. Load + Stress Testing

```
### Load Test (expected load)
Target: 100 concurrent users
Ramp: 0 → 100 over 30s, sustain 5 min
  ✅ P95 < target for all endpoints
  ✅ No errors
  ✅ No memory leak (stable after 5 min)

### Stress Test (find breaking point)
Target: Find max concurrent users before failure
  - 100 users: OK
  - 200 users: P95 exceeds target (2.1s vs 500ms)
  - 300 users: 5% error rate (timeouts)
  - Breaking point: ~250 concurrent users

### Soak Test (sustained load)
Target: 50 concurrent users for 2 hours
  - Memory: stable at 320MB
  - No error rate increase over time
  - No DB connection leak
  ✅ Pass — system stable under sustained load
```

- [ ] Load test: expected load + 20% buffer
- [ ] Stress test: find the breaking point and document it
- [ ] Soak test: 2 hours minimum (catches memory leaks, connection pool exhaustion)
- [ ] Every test includes: error rate (pass: < 1%), resource usage (pass: no growth)

### 3. Security Baseline

```markdown
| Check | Status | Detail |
|-------|--------|--------|
| HTTPS enforced | ✅ | HTTP → HTTPS redirect, HSTS header |
| Security headers | ✅ | CSP, XFO, XSS-Protection, Referrer-Policy |
| TLS version | ✅ | TLS 1.3 only (1.2 for legacy clients) |
| Cookie flags | ⚠️ | HttpOnly missing on session cookie |
| CORS | ✅ | Restricted to *.example.com |
| Rate limiting | ✅ | 60 req/min per user on list endpoints |
```

- [ ] Automated security header scan
- [ ] If any ⚠️ or ❌ → log as security bug (Medium severity minimum)

### 4. Compatibility Testing

```markdown
| Browser | Status | Notes |
|---------|--------|-------|
| Chrome 120+ | ✅ | Full pass |
| Firefox 115+ | ✅ | Full pass |
| Safari 17+ | ⚠️ | Export download filename encoding issue |
| Edge 120+ | ✅ | Full pass |

Mobile viewports:
| Device | Status | Notes |
|--------|--------|-------|
| iPhone 14 (390px) | ✅ | Responsive layout OK |
| iPad (810px) | ✅ | Responsive layout OK |
| Desktop (1920px) | ✅ | Full layout |
```

- [ ] Target: latest 2 versions of Chrome, Firefox, Safari, Edge
- [ ] Mobile: 3 viewport sizes (mobile, tablet, desktop)
- [ ] If ⚠️ or ❌ → log bug (Medium or Low depending on impact)

### 5. Accessibility (if applicable)

```markdown
| Check | Status | Issues |
|-------|--------|--------|
| Automated scan (aXe) | ✅ | 0 Critical, 2 Low |
| Keyboard navigation | ✅ | All interactive elements reachable |
| Screen reader (VoiceOver) | ⚠️ | Export button missing aria-label |
| Color contrast | ✅ | All ratios ≥ 4.5:1 |
```

- [ ] Automated accessibility scan (aXe, WAVE)
- [ ] Manual: tab through all interactive elements
- [ ] Critical/High a11y issues = release blocker (if public-facing)

### 6. Error Recovery

```markdown
| Scenario | Expected | Actual | Result |
|----------|----------|--------|--------|
| Restart app service | Auto-recover within 30s | 22s recovery | ✅ |
| Kill DB connection | Pool reconnects, retry succeeds | 3 retries, success | ✅ |
| Network partition to payment API | Graceful degradation, clear error | 503 with "payment unavailable" | ✅ |
| Exhaust disk space | Clean error, no data corruption | 507 with message | ✅ |
```

- [ ] Test: restart, kill dependency, network partition, resource exhaustion
- [ ] Document recovery time and behavior

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Load test on dev laptop | Use production-like environment or don't bother |
| Only test happy path load | Test normal + peak + error scenarios |
| Skip soak test | Memory leaks show after 30+ min, not in 2-min load test |
| No baseline comparison | "Is 500ms good?" — compare to last release's 300ms |
| Test once | Run 3 times, take median. Single runs have variance. |
| Ignore NFRs without targets | "Slow" is not testable. Push for quantifiable targets. |

## Time Budget

| Scope | Perf Test | Load/Stress | Security | Compat | Recovery | Total |
|-------|-----------|-------------|---------|--------|----------|-------|
| Light | 30 min | 30 min | 15 min | 15 min | 15 min | 1.75 hr |
| Medium | 1 hr | 1 hr | 30 min | 30 min | 30 min | 3.5 hr |
| Full | 2 hr | 2 hr | 1 hr | 1 hr | 1 hr | 7 hr |

## Done
- Performance report: P95, throughput, error rate, resource usage per endpoint
- Load/stress test results (breaking point documented)
- Soak test (2h+ with no degradation)
- Security baseline (headers, TLS, cookies, CORS)
- Compatibility matrix (browsers + mobile viewports)
- Accessibility scan + manual check
- Error recovery test results
- All findings compared to NFR targets from PRD

## Next → `09-security-pentest.md`
Performance below target? Flag to dev for optimization before security testing.
