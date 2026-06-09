# Threat Modeling

## Need
- Architecture diagram with trust boundaries drawn
- Data flow diagrams per major story
- API contracts (endpoints, auth per endpoint)
- Compliance requirements (GDPR, SOC2, PCI, HIPAA)
- Component list with data stores

## Instructions

### 1. Asset Inventory

| Asset | Location | Sensitivity | Classification |
|-------|----------|-------------|---------------|
| User credentials | Auth DB | Critical | Restricted |

- [ ] Classification: Public / Internal / Confidential / Restricted
- [ ] Each data store gets an asset entry

### 2. Trust Boundary Review

From architecture diagram, list every boundary:

- [ ] Every arrow crossing a trust boundary is a threat vector
- [ ] List controls already in place vs. controls needed

### 3. STRIDE Per Component

For each component, run STRIDE:

| Category | Threat | Likelihood | Impact | Risk | Mitigation |
|----------|--------|-----------|--------|------|------------|
| Spoofing | Attacker calls API with stolen JWT | Medium | High | High | JWT expiry (15 min), refresh token rotation |

- [ ] One STRIDE table per component with data stores
- [ ] Likelihood: Low / Medium / High
- [ ] Impact: Low / Medium / High / Critical
- [ ] Risk: product of likelihood and impact

### 4. Risk Table (All Findings)

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
```

- [ ] Acceptance criteria per mitigation (how to verify it's fixed)
- [ ] Owner assigned
- [ ] Deadline before SG1

### 6. Accepted Risks

- [ ] PM explicitly accepts, not by default
- [ ] Review accepted risks quarterly

### 7. Compliance Checklist

| Requirement | Compliant? | Evidence |
|-------------|-----------|----------|
| Data encrypted at rest | Yes | RDS encryption enabled |

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

→ Next: `05-design-review.md`
Critical/High threats not mitigated? SG1 will fail. Architecture change needed? Revert to architecture.
