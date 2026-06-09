# Objective: Conduct Meeting

## Goal
Run a structured real-time meeting with dynamically assembled roles to brainstorm, decide, and produce action items for a given topic.

## Squad
| Role | Responsibility |
|------|---------------|
| Meeting Facilitator | Convene, agenda, guide discussion, capture outcomes |
| *Dynamic roles* | Spawned based on meeting topic (see Role Selection Matrix below) |

## Schedule
```
Facilitator: Convene --> Agenda --> Brainstorm --> Decisions --> Action Items --> Minutes
                 |            |            |             |              |
                 v            v            v             v              v
            Dynamic roles join based on topic relevance
```

**Parallel**: Brainstorming involves all spawned roles contributing simultaneously.
**Sequential**: Agenda before brainstorm. Decisions after discussion. Action items after decisions. Minutes final.

## Dependencies
- **Needs**: Meeting topic / question from user
- **Blocks**: Nothing (standalone objective)

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| Meeting Facilitator | Meeting agenda | Markdown |
| Dynamic roles | Ideas, opinions, proposals | Markdown bullets |
| Meeting Facilitator | Decision log | ADR-style Markdown |
| Meeting Facilitator | Action item list | Markdown checklist |
| Meeting Facilitator | Meeting minutes | Markdown |

## Acceptance
- Agenda set and shared before discussion
- All relevant roles identified and spawned
- Brainstorming captured with all contributions
- Decisions recorded with rationale
- Action items assigned with owners
- Minutes logged to `.agentcrew/log/meeting/<topic>/<timestamp>.md`

## Role Selection Matrix

Meeting topic keywords determine which roles are spawned:

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

If topic doesn't match any keywords: spawn PM + Architect + Tech Lead as default.

## Solo Invocation
- "/meeting brainstorm [topic]" -> Convene with relevant roles
- "/meeting decide [question]" -> Convene with decision-makers
- "/meeting retro" -> Convene with full team

## Procedure References
- Facilitator: `meeting/01-convene.md` (convene + agenda)
- Facilitator: `meeting/02-brainstorm.md` (brainstorming)
- Facilitator: `meeting/03-decisions.md` (decision capture)
- Facilitator: `meeting/04-action-items.md` (action items)
- Facilitator: `meeting/05-minutes.md` (minutes)

## Cross-Cutting
- Decision points may trigger Debate (`debate/`) if strong disagreement arises
