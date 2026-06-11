---
extends: ../workflow.md
role: Frontend/UI-React
trigger: UX designs + API contracts + component tokens available.
process:
  - Scaffold — Vite + TypeScript + React, configure routing, set up TanStack Query
  - Components — build per UX designs using atomic design + hooks
  - State & Data — wire up Context/Zustand for client state, TanStack Query for server state
  - Routing — implement React Router with loaders, error boundaries, nested routes
  - Testing — RTL component tests + MSW-integrated feature tests
  - Performance — lazy load routes, memoize, audit bundle
done_when: All screens implemented in React, routes working, tests passing, bundle size within budget
needs:
  - what: UI designs + assets
    from: UX Designer
  - what: API contracts
    from: Backend / Architect
  - what: Component tokens + route map
    from: UX Designer / PM
gives:
  - what: React components, hooks, pages
    to: Repo
  - what: RTL + MSW tests
    to: QA
  - what: Lazy-loaded route bundles
    to: Build (performance)
quality_checklist:
  - Every component has loading, empty, error, and edge case states
  - Routes lazy-loaded with React.lazy + Suspense
  - TanStack Query for all server state (no fetch in useEffect)
  - No class components in new code
  - Bundle size audited — no regression >5%
  - All interactions testable via RTL (userEvent, not fireEvent)
---

## Trigger
UX designs + API contracts + component tokens available.

## Instructions
1. Scaffold — set up Vite + TypeScript + React, configure React Router with createBrowserRouter, add TanStack Query provider.
2. Components — build per UX designs using atomic design pattern. Each component in own directory with co-located test and styles.
3. State & data — choose strategy per feature: local state for UI-only, Context/Zustand for shared client state, TanStack Query for server data.
4. Routing — implement page tree with nested routes, loaders for data fetching, error boundaries per route segment.
5. Testing — write RTL tests for each component (render, interaction, edge case). Use MSW to mock API calls.
6. Performance — lazy-load each route page. Use React.memo on expensive lists. useMemo/useCallback only after profiling.
7. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/frontend-ui-react.md`
8. Update `.crewmarkdown/state/workflow.json`

## Done When
All screens implemented in React, routes working, tests passing, bundle size within budget.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| UI designs + assets | UX Designer | React components, hooks, pages | Repo |
| API contracts | Backend / Architect | RTL + MSW tests | QA |
| Component tokens + route map | UX Designer / PM | Lazy-loaded route bundles | Build |

## Quality Checklist
- Every component has loading, empty, error, and edge case states
- Routes lazy-loaded with React.lazy + Suspense
- TanStack Query for all server state (no fetch in useEffect)
- No class components in new code
- Bundle size audited — no regression >5%
- All interactions testable via RTL (userEvent, not fireEvent)
