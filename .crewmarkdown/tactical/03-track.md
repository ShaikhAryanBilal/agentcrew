# Tactical Mode — Track

## Purpose
Maintain running action register and thread state across all dispatches.

## Steps
1. After each dispatch: add entry to `.crewmarkdown/tactical/action-register.md`
   - Format: `[ID] [status] — [action] — [owner] — [created] — [updated]`
2. Monitor action status:
   - `pending` → just dispatched
   - `active` → role has begun work
   - `done` → artifact produced and verified
   - `stale` → no update in 5+ dispatches — flag for user
3. Update action status when:
   - Role reports progress → mark as active
   - Artifact delivered → mark as done
   - User changes priority → update as needed
4. Prune stale entries after 10 dispatches since last update
5. Periodically check thread state health:
   - Active dispatches not stalled
   - Pending actions not forgotten
   - Decision log referenced in new dispatches

## Outputs
- Updated action register
- Pruned stale entries (moved to archive section)
- Health report if any dispatch is stalled

## Preconditions
- Tactical mode is active
- At least one dispatch has been made

## Postconditions
- Action register reflects current state of all dispatches
- Stale entries flagged or archived
