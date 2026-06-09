# Hotfix Process

## Need
- Critical production incident (service down, data loss/corruption, exploitable vulnerability)
- Reporter information (who reported, how, what's the impact)

## Decision Tree

```
Is this a hotfix?
├── Service down or degraded — YES
├── Data loss or corruption — YES
├── Security vulnerability exploitable in production — YES
├── P0 flow completely broken (login, payment, core CRUD) — YES
├── Minor bug, cosmetic issue, feature request — NOT a hotfix → next release
├── Performance degradation but not breaking — NOT a hotfix → next sprint
└── Unsure? → Ask PM + Tech Lead. If they say hotfix, it's a hotfix.

Can the issue be mitigated without a code change?
├── Yes → Feature flag toggle, config change, restart. Monitor. Fix in standard release.
├── No → Proceed with hotfix.
└── Maybe → Try mitigation first (takes < 15 min). If fails, proceed with hotfix.
```

## Do

### 1. Triage (< 15 min)

```markdown
Incident: High error rate on invoice export endpoint — 50% 5xx
Reporter: Monitoring alert (PagerDuty)
Impact: Users cannot export invoices. Accounting team blocked.
Severity: Critical (P0 flow completely broken)

Quick mitigation attempted:
  - Restart pods (no change)
  - Check recent deploy (v1.2.3 deployed 2h ago — possible root cause)
  - Feature flag? (No flag for export feature)
  → Hotfix required

Root cause hypothesis:
  - Export endpoint uses new CSV library that throws on null fields
  - Quick scan of code confirms: library v2.0 changed behavior on null values
```

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

Test: Include a test that reproduces the bug.
  - If test environment is down → manual verification after deploy
  - If test possible → write test, verify fix

Commit: hotfix: handle null fields in CSV export (BUG-017)
```

- [ ] Branch from last production tag (not current main)
- [ ] Minimal diff: one reason per hotfix
- [ ] Test written to reproduce the bug (if possible)
- [ ] Conventional commit: `hotfix:` prefix

### 3. Expedited Review

```markdown
Review rules (hotfix == fast, not sloppy):
  - 1 reviewer minimum (2 if touching payments/auth)
  - Review scope: does fix work? Any side effects? Is the change minimal?
  - Skip: style review, architecture discussion, refactoring suggestions
  - CI must pass: lint + test + build (can skip scan if emergency)

Review time target: < 15 min
```

- [ ] Fast-track review: focus on correctness, not style
- [ ] CI green (can skip security scan if critical emergency, but document exception)
- [ ] If review finds issue with fix → fix it, re-review. Don't bypass review.

### 4. Deploy & Verify

```
Pre-deploy:
  - Monitoring active? ✅
  - Rollback plan: current prod version (before hotfix) is healthy ✅
  - Hotfix branch CI green ✅
  - Deploy window: immediate (production is down) ✅

Deploy:
  1. Deploy hotfix branch to production (bypass staging if necessary)
  2. Verify health checks pass
  3. Run smoke tests (critical flows: login, export, payment)
  4. Monitor for 15 min: error rate returning to baseline

Verify:
  - Reporter confirms fix: "export works now — data is correct"
  - Error rate back to baseline (0.05%)
  - No new errors introduced

Rollback:
  - If hotfix causes new issues → rollback to previous prod version
  - Hotfix is not "done" until monitoring shows recovery
```

- [ ] Bypass staging if production is down (document the exception)
- [ ] Smoke test critical flows after deploy
- [ ] Monitor until error rate returns to baseline
- [ ] Reporter confirms fix

### 5. Backport + RCA

```
### Merge to main
Once hotfix is verified in production:
  git checkout main
  git pull
  git merge hotfix/csv-null-handling
  git push

If main has diverged:
  git cherry-pick <hotfix-commit> into main
  (resolve conflicts, re-test, commit)

### Root Cause Analysis (within 24h)

RCA Document: BUG-017 — CSV export 500 on null fields

Timeline:
  12:00 UTC — v1.2.3 deployed
  13:45 UTC — Alert fires (50% 5xx on export endpoint)
  13:47 UTC — On-call acknowledges
  13:55 UTC — Root cause identified: new CSV library v2.0 null behavior
  14:00 UTC — Hotfix branch created
  14:10 UTC — Hotfix reviewed and approved
  14:15 UTC — Hotfix deployed to production
  14:30 UTC — Error rate back to baseline
  14:35 UTC — Incident closed

Root cause:
  CSV library upgrade included in v1.2.3 changed null handling behavior.
  Library v2.0 throws on null fields; v1.x returned empty string.
  Not caught in code review because library diff not reviewed carefully.

Fix:
  Added null check before accessing field (PR #148)

Prevention:
  - Add library upgrade review checklist item: "check breaking changes in CHANGELOG"
  - Add test: export with null fields in test data
  - Add monitoring: export error rate tracked per minute

Action items:
  | Item | Owner | Due |
  |------|-------|-----|
  | Add library upgrade checklist | Tech Lead | Next sprint |
  | Add null-field test case | QA | This sprint |
  | Add export error rate to alerts | DevOps | This sprint |
```

- [ ] Hotfix merged back to main within 24h
- [ ] RCA written within 24h (blameless, timeline format)
- [ ] Action items to prevent recurrence

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

## Next → `03-feedback-loop.md`
Hotfix causes new issues? Rollback, reassess, re-deploy. Otherwise proceed to feedback.
