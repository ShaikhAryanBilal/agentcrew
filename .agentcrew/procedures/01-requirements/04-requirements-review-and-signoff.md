# Requirements Review & Sign-off

## Need
- PRD draft (all sections filled)
- Stakeholder list (who needs to approve)
- Known outstanding questions (if any)

## Instructions

### 1. Review Cycle

- [ ] Send PRD with explicit review request:
  ```
  Subject: PRD Review: [Feature Name] — reply by [date+time]
  Body:
  - Summary: 1-line
  - Key decisions needed: [list 2-3 open questions]
  - Review window: [48h / 24h / 4h if urgent]
  - Link to PRD
  ```
- [ ] Tag each stakeholder with what they need to review:
  ```
  PM:     Problem statement, scope, success metrics
  Tech:   Feasibility, constraints, dependencies
  QA:     Acceptance criteria, testability
  Design: UX requirements (if applicable)
  Legal:  Compliance implications (if applicable)
  ```
- [ ] Set deadline. No deadline = no response. 48h default, 24h if urgent.

### 2. Feedback Resolution

Collect all feedback. Process per type:

| Feedback Type | Resolution Path |
|---------------|-----------------|
| Factual error | Fix immediately |
| Missing requirement | PM decides: add to scope or defer |
| Scope disagreement | PM decides on record ("I choose X because Y") |
| Feasibility concern | Tech Lead writes 1-para impact note, PM decides |
| Edge case | Add to AC if P0, or note as future |
| "I don't like it" | PM asks "what specifically?" If no answer, overrule |

- [ ] Track each piece of feedback: ID, author, resolution, date
- [ ] If unresolved → escalate to decision-maker above

### 3. Sign-off Record

```
REQUIREMENTS SIGN-OFF
Feature: [Name]
Version: v1.0
Date: yyyy-mm-dd

Approvals:
☐ PM: [Name] — [date]
☐ Tech Lead: [Name] — [date]
☐ Architect: [Name] — [if design-significant]
☐ QA Lead: [Name] — [if test-significant]
☐ Legal: [Name] — [if required]

SG1 Check:
☐ Routes to threat model (security-significant features)
☐ No threat model needed (no auth/payments/PII)

Scope frozen: Yes — changes after this point require change request
```

- [ ] Get explicit sign-off (thread reply, approval tool, or signature)
- [ ] Silent stakeholder at deadline → deemed approved. Note it.
- [ ] Tag PRD as `v1.0` after sign-off

### 4. Scope Freeze

- [ ] Scope is frozen. Changes = change request.
- [ ] Change request process: impact assessment → PM decision → version bump
- [ ] Minor clarifications (no scope change) do NOT require re-sign-off

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Infinite review rounds | 2 rounds max. Round 3 = you didn't write clearly enough. |
| Asking "any feedback?" | Ask specific people specific questions. Generic = silence. |
| Letting stakeholders skip reading | Set deadline. No reply = approved by default. |
| Accepting verbal sign-off | Written record. Thread, ticket, signature. |
| Scope creep without process | Change request or defer. No free additions. |

## Time Budget
| Stakeholders | Rounds | Typical Time |
|-------------|--------|-------------|
| 2-3 (small) | 1 | 1 day |
| 4-6 (medium) | 1-2 | 2-3 days |
| 7+ (large, multi-team) | 2 | 3-5 days |
| Compliance-involved | 2+ | 1-2 weeks |

## Done
- Signed-off PRD (v1.0, scope frozen)
- Approval record (who, when)
- SG1 decision made (route to threat model or skip)
- Change request process documented

→ Next: `02-design/01-system-architecture.md`
Scope disagreement? PM resolves. Feasibility concern? Tech Lead writes impact note. If still blocked, revert to `03-prd.md` with updated constraints.
