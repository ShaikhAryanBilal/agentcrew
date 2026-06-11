# ADR Workflow

## Need
- Significant architecture decision (framework, DB, protocol, deploy strategy)
- Trade-off with non-trivial consequences
- Decision that impacts multiple teams / objectives
- Any decision that might need revisiting later

## Instructions
1. **Propose** — Tech Lead or Architect drafts ADR using template
2. **Review** — Squad reviews, may trigger debate if disagreement
3. **Decide** — Architect (technical) or PM (product) makes final call
4. **Record** — Save to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/adr.md` (derive `<chat-slug>` from request context)
5. **Communicate** — Link ADR in relevant objective artifacts
6. **Enforce** — Add compliance checks (linter, CI gate, review checklist)

## ADR Lifecycle
```
Proposed → Accepted → (optionally) Deprecated → Superseded
```

## Storage
`.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/adr.md`

## Referencing
Other documents reference ADRs as: `[ADR-001: Use PostgreSQL](adr/2026-06-09-use-postgresql.md)`

## Done
- ADR proposed, reviewed, decided
- Filed in log directory
- Communicated to affected teams
- Compliance checks added
