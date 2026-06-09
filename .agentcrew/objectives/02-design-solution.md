# Objective: Design Solution

## Goal
Produce a complete, reviewed design pack: system architecture, tech spec, database design,
API contracts, threat model, UI wireframes, and design approval.

## Squad
| Role | Responsibility |
|------|---------------|
| Architect | System architecture, tech spec, DB design, API design |
| UX Designer | User research, wireframes, visual design, prototype |
| Security Engineer | Threat modeling, STRIDE analysis, compliance |

## Schedule
```
Architect: Arch ──> Tech Spec ──> DB ──> API ──> Review
UX:        Research ──> Wireframes ──> Visual Design ──> Prototype
Security:  Threat Model ────────────> (parallel with Architect)
```

**Parallel**: UX research and Security analysis run concurrent with Architect.  
**Sequential**: Tech spec needs architecture. DB needs tech spec. API needs DB.
Review needs everything. UX handoff to Frontend happens at objective end.

## Dependencies
- **Needs**: Signed-off PRD (from Clarify Vision)
- **Blocks**: Build Feature, Verify Quality

## Artifacts
| Role | Produces | Format |
|------|----------|--------|
| Architect | Architecture diagram + component map | Markdown/Mermaid |
| Architect | Technical specification | Markdown |
| Architect | Database schema DDL | SQL |
| Architect | API contracts (OpenAPI) | YAML |
| UX Designer | User personas + journey maps | Markdown |
| UX Designer | Wireframes + mockups | Markdown/Image |
| UX Designer | Interactive prototype | Link/Description |
| UX Designer | Design system tokens | Markdown |
| Security | Asset inventory + classification | Markdown |
| Security | STRIDE threat table + mitigations | Markdown |
| Security | Compliance checklist | Markdown |
| Architect | Design review approval | Markdown |

## Acceptance
- Architecture covers all P0 feature requirements
- Tech spec includes component spec, data models, config, observability
- DB design includes schema, indexes, migration strategy, backup plan
- API design includes all endpoints, request/response schemas, error format
- Threat model: all STRIDE categories assessed, High/Critical mitigated
- UX: wireframes for all screens, design tokens defined
- Design review: approved (may have conditions)
- SG1 gate: threat model complete, high threats mitigated

## Procedure References
Roles use these existing step files:
- Architect: `procedures/02-design/01-system-architecture.md`, `procedures/02-design/02-technical-specification.md`, `procedures/02-design/03-database-design.md`, `procedures/02-design/04-api-design.md`
- Security: `procedures/02-design/06-threat-modeling.md`
- All: `procedures/02-design/05-design-review.md`

## Debate Triggers
- Tech stack selection (framework, language, DB) → debate/trigger
- Architecture fork (monolith vs microservices) → debate/trigger
- API design philosophy (REST vs GraphQL) → debate/trigger
- UX approach (design system vs custom) → debate/trigger

## Solo Invocation
- "Architect, design the database for [feature]" → Architect runs DB design only
- "UX Designer, create wireframes for [screen]" → UX runs design only
- "Security, do threat modeling for [system]" → Security runs threat model only
- "Architect, review the design" → Runs design review only
