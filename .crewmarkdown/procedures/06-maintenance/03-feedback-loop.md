# Feedback Loop

## Need
- Completed release or sprint (deploy successful or rolled back)
- Data: monitoring metrics, incidents, user feedback, team input
- Previous action items (from last retro, uncompleted)
- Team available for retrospective

## Instructions

### 1. Data Collection (Before Retro)

Collect: velocity, completion rate, bug count, incident count, test coverage, satisfaction
Compare to previous sprint/cycle (trend, not snapshot)
Include: what was planned, what was delivered, what went wrong

### 2. Retrospective

```
## Retro: Sprint 12 (June 8-19)

### What Went Well
- CSV export feature delivered on time

### What Went Wrong
- P1 pass rate below target (89% vs 95%)

### What To Improve
1. Library upgrade checklist — add to code review
2. Test planning: align P1 scope with timeline

### Action Items
| # | Action | Owner | Due |
|---|--------|-------|-----|
| 1 | Add "breaking changes in CHANGELOG" to code review | Tech Lead | Next sprint |
```

- [ ] 3 categories: went well, went wrong, to improve
- [ ] Keep blameless. Focus on process, not people.
- [ ] Action items: specific, owned, dated

### 3. Improvement Backlog

- [ ] Each improvement item has: type, effort estimate, impact assessment
- [ ] Assign to upcoming sprint
- [ ] Track completion in next retro

### 4. Release Retrospective (for major releases)

- [ ] Separate from sprint retro if release spans multiple sprints
- [ ] Focus on: release process, not sprint process

### 5. Close the Loop

- [ ] Action items from this retro → added to backlog with owners
- [ ] Previous retro action items → status: completed / in progress / canceled
- [ ] Process changes documented (update workflow step files if needed)
- [ ] Celebrate: team wins, individual contributions, customer praise

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Retro without data | Bring metrics. Opinions without data are noise. |
| Blame individuals | "We failed" not "you failed." Process problem, not people. |
| Action items without owners | Every item has a name. No "team to investigate." |
| Too many action items | Top 3-5. Everything else is backlog. |
| Retro without follow-up | Start next retro with: "did we complete our action items?" |
| Skip retro when busy | Most important retro is after a bad sprint. Don't skip. |

## Time Budget
| Type | Data Collection | Retro | Write-up | Total |
|------|----------------|-------|----------|-------|
| Quick (after hotfix) | 10 min | 20 min | 10 min | 40 min |
| Sprint retro (2 weeks) | 15 min | 45 min | 15 min | 1.25 hr |
| Major release retro | 30 min | 1 hr | 30 min | 2 hr |

## Done
- Retro notes (went well, went wrong, to improve)
- Action items (3-5 items with owners and deadlines)
- Action items from previous retro reviewed
- Improvement items added to backlog
- Process docs updated (if changes adopted)
- Wins celebrated

→ Next: `01-requirements/01-requirements-gathering.md` (loop back — new cycle begins)
No improvements identified? Continue to next feature cycle.
