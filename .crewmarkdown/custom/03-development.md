# Custom: Development

## Context
CrewMarkdown is itself the workflow metadata. Development means improving the workflow pipeline — adding steps, fixing routing, improving scripts.
All changes require maintaining backward compatibility with existing step references.

## Always Do
- Validate cross-references after any step rename/move
- Update codebase-map.md after adding files
- Keep existing step IDs stable (add redirects if renaming)

## Never Do
- Break the objective contract (objectives mapped in 00-objectives.md)
- Remove a step without updating all Next/Revert references

## Overrides
- Implementation step produces markdown and shell scripts, not application code
- Unit testing means validating step integrity (link checks, not code tests)

## Reference
- .crewmarkdown/00-objectives.md — objective index
- .crewmarkdown/scripts/ — all automation scripts
