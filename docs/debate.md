# Debate Framework

Structured decision-making for resolving disagreements with multiple viable options.

**Cross-cutting:** Activated at decision points within *any* objective.

## Purpose

When there are multiple valid approaches, the debate framework ensures all perspectives are heard, decisions are documented with rationale, and the best option wins on merit.

## The Process

1. **Debate Trigger** — A decision point arises with multiple viable options. The objective lead calls for a debate.
2. **Panel Assembly** — Facilitator assembles roles with stake in the decision. Each represents their role's perspective.
3. **Opening Statements** — Each panelist presents their stance with evidence.
4. **Cross-Examination** — Structured rounds of rebuttal, questioning, and evidence.
5. **Scoring** — Panelists score options against agreed criteria. Highest score wins.
6. **Resolution** — Decision recorded with rationale, rejected options, and consequences.

## Typical Debate Triggers

| In Objective | Typical Debate | Panel |
|-------------|---------------|-------|
| Clarify Vision | Scope trade-off, priority | PM, BA, Architect |
| Design Solution | Tech stack, architecture fork | Architect, Backend, Frontend, Security |
| Plan Work | Sprint scope, capacity | EM, PM, Tech Lead |
| Build Feature | Implementation approach, library | Tech Lead, Dev, QA |
| Verify Quality | Test strategy, automation | QA, Dev, DevOps |
| Ship Release | Rollout strategy, rollback | DevOps, PM, Tech Lead |
| Operate & Learn | Refactor vs rewrite, tooling | Tech Lead, Architect, DevOps |
| Conduct Meeting | Decision point, brainstorm topic, retro | Meeting Facilitator + dynamic roles |

## Key Files

| File | Purpose |
|------|---------|
| `.agentcrew/debate/01-debate-trigger.md` | When and how to trigger a debate |
| `.agentcrew/debate/02-debate-panel.md` | Panel composition rules |
| `.agentcrew/debate/03-debate-rounds.md` | Debate round structure and timing |
| `.agentcrew/debate/04-debate-resolution.md` | Scoring criteria and resolution process |
| `.agentcrew/debate/05-debate-log.md` | Logging format for debate records |

---

*MIT Licensed — Built for AI-native development*
