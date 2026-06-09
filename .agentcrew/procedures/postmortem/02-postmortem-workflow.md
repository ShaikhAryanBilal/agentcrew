# Post-Mortem Workflow

## Trigger
- SEV1/SEV2 incident resolved
- SEV3 incident with meaningful lesson
- Security breach (mandatory)
- Recurring issue pattern identified

## When to Run
- Within 48h of incident resolution (while fresh)
- Before closing the incident
- All action items tracked before post-mortem is finalized

## Process
1. **Collect Data** — gather timeline, logs, metrics, chat transcripts
2. **Draft** — facilitator (or lead responder) fills template
3. **Review** — whole team reviews for accuracy, completeness
4. **Blameless Check** — ensure no individual blame language
5. **Action Items** — assign owners, link tickets, set deadlines
6. **Publish** — save to `.agentcrew/log/postmortem/<date>-<slug>.md`
7. **Track** — action items tracked in sprint/backlog until closed

## Roles
| Role | Responsibility |
|------|---------------|
| Facilitator | Runs the post-mortem meeting, keeps blameless |
| Scribe | Takes notes, drafts the document |
| Subject matter expert | Explains what happened technically |
| Action item owner | Fixes the root cause |

## Blameless Culture Rules
- Focus on systems, not people
- "What could we change so this never happens again?"
- No "should have" language directed at individuals
- Assume good intent from everyone
