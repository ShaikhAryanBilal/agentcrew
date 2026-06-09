# Bug Tracking

## Need
- Bug discovered (from functional testing, regression, UAT, production monitoring, security scan)
- Environment details (staging vs production, browser, OS, data state)
- Steps to reproduce

## Instructions

### 1. Bug Report Template

```markdown
BUG-012: Export returns 500 when invoice has null customer_id

Severity: Critical
Priority: P0
Status: Fixed / Verified
Tag: functional, regression
Found in: v1.2.3-rc1 (staging)
Source: Functional testing (TC-002)
Reported by: [Name]
Date: 2026-06-10

Description:
Export endpoint returns HTTP 500 with "Cannot read property 'name' of null"

Steps to reproduce:
1. Create an invoice with customer_id = null
2. Send GET /api/v1/invoices/export?format=csv
3. Observe HTTP 500

Expected behavior:
- Export should include invoices with null customer_id, showing "N/A"

Actual behavior:
- HTTP 500, internal server error

Environment:
- Staging, PostgreSQL 15, Node 20

Root cause: (filled after triage)
- InvoiceService.toCSVRow assumes customer is always non-null.

Resolution: (filled after fix)
- PR #145 added null check
```

- [ ] Every field filled. No "TBD" defaults.
- [ ] Title = symptom, not cause
- [ ] Steps: numbered, exact, reproducible by someone else

### 2. Severity + Priority

```
Severity (technical impact):
  Critical: Data loss, security breach, auth bypass, core flow completely broken
  High: Feature unusable, major regression, P0 flow broken
  Medium: Feature partially broken, workaround exists
  Low: Cosmetic, typo, minor UI glitch

Priority (business impact):
  P0: Fix now — blocking release or production down
  P1: This sprint — important but has workaround
  P2: Next sprint — nice to have
  P3: Backlog — future consideration
```

- [ ] Severity assigned by QA (technical judgment)
- [ ] Priority assigned by PM (business judgment)

### 3. Bug Lifecycle

```
New → Triaged → In Progress → Fixed (CI) → Verified (QA) → Closed
```

| Status | Who | Action |
|--------|-----|--------|
| New | Reporter | Bug created with all fields |
| Triaged | PM + Lead | Severity + priority assigned, owner set |
| In Progress | Dev | Fixing the bug |
| Fixed (CI) | Dev | PR merged, fix deployed to staging |
| Verified | QA | Re-test passes, bug confirmed fixed |

- [ ] Move status when action taken. Don't skip statuses.
- [ ] Verified ≠ Closed until QA confirms on staging.

### 4. Bug Tracking During Testing

- [ ] Link bugs to test cases: BUG-012 → TC-002
- [ ] Link bugs to requirements: BUG-012 → FR-003
- [ ] After fix: re-run the failing test + related tests

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Vague bug title ("it doesn't work") | "Export returns 500 when customer_id is null" |
| Steps like "go to page and click" | Exact URLs, exact inputs, exact sequence |
| No environment info | Build version, DB state, browser, device |
| One bug report per sprint | Log immediately. Small bugs become big bugs. |
| Closing without verification | Dev marks Fixed, QA marks Verified. Two steps. |
| "Can't reproduce" = close | Log as "need more info" not "closed." |

## Time Budget
| Bug | Write | Triage | Retest | Total |
|-----|-------|--------|--------|-------|
| Clear, reproducible | 5 min | 2 min | 5 min | 12 min |
| Intermittent, complex | 10 min | 5 min | 10 min | 25 min |
| Security (needs investigation) | 10 min | 10 min | Varies | 20 min + investigation |

## Done
- Bug report with: title, steps, expected, actual, severity, priority, environment
- Status tracked through lifecycle
- Linked to test case and requirement
- Fixed bugs verified by re-running test
- Known issues list maintained for accepted Medium/Low bugs

→ Next: `07-uat.md`
Critical/P0 bug? Escalate to PM + Tech Lead. Security bug? Tag security, assign to security engineer.
