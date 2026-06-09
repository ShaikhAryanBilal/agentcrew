# Threat Modeling

## Need
- Architecture diagram with trust boundaries drawn
- Data flow diagrams per major story
- API contracts (endpoints, auth per endpoint)
- Compliance requirements (GDPR, SOC2, PCI, HIPAA)
- Component list with data stores

## Decision Tree

```
Does the system handle ANY of these?
├── User authentication/authorization
├── Payment/financial data
├── PII (name, email, phone, address, DOB)
├── Health data
├── API keys, tokens, secrets
├── File uploads
└── None of the above → Low risk. Limited threat model (skip STRIDE, just do asset inventory).

Is this an existing system or new?
├── New → Full STRIDE per component
└── Existing → Focus on delta (new components, changed trust boundaries)

Compliance required?
├── PCI-DSS → Must handle card data. Additional controls required.
├── SOC2 → Access controls, audit logging, encryption
├── GDPR → Data classification, retention, right to deletion
├── HIPAA → BA agreement, encryption, access logs
└── None → Standard security practices still apply
```

## Do

### 1. Asset Inventory

| Asset | Location | Sensitivity | Classification |
|-------|----------|-------------|---------------|
| User credentials | Auth DB | Critical | Restricted |
| PII (name, email) | User DB | High | Confidential |
| Invoices (financial) | Invoice DB | High | Confidential |
| API keys | Vault (not code) | Critical | Restricted |
| Session tokens | Redis | Critical | Restricted |
| Public product catalog | Product DB | Low | Public |
| Logs | CloudWatch | Medium | Internal |

- [ ] Classification: Public / Internal / Confidential / Restricted
- [ ] Each data store gets an asset entry

### 2. Trust Boundary Review

From architecture diagram, list every boundary:

```
Boundary 1: Browser ↔ API Gateway
  Trust: Browser is UNTRUSTED
  Risk: Injection, CSRF, XSS, auth bypass
  Controls: Input validation, CSRF token, auth check, rate limit

Boundary 2: API Gateway ↔ App Server
  Trust: Internal network (TRUSTED but not zero-trust)
  Risk: Service-to-service auth bypass
  Controls: mTLS or service token, network policy

Boundary 3: App Server ↔ Database
  Trust: Private subnet (TRUSTED)
  Risk: SQL injection, credential compromise
  Controls: Parameterized queries, least-privilege DB user, encrypted connection

Boundary 4: App Server ↔ Payment Gateway
  Trust: External (UNTRUSTED)
  Risk: Webhook spoofing, data interception
  Controls: HMAC signature verification, TLS, IP allowlist
```

- [ ] Every arrow crossing a trust boundary is a threat vector
- [ ] List controls already in place vs. controls needed

### 3. STRIDE Per Component

For each component, run STRIDE:

```markdown
### Component: Invoice Service

| Category | Threat | Likelihood | Impact | Risk | Mitigation |
|----------|--------|-----------|--------|------|------------|
| Spoofing | Attacker calls API with stolen JWT | Medium | High | High | JWT expiry (15 min), refresh token rotation, check jti in DB |
| Tampering | Attacker modifies invoice data in transit | Low | High | Medium | TLS 1.3, request signing for webhook callbacks |
| Repudiation | Customer claims they didn't create invoice | Low | Medium | Low | Audit log (who, what, when, IP), immutable |
| Info Disclosure | Error response leaks DB schema | Medium | Medium | Medium | All errors use generic format, stack traces never returned |
| DoS | Attacker floods export endpoint with large requests | Medium | High | High | Rate limit (30/min per user), max export rows (100k), timeout (30s) |
| Elevation | Customer calls DELETE endpoint meant for admin | Low | Critical | High | RBAC check on every endpoint, test negative auth scenarios |
```

- [ ] One STRIDE table per component with data stores
- [ ] Likelihood: Low / Medium / High (use your judgment)
- [ ] Impact: Low / Medium / High / Critical
- [ ] Risk: product of likelihood and impact

### 4. Risk Table (All Findings)

```markdown
| ID | Threat | STRIDE | Component | Likelihood | Impact | Risk | Mitigation | Owner | Status |
|----|--------|--------|-----------|-----------|--------|------|------------|-------|--------|
| T01 | JWT forgery | S | API Gateway | Medium | Critical | Critical | Verify RS256 signature; reject alg=none | Backend | Mitigated |
| T02 | SQL injection | T | Invoice Service | Low | Critical | High | Parameterized queries; no raw SQL | Backend | Mitigated |
| T03 | No rate limit on export | D | Invoice Service | Medium | High | High | Rate limit: 30/min per user, timeout: 30s | Backend | Planned |
| T04 | Error leaking stack trace | I | All | Medium | Medium | Medium | Global error handler | Backend | Needs fix |
| T05 | Webhook replay attack | T | Payment Webhook | Low | Medium | Low | Nonce check + timestamp window | Backend | Not planned |
```

- [ ] Prioritize: all Critical/High must be mitigated before SG1
- [ ] Medium may be accepted by PM with documented rationale
- [ ] Low are documented but may be deferred

### 5. Mitigation Plan

For each High/Critical threat, specify exact mitigation:

```
T01: JWT forgery
  Mitigation: Use RS256 with well-known JWKS endpoint, verify on every request
  Verification: Unit test that rejects alg=none, integration test with forged token
  Gate: SG1

T03: No rate limit on export
  Mitigation: Token bucket per user, 30 req/min burst, 10 req/min sustained
  Verification: Load test with 100 concurrent requests, verify 429 after limit
  Gate: SG1
```

- [ ] Acceptance criteria per mitigation (how to verify it's fixed)
- [ ] Owner assigned
- [ ] Deadline before SG1

### 6. Accepted Risks

Risks that PM accepts (with signature):

```
| ID | Risk | Rationale | Accepted By | Date |
|----|------|-----------|-------------|------|
| T05 | Webhook replay within 5min window | Low impact, low likelihood, mitigation cost > damage | PM [Name] | 2026-06-08 |
```

- [ ] PM explicitly accepts, not by default
- [ ] Review accepted risks quarterly

### 7. Compliance Checklist

| Requirement | Compliant? | Evidence |
|-------------|-----------|----------|
| Data encrypted at rest | Yes | RDS encryption enabled |
| Data encrypted in transit | Yes | TLS 1.3, mTLS for internal |
| Access logging | Partially | Need: CISO audit log format |
| PII retention policy | Not implemented | Need: auto-delete after 36 months |
| Right to deletion (GDPR) | Not implemented | Need: delete user API |


- [ ] Map compliance requirements to actual controls
- [ ] Flag gaps with owners and deadlines

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Only think about authentication | STRIDE covers 7 categories, not just "who can log in" |
| Assume internal network is safe | Zero trust: every call authenticates regardless of network |
| Skip threat model because "we use HTTPS" | HTTPS is baseline, not security strategy |
| Ignore third-party dependencies | Every library is a potential threat vector |
| Document threats without mitigations | Every threat gets a response (mitigate, accept, transfer) |
| Threat model once and never revisit | Update when architecture changes |
| Lock threat model behind security expert | Use STRIDE table. Pattern-match. Blockers only. |

## Time Budget

| Components | Asset Inventory | STRIDE | Risk Table | Mitigations | Total |
|-----------|----------------|--------|-----------|-------------|-------|
| 2-3 (low risk) | 5 min | 20 min | 10 min | 10 min | 45 min |
| 4-6 (medium risk) | 10 min | 40 min | 20 min | 20 min | 1.5 hr |
| 7+ (high risk/compliance) | 15 min | 1 hr | 30 min | 30 min | 2.25 hr |

## Done
- Asset inventory (data types, locations, classification)
- Trust boundary review with controls
- STRIDE table per component
- Risk table with likelihood, impact, risk level
- Mitigation plan for all Critical/High risks
- Accepted risks log (signed by PM)
- Compliance checklist (compliant or gap with owner)
- SG1 ready for review

## Next → `05-design-review.md`
Critical/High threats not mitigated? SG1 will fail. Architecture change needed? Revert to architecture.
