# Light Variant — Objective-Based (7-Step)

Trims full lifecycle to essentials for small projects / MVPs / prototypes.
Uses same objective-based routing as full but with compressed scope.

## Request → Objective

| Request | Objective | Solo / Squad |
|---------|-----------|-------------|
| "Build feature" / "New project" | Clarify Vision (light) | PM solo |
| "Design the system" | Design Solution (light) | Architect solo |
| "Plan the sprint" | Plan Work (light) | EM solo |
| "Implement X" / "Write code" | Build Feature (light) | Dev solo |
| "Test this" | Verify Quality (light) | Dev solo (self-test) |
| "Deploy to prod" / "Release" | Ship Release (light) | DevOps solo |
| "Set up monitoring" / "Hotfix" | Operate & Learn (light) | DevOps solo |
| "Bug found" | qa/bugfix flow | Dev solo |

## Objective Definitions (Light)

### 1. Clarify Vision (light) — max 30 min
**Goal:** 1-page PRD
**Squad:** PM solo
**Do:** Write minimal PRD with problem, 3 core features, constraints, 1 success metric
**Done:** PRD.md (1 page max)

### 2. Design Solution (light) — max 1 hr
**Goal:** 1-page design sketch
**Squad:** Architect solo
**Do:** Ascii diagram, data model, key endpoints, key decision + rationale, trust boundary
**Done:** design.md (1 page max)

### 3. Plan Work (light) — max 30 min
**Goal:** Task breakdown
**Squad:** EM solo
**Do:** Break feature into tasks (≤1 dev-day each), estimate effort (S/M/L/XL)
**Done:** Task list in state

### 4. Build Feature (light)
**Goal:** Working code with tests
**Squad:** Dev solo
**Do:** Branch → implement → self-review → PR → merge
**Constraints:** No function > 40 lines, no TODOs, no secrets
**Done:** Feature on main with CI passing

### 5. Verify Quality (light) — max 1 hr
**Goal:** Smoke test + bug check
**Squad:** Dev solo
**Do:** Run CI, manual smoke test critical flows, log any bugs
**Done:** Test report (pass/fail per flow)

### 6. Ship Release (light) — max 30 min
**Goal:** Deploy to production
**Squad:** DevOps solo
**Do:** Tag → deploy → smoke test (5 min) → 15 min monitoring
**Security gate:** Dep scan clean + no secrets in repo
**Rollback:** Previous tag
**Done:** Live feature, monitoring stable (15 min)

### 7. Operate & Learn (light) — max 30 min
**Goal:** Verify + log
**Squad:** DevOps solo
**Do:** Monitor error rate, latency, CPU/memory (30 min), log observations
**Done:** All-clear report

## Bug Fix Flow (qa/bugfix) — max 1 hr
- [ ] Reproduce bug, log steps
- [ ] Fix: minimal change, include test
- [ ] 1 reviewer (fast track)
- [ ] Deploy per Ship Release (light) — bypass staging if critical
- [ ] Verify fix in production
- [ ] RCA within 24h: why bug reached prod? prevention?

## Usage

Light variant mirrors the full objective structure but collapses scope.
Switch between light and full based on project complexity.
