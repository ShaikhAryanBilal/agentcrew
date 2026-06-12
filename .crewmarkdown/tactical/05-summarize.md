# Tactical Mode — Summarize

## Purpose
Produce thread snapshots (on request) and final tactical summary (on end).

## Steps
### On-Request Summary (user says "summarize", "status", "what's happening")
1. Read thread state from `.crewmarkdown/tactical/thread-state.json`
2. Read action register from `.crewmarkdown/tactical/action-register.md`
3. Read decision log from `.crewmarkdown/tactical/decision-log.md`
4. Compile:
   - Total dispatches
   - Active dispatches (with current status)
   - Pending actions
   - Recent decisions (last 5)
   - Next expected action
5. Present to user as tactical summary

### End-of-Thread Summary (user says `/end` or thread naturally ends)
1. Compile complete report:
   - Thread duration (activation to end)
   - All dispatches: #[N] → role(s) → objective → outcome
   - All decisions: D-[N] → decision → rationale
   - All actions: [ID] → status (done/stale/cancelled)
   - Open items (actions still pending)
2. Archive thread state: copy to log directory
3. Produce final summary to user
4. Clean up tactical state files (or keep as reference)

## Outputs
- On-request: tactical summary text to user
- End-of-thread: final tactical summary to user + archived state

## Preconditions
- Tactical mode is active (for on-request) or ending (for final)

## Postconditions
- On-request: user has thread snapshot
- Final: thread state archived, tactical mode deactivated, all resources logged
