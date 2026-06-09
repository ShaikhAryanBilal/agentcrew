# Bug Tracking

## Need
- Bug discovered (from functional testing, regression, UAT, production monitoring, security scan)
- Environment details (staging vs production, browser, OS, data state)
- Steps to reproduce

## Decision Tree

```
Where was the bug found?
├── Testing (pre-prod) → Standard triage. Fix before release.
├── UAT → User-facing. Higher priority. PM may classify as release blocker.
├── Production → Immediate triage. Hotfix if Critical/High.
└── Security scan → Tag security. Assign to security engineer.

Is the bug reproducible?
├── Yes → Log with exact steps. Proceed to triage.
├── No (intermittent) → Log with observed frequency. Tag flaky. Add logging to capture next occurrence.
└── Can't reproduce → Log anyway. Note "could not reproduce." If happens again → escalate.

Is the bug in a P0 feature?
├── Yes → Severity at least High. Fix before release.
└── No → Normal triage. May defer.
```

## Do

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
when an invoice has a null customer_id.

Steps to reproduce:
1. Create an invoice with customer_id = null (or update existing invoice to set customer_id null)
2. Send GET /api/v1/invoices/export?format=csv
3. Observe HTTP 500 with error above

Expected behavior:
- Export should include invoices with null customer_id, showing "N/A" or empty in customer column
- OR export should exclude invoices with null customer_id (document behavior)

Actual behavior:
- HTTP 500, internal server error
- Error logged: "TypeError: Cannot read property 'name' of null at ExportService.formatRow"

Environment:
- Staging, PostgreSQL 15, Node 20
- Invoice: id=abc-123, customer_id=null

Attachments:
- screenshot: export-error-500.png
- log: export-error.log

Root cause: (filled after triage)
- InvoiceService.toCSVRow assumes customer is always non-null.
- customer.name accessed without null check.

Resolution: (filled after fix)
- PR #145 added null check: customer ? customer.name : 'N/A'
- Deployed to staging v1.2.3-rc2
- Verified: TC-002 passes now
```

- [ ] Every field filled. No "TBD" defaults.
- [ ] Title = symptom, not cause ("Export 500" not "null pointer")
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

Combined:
  | Severity \ Priority | P0 | P1 | P2 | P3 |
  |---------------------|----|----|----|-----|
  | Critical            | Fix now | Fix now | Fix now | Fix now |
  | High                | Fix now | This sprint | This sprint | This sprint |
  | Medium              | Fix now | This sprint | Next sprint | Next sprint |
  | Low                 | — | This sprint | Next sprint | Backlog |
```

- [ ] Severity assigned by QA (technical judgment)
- [ ] Priority assigned by PM (business judgment)
- [ ] If severity and priority disagree → PM decides

### 3. Bug Lifecycle

```
New → Triaged → In Progress → Fixed (CI) → Verified (QA) → Closed
                ↓                          ↓
            Won't Fix                   Re-open
                ↓
            Duplicate
                ↓
            Need More Info ←→ In Progress
```

| Status | Who | Action |
|--------|-----|--------|
| New | Reporter | Bug created with all fields |
| Triaged | PM + Lead | Severity + priority assigned, owner set |
| In Progress | Dev | Fixing the bug |
| Fixed (CI) | Dev | PR merged, fix deployed to staging |
| Verified | QA | Re-test passes, bug confirmed fixed |
| Re-opened | QA | Re-test fails → dev re-assigned |
| Won't Fix | PM | Decision: not fixing (document why) |
| Duplicate | Triage | Linked to original bug, closed |
| Need More Info | Triage | QA or dev adds info, moves back to New |

- [ ] Move status when action taken. Don't skip statuses.
- [ ] Verified ≠ Closed until QA confirms on staging.

### 4. Bug Tracking During Testing

```
During test execution:
  ❌ TC-002 fails → BUG-012 created → continue testing other areas
  ⏳ Pending BUG-012 fix → skip dependent tests, mark ⏳

After fix deployed:
  ✅ Re-run TC-002 → passes → BUG-012 moved to Verified
  ✅ Re-run related tests → all pass → close BUG-012
```

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

## Next → `07-uat.md`
Critical/P0 bug? Escalate to PM + Tech Lead. Security bug? Tag security, assign to security engineer.
