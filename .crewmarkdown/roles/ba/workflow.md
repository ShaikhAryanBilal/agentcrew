---
role: BA
trigger: Stakeholder input received / PRD draft available.
process:
  - Requirements Analysis — parse raw input, classify ([F], [NF], [B], [T], [C]), identify gaps
  - User Story Writing — write P0/P1 stories with 2-3 acceptance criteria each
  - Dependency Mapping — map story dependencies, identify critical path
  - Gap Analysis — compare against existing system, flag missing requirements
  - Handoff to PM — deliver structured reqs + stories for PRD inclusion
done_when: Requirements classified, gaps documented, stories written with ACs, dependency graph complete
needs:
  - what: Raw stakeholder input
    from: Stakeholders / PM
  - what: Domain context
    from: Subject matter experts
  - what: Existing system docs
    from: Codebase map / Tech Lead
gives:
  - what: Structured requirements
    to: PM, Architect
  - what: User stories + ACs
    to: PM, Dev
  - what: Dependency graph
    to: PM, Architect
  - what: Gap analysis
    to: PM
quality_checklist:
  - Each requirement classified as [F], [NF], [B], [T], or [C]
  - User stories follow INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable)
  - Acceptance criteria distinguish functional vs non-functional
  - Dependency graph includes all blocking relationships
  - Edge cases and error paths covered in stories
  - Gap analysis compares against existing system, not just ideal state
---

## Trigger
Stakeholder input received / PRD draft available.

## Instructions
1. Requirements analysis — parse raw input, classify as [F], [NF], [B], [T], or [C], and identify gaps.
2. User story writing — write P0/P1 stories with 2–3 acceptance criteria each.
3. Dependency mapping — map story dependencies and identify the critical path.
4. Gap analysis — compare against existing system and flag missing requirements.
5. Handoff to PM — deliver structured requirements and stories for PRD inclusion.
6. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/ba.md` (derive `<chat-slug>` from request text)
7. Update `.crewmarkdown/state/workflow.json`

## Done When
Requirements classified, gaps documented, stories written with ACs, dependency graph complete.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Raw stakeholder input | Stakeholders / PM | Structured requirements | PM, Architect |
| Domain context | Subject matter experts | User stories + ACs | PM, Dev |
| Existing system docs | Codebase map / Tech Lead | Dependency graph | PM, Architect |
| — | — | Gap analysis | PM |

## Quality Checklist
- Each requirement classified as [F], [NF], [B], [T], or [C]
- User stories follow INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- Acceptance criteria distinguish functional vs non-functional
- Dependency graph includes all blocking relationships
- Edge cases and error paths covered in stories
- Gap analysis compares against existing system, not just ideal state
