# Release Planning

## Need
- QA sign-off (pass or conditional — must not be fail)
- Build artifact (versioned, from CI — Docker image, binary, or package)
- Known issues list (accepted Medium/Low bugs, UX gaps)
- Release notes template (previous release notes for format reference)

## Instructions

### 1. Release Scope

```
v1.2.3
Included:
  [FEAT] Invoice CSV export (P0)
  [FIX] Export 500 on null customer_id (BUG-012)
Deferred:
  [FEAT] PDF export — next release
Breaking Changes: None
```

- [ ] List everything included, deferred, and explicitly excluded
- [ ] Flag any breaking changes and migration steps

### 2. Release Notes

- [ ] Follow project's existing release notes format
- [ ] Include: features, fixes, known issues, breaking changes, migration notes
- [ ] Include artifact checksums for traceability

### 3. Deploy Window

- [ ] Staging first, then production (minimum 24h between for validation)
- [ ] Production: off-peak hours, avoid Fridays if possible (or ensure on-call coverage)
- [ ] Document: timezone, expected downtime, approver

### 4. Rollback Plan

```
Rollback triggers:
  - Error rate spike > 5% in first 5 min
  - P95 latency > 2x baseline
  - Critical bug discovered post-deploy

Rollback steps:
  1. Revert migration
  2. Deploy previous image
  3. Verify health checks pass
  4. Monitor for 15 min
  5. Announce rollback
```

- [ ] Rollback steps: numbered, executable by on-call engineer
- [ ] Rollback includes: code, DB migration, config changes
- [ ] Rollback triggers defined (quantitative thresholds)

### 5. Smoke Tests

- [ ] 5-10 critical-path checks
- [ ] Can be executed manually or automated (prefer automated)
- [ ] If any smoke test fails → rollback

### 6. Stakeholder Notification

- [ ] Send notification 24h before deploy
- [ ] Include: what, when, expected impact, rollback plan, known issues

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Deploy without release plan | Even patch releases get a plan. 5 min of planning. |
| Skip rollback plan | Every deploy has a rollback. Assume it will fail. |
| Deploy on Friday afternoon | Off-peak hours, early week preferred. |
| Ignore known issues in release notes | List them. Users discover them anyway. |
| No smoke tests | 5 minutes of checks saves hours of incident response. |

## Time Budget
| Release Type | Scope | Notes | Rollback | Notify | Total |
|-------------|-------|-------|----------|--------|-------|
| Patch | 10 min | 10 min | 5 min | 5 min | 30 min |
| Minor | 15 min | 20 min | 10 min | 10 min | 55 min |
| Major | 30 min | 30 min | 15 min | 15 min | 1.5 hr |

## Done
- Release scope document (included, deferred, breaking changes)
- Release notes (features, fixes, known issues, migration notes)
- Deploy window scheduled
- Rollback plan (steps, triggers, ETA)
- Smoke tests defined (5-10 critical checks)
- Stakeholder notification sent
- Deploy approval from PM + Tech Lead

→ Next: `02-staging-deployment.md`
Approval denied? Address concerns and re-plan. Scope disagreement? PM decides.
