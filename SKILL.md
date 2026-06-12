---
name: CrewMarkdown
description: >
  CrewMarkdown — universal agent router for any domain: engineering, business, creative, or operations.
  Every request routes through `.crewmarkdown/00-objectives.md`. Roles work solo, squad,
  or orchestrated. Each has contract + workflow + skills + templates.
  Also triggered by: "CrewMarkdown", "workflow", "follow the process", /CrewMarkdown.
---

# CrewMarkdown Skill

## Detection
1. Check `.crewmarkdown/00-objectives.md` exists
2. Yes → use this skill. No → skip.

## Routing
1. Read `00-objectives.md` → match request to objective
2. Read objective file → goal, squad, artifacts, acceptance
3. Read `00-team.md` → invocation mode (solo/squad/orchestrate)
4. Load each role's `contract.md` + `workflow.md`
5. Load procedure files if needed
6. Read `custom/<phase>.md` → apply overrides
7. Execute: roles produce artifacts
8. Log: `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text — kebab-case, max 5 words)
9. State: update `.crewmarkdown/state/workflow.json`
10. Verify acceptance criteria

## Invocation Modes
| Mode | Pattern | When |
|------|---------|------|
| Solo | "[Role], do [task]" | Single role, self-contained |
| Squad | "Squad ([roles]), achieve [objective]" | Multiple roles, one objective |
| Orchestrate | "Build this [feature/system]" | Full lifecycle, multiple objectives |
| Meeting | "/meeting [topic]" | Structured deliberation, decisions, action items |
| Incident | "/incident [signal]" | Production issue, outage, SEV |
| Review | "/review [artifact]" | Code, design, PRD, docs review |
| Interview | "/interview [topic]" | User research, stakeholder discovery |
| Negotiation | "/negotiate [issue]" | Conflict resolution, trade-off bargaining |
| Retrospective | "/retro [period]" | Sprint/project reflection, improvement |
| Hackathon | "/hackathon [theme]" | Rapid prototyping, innovation sprint |
| Onboarding | "/onboard [role]" | New hire ramp-up, guided orientation |
| Tactical | "/tactical" | Continuous always-on thread, dynamic role dispatch per request |

## Domain Scope
CrewMarkdown handles all domains — not just coding:
- **Engineering**: full-stack dev, data pipelines, ML, infra, QA, security
- **Business**: marketing campaigns, sales strategy, hiring, budgeting, compliance
- **Creative**: content strategy, UX research, brand, visual design
- **Operations**: incident response, retrospectives, onboarding, meetings, reviews, negotiations
- **Strategy**: OKRs, architecture decisions, sprint planning, GTM planning

## Skill-Level Inference
CrewMarkdown adapts autonomy to user expertise automatically — no config needed.

| Signal | Auto (0-30) | Guided (31-65) | Expert (66-100) |
|--------|-------------|----------------|-----------------|
| Role mention | None | Casual | Explicit |
| Jargon | 0 domain terms | 1-2 general | 3+ specific |
| Verb | "I want", "make" | "help me", "should I" | "implement", "configure" |
| Scope | Whole project | Feature/area | Specific task |

Auto → agent delivers, user approves. Guided → agent proposes, user decides. Expert → agent executes precisely.

## Zero-Config Entry
`go.ps1` at project root provides a jargon-free entry point. Single prompt, full pipeline behind the scenes.
