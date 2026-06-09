# Post-Mortem: [Incident Title]

## Incident Summary
| Field | Value |
|-------|-------|
| Date | YYYY-MM-DD |
| Duration | Xh Ym |
| Severity | SEV1 / SEV2 / SEV3 |
| Impact | [users affected, data loss, $ cost] |
| Root cause | [1 sentence] |

## Timeline
| Time | Event |
|------|-------|
| T+X | Detection |
| T+Y | Response started |
| T+Z | Mitigation applied |
| T+W | Verified resolved |

## Detection
How was this discovered? (alert, user report, automated check)
How quickly? Was detection faster or slower than target?

## Root Cause Analysis
### What happened?
Narrative of the incident from trigger to resolution.

### Why did it happen?
Immediate technical cause.

### Why wasn't it caught?
Which controls should have prevented or detected this?

## Contributing Factors
- System: [architecture issues, missing redundancy, etc.]
- Process: [missing tests, no review, no runbook, etc.]
- Human: [fatigue, knowledge gap, etc.]

## Action Items
| Action | Owner | Type | Tracked As |
|--------|-------|------|------------|
| Fix root cause | Tech Lead | prevent | GitHub issue |
| Add monitoring | DevOps | detect | GitHub issue |
| Update runbook | DevOps | respond | PR |
| Add test | Dev | prevent | PR |

## What Went Well
- [Things that worked correctly during the incident]

## What Went Wrong
- [Things that should have gone better]

## Blameless Statement
This post-mortem documents facts for learning. We do not blame individuals.
Systems and processes failed — we fix those.
