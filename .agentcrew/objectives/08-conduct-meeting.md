# Conduct Meeting

## System
You are executing objective: Conduct Meeting. Run a structured real-time meeting with dynamically assembled roles to brainstorm, decide, and produce action items for a given topic.

## Instructions
1. Assemble squad: Meeting Facilitator + dynamic roles spawned per Role Selection Matrix
2. Facilitator convenes and sets agenda (meeting/01-convene.md)
3. Facilitator runs brainstorm (meeting/02-brainstorm.md) with all spawned roles contributing in parallel
4. Facilitator captures decisions with rationale (meeting/03-decisions.md)
5. Facilitator records action items with owners (meeting/04-action-items.md)
6. Facilitator writes minutes (meeting/05-minutes.md)
7. Verify acceptance criteria
8. Log to `.agentcrew/log/meeting/<topic>/<timestamp>.md`
9. Update `.agentcrew/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| Meeting Facilitator | Convene, agenda, guide discussion, capture outcomes |
| Dynamic roles | Spawned based on meeting topic (see Role Selection Matrix) |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Meeting topic/question | User | Meeting agenda (Markdown) | Facilitator |
| Topic + agenda | Facilitator | Ideas, opinions, proposals (Markdown bullets) | Dynamic roles |
| Discussion | All | Decision log (ADR-style Markdown) | Facilitator |
| Decisions | Facilitator | Action item list (Markdown checklist) | All |
| All artifacts | Facilitator | Meeting minutes (Markdown) | Log |

## Acceptance
- Agenda set and shared before discussion
- All relevant roles identified and spawned
- Brainstorming captured with all contributions
- Decisions recorded with rationale
- Action items assigned with owners
- Minutes logged to `.agentcrew/log/meeting/<topic>/<timestamp>.md`

## Role Selection Matrix
| Topic Contains | Spawned Roles |
|---------------|--------------|
| feature, product, requirement, roadmap | PM, BA, Architect |
| architecture, design, tech-stack, pattern | Architect, Tech Lead, Security, DevOps |
| sprint, planning, capacity, velocity | EM, PM, Tech Lead |
| bug, defect, issue, qa, quality | QA, Security, relevant Dev |
| deploy, release, ci/cd, pipeline | DevOps, PM, Tech Lead |
| security, threat, vulnerability | Security, Architect, DevOps |
| data, pipeline, etl, database | Data Engineer, Backend, Architect |
| ml, model, ai, training | ML Engineer, Data Engineer |
| mobile, ios, android | Mobile Dev, Backend |
| ui, ux, design, frontend | UX Designer, Frontend |
| api, integration, backend | Backend, Frontend, Tech Lead |
| monitor, observability, ops | DevOps, EM |
| retro, retrospective, process | EM, PM, Tech Lead |
| strategy, vision, roadmap | PM, Architect, EM |
| general, brainstorm, ideation | PM, Architect, Tech Lead, relevant Dev |

Default (no keyword match): PM + Architect + Tech Lead

## Gates
- None

## Procedures
- Facilitator: `meeting/01-convene.md`
- Facilitator: `meeting/02-brainstorm.md`
- Facilitator: `meeting/03-decisions.md`
- Facilitator: `meeting/04-action-items.md`
- Facilitator: `meeting/05-minutes.md`

## Debate Triggers
- Decision points with strong disagreement → trigger debate (`debate/`)
