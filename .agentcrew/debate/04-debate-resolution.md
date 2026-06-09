# Debate Resolution — Pick the Best Solution

## Need
- Debate rounds completed
- Facilitator summary + transcript
- Final positions from all panelists

## Decision Tree

```
Consensus reached?
├── Yes → Record consensus. Document rationale. Done.
└── No → Still multiple options viable?
    ├── No → Single remaining option. Default winner.
    └── Yes → Use criteria-based scoring to pick winner.
```

## Do

### 1. Check for Consensus

- [ ] Did all panelists converge on the same option?
- [ ] Any strong objections remaining? (🔴 blocking)
- [ ] If consensus: skip scoring, record decision

### 2. Criteria-Based Scoring (if no consensus)

Score each option against weighted criteria. Facilitator leads scoring with panelist input.

#### Step 1: Define Criteria

Pick from standard criteria set (add project-specific as needed):

```
| Criteria | Weight (1-5) | Definition |
|----------|-------------|------------|
| Feasibility | 5 | Can we build this with current team/timeline? |
| Scalability | 3 | Works at 10x current load? |
| Maintainability | 4 | Easy to change in 6 months? |
| Cost | 3 | Development + operational cost |
| Security | 5 | Attack surface, compliance, data safety |
| Performance | 3 | Meets latency/throughput requirements |
| UX | 2 | End-user impact |
| Testability | 3 | Can we automate tests effectively? |
| Time to Market | 4 | How fast can we ship? |
| Risk | 5 | What's the downside if wrong? |
```

#### Step 2: Weight Criteria

Facilitator leads weighting session:

- [ ] Each panelist proposes weights from their role perspective
- [ ] Discuss disagreements on weights (30 sec per disagreement)
- [ ] Final weights = average of panelist weights (rounded)
- [ ] If tie on weight importance → Architect + PM decide

#### Step 3: Score Each Option

Each panelist scores each option 1-5 per criterion:

```
## Scoring Matrix

Option: [Name]

| Criteria | Weight | Score (1-5) | Weighted Score |
|----------|--------|-------------|----------------|
| Feasibility | 5 | 4 | 20 |
| Scalability | 3 | 3 | 9 |
| Maintainability | 4 | 5 | 20 |
| Cost | 3 | 2 | 6 |
| Security | 5 | 4 | 20 |
| Performance | 3 | 4 | 12 |
| UX | 2 | 3 | 6 |
| Testability | 3 | 4 | 12 |
| Time to Market | 4 | 3 | 12 |
| Risk | 5 | 3 | 15 |
| **Total** | | | **132** |
```

- [ ] Score per criterion: 1 = worst, 5 = best
- [ ] Score rationale required for any score < 3
- [ ] Scores are averaged across all panelists (not per-role)

#### Step 4: Tally

```
| Option | Panelist A Score | Panelist B Score | Panelist C Score | Average Total |
|--------|-----------------|-----------------|-----------------|---------------|
| Option 1 | 132 | 128 | 135 | 131.7 |
| Option 2 | 118 | 145 | 120 | 127.7 |
| Option 3 | 95 | 100 | 110 | 101.7 |

Winner: Option 1 (Avg: 131.7)
```

### 3. Tiebreaker

If top 2 options are within 5% of each other:

- [ ] Round 2 of scoring focused only on tiebreak criteria (Security + Feasibility only)
- [ ] If still tied → Facilitator casts deciding vote
- [ ] If facilitator abstains → PM casts deciding vote
- [ ] Record dissenting opinion in decision record

### 4. Decision Record

```
## Decision Record

### Decision
- Question: [exact question]
- Winner: Option [N] — [name]
- Date: yyyy-mm-dd

### How Decided
- [ ] Consensus
- [ ] Criteria scoring (matrix attached)
- [ ] Tiebreaker by: [facilitator / PM]

### Rationale (3 bullets max)
1. [Top reason]
2. [Second reason]
3. [What risk this decision accepts]

### Dissenting Opinion (if any)
- [Panelist role]: [concern]

### Impact
- Affects: [components, teams, timeline]
- Requires: [follow-up actions, approvals]
```

### 5. Action Items

- [ ] Winner option documented in workflow state
- [ ] Losing option rationale archived (may be revisited if winner fails)
- [ ] Dissenting opinion recorded
- [ ] Decision communicated to affected teams

## Anti-Patterns

| Don't | Instead |
|-------|---------|
| Voting without criteria | Score against weighted criteria |
| Loser option discarded entirely | Archive with rationale — it may be the fallback |
| Facilitator pushes their own option | Facilitator stays neutral |
| Ignore dissenting opinion | Record it. It's free risk analysis. |
| Re-debate after scoring | Scoring is final. Trust the process. |

## Output

```
## Debate Resolved
- Decision: [question]
- Winner: [option]
- Method: Consensus / Criteria / Tiebreaker
- Decided by: [facilitator/PM]
- Dissenting: [panelist] — [concern]
```

## Done
- Winner selected
- Scoring matrix complete (if used)
- Decision record written
- Dissenting opinion recorded
- Action items assigned

## Next → `05-debate-log.md`
Winner feeds into the parent workflow step. Debate artifacts archived for future reference.
