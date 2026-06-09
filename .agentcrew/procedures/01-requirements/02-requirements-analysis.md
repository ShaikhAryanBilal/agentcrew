# Requirements Analysis

## Need
- Structured requirement list from intake (FR-xxx, NFR-xxx, etc.)
- Blocker questions answered (if any)
- Clarification notes from PM/stakeholder

## Decision Tree — How Deep to Analyze?

```
Are there > 20 requirements?
├── Yes → Group by feature area first. Analyze per group. Do NOT analyze flat.
└── No → Analyze as single list.

Are there contradictions?
├── Yes → Flag to PM before proceeding. Blocked until resolved.
└── No → Proceed.

Is this a new product (greenfield)?
├── Yes → Heavy analysis: personas, user journeys, dependency graph.
└── No → Incremental: delta analysis only. What changes from current?
```

## Do

### 1. Clean + Deduplicate

- [ ] Merge overlapping requirements (same intent, different wording → keep one)
- [ ] Split compound requirements ("user can search and export" → two items)
- [ ] Tag merged items with both original IDs (traceability)
- [ ] Remove anything that's not a requirement (question, opinion, solution idea)

**Merge rule:** If two FRs describe same behavior with 80%+ overlap → merge. Otherwise keep separate.

### 2. Prioritize — MoSCoW + Effort Matrix

| Priority | Label | Rule | What if unsure? |
|----------|-------|------|-----------------|
| **P0** | Must have | No launch without this | PM decides |
| **P1** | Should have | Important, has workaround | PM decides |
| **P2** | Could have | Nice to have, no blocker | Default if unclear |
| **P3** | Won't have | Explicitly deferred | Document why, revisit next cycle |

Effort per item:
```
S = < 1 dev-day     (trivial)
M = 1-3 dev-days    (standard)
L = 1-2 dev-weeks   (complex)
XL = 2+ dev-weeks   (must split)
```

- [ ] Assign MoSCoW priority to each item
- [ ] Estimate effort per item (coarse — refine in sprint planning)
- [ ] Flag P0 items with effort > L — need split or scope review

### 3. Dependency Graph

Map requirements that depend on others:

```
FR-003 (export) ──depends-on──> FR-001 (invoice model)
FR-005 (email)   ──depends-on──> FR-003 (export)
```

- [ ] Draw dependency edges between related FRs
- [ ] If A depends on B, A cannot ship before B
- [ ] Output as:
  ```
  [FR-001] Invoice data model
    └── [FR-003] CSV export
    └── [FR-004] PDF export
          └── [FR-005] Email invoice
  ```
- [ ] Identify circular dependencies → flag to architect

### 4. Conflict Detection

- [ ] Scan for pairs where one FR contradicts another:
  ```
  FR-010: User edits invoice after submission
  vs
  FR-011: Submitted invoices are immutable
  → Flag: "FR-010 vs FR-011 — contradiction. PM to decide: editable or immutable?"
  ```
- [ ] Scan for implicit conflicts (NF requirement vs constraint):
  ```
  NFR-001: Page load < 500ms
  vs
  CR-002: Must use legacy mainframe DB
  → Flag: "500ms on mainframe DB likely impossible. Verify or relax NFR."
  ```
- [ ] Tag all conflicts to PM. Blocked until resolved.

### 5. User Stories

Write ONLY for P0 and P1 items. P2/P3 skip.

Format:
```
Story: As [actor type] I want [goal] so that [reason]
AC1: [concrete condition]
AC2: [edge case]
```

Example:
```
Story: As an accountant I want to export invoices as CSV so that I can import them into QuickBooks
AC1: CSV contains columns: invoice_id, date, amount, status, customer_name
AC2: Date range filter works when start > end → empty result, not error
AC3: Export with 10k+ rows completes within 3 seconds
```

- [ ] Write stories for P0, P1
- [ ] Include 2-3 acceptance criteria per story
- [ ] Link stories back to FR IDs

### 6. Output Format

```
## Analysis: Invoice Export Feature

### Dependency Graph
[FR-001] Invoice model ──→ [FR-003] CSV export ──→ [FR-005] Email invoice

### Prioritized Backlog

P0 (must have):
  [FR-001] Invoice data model (S)
  [FR-003] CSV export (M)

P1 (should have):
  [FR-005] Email invoice (M) — depends on FR-003

P2 (nice to have):
  [FR-006] Scheduled auto-export (L)

### Conflicts
  ❌ P0 FR-001 vs FR-002: Immutable invoices vs edit-after-submit — PM pending

### User Stories
  📖 Accountant exports CSV → see user-stories.md
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Prioritize everything P0 | Only P0 what literally blocks launch. Everything else is P1-P3. |
| Write stories for obvious items | Skip story if behavior is self-explanatory ("login with email") |
| Ignore the dependency graph | Build it. It prevents "we shipped export before invoice data existed" |
| Over-analyze P3 items | P3 gets 0 analysis time. If questioned, "we deferred it." |
| Accept every requirement as-is | Push back on "we need X" — ask "what problem does X solve?" |

## Time Budget

| Backlog Size | Clean | Prioritize | Dependencies | Stories | Total |
|-------------|-------|-----------|-------------|---------|-------|
| < 10 items | 5 min | 5 min | 5 min | 10 min | 25 min |
| 10-20 items | 10 min | 10 min | 10 min | 20 min | 50 min |
| 20+ items | 15 min | 15 min | 15 min | 30 min | 75 min |

## Done
- Clean, deduplicated, split requirement list
- MoSCoW priority + effort estimate per item
- Dependency graph (FRs mapped to FRs)
- Conflict list (resolved or flagged)
- User stories for P0 and P1 (with acceptance criteria)
- All items traceable to original source

## Next → `03-prd.md`
Contradictions unresolved? Block. Otherwise advance.
