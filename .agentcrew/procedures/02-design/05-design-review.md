# Design Review

## Need
- Architecture diagram with components + trust boundaries
- Tech spec (component specs, data models, config)
- DB design (schema, migrations, indexes)
- API contracts (OpenAPI spec)
- Threat model (SG1 pass required — Critical/High threats mitigated)

## Decision Tree

```
SG1 status?
├── Pass (all Critical/High mitigated) → Proceed to full review
├── Fail → Revert to threat modeling. Do NOT review design with open Critical threats.
└── Not applicable (no security-significant features) → Skip SG1 check, proceed

Design complexity?
├── Simple (2-4 components, < 10 endpoints, < 10 tables) → Single reviewer
├── Medium (5-8 components, 10-20 endpoints) → 2 reviewers
└── Complex (9+ components, 20+ endpoints, multi-region) → Full review meeting

How many reviewers needed?
├── 1 reviewer minimum for standard changes
├── 2 reviewers for features touching auth/payments/PII
└── 3+ reviewers for architecture decisions affecting multiple teams
```

## Do

### 1. SG1 Gate Check (First)

Before ANY review comments on design quality, verify security gate:

- [ ] Threat model exists? (or SG1 not applicable)
- [ ] All Critical/High threats have mitigations assigned?
- [ ] Mitigations have acceptance criteria?
- [ ] Accepted risks documented and signed by PM?
- [ ] Compliance checklist gaps have owners + deadlines?

**SG1 fails if:** Any Critical threat unmitigated. Any High threat unmitigated without acceptance.
**SG1 passes if:** All Critical/High threats addressed or accepted.

### 2. Architecture Review

- [ ] Architecture covers ALL functional requirements from PRD?
- [ ] Non-functional requirements addressed? (perf, scale, security, availability, cost)
- [ ] Components have single responsibility? (if >1 job, split)
- [ ] Trust boundaries marked correctly? (every external input is a boundary)
- [ ] Data flow covers happy path + error paths?
- [ ] Tech stack choices justified? (not just "we always use this")
- [ ] Scalability strategy documented? (what breaks first under 10x?)
- [ ] Deployment model appropriate for requirements?

### 3. Tech Spec Review

- [ ] Each component has: inputs, processing steps, outputs, error paths?
- [ ] Data models match entities in PRD?
- [ ] Error handling strategy per layer defined? (validation, business, I/O, third-party)
- [ ] Configuration documented? (keys, sources, defaults)
- [ ] Observability plan: metrics, logs, traces, alerts?
- [ ] Migration path documented (if replacing existing system)?
- [ ] No implementation details in spec? (spec is WHAT, code is HOW)

### 4. DB Design Review

- [ ] Schema matches data models in tech spec?
- [ ] Relationships correct? (1:1, 1:N, M:N with proper FK + indexes)
- [ ] Indexing strategy justified by query patterns?
- [ ] Migrations versioned and reversible?
- [ ] Zero-downtime deployment possible?
- [ ] Backup/recovery defined (RPO, RTO)?
- [ ] No anti-patterns: EAV, cascade delete without thinking, no PK, generic status string

### 5. API Review

- [ ] Every user story → at least one endpoint?
- [ ] Endpoints named consistently? (RESTful: nouns, not verbs)
- [ ] Request/response schemas complete? (all fields, types, constraints)
- [ ] Error format consistent across all endpoints?
- [ ] Auth + rate limits per endpoint defined?
- [ ] Pagination strategy defined?
- [ ] Versioning strategy defined? (or explicitly defer)
- [ ] OpenAPI spec matches design?

### 6. Risk Register Update

- [ ] Identify new risks found during review
- [ ] Update risk table with findings:
  ```
  | ID | Risk | Severity | Owner | Status |
  |----|------|----------|-------|--------|
  | R01 | Single AZ deployment — risk if AZ goes down | Medium | DevOps | Mitigate: multi-AZ |
  | R02 | No caching on invoice list — perf risk at scale | Low | Backend | Accept (monitor) |
  ```

### 7. Outcome

- [ ] **Approve** → All checks pass. Proceed to sprint planning.
- [ ] **Conditional approve** → Minor issues noted, can proceed but fix before code review.
- [ ] **Request changes** → Major issues found. Revert to relevant design step.

## Output Format

```
DESIGN REVIEW: Invoice Export Feature
Reviewer: [Name]
Date: yyyy-mm-dd
Result: Approve / Conditional / Changes requested

SG1: ✅ Pass (all Critical/High threats mitigated)

Architecture: ✅ Pass
  Notes: Consider adding cache for invoice list endpoint

Tech Spec: ✅ Pass
  Notes: None

DB Design: ✅ Conditional
  Issues: Add composite index (customer_id, created_at) on invoices — missing from current design
  Fix before: code review

API Design: ✅ Pass
  Notes: None

Risk Register: Updated with R01, R02

Review comments:
🔴 Blocking:
  1. Missing index (customer_id, created_at) on invoices — will cause slow queries
🟡 Suggest:
  1. Consider adding cache layer for invoice list
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Review design without reading PRD first | Map every requirement to a design element |
| Skip SG1 check | SG1 first. Security before convenience. |
| Only review what you like | Review the error paths, edge cases, and failure modes |
| Leave vague feedback ("this could be better") | Specific: "missing index, suggested: (customer_id, created_at)" |
| Accept "we'll fix it later" for blocking issues | Blockers block. Either revert or conditional approve with deadline. |
| Review alone for critical systems | Get a second set of eyes on auth, payments, data integrity |

## Time Budget

| Complexity | Pre-read | SG1 Check | Full Review | Write Output | Total |
|-----------|----------|-----------|-------------|-------------|-------|
| Simple | 15 min | 5 min | 20 min | 5 min | 45 min |
| Medium | 30 min | 10 min | 40 min | 10 min | 1.5 hr |
| Complex (meeting) | 1 hr | 15 min | 1 hr | 15 min | 2.5 hr |

## Done
- Design review output (approved or changes requested)
- SG1 pass/fail
- Risk register updated
- Issues tagged: 🔴 blocking / 🟡 suggest / 🟢 nitpick
- Every issue has: what, where, severity

## Next → `03-development/01-sprint-planning.md`
Major issues? Revert to relevant design step (arch, spec, DB, API, or threat). SG1 fail? Revert to threat modeling.
