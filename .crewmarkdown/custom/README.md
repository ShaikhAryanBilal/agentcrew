# Custom Instructions

Fill these per-phase files with project-specific instructions.  
Agent reads the matching file before executing any step in that phase.

## How it works

1. Router tells agent: "Check `custom/<phase>.md` before running"
2. If file has content → inject as additional context
3. If file is empty / default → skip, use standard procedure

## Files

| Phase | File |
|-------|------|
| Requirements | `01-requirements.md` |
| Design | `02-design.md` |
| Development | `03-development.md` |
| QA | `04-qa.md` |
| Deployment | `05-deployment.md` |
| Maintenance | `06-maintenance.md` |

## Template format per file

```markdown
# Custom: [Phase]

## Context
Project-specific background the agent should know.

## Always Do
Things to always include in this phase.

## Never Do
Things to avoid.

## Overrides
Changes to default procedure steps.

## Reference
Links, docs, APIs, contacts.
```

Empty sections = agent ignores them.

## Quick setup

```bash
# Interactive scaffold (fills all 6 custom files with prompts)
./.crewmarkdown/scripts/init-workflow.sh

# Or non-interactive:
./.crewmarkdown/scripts/init-workflow.sh --project "MyApp" --stack "node,react" --ci "GitHub Actions"
```
