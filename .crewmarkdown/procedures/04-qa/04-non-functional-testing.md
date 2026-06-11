# Non-Functional Testing

## Need
- Build deployed to staging (production-equivalent environment)
- Non-functional requirements from PRD (response time targets, throughput, availability)
- Test tools configured (k6, Lighthouse, aXe, etc.)
- Baseline measurements from previous releases (for comparison)

## Instructions

### 1. Performance Testing

- [ ] Measure: P95 response time, throughput, error rate, CPU, memory, DB connections
- [ ] Ramp load: start at 10% → 50% → 100% → 150% (find breaking point)
- [ ] Compare to baseline from last release
- [ ] Document: test config, environment spec, time of day

### 2. Load + Stress Testing

- [ ] Load test: expected load + 20% buffer
- [ ] Stress test: find the breaking point and document it
- [ ] Soak test: 2 hours minimum (catches memory leaks, connection pool exhaustion)
- [ ] Every test includes: error rate (pass: < 1%), resource usage (pass: no growth)

### 3. Security Baseline

```
| Check | Status | Detail |
|-------|--------|--------|
| HTTPS enforced | ✅ | HTTP → HTTPS redirect, HSTS header |
| Security headers | ✅ | CSP, XFO, XSS-Protection, Referrer-Policy |
| TLS version | ✅ | TLS 1.3 only |
| Cookie flags | ⚠️ | HttpOnly missing on session cookie |
| CORS | ✅ | Restricted to *.example.com |
| Rate limiting | ✅ | 60 req/min per user |
```

- [ ] Automated security header scan
- [ ] If any ⚠️ or ❌ → log as security bug (Medium severity minimum)

### 4. Compatibility Testing

- [ ] Target: latest 2 versions of Chrome, Firefox, Safari, Edge
- [ ] Mobile: 3 viewport sizes (mobile, tablet, desktop)
- [ ] If ⚠️ or ❌ → log bug (Medium or Low depending on impact)

### 5. Accessibility (if applicable)

- [ ] Automated accessibility scan (aXe, WAVE)
- [ ] Manual: tab through all interactive elements
- [ ] Critical/High a11y issues = release blocker (if public-facing)

### 6. Error Recovery

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

→ Next: `09-security-pentest.md`
Performance below target? Flag to dev for optimization before security testing.
