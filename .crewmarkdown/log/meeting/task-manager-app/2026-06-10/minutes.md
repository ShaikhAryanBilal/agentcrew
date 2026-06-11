# Meeting Minutes — Task Manager App Kickoff

- **Date**: 2026-06-10
- **Duration**: 30 min
- **Facilitator**: Meeting Facilitator
- **Attendees**: PM, BA, Architect, Tech Lead, UX Designer, Frontend, Backend

## Objective
Define vision, scope, and tech stack for a Task Manager App MVP. Produce initial features, decisions, and actionable next steps.

## Agenda & Discussion

### 1. Vision & User Needs (PM + BA)
- MVP: task CRUD, lists, due dates, reminders
- Target: individual users (team features deferred to v2)
- Differentiator: sub-100ms ops, offline support, clean UX

### 2. UX (UX Designer)
- Personas: professional, student, freelancer
- Flows: Dashboard → Lists → Create/Edit → Reminder → Done
- Mobile-first responsive, dark mode, swipe gestures, keyboard shortcuts

### 3. Architecture (Architect + Tech Lead)
- SPA + REST API + SQLite local-first
- Clean architecture: domain / data / presentation layers
- PWA for installability + offline

### 4. Frontend (Frontend)
- SvelteKit + Tailwind
- Components: TaskCard, TaskList, FilterBar, SearchBar, Modal
- Svelte stores for state

### 5. Backend (Backend)
- Python FastAPI + SQLModel
- Endpoints: tasks CRUD, lists, notifications via Web Push API
- Auto OpenAPI docs

## Decisions

| # | Question | Decision | Consensus |
|---|----------|----------|-----------|
| D1 | Svelte vs React | SvelteKit | Unanimous |
| D2 | Node vs Python | Python FastAPI | Unanimous |
| D3 | SQLite vs PostgreSQL | SQLite local-first, Postgres in v2 | Unanimous |
| D4 | Offline strategy | PWA + IndexedDB + SW | Unanimous |
| D5 | Auth for v1 | Email+Password JWT, optional until v2 | Consent |

## Action Items

| # | Owner | Task | Deadline |
|---|-------|------|----------|
| AI-1 | PM | PRD with user stories | 2026-06-14 |
| AI-2 | UX Designer | Wireframes (dashboard, list, detail, settings) | 2026-06-17 |
| AI-3 | Architect | System architecture doc + ADR | 2026-06-14 |
| AI-4 | Tech Lead | Repo scaffold + CI | 2026-06-17 |
| AI-5 | Backend | Task CRUD API + schema | 2026-06-21 |
| AI-6 | Frontend | Dashboard + task list UI | 2026-06-21 |
| AI-7 | PM + BA | MVP vs v2 scope doc | 2026-06-14 |
| AI-8 | Tech Lead | PWA offline research spike | 2026-06-17 |

## Parking Lot
- Team collaboration (v2)
- AI task prioritization (v3)
- Calendar integration (v2)
- File attachments (v2)

## Next Steps
1. PM writes PRD (AI-1)
2. Architect writes system design (AI-3)
3. PM+BA finalize scope (AI-7)
4. UX designer delivers wireframes (AI-2)
5. Follow-up meeting: design review after artifacts ready
