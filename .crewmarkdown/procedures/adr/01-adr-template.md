# ADR Template

## Need
- Decision to document
- Context of the decision

## Instructions
1. Copy template
2. Fill each section
3. Save to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/adr.md` (derive `<chat-slug>` from request context)

## Template

```markdown
# [Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What is the issue motivating this decision? What constraints apply?
What alternatives were considered?

## Decision
What is the chosen approach? Why?

## Consequences
What becomes easier? What becomes harder?
What trade-offs were accepted?

## Compliance
How will we enforce / verify this decision?
(linter rules, CI checks, code reviews, etc.)

## Notes
Links to related ADRs, debate logs, design docs.
```

## Done
- ADR written with context, decision, consequences, compliance, notes
- Filed in log directory
