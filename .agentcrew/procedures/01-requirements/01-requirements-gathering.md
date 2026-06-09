# Requirements Intake

## Need
- Raw message from any source: email, WhatsApp, Slack, ticket, voice note, screenshot, 2AM DM
- Source attribution (who, channel, timestamp)
- Decision tree first:

```
Is the request a single sentence?
├── Yes → Is it actionable? ("Add dark mode")
│   ├── Yes → Accept. Flag low confidence. Send clarification pre-emptively.
│   └── No → ("Make it better") → Ask: "What specific problem? What's the measurable outcome?"
└── No → Is it detailed? (paragraph, screenshots, references)
    ├── Yes → Extract structured. High confidence.
    └── No → Multiple fragments → Merge, dedupe, flag contradictions.

Is there a financial/security/legal implication?
├── Yes → Flag immediately. Tag compliance.
└── No → Standard path.
```

## Do

### 1. Parse — 5W1H+C Extraction

Extract from raw input. If missing, mark gap.

| Field | What | Example |
|-------|------|---------|
| **Who** | Stakeholder(s) | "PM Sarah", "Customer support team" |
| **What** | Desired capability | "Export invoices as CSV" |
| **Why** | Business reason | "Accounting team needs to import into QuickBooks" |
| **When** | Timeline | "Before month-end close (June 30)" |
| **Pain** | Current friction | "Manual copy-paste takes 4 hrs every month" |
| **How** | Measure of success | "1-click export, < 3 sec for 10k rows" |
| **Constraint** | Tech/budget/legal | "No cloud storage, must be on-prem" |

- [ ] Parse into table above. Mark gaps as `❓`
- [ ] Flag implicit assumptions (things stated as fact but unverified)
- [ ] Rate confidence per item: High / Medium / Low

### 2. Gap Analysis

For each `❓` gap:

```
Is this a blocker (cannot design without it)?
├── Yes → Add to question queue. Mark MUST answer before next step.
└── No → Note as assumption, document decision will be revisited.

Is this a contradiction? (two stakeholders want opposite things)
├── Yes → Flag to PM. Do NOT resolve yourself.
└── No → Skip.
```

### 3. Classification — Tag Every Requirement

| Tag | Color | Meaning | Example |
|-----|-------|---------|---------|
| `[F]` | Functional | Feature, behavior | "User can reset password" |
| `[NF]` | Non-functional | Performance, scale, security | "Page loads < 2s on 3G" |
| `[B]` | Business | Process, policy, rule | "Orders > $500 require manager approval" |
| `[T]` | Tech | Infrastructure, tooling | "Deploy to Kubernetes, not bare metal" |
| `[C]` | Constraint | Hard boundary | "Must use existing PostgreSQL, no new DB" |

- [ ] Tag each parsed item
- [ ] Write as: `FR-001: As [actor] I want [capability] (Source: Slack #product, Confidence: High)`
- [ ] Use prefix: `FR-` (functional), `NFR-` (non-func), `BR-` (business), `TR-` (tech), `CR-` (constraint)

### 4. Clarification — Only Blockers

- [ ] Generate questions ONLY for blocker gaps (can't proceed without answer)
- [ ] Format per question:
  ```
  Q: Can [system] export [format] to [destination]?
  Why: Design depends on format — CSV vs JSON vs both.
  Blocker: Yes — cannot spec export endpoint without format.
  ```
- [ ] Send as single message (not a barrage)
- [ ] Set expected response deadline
- [ ] If no answer by deadline → escalate to PM with impact statement

### 5. Output Format

Final output is a structured requirement list. Example:

```
## Requirements — Invoice Export (FR-001 — FR-005)

| ID | Description | Tag | Source | Confidence | Priority |
|----|-------------|-----|--------|------------|----------|
| FR-001 | Export single invoice as CSV | F | Slack #product | High | — |
| FR-002 | Export batch (select date range) | F | Meeting 06/01 | Medium | — |
| FR-003 | Export completes < 3s for 10k rows | NF | Email from Sarah | Low | — |
| FR-004 | Must NOT use cloud storage | C | Legal policy | High | — |
| ❓ | What delimiter? Comma vs semicolon? | — | Gap | — | — |
```

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Ask every question you can think of | Ask only blockers. Save non-blockers for analysis. |
| Accept "ASAP" as a deadline | Pin to a date. "ASAP" is anxiety, not a date. |
| Rewrite the user's words | Quote raw, then restate. Don't lose their language. |
| Assume technical terms are understood | Define acronyms on first use. Always. |

## Time Budget

| Input Quality | Parse | Gaps | Classify | Total |
|---------------|-------|------|----------|-------|
| Clear request (paragraph) | 5 min | 2 min | 3 min | 10 min |
| Vague (sentence/fragment) | 5 min | 5 min | 3 min | 13 min + questions |
| Contradictory | 10 min | 10 min | 5 min | 25 min + PM escalation |
| Long (email chain, doc) | 15 min | 10 min | 10 min | 35 min |

Exceeded budget? You're over-analyzing. Ship the gap list with the question queue.

## Done
- Structured requirement list (ID, description, tag, source, confidence)
- Gap list with blocker/non-blocker labels
- Clarification questions sent (if any blockers)
- Confidence per item documented

## Next → `02-requirements-analysis.md`
Blocked? Wait for answers. No blockers? Advance.
