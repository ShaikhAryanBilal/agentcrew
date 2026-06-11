# Decisions — Task Manager App Kickoff

## D1: Frontend Framework

- **Question**: Svelte vs React for frontend?
- **Options**: SvelteKit / React + Vite
- **Decision**: SvelteKit
- **Rationale**: Smaller bundle, faster dev, simpler state (stores), SvelteKit handles routing + SSR. MVP scope doesn't need React ecosystem.
- **Alternatives**: React + Vite — richer ecosystem, more hiring pool, but heavier.
- **Consensus**: Unanimous

## D2: Backend

- **Question**: Node.js vs Python?
- **Options**: Node+Express / Python FastAPI
- **Decision**: Python FastAPI
- **Rationale**: Auto OpenAPI docs, async natively, type-safe via Pydantic, same stack for future ML features. Team familiarity.
- **Alternatives**: Node+Express — faster raw throughput, bigger npm ecosystem.
- **Consensus**: Unanimous

## D3: Database Strategy

- **Question**: Local-first or server-first?
- **Options**: SQLite local-first / PostgreSQL server-first
- **Decision**: SQLite local-first via SQLModel. Sync layer in v2.
- **Rationale**: MVP is single-user. Eliminates server hosting cost initially. SQLModel abstracts DB — migration to Postgres is a config change.
- **Alternatives**: PostgreSQL — ready for multi-user, but adds ops overhead for MVP.
- **Consensus**: Unanimous

## D4: Offline Strategy

- **Question**: PWA with IndexedDB vs always-online?
- **Decision**: PWA + IndexedDB + Service Worker cache
- **Rationale**: Task managers must work offline. SW caches API responses, IndexedDB stores local mutations, sync queue when online.
- **Consensus**: Unanimous

## D5: Auth

- **Question**: Auth for v1?
- **Decision**: Email+Password via JWT (simple). OAuth deferred to v2.
- **Rationale**: MVP is single-user local-first. Auth endpoint exists but optional until sync v2.
- **Consensus**: Consent (minor concern: security hardening needed before public)
