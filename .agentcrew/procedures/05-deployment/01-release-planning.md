# Release Planning

## Need
- QA sign-off (pass or conditional — must not be fail)
- Build artifact (versioned, from CI — Docker image, binary, or package)
- Known issues list (accepted Medium/Low bugs, UX gaps)
- Release notes template (previous release notes for format reference)

## Decision Tree

```
QA sign-off result?
├── Pass → Full release. Proceed with planning.
├── Conditional → Release with documented known issues. Include in release notes.
└── Fail → Do not plan. Revert to QA or dev.

Is this a major release or patch?
├── Major (new features, breaking changes) → Full release plan. Stakeholder comms. Scheduled window.
├── Minor (feature additions, backward-compatible) → Standard plan. Deploy during business hours.
└── Patch (bug fixes, security patches) → Fast-track. Deploy ASAP if security fix.

Deployment risk?
├── High (DB migration, breaking change, new service) → Scheduled window, extended monitoring, full rollback plan.
├── Medium (config change, new endpoint) → Standard monitoring, rollback plan.
└── Low (bug fix, UI change) → Deploy anytime, quick rollback.
```

## Do

### 1. Release Scope

```
v1.2.3

Included:
  [FEAT] Invoice CSV export (P0)
  [FIX] Export 500 on null customer_id (BUG-012)
  [FIX] Date filter boundary mismatch (BUG-015)

Deferred:
  [FEAT] PDF export — next release
  [FIX] Approval button UX (ISS-001) — next sprint

Breaking Changes:
  None — backward compatible

Dependencies:
  Payment service API v2 (already deployed)
  PostgreSQL migration V003__add_export_log_table (included)
```

- [ ] List everything included, deferred, and explicitly excluded
- [ ] Flag any breaking changes and migration steps

### 2. Release Notes

```markdown
# Release v1.2.3 — Invoice Export

## New Features
- Invoice CSV export: export invoices as CSV with date range filter
- Export performance: 10k rows exported in < 3 seconds

## Bug Fixes
- Fixed: Export returns 500 when invoice has null customer (BUG-012)
- Fixed: Date filter boundary mismatch (BUG-015)

## Known Issues
- Date filter returns empty for valid range in specific edge case (BUG-016)
  Workaround: adjust date range slightly

## Breaking Changes
- None

## Migration Notes
- Run: `V003__add_export_log_table.sql` (automatic with deploy)

## Checksums
- Docker image: accounting-api:v1.2.3 (sha256:abc123...)
- Migration: V003__add_export_log_table.sql (md5: def456...)
```

- [ ] Follow project's existing release notes format
- [ ] Include: features, fixes, known issues, breaking changes, migration notes
- [ ] Include artifact checksums for traceability

### 3. Deploy Window

```
| Environment | Date | Time | Expected Downtime | Approver |
|-------------|------|------|-------------------|----------|
| Staging | Jun 13 | 10:00 UTC | 0 (rolling) | DevOps |
| Production | Jun 14 | 02:00 UTC (off-peak) | < 1 min | PM + Tech Lead |

Production deploy window rationale:
  - Off-peak hours (2 AM UTC = low traffic)
  - Friday deploy (avoid weekend if issues arise — adjust based on team)
  - No expected downtime (rolling update, migrations backward-compatible)
```

- [ ] Staging first, then production (minimum 24h between for validation)
- [ ] Production: off-peak hours, avoid Fridays if possible (or ensure on-call coverage)
- [ ] Document: timezone, expected downtime, approver

### 4. Rollback Plan

```markdown
Rollback triggers:
  - Error rate spike > 5% in first 5 min
  - P95 latency > 2x baseline
  - Critical bug discovered post-deploy (data loss, auth broken)

Rollback steps:
  1. Revert migration: `./scripts/rollback V003__add_export_log_table`
  2. Deploy previous image: accounting-api:v1.2.2
  3. Verify health checks pass
  4. Monitor for 15 min
  5. Announce rollback

Rollback ETA: 5 minutes
```

- [ ] Rollback steps: numbered, executable by on-call engineer
- [ ] Rollback includes: code, DB migration, config changes
- [ ] Rollback triggers defined (quantitative thresholds)

### 5. Smoke Tests

```markdown
Post-deploy smoke tests (< 5 min):
  ✅ Health endpoint returns 200
  ✅ Login with test user works
  ✅ Create invoice returns 201
  ✅ List invoices returns 200
  ✅ Export returns CSV
  ✅ Logout clears session
```

- [ ] 5-10 critical-path checks
- [ ] Can be executed manually or automated (prefer automated)
- [ ] If any smoke test fails → rollback

### 6. Stakeholder Notification

```
Subject: Release v1.2.3 — Invoice Export — June 14, 02:00 UTC
To: eng@, product@, support@

What: Invoice CSV export feature + bug fixes
When: June 14, 02:00-02:15 UTC
Downtime: None expected (rolling update)
Rollback plan: Yes, 5 min ETA

Known issues shipped: BUG-016 (date filter edge case, low risk)
Release notes: [link to release notes]
```

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
- Deploy window scheduled (date, time, downtime expected)
- Rollback plan (steps, triggers, ETA)
- Smoke tests defined (5-10 critical checks)
- Stakeholder notification sent
- Deploy approval from PM + Tech Lead

## Next → `02-staging-deployment.md`
Approval denied? Address concerns and re-plan. Scope disagreement? PM decides.
