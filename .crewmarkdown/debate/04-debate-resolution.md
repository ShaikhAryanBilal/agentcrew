# Debate Resolution — Pick the Best Solution

## Need
- Debate rounds completed
- Facilitator summary + transcript
- Final positions from all panelists

## Instructions

### 1. Check for Consensus
- [ ] Did all panelists converge on the same option?
- [ ] Any strong objections remaining? (🔴 blocking)
- [ ] If consensus: skip scoring, record decision

### 2. Criteria-Based Scoring (if no consensus)

Score each option against weighted criteria.

#### Step 1: Define Criteria
Pick from standard criteria set (add project-specific as needed):
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

#### Step 2: Weight Criteria
- [ ] Each panelist proposes weights from their role perspective
- [ ] Discuss disagreements (30 sec per disagreement)
- [ ] Final weights = average of panelist weights (rounded)
- [ ] If tie → Architect + PM decide

#### Step 3: Score Each Option
- [ ] Score per criterion: 1 = worst, 5 = best
- [ ] Score rationale required for any score < 3
- [ ] Scores are averaged across all panelists

#### Step 4: Tally
Winner is option with highest average total score.

### 3. Tiebreaker
If top 2 options are within 5%:
- [ ] Round 2 of scoring focused only on tiebreak criteria (Security + Feasibility)
- [ ] If still tied → Facilitator casts deciding vote
- [ ] If facilitator abstains → PM casts deciding vote
- [ ] Record dissenting opinion

### 4. Decision Record
```
- Question: [exact question]
- Winner: Option [N]
- How Decided: Consensus / Criteria scoring / Tiebreaker
- Rationale (3 bullets max)
- Dissenting Opinion (if any)
- Impact: [components, teams, timeline]
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

## Done
- Winner selected
- Scoring matrix complete (if used)
- Decision record written
- Dissenting opinion recorded
- Action items assigned

→ Next: `05-debate-log.md`
Winner feeds into the parent workflow step. Debate artifacts archived for future reference.
