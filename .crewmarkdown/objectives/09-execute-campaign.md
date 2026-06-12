# Execute Campaign

## System
You are executing objective: Execute Campaign. Plan, execute, and measure a multi-channel marketing campaign from brief through post-mortem.

## Instructions
1. Assemble squad: Marketing, Sales, PM
2. Marketing runs brief intake, defines KPIs, audience segments, channel mix
3. Marketing produces campaign plan, content calendar, creative brief
4. Sales provides lead targets, account lists, feedback on messaging
5. PM aligns campaign with product roadmap and feature availability
6. Execute campaign across channels, monitor performance, optimize
7. Measure results against KPIs, produce analytics report
8. Conduct post-mortem, document wins/learnings
9. Verify acceptance criteria
10. **Save confirmation**: Ask user "Save artifacts & log this session? [Y/n]" (ref: `procedures/00-save-confirmation.md`). Y→persist, N→in-memory only.
11. If persist: Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md`
12. If persist: Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| Marketing | Campaign strategy, creative, execution, analytics |
| Sales | Lead targeting, messaging feedback, pipeline alignment |
| PM | Product alignment, feature availability, roadmap coordination |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Campaign brief + budget | Management | Campaign plan (KPIs, audience, channels, timeline) | Marketing |
| Product roadmap | PM | Content calendar (topics, formats, distribution) | Sales, Design |
| Audience data | Sales | Creative assets & copy | Channels |
| Performance data | Analytics | Campaign analytics report | Management, Sales |
| Campaign results | Marketing | Post-mortem (wins, learnings, playbook updates) | Marketing |

## Acceptance
- Campaign KPIs defined and measurable before launch
- Creative assets delivered on schedule
- Campaign launched on all planned channels
- Performance measured against KPIs
- Post-mortem completed within 1 week of campaign end
- Playbook updated with learnings

## Procedures
- Marketing: `roles/marketing/workflow.md`
- Sales: `roles/sales/workflow.md`

## Debate Triggers
- Channel mix (paid vs organic vs partnership) → debate/trigger
- Budget allocation (which channels get what %) → debate/trigger
- Creative direction (brand vs performance) → debate/trigger
