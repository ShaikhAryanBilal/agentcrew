# Tactical Mode — Activate

## Purpose
Initialize the continuous tactical thread on `/tactical` invocation.

## Steps
1. Create thread state file at `.crewmarkdown/tactical/thread-state.json`
2. Initialize with: activation timestamp, dispatch counter (0), active dispatches [], action register ref
3. Create action register at `.crewmarkdown/tactical/action-register.md`
4. Create decision log at `.crewmarkdown/tactical/decision-log.md`
5. Announce to user: "Tactical mode active. Standing by for requests."
6. Set context: thread is now in continuous mode — all requests will be dispatched dynamically

## Outputs
- `.crewmarkdown/tactical/thread-state.json` — initialized
- `.crewmarkdown/tactical/action-register.md` — initialized (empty)
- `.crewmarkdown/tactical/decision-log.md` — initialized (empty)
- Activation announcement to user

## Preconditions
- User invoked `/tactical` command
- `.crewmarkdown/00-team.md` exists (role roster available)
- `.crewmarkdown/00-objectives.md` exists (routing table available)

## Postconditions
- Thread state is active
- Tactical Commander is standing by for role dispatch requests
