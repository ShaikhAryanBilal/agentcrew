## Debate Archive

- **Decision**: Should we build with vanilla HTML/CSS/JS for an app serving thousands of concurrent users?
- **Slug**: vanilla-vs-framework-debate
- **Date**: 2026-06-10
- **Phase**: Cross-cutting (design)
- **Parent Step**: Debate trigger via Debator role

### Brief
Decision question: Should the app use vanilla HTML/CSS/JS or a framework/backend stack given 1000s of concurrent users? Context: early-stage product, small team, need to ship fast. Constraints: team is comfortable with vanilla JS, no existing framework preference.

### Panel
| Role | Panelist | Initial Stance | Final Stance | Shift? |
|------|----------|---------------|-------------|--------|
| Architect | Debator | Framework (React/Vue/Svelte) + backend | Svelte + backend | Yes — softened from "any framework" to "Svelte specifically" |
| Backend | Debator | Vanilla frontend + backend API | Vanilla frontend + backend API | No |
| Frontend | Debator | Lightweight framework (Preact/Svelte/Lit) | Svelte | No |
| DevOps | Debator | Vanilla on CDN (zero build) | Svelte on CDN (compiled = near-vanilla) | Yes — accepted Svelte compiled output |
| Security | Debator | Vanilla fine, security is backend work | Vanilla/Svelte both fine | No |
| PM | Debator | Vanilla MVP, migrate later | Svelte MVP, no migration needed | Shifted — accepted Svelte as compromise |

### Transcript Summary
- **R1**: Architect argued framework for structure at scale. Backend countered vanilla+API is proven. Frontend proposed Svelte/Preact as middle ground. DevOps pushed CDN-first. Security said framework irrelevant for security. PM said ship fast.
- **R2**: Architect challenged PM on migration cost. PM countered that 80% don't reach migration scale. Frontend raised SEO — DevOps offered prerender solution. Architect warned of code degradation past 20 screens.
- **R3**: Architect softened to Svelte. DevOps accepted compiled output. PM embraced Svelte as fast-track. Consensus reached.

### Scoring Matrix
Not needed — consensus reached in Round 3.

### Decision
- **Winner**: Svelte frontend + lightweight backend API + CDN delivery
- **Runner-up**: Pure vanilla + backend API
- **Method**: Consensus
- **Rationale**: Svelte is compile-time (zero runtime overhead, ~0KB framework cost), provides component structure without virtual DOM, ships like vanilla on CDN, prevents XSS via compiler. Backend handles auth/data/scaling.

### Action Items
| Owner | Task | Deliverable | Deadline |
|-------|------|-------------|----------|
| PM | Write user stories for MVP screens | PRD | Next session |
| Architect | Define system architecture (Svelte + API + CDN) | Architecture doc | Next session |
| DevOps | Set up Svelte scaffold + CDN config | Repo + pipeline | Next session |

### Retrospective (to be filled after parent step completes)
- Was the decision correct? TBD
