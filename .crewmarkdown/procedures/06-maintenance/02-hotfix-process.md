# Hotfix Process

## Need
- Critical production incident (service down, data loss/corruption, exploitable vulnerability)
- Reporter information (who reported, how, what's the impact)

## Instructions

### 1. Triage (< 15 min)

- [ ] Confirm it's a hotfix (P0/Critical only)
- [ ] Quick mitigation attempt (restart, feature flag, config change) — if works, skip code fix
- [ ] If mitigation fails → proceed
- [ ] Communicate: current status, estimated fix time, expected impact

### 2. Fix

```
Branch: git checkout -b hotfix/csv-null-handling main   (from LAST PRODUCTION TAG, not current main)

Rule: MINIMAL change. One change, one file, one purpose.
  ✅ Fix: add null check in CSV row formatter (1 line)
  ❌ Don't: refactor CSV module, upgrade library, rename functions
```

- [ ] Branch from last production tag (not current main)
- [ ] Minimal diff: one reason per hotfix
- [ ] Test written to reproduce the bug (if possible)
- [ ] Conventional commit: `hotfix:` prefix

### 3. Expedited Review

Review rules (hotfix == fast, not sloppy):
  - 1 reviewer minimum (2 if touching payments/auth)
  - Review scope: does fix work? Any side effects? Is the change minimal?
  - Skip: style review, architecture discussion, refactoring suggestions
  - CI must pass: lint + test + build (can skip scan if emergency)

Review time target: < 15 min

- [ ] Fast-track review: focus on correctness, not style
- [ ] CI green (can skip security scan if critical emergency, but document exception)

### 4. Deploy & Verify

- [ ] Bypass staging if production is down (document the exception)
- [ ] Smoke test critical flows after deploy
- [ ] Monitor until error rate returns to baseline
- [ ] Reporter confirms fix

### 5. Backport + RCA

- [ ] Hotfix merged back to main within 24h
- [ ] RCA written within 24h (blameless, timeline format)
- [ ] Action items to prevent recurrence

RCA template:
```
RCA Document: BUG-017 — CSV export 500 on null fields
Timeline: Detection → Response → Mitigation → Verified
Root cause: [technical cause]
Fix: [what was changed]
Prevention: [process changes to prevent recurrence]
Action items: [owner, due]
```

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Hotfix for non-critical issues | Only P0/Critical. Everything else waits for standard release. |
| Refactor during hotfix | One change. One reason. Minimum diff. |
| Skip review ("it's just one line") | One line can break production. Always review. |
| Forget to backport to main | Hotfix on branch = lost if not merged. Cherry-pick to main immediately. |
| No RCA | Hotfix without RCA = same bug will happen again. |
| Blame in RCA | Timeline + root cause + prevention. No "who did this." |

## Time Budget
| Phase | Target | If Complex |
|-------|--------|-----------|
| Triage | < 15 min | 30 min |
| Fix + test | 30 min | 1 hr |
| Review | < 15 min | 30 min |
| Deploy + verify | 30 min | 1 hr |
| RCA | < 24 hr | 48 hr |

Total hotfix cycle: ~1.5 hours (target)

## Done
- Hotfix deployed to production (minimal fix, verified)
- Error rate recovered, reporter confirms fix
- Hotfix merged back to main
- RCA document written (blameless, action items assigned)
- Process improvement items added to backlog

→ Next: `03-feedback-loop.md`
Hotfix causes new issues? Rollback, reassess, re-deploy.
