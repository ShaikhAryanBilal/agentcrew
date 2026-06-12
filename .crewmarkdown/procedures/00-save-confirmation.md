# Save Confirmation Gate

## Purpose
Before writing logs and updating state, confirm whether the user wants to persist artifacts or keep this session in-memory only. Reduces unnecessary disk writes during exploratory/browsing sessions.

## Flow
```
Artifacts produced + acceptance verified
  ↓
Ask: "Save artifacts & log this session? [Y/n]"
  ↓
Y → proceed: write logs + update state/workflow.json
N → skip: present in-memory summary. No files written.
```

## Prompt
After acceptance criteria verified, output:

> **Save session?** Log artifacts and update state? [Y/n]

If user types `Y` or `y` or presses Enter → persist.
If user types `N` or `n` → skip. Show summary in-memory only.

## Behavior When Skipped
- No log file written to `.crewmarkdown/logs/<...>`
- No update to `.crewmarkdown/state/workflow.json`
- Artifacts are presented in-conversation only
- User can later say "save last session" to trigger persistence retroactively

## Retroactive Save
If user later says "save last session" or "persist previous":
1. Reconstruct log from conversation history
2. Write to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/<role>.md`
3. Update `.crewmarkdown/state/workflow.json`
