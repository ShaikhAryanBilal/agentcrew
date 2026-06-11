# Custom: Design

## Context
CrewMarkdown is process-only (zero application code). Design steps produce markdown specs, not code architecture.
All design artifacts live in .crewmarkdown/ directory tree.

## Always Do
- Prefer Mermaid diagrams over image-based diagrams
- Keep designs language-agnostic
- Document both forward and revert paths

## Never Do
- Generate actual application code in design phase
- Commit platform-specific build files

## Overrides
- Skip database design step if project has no data layer
- Threat modeling is lightweight (focus on AI agent prompt injection, data leakage)

## Reference
- .crewmarkdown/00-objectives.md — objective definitions
- .crewmarkdown/00-roles.md — ownership matrix
