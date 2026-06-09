# Feedback Loop

## Need
- Completed release or sprint (deploy successful or rolled back)
- Data: monitoring metrics, incidents, user feedback, team input
- Previous action items (from last retro, uncompleted)
- Team available for retrospective

## Decision Tree

```
Was the release successful?
├── Yes (deployed, stable, no major incidents) → Standard retro. Focus on what went well + improvements.
├── Yes (but with incidents) → Incident-focused retro. Root cause + prevention.
├── Rolled back → Full retro. What went wrong? Process failure?
└── Canceled before deploy → Light retro. What blocked? Fix process?

What's the cadence?
├── End of sprint (2 weeks) → Full retro (1h)
├── After major release → Full retro (1h) + release retrospective
├── After hotfix → Quick retro (30 min) — separate from sprint retro
└── Monthly check-in → Light review (30 min) — metrics review only
```

## Do

### 1. Data Collection (Before Retro)

```markdown
### Sprint Metrics
- Velocity: 45 pts (previous: 42 pts) — stable
- Completion: 8/10 committed stories delivered
- Bugs: 3 found in testing, 2 found post-deploy
- Hotfix count: 1 (BUG-017)
- Test coverage: 83% on new code (target: 80%)

### Quality Metrics
- P0 pass rate: 100%
- P1 pass rate: 89% (below 95% target)
- Regression bugs: 1 (BUG-015 — fixed)
- Security findings: 2 Medium (fixed)
- UAT satisfaction: 3.8/5

### Incident Metrics
- Incidents: 1 (hotfix — CSV export null handling)
- MTTR: 50 min (target: < 60 min)
- Root cause: library upgrade not reviewed for breaking changes
```

- [ ] Collect: velocity, completion rate, bug count, incident count, test coverage, satisfaction
- [ ] Compare to previous sprint/cycle (trend, not snapshot)
- [ ] Include: what was planned, what was delivered, what went wrong

### 2. Retrospective

```markdown
## Retro: Sprint 12 (June 8-19)

### What Went Well
- CSV export feature delivered on time (commitment met)
- UAT satisfaction high (accountant: 5/5)
- Hotfix turnaround: 50 min (fast response)
- Code review quality improved (fewer blocking issues)

### What Went Wrong
- P1 pass rate below target (89% vs 95%) — test cases were too aggressive for timeline
- Library upgrade breaking change not caught in review (caused hotfix)
- Staging environment contention with other team (delayed testing by 1 day)

### What To Improve
1. Library upgrade checklist: "read CHANGELOG for breaking changes" — add to code review
2. Test planning: align P1 scope with timeline, not ideal
3. Staging environment: schedule with other team or add isolated test namespace
4. Feature flags: add flags for high-risk features so we can disable without hotfix

### Action Items
| # | Action | Owner | Due | Type |
|---|--------|-------|-----|------|
| 1 | Add "breaking changes in CHANGELOG" to code review checklist | Tech Lead | Next sprint | Process |
| 2 | Review P1 test scope — right-size for sprint duration | QA | Next sprint | Process |
| 3 | Schedule staging environment usage with Platform team | DevOps | This week | Coordination |
| 4 | Add feature flag support to deployment pipeline | DevOps | Next sprint | Tooling |
```

- [ ] 3 categories: went well, went wrong, to improve
- [ ] Keep blameless. Focus on process, not people.
- [ ] Action items: specific, owned, dated

### 3. Improvement Backlog

```markdown
| Item | Type | Effort | Impact | Sprint |
|------|------|--------|--------|--------|
| Library upgrade checklist | Process | S | High | Next |
| P1 test scope planning | Process | S | Medium | Next |
| Staging env scheduling | Coordination | M | High | Next |
| Feature flags | Tooling | L | High | Sprint+2 |
| Export null test case | Test | S | High | This sprint |
```

- [ ] Each improvement item has: type, effort estimate, impact assessment
- [ ] Assign to upcoming sprint
- [ ] Track completion in next retro

### 4. Release Retrospective (for major releases)

```markdown
### Release v1.2.3 Retro

What worked in the release process:
  - Release planning was thorough (rollback plan, smoke tests, deploy window)
  - QA sign-off document was comprehensive
  - Stakeholder communication clear

What didn't work:
  - Library upgrade slipped through code review
  - Staging deploy delayed due to environment contention

Process changes for next release:
  - Add "dependency changes" section to PR template
  - Reserve staging environment 48h before target deploy date
```

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
- Action items from previous retro reviewed (completed/in progress/canceled)
- Improvement items added to backlog
- Process docs updated (if changes adopted)
- Wins celebrated

## Next → `01-requirements/01-requirements-gathering.md` (loop back — new cycle begins)
No improvements identified? Continue to next feature cycle.
