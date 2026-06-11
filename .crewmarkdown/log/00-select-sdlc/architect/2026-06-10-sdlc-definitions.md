# Log: SDLC Model Definitions Created

**Role:** Architect  
**Date:** 2026-06-10T13:39:00Z  
**Objective:** Select SDLC Model (obj/select-sdlc)

## Work Done
- Created `.crewmarkdown/config/sdlc-models.md` with full definitions for 8 SDLC models:
  - Waterfall (linear-sequential, 6 phases, SG0→SG4 strict)
  - V-Model (V-shaped, dev phases paired with test phases)
  - Spiral (risk-driven iterative, evaluation gate per cycle)
  - Agile/Scrum (timeboxed sprints, per-PR gates)
  - Iterative (refinement cycles, per-iteration evaluation)
  - Incremental (per-increment full gate chain)
  - Big Bang (single pass, high risk)
  - RAD (prototype loops, demo acceptance)
- Each model includes: phase map, phase details table, transitions, gate sequence, risk pattern
- Added selection_criteria scoring matrix across 6 dimensions

## Selection Criteria Designed
| Dimension | Low | Medium | High |
|-----------|-----|--------|------|
| Requirement clarity | Waterfall, V-Model | Spiral, Incremental | Agile, Iterative, RAD |
| Risk tolerance | Waterfall, V-Model | Incremental, Iterative | Spiral, Agile, RAD |
| Team size | Agile, RAD, Iterative | Incremental, Spiral | Waterfall, V-Model |
| Project complexity | Big Bang, RAD | Agile, Iterative, Incremental | Spiral, Waterfall, V-Model |
| User involvement | Waterfall, V-Model, Big Bang | Spiral, Incremental | Agile, Iterative, RAD |
| Delivery speed | Waterfall, V-Model | Spiral, Incremental, Iterative | Agile, RAD, Big Bang |

## Artifacts
- `.crewmarkdown/config/sdlc-models.md`
