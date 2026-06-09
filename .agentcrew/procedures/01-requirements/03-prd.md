# PRD Writing

## Need
- Prioritized backlog with user stories (P0, P1)
- Dependency graph
- Conflict resolutions from PM
- Known constraints (tech, timeline, budget, legal)

## Decision Tree

```
Is this a new product or major feature (> 5 P0 items)?
├── Yes → Full PRD template below. Every section required.
└── No → Light PRD. Skip personas, out-of-scope, risk register.

Does it affect external users (not internal)?
├── Yes → Include UX guidelines, a11y, i18n, device support.
└── No → Internal tool → skip UX section, focus on functional.

Is there a compliance implication?
├── Yes → Add compliance section. Involve legal.
└── No → Skip compliance section.
```

## Do

### 1. PRD Template

Copy this template. Fill every section. Remove section instructions (text in `[]`). Do NOT delete section headings — empty = explicitly not applicable.

```markdown
# PRD: [Feature Name]

## 1. Problem Statement
[One sentence. "Currently X takes 4hrs/month. This feature reduces it to 1 click."]
[If you can't write one sentence, you don't understand the problem.]

## 2. Target Users
[Table]

| Persona | Role | Key Need | Example |
|---------|------|----------|---------|
| [Name] | [Job title] | [Pain this solves] | [Real person if possible] |

For internal-only features → skip this section.

## 3. Success Metrics

| Metric | Current | Target | How Measured |
|--------|---------|--------|-------------|
| [e.g. export time] | [e.g. 4 hrs] | [e.g. < 3 sec] | [e.g. perf test] |
| [Adoption rate] | — | [e.g. 80% of users in 2 weeks] | [e.g. analytics] |

SMART only. "Make it faster" → rewrite. "Reduce P95 latency from 2s to 200ms" → keep.

## 4. Scope

### In Scope (this release)
- [FR-001] Invoice data model
- [FR-003] CSV export
- [List P0 + P1 items]

### Out of Scope (explicitly not doing)
- PDF export (future)
- Scheduled auto-export (future)
- [Everything not listed above that someone might assume is included]

### Future (deferred but tracked)
- [FR-006] Scheduled export — revisit after launch

## 5. Feature Details

For each P0 item:

### [FR-003] CSV Export
**User story:** As an accountant I want to export invoices as CSV...
**Acceptance criteria:**
- [ ] AC1: CSV contains correct columns
- [ ] AC2: Date range filter works
- [ ] AC3: 10k rows completes within 3s
**Notes:**
- Delimiter: comma. Semicolon is future configurable.
- Encoding: UTF-8 with BOM (Excel compatibility)

## 6. Non-Functional Requirements

| NFR | Target | Rationale |
|-----|--------|-----------|
| [NFR-001] P95 response time | < 500ms | Accounting team expectation |
| [NFR-002] Uptime | 99.9% | Financial data critical |
| [NFR-003] Concurrent users | 50 simultaneous | Team size × 2 buffer |

Skip if no measurable target. "Fast" is not an NFR.

## 7. UX Requirements
- [ ] Follow existing design system
- [ ] Support keyboard navigation
- [ ] Error states shown inline (not alerts)
- [ ] Loading states for operations > 1s
- [ ] Mobile responsive (if external)
- [ ] a11y: WCAG 2.1 AA minimum
- [ ] i18n: All user-facing strings externalized (if multi-language)

Internal tool → skip this section.

## 8. Constraints

| Type | Constraint | Source |
|------|-----------|--------|
| Tech | Must use existing PostgreSQL | Engineering |
| Timeline | Ship before June 30 | Business |
| Budget | No additional cloud spend | Finance |
| Legal | PII encrypted at rest + in transit | Compliance |

## 9. Dependencies

| Dependency | Impact if delayed | Owner |
|-----------|-------------------|-------|
| Payment webhook API | Blocks FR-003 entirely | Backend team |
| Design system v2 | FR-005 needs new component | Design team |

## 10. Risks + Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Legacy DB can't meet 500ms | Medium | High | Benchmark early, relax target if needed |
| Export > 10k rows times out | Low | Medium | Implement streaming, not full-buffer |

## 11. Stakeholders

| Role | Name | Approval needed? | Informed? |
|------|------|-----------------|-----------|
| Product Manager | [Name] | Yes | — |
| Engineering Lead | [Name] | Yes | — |
| QA Lead | [Name] | No | Yes |
| Legal | [Name] | Only for compliance | If applicable |

## 12. Revision History

| Date | Author | Change |
|------|--------|--------|
| yyyy-mm-dd | [Name] | Initial draft |
```

### 2. Populate Each Section

- [ ] Start with Problem Statement — if this takes > 2 min, you don't understand the ask
- [ ] Map each P0/P1 to a section in Feature Details
- [ ] For each AC: ensure it's testable. "User-friendly error" → rewrite. "Error shows inline with field name and suggested action" → good.
- [ ] Write Out of Scope explicitly — biggest source of misunderstanding is what's NOT included
- [ ] Run risks: think of 3 things that could derail this. If none, think harder.

### 3. PRD Review Gates

Before calling it done:

- [ ] Problem statement readable by a non-technical stakeholder? Test it on someone outside the team.
- [ ] Every "In Scope" item links to a user story or AC?
- [ ] "Out of Scope" list would surprise nobody? Add anything someone might assume is included.
- [ ] Success metrics are measurable (number + unit)?
- [ ] No placeholder text, TODO, "TBD" without a date attached?
- [ ] Total document fits on 2-3 printed pages? (If longer, you're including implementation details. Stop.)

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| PRD > 5 pages | 2-3 pages max. Detail lives in linked specs. |
| "User experience should be good" | Define good: "P95 < 2s, zero errors, WCAG AA" |
| Writing PRD alone | Send draft to PM + 1 dev + 1 QA for 15-min sanity check |
| Including implementation details | PRD is WHAT and WHY. Design doc is HOW. |
| Changing scope without updating | Every scope change updates PRD. Version history. |
| Skipping Out of Scope | This is where scope creep hides. Write it explicitly. |

## Time Budget

| Scope | Sections | Write | Review | Total |
|-------|----------|-------|--------|-------|
| Small (1-3 P0, no NF) | 8 required | 30 min | 10 min | 40 min |
| Medium (3-6 P0, some NF) | 12 sections | 1 hr | 20 min | 1.5 hr |
| Large (6+ P0, external users) | Full template | 2 hr | 30 min | 2.5 hr |
| Compliance-heavy | + compliance review | +1 hr | +1 hr legal | Variable |

## Done
- PRD.md file with all sections filled
- No "TBD" without a date — every unknown has an owner + deadline
- Reviewed by: PM (content), Tech Lead (feasibility)
- Signed off by stakeholders (or pending with dates)

## Next → `04-requirements-review-and-signoff.md`
PM says "this doesn't match what I asked"? Revert to intake.
