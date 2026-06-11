# Design Solution

## System
You are executing objective: Design Solution. Produce a complete, reviewed design pack: system architecture, tech spec, database design, API contracts, threat model, UI wireframes, and design approval.

## Instructions
1. Assemble squad: Architect, UX Designer, Security Engineer
2. Run in parallel: UX research, Security threat modeling, Architect defining architecture
3. Architect produces tech spec (needs architecture), DB design (needs tech spec), API contracts (needs DB) sequentially
4. UX produces wireframes, visual design, prototype after research
5. Security produces STRIDE threat table, asset inventory, compliance checklist
6. All roles participate in design review (procedures/02-design/05-design-review.md)
7. Verify acceptance criteria
8. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md` (derive `<chat-slug>` from request text)
9. Update `.crewmarkdown/state/workflow.json`

## Squad
| Role | Responsibility |
|------|---------------|
| Architect | System architecture, tech spec, DB design, API design |
| UX Designer | User research, wireframes, visual design, prototype |
| Security Engineer | Threat modeling, STRIDE analysis, compliance |

## Inputs → Outputs
| Input | From | → Output | To |
|-------|------|---------|----|
| Signed-off PRD | PM | Architecture diagram + component map (Markdown/Mermaid) | Review |
| Architecture | Architect | Technical specification (component spec, data models, config, observability) | Review |
| Tech spec | Architect | Database schema DDL (SQL) | Review |
| DB design | Architect | API contracts OpenAPI (YAML) | Review |
| User needs | PRD | User personas + journey maps (Markdown) | Review |
| Research insights | UX | Wireframes + mockups (Markdown/Image) | Review |
| Wireframes | UX | Interactive prototype (Link/Description) | Review |
| Design decisions | UX | Design system tokens (Markdown) | Review |
| System scope | PRD | Asset inventory + classification (Markdown) | Review |
| Architecture | Security | STRIDE threat table + mitigations (Markdown) | Review |
| Requirements | Security | Compliance checklist (Markdown) | Review |
| All artifacts | All | Design review approval (Markdown) | PM |

## Acceptance
- Architecture covers all P0 feature requirements
- Tech spec includes component spec, data models, config, observability
- DB design includes schema, indexes, migration strategy, backup plan
- API design includes all endpoints, request/response schemas, error format
- Threat model: all STRIDE categories assessed, High/Critical mitigated
- UX: wireframes for all screens, design tokens defined
- Design review: approved (may have conditions)
- SG1 gate: threat model complete, high threats mitigated

## Gates
- **SG1**: Threat model complete, high threats mitigated

## Procedures
- Architect: `procedures/02-design/01-system-architecture.md`
- Architect: `procedures/02-design/02-technical-specification.md`
- Architect: `procedures/02-design/03-database-design.md`
- Architect: `procedures/02-design/04-api-design.md`
- Security: `procedures/02-design/06-threat-modeling.md`
- All: `procedures/02-design/05-design-review.md`

## Debate Triggers
- Tech stack selection (framework, language, DB) → debate/trigger
- Architecture fork (monolith vs microservices) → debate/trigger
- API design philosophy (REST vs GraphQL) → debate/trigger
- UX approach (design system vs custom) → debate/trigger
