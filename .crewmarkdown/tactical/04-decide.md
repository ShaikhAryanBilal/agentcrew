# Tactical Mode — Decide

## Purpose
Log key decisions with rationale for continuity across the thread.

## Steps
1. When a decision is made during the thread (by user or by Tactical Commander):
   - Record in `.crewmarkdown/tactical/decision-log.md`
   - Format: `[ID] Decision: [what] — Rationale: [why] — By: [who] — When: [timestamp]`
2. Link decision to relevant dispatch:
   - If decision came from a role's work → reference dispatch #[N]
   - If decision is about routing → reference the request context
3. Reference decision log in future dispatches:
   - When dispatching a role, check if any past decisions affect the work
   - Include relevant decisions in the dispatch context
4. Keep decision log searchable:
   - Use consistent ID format: `D-[N]`
   - Use tags for quick lookup (e.g., `#arch`, `#security`, `#ux`)

## Outputs
- Updated decision log with new entry
- Relevant decisions referenced in future dispatches

## Preconditions
- Tactical mode is active
- A decision was made that affects the thread

## Postconditions
- Decision recorded with rationale and context
- Decision available for future dispatch context
