# System Architecture

## Need
- Signed-off PRD with scope + success metrics
- Non-functional requirements (perf, scale, security, compliance)
- Known constraints (budget, timeline, existing infra)

## Instructions

### 1. Actor + System Boundary Map

- [ ] List all actors:
  ```
  | Actor | Type | Initiates? | Authenticated? |
  |-------|------|-----------|----------------|
  | End user | Person | Yes | Yes (JWT) |
  | Admin | Person | Yes | Yes + MFA |
  | Payment Gateway | External System | Yes (webhook) | Yes (HMAC) |
  | Email Service | External System | No | API key |
  ```
- [ ] Draw system boundary: what's IN vs OUT of your system
- [ ] Mark trust boundaries

### 2. Component Decomposition

- [ ] For each component: name, responsibility, 1-sentence only
  ```
  | Component | Responsibility |
  |-----------|---------------|
  | API Gateway | Auth, rate limit, request routing |
  | Invoice Service | Business logic: create, update, export invoices |
  ```
- [ ] Single responsibility per component. If a component does > 1 thing, split.
- [ ] Define communication between components (sync vs async)
- [ ] Mark data stores per component (which DB, cache, blob storage)

### 3. Data Flow Per Major User Story

For each P0 story, draw the flow:

- [ ] Trace happy path completely
- [ ] Trace error path: what happens when each step fails?

### 4. Tech Stack Decisions

Format — every decision needs rationale:
```
| Concern | Choice | Alternatives Considered | Why |
|---------|--------|------------------------|-----|
| API style | REST | GraphQL | Team familiar, simple CRUD |
```

- [ ] Document the decision, not just the choice
- [ ] If team already uses X, default to X unless X is clearly wrong
- [ ] No "we just like it" as rationale

### 5. Scalability Strategy

- [ ] Document scaling dimensions (users, data volume, request rate)
- [ ] Horizontal vs vertical decision per component
- [ ] What breaks first under 10x load? Document the bottleneck.

### 6. Deployment Model

- [ ] Single-region vs multi-region?
- [ ] Environment strategy: dev / staging / prod
- [ ] Infrastructure-as-code approach
- [ ] CI/CD pipeline: build → test → deploy flow

## ADR Template

For each significant decision, write an ADR:

```markdown
# ADR-001: Use REST over GraphQL
## Context
Invoice export API needs to support CSV, future PDF. Team is familiar with REST.
## Decision
REST. GraphQL adds complexity without benefit for current use case.
## Consequences
+ Simpler implementation
- Client needs separate endpoint per export format
## Status
Accepted
## Date
2026-06-08
```

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Over-architect for scale you won't reach | Design for 10x current, not 1000x |
| Draw boxes without data flow | Every box needs arrows showing data movement |
| Choose tech because it's trendy | Choose because it solves the problem |
| Skip trust boundaries | Mark them. Security flaws live at trust boundaries. |
| Make components too small | If it has one method, it's not a component |
| No exit strategy | Document: "if we need to replace X, here's the migration path" |

## Time Budget
| Complexity | Actors | Components | Data Flows | Total |
|-----------|--------|-----------|-----------|-------|
| Simple (2-3 actors, 2-4 components) | 10 min | 15 min | 15 min | 40 min |
| Medium (4-6 actors, 5-8 components) | 15 min | 30 min | 30 min | 1.25 hr |
| Complex (7+ actors, 9+ components, multi-region) | 30 min | 1 hr | 1 hr | 2.5 hr |

## Done
- Component diagram (ASCII or Mermaid)
- Component responsibility table (1-line each)
- Data flow diagrams for P0 stories (happy + error path)
- Tech stack decision table with rationale
- Scalability strategy documented
- Deployment model defined
- ADRs written for top 3 non-obvious decisions
- Trust boundaries marked on diagram

→ Next: `02-technical-specification.md`
Too complex for one pass? Split scope and revert to PRD. Architecture gap found? Flag to PM.
