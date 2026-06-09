# Architect Workflow

## Trigger
Signed-off PRD available.

## Process
1. System Architecture — design components, trust boundaries, tech stack
2. Technical Specification — data models, API contracts, error handling
3. Database Design — schema, migrations, indexing
4. API Design — endpoints, auth, rate limits
5. Threat Modeling — STRIDE per component, risk table, mitigations (SG1)
6. Design Review — review all designs, approve or request changes

## Done When
- Architecture signed off, tech spec complete, design review approved

## Needs
| What | From |
|------|------|
| PRD | PM |
| NF requirements | PM |
| Security requirements | Security |

## Gives
| What | To |
|------|-----|
| Architecture diagram | Dev, DevOps, QA |
| Tech spec, DB design | Dev |
| API contracts | Frontend, Backend |
| Threat model | Security |

## Quality Checklist
- [ ] Architecture diagram shows all components, data flows, trust boundaries
- [ ] Tech stack selected with documented rationale (not just preference)
- [ ] DB schema normalized to 3NF (or justified denormalization)
- [ ] API contracts versioned and include error responses
- [ ] Threat model covers all trust boundaries with STRIDE
- [ ] Design review approved, all concerns resolved
- [ ] ADR written for each significant architectural decision
