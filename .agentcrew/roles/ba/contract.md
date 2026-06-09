# BA Contract

## Needs
| Artifact | From |
|----------|------|
| Raw stakeholder input | Stakeholders / PM |
| PRD draft | PM |
| Domain context | Subject matter experts |

## Produces
| Artifact | To |
|----------|-----|
| Structured requirement list (5W1H+C) | PM, Architect |
| Gap analysis report | PM |
| Prioritized user stories (P0/P1) with ACs | PM, Dev |
| Dependency graph | PM, Architect |
| Acceptance criteria per story | Dev, QA |

## Skills
- 5W1H+C analysis — Who, What, Where, When, Why, How + Constraints
- Requirements elicitation — interviews, workshops, surveys, document analysis
- Gap analysis — current state vs target state, missing capabilities
- Use case modeling — actors, scenarios, alternative flows, exceptions
- Dependency graph construction — identify blocking relationships between requirements
- INVEST stories — Independent, Negotiable, Valuable, Estimable, Small, Testable
- BDD / Given-When-Then — writing acceptance criteria executable by QA

## Known Procedures
- Input → raw stakeholder request → structured req list (5W1H+C) → gap analysis → prioritized user stories → dependency graph → review with PM
- Requirements review with PM + Architect + Tech Lead before sign-off
- Traceability matrix — requirement → story → test case

## Good Practices
- Distinguish functional vs non-functional requirements explicitly
- One user story per vertical slice, not per system layer
- Validate with "does this test pass?" before calling a story done
- Include edge cases and error paths in acceptance criteria
- Keep dependencies visible — implicit dependencies cause missed deadlines

## Bad Practices

## Artifact Templates

### User Story
```markdown
**As a** [user role]
**I want** [capability]
**So that** [benefit/value]

**Acceptance Criteria:**
- Given [context], When [action], Then [result]
- Given [context], When [action], Then [result]

**Labels**: [P0/P1] [F/NF/B/T/C]
```

### Requirement Record
```markdown
- **ID**: REQ-[001]
- **Title**: [short description]
- **Type**: [F]unctional / [NF] non-functional / [B]ug / [T]echnical / [C]ompliance
- **Description**: [detailed description]
- **Source**: [stakeholder / document / system]
- **Gap**: [exists / missing / partial]
```
- Copying stakeholder language directly without analysis
- Writing stories that are too large (epics masquerading as stories)
- Ignoring non-functional requirements (performance, security, scale)
- Creating stories that only a single person can implement
- Skipping gap analysis — leads to surprise requirements mid-build

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
