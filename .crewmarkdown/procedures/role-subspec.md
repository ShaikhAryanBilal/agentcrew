# Role Sub-Specification System

## Purpose
Split each role family into sub-specializations so requests load only relevant skills, procedures, and contracts.

## Directory Schema
```
roles/<family>/
  contract.md              # Parent: generic skills + needs + produces
  workflow.md              # Parent: generic process
  <sub-spec>/
    contract.md            # Child: extends parent, overrides/adds
    workflow.md            # Child: sub-spec-specific process
```

## Inheritance Pattern

### Parent Contract (roles/<family>/contract.md)
Full standard contract with all skills, needs, produces. Used as fallback when no sub-spec matches.

### Sub-Spec Contract (roles/<family>/<sub-spec>/contract.md)
```yaml
---
extends: ../contract.md     # Inherits parent needs, produces, skills
role: Frontend/UI-React      # Qualified name for routing
layer: UI                    # Layer classification
framework: React             # Framework/tool classification
sub_of: Frontend             # Parent role family
tags: [react, jsx, hooks, SPA]
keywords: [react, jsx, tsx, hooks, component-library]
# Overrides — only what differs from parent:
needs_override:              # Added needs (merged with parent)
  - artifact: Component library tokens
    from: UX Designer
skills_add:                  # Skills unique to this sub-spec
  - React hooks — useState, useEffect, useReducer, custom hooks
  - JSX/TSX — component composition, fragments, portals
  - React patterns — compound components, render props, HOCs, Suspense
skills_remove:               # Skills inherited but irrelevant
  - Vue-specific patterns
procedures_override:         # Full replacement of parent procedure
  - Setup: Vite + React + TypeScript scaffold
  - Components: build per design system, use hooks for state
  - Testing: React Testing Library, component-level + integration
  - Performance: React.memo, useMemo, useCallback, lazy loading
good_practices_add:
  - Keep components pure — same input, same output
  - Use TypeScript strict mode
bad_practices_add:
  - Using class components in new code
---
```

## Resolution Algorithm (hybrid)

### Step 1: Keyword Scan
Check request against `keywords:` in each sub-spec's frontmatter.
```
"build React dashboard" → matches ui-react's keywords: [react, jsx, tsx, hooks]
"Express API for users" → matches api-express's keywords: [express, rest, middleware, router]
```

### Step 2: Layer × Framework Match
If keywords found:
- Load sub-spec contract + workflow
- Parent contract cached as fallback

### Step 3: Fallback
If no keyword match:
- Load parent contract (generic)
- Log: "No sub-spec match for [request], using generic [role]"

## Logging
Sub-spec logs write to:
`.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/<family>-<subspec>.md`

Example: `backend-api-express.md`, `frontend-ui-react.md`

## When to Create a Sub-Spec
- Framework/technology has distinct syntax, patterns, and conventions
- Layer has different concerns (API vs worker vs cron)
- Sub-spec adds non-trivial new skills or overrides >30% of parent procedures

## When NOT to Create a Sub-Spec
- Just a different library in the same ecosystem (Redux vs Zustand → skill entry, not sub-spec)
- Version differences (React 18 vs 19 → update parent, not new sub-spec)
- Overlap >80% with parent — not enough differentiation

## State Integration
Sub-spec references are stored in `.crewmarkdown/state/role-nav.json`:
```json
{
  "role": "Frontend/UI-React",
  "parent": "Frontend",
  "layer": "UI",
  "framework": "React",
  "contract": "roles/frontend/ui-react/contract.md",
  "workflow": "roles/frontend/ui-react/workflow.md",
  "keywords": ["react", "jsx", "tsx", "hooks", "component-library"]
}
```
