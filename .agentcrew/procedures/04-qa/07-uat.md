# User Acceptance Testing

## Need
- Build deployed to UAT/staging environment
- Signed-off PRD (acceptance criteria per user story)
- Test scenarios (happy paths per user role)
- Test users set up (with realistic data that matches personas)

## Decision Tree

```
Who are the UAT users?
├── Internal stakeholders (PM, business users) → Structured scenarios, guided execution
├── External beta users → Less structured, more open exploration
└── Both → Internal first (blockers), then external (feedback)

How many participants?
├── 1-3 → Each participant goes through all scenarios
├── 4-8 → Split scenarios by role, each person tests their role's flows
└── 9+ → Representative sample (not everyone tests everything)

What type of feedback needed?
├── Usability (is it easy to use?) → Open-ended, observe struggles
├── Correctness (does it work right?) → Structured pass/fail per scenario
└── Both → Run structured tests first, then open exploration
```

## Do

### 1. Scenario Preparation

Per user role (from PRD personas), write scenarios:

```markdown
### Role: Accountant

Scenario A1: Export invoices for month-end close
Steps:
  1. Log in as accountant (user: accountant@example.com)
  2. Navigate to Invoices page
  3. Click "Export" button
  4. Select date range: June 1 - June 30
  5. Select format: CSV
  6. Click "Download"
  7. Open downloaded file in Excel

Check:
  ✅ File downloads successfully
  ✅ Columns: invoice_id, number, customer, amount, status, due_date
  ✅ Data matches expected invoices for June
  ✅ Excel opens without errors
  ✅ Can you complete your month-end close with this?

Satisfaction: ___ (1-5)

Free text feedback:
  Is anything missing? What would make this better?
```

- [ ] One scenario per major user goal
- [ ] Each scenario ends with: "Did this work? What would make it better?"
- [ ] Instructions: simple enough that anyone can follow without QA guidance

### 2. Execution

```markdown
UAT Session — June 12, 2026
Participants: Sarah (Accounting), Mike (Finance Manager)

| Scenario | Participant | Result | Feedback | Satisfaction |
|----------|-------------|--------|----------|-------------|
| A1: Export invoices | Sarah | ✅ Pass | "Much faster than manual. Would like PDF too." | 5/5 |
| A2: Filter invoices | Sarah | ✅ Pass | "Date picker is intuitive." | 4/5 |
| B1: Approve invoice | Mike | ❌ Fail | "Approval button not obvious. Expected it on invoice detail page, not list." | 2/5 |

Issues Found:
  ISS-001: Approval button placement confusing (UX feedback)
  - Sarah found it on second try after hovering on each icon
  - Mike expected it on the invoice detail page
  - Recommendation: Add "Approve" button to invoice detail and rename icon tooltip
```

- [ ] Guide user through first scenario, then let them proceed independently
- [ ] Watch for: confusion, hesitation, errors — these are UX issues even if the feature "works"
- [ ] Record: pass/fail, satisfaction score (1-5), verbatim feedback
- [ ] Don't defend the design. Listen.

### 3. Issue Classification

UAT issues are NOT bugs (unless behavior violates spec). They are:

```
| Type | Definition | Action |
|------|-----------|--------|
| UX gap | Feature works but is confusing | Route to PM + UX designer |
| Feature gap | Missing capability user expected | PM decides: add, defer, or explain |
| Training gap | Feature exists but user didn't know | Documentation or walkthrough |
| Bug | Feature violates spec | Route to bug tracking |
| Enhancement | User wants improvement to working feature | PM prioritizes for future |
```

- [ ] Classify each issue by type
- [ ] Bug → bug tracking (standard process)
- [ ] UX gap → design review
- [ ] Feature gap → PM decision (add to PRD or defer)

### 4. Satisfaction Scoring

```markdown
Satisfaction Summary:
  Average: 3.8/5
  By role:
    Accountant: 4.5/5 (2 scenarios)
    Finance Manager: 2.5/5 (2 scenarios)

  Scores:
    5: "Perfect, exactly what we need"     → 2 scenarios
    4: "Good, minor improvements"           → 1 scenario
    3: "Adequate, needs work"               → 0 scenarios
    2: "Not usable, needs major rework"     → 1 scenario
    1: "Completely wrong approach"          → 0 scenarios
```

- [ ] Score per scenario, not per feature
- [ ] Score < 3 = does not meet user needs. Escalate to PM.

### 5. UAT Sign-off

```markdown
UAT SIGN-OFF

Feature: Invoice Export
Date: 2026-06-12
Participants: Sarah (Accounting), Mike (Finance Manager)

UAT Result:
  ✅ Pass — 3/4 scenarios pass
  ⚠️ Conditional — ISS-001 (approval button UX) acknowledged by PM, fix scheduled

Blockers:
  ❌ None

Signature:
  PM: [Name] — Accepted with ISS-001 noted
  QA: [Name] — UAT complete, handoff to QA sign-off
```

- [ ] PM signs off: accepts the feature with or without conditions
- [ ] If PM will not sign off → blockers logged, route back to dev

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Guide users through every click | Let them explore. See what confuses them naturally. |
| Dismiss feedback ("it's by design") | Record it. Design can be wrong. |
| Only test happy path | Let users try to break it. They will. |
| Skip UAT because "dev tested it" | Dev and users have different expectations. Always UAT. |
| Ask leading questions ("it's easy, right?") | "What was confusing? What would you change?" |
| Ignore satisfaction scores | 2/5 means something is wrong. Investigate. |

## Time Budget

| Participants | Scenarios | Per Session | Analysis | Total |
|-------------|-----------|-------------|----------|-------|
| 1-2 | 3-5 | 45 min | 30 min | 1.5-2 hr |
| 3-5 | 5-8 | 1 hr | 45 min | 2-3 hr |
| 6+ | 8-12 | 1.5 hr | 1 hr | 3-4 hr |

## Done
- UAT execution report (scenario results, satisfaction scores)
- User feedback log (verbatim quotes, observations)
- Issues classified (UX gap / feature gap / training / bug / enhancement)
- PM sign-off (or blocker list with decisions)
- Known issues handed off to QA sign-off

## Next → `08-qa-signoff.md`
Blocker found (PM won't sign)? Route to bug tracking or design review. Major UX issues? Route to PM + UX.
