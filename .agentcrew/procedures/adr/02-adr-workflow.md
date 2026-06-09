# ADR Workflow

## When to Write an ADR
- Significant architecture decision (framework, DB, protocol, deploy strategy)
- Trade-off with non-trivial consequences
- Decision that impacts multiple teams / objectives
- Any decision that might need revisiting later

## Process
1. **Propose** — Tech Lead or Architect drafts ADR using template
2. **Review** — Squad reviews, may trigger debate if disagreement
3. **Decide** — Architect (technical) or PM (product) makes final call
4. **Record** — Save to `.agentcrew/log/adr/<date>-<slug>.md`
5. **Communicate** — Link ADR in relevant objective artifacts
6. **Enforce** — Add compliance checks (linter, CI gate, review checklist)

## ADR Lifecycle
```
Proposed → Accepted → (optionally) Deprecated → Superseded
```

## Storage
`.agentcrew/log/adr/YYYY-MM-DD-short-description.md`

## Referencing
Other documents reference ADRs as: `[ADR-001: Use PostgreSQL](adr/2026-06-09-use-postgresql.md)`
