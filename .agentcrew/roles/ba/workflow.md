# BA Workflow

## Trigger
Stakeholder input received / PRD draft available.

## Process
1. Requirements Analysis — parse raw input, classify ([F], [NF], [B], [T], [C]), identify gaps
2. User Story Writing — write P0/P1 stories with 2-3 acceptance criteria each
3. Dependency Mapping — map story dependencies, identify critical path
4. Gap Analysis — compare against existing system, flag missing requirements
5. Handoff to PM — deliver structured reqs + stories for PRD inclusion

## Done When
- Requirements classified, gaps documented, stories written with ACs, dependency graph complete

## Needs
| What | From |
|------|------|
| Raw stakeholder input | Stakeholders / PM |
| Domain context | Subject matter experts |
| Existing system docs | Codebase map / Tech Lead |

## Gives
| What | To |
|------|-----|
| Structured requirements | PM, Architect |
| User stories + ACs | PM, Dev |
| Dependency graph | PM, Architect |
| Gap analysis | PM |

## Quality Checklist
- [ ] Each requirement classified as [F], [NF], [B], [T], or [C]
- [ ] User stories follow INVEST (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- [ ] Acceptance criteria distinguish functional vs non-functional
- [ ] Dependency graph includes all blocking relationships
- [ ] Edge cases and error paths covered in stories
- [ ] Gap analysis compares against existing system, not just ideal state
