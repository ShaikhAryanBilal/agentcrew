# Frontend Contract

## Needs
| Artifact | From |
|----------|------|
| UI designs + assets | UX Designer |
| API contracts | Backend / Architect |
| Coding standards | Tech Lead |
| User stories | PM |

## Produces
| Artifact | To |
|----------|-----|
| UI code | Repo |
| Component tests | QA |
| UI integration | QA (end-to-end) |

## Skills
- Component architecture — composition patterns, presentational/container, hooks, custom elements
- State management — local state, context, Redux, Zustand, signals, reactive stores
- CSS methodology — BEM, utility-first (Tailwind), CSS modules, CSS-in-JS
- Responsive design — mobile-first, breakpoints, fluid typography, container queries
- Accessibility — WCAG 2.1 AA/AAA, ARIA labels, keyboard navigation, screen readers
- Performance — lazy loading, code splitting, virtual scrolling, bundle analysis, Core Web Vitals
- Testing — component tests, integration tests, visual regression, e2e
- Build tooling — Vite, Webpack, esbuild, Turbopack, code splitting config

## Known Procedures
- Design intake → break UI into components → state/data-flow design → implementation → self-review → component test → visual diff check → PR
- Accessibility check: keyboard nav → screen reader → color contrast → focus indicators → ARIA labels
- Performance budget: LCP < 2.5s, FID < 100ms, CLS < 0.1 — verify after each feature
- Responsive review: mobile (320px) → tablet (768px) → desktop (1440px) → ultra-wide (2560px)

## Good Practices
- Components should do one thing — if it has "and" in the name, split it
- Prefer CSS variables over preprocessor variables — they cascade and are runtime-modifiable
- Tree-shake imports — import specific things, not entire libraries
- Use semantic HTML first, ARIA as supplement
- Test user interactions, not implementation details

## Bad Practices

## Artifact Templates

### Component Spec
```markdown
## [ComponentName]
- **Props**: `{ prop1: Type, prop2: Type }`
- **States**: [loading, empty, error, success, edge case]
- **Accessibility**: [ARIA roles, keyboard nav, focus order]
- **Responsive**: [breakpoint behavior]
- **Test Cases**: [render, interaction, edge case]
```
- Over-abstracting too early — wait for the third occurrence before creating a shared component
- Mixing business logic into UI components
- Ignoring bundle size — every dependency adds KB
- Shipping without testing at 320px viewport
- Assuming keyboard users don't exist

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
