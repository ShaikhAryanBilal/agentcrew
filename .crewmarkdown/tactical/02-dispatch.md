# Tactical Mode — Dispatch

## Purpose
Route each incoming request to the appropriate role(s) and launch execution.

## Steps
1. Parse the user's request to determine domain (engineering, business, creative, operations, strategy)
2. Check for mode conflicts:
   - If request matches `/meeting` → route to Meeting mode, note in thread state, resume on completion
   - If request matches `/incident` → route to Incident mode, note in thread state, resume on completion
   - If request matches `/review` → route to Review mode, note in thread state, resume on completion
   - If request matches `/interview` → route to Interview mode, note in thread state, resume on completion
   - If request matches `/negotiate` → route to Negotiation mode, note in thread state, resume on completion
   - If request matches `/retro` → route to Retrospective mode, note in thread state, resume on completion
   - If request matches `/hackathon` → route to Hackathon mode, note in thread state, resume on completion
   - If request matches `/onboard` → route to Onboarding mode, note in thread state, resume on completion
   - If request matches `/tactical` or is already in tactical → handle natively
3. Match request to role(s) using:
   - If explicit role call ("[Role], do X") → dispatch to that role solo
   - If request matches an objective → dispatch the objective's squad
   - If request is multi-domain → dispatch multiple roles sequentially
4. Increment dispatch counter in thread state
5. Produce role dispatch message:
   - Dispatch #[N]: [request summary]
   - Role(s): [role names]
   - Objective: [specific task]
   - Context: [relevant thread state, previous dispatches]
   - Expected artifact: [what to produce]
6. Log dispatch to thread state
7. Add action to action register

## Outputs
- Role dispatch message to assigned role(s)
- Thread state updated with dispatch record
- Action register updated with new entry

## Preconditions
- Tactical mode is active
- Request received from user

## Postconditions
- Role(s) dispatched with clear objective and context
- Thread state reflects new dispatch
- Action register has new entry
