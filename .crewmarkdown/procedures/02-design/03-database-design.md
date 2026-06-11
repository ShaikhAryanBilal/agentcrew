# Database Design

## Need
- Data models from tech spec (entities, fields, relationships)
- Query patterns (which queries run, how often, with what filters)
- Non-functional requirements (scale, consistency, durability)
- Constraints (existing DB technology, licensing, team skills)

## Instructions

### 1. DB Technology Selection

| Criterion | Winner (example) | Why not alternatives |
|-----------|-----------------|---------------------|
| ACID required | PostgreSQL | MySQL: weaker consistency in some configs |

- [ ] Select DB type with explicit rationale
- [ ] Confirm with DevOps (licensing, hosting, ops capacity)

### 2. Schema Design

- [ ] Every table needs: PK, created_at, updated_at
- [ ] Every FK needs an index
- [ ] Naming: snake_case, singular, descriptive
- [ ] Soft delete with `deleted_at` (NULL = active). Index with `WHERE deleted_at IS NULL`.

| Relationship | Implementation | Example |
|-------------|---------------|---------|
| 1:1 | FK with UNIQUE constraint | user → profile |
| 1:N | FK on child table | customer → invoices |
| M:N | Junction table | invoice ↔ line_items |
| Polymorphic | Separate join tables (not single polymorphic FK) | tags for invoices AND customers |

- [ ] Document which side owns the relationship
- [ ] For M:N: include composite PK (both FKs), avoid surrogate PK unless needed

### 3. Indexing Strategy

Base indexes on actual query patterns, not guesses:

- [ ] Index per query pattern. No index without a query to justify it.
- [ ] Partial indexes for filtered queries (`WHERE status = 'pending'`)
- [ ] Covering indexes for read-heavy hot paths
- [ ] Avoid over-indexing: each index slows writes. Max 5-7 indexes per table.

### 4. Migration Strategy

Pattern: versioned SQL files, applied in order, never modified after merge.

Migration types:
  - Additive (CREATE TABLE, ADD COLUMN) → Safe, can roll forward
  - Destructive (DROP TABLE, DROP COLUMN) → Multi-phase
  - Data migration (backfill, transform) → Separate script from DDL

Rollback: each migration should have a down migration.

Zero-downtime rule:
  - No ALTER TABLE that locks for > 1s on prod
  - Use pt-online-schema-change or pgroll for large tables
  - Add columns as nullable, backfill, then add NOT NULL

- [ ] Naming: `V001__descriptive_name.sql` + `V001__descriptive_name.down.sql`
- [ ] Each migration is idempotent (use `IF NOT EXISTS`, `IF EXISTS`)

### 5. Data Seeding

- [ ] Reference data → migration (always applied)
- [ ] Demo data → seed script (dev/staging only)
- [ ] Production data → data import script, never migration

### 6. Backup + Recovery

- [ ] RPO/RTO defined and agreed with PM
- [ ] Backup retention policy documented
- [ ] Restore test scheduled

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| EAV (Entity-Attribute-Value) pattern | JSONB or separate table |
| Single table for everything | Normalize to 3NF, denormalize only when perf measured |
| No migration strategy | Every schema change is a migration. No manual ALTER TABLE in prod. |
| Index everything | Index based on actual query patterns. Measure first. |
| Cascade delete without thinking | "What happens when customer is deleted?" — define it. |
| Storing computed values | Compute at read time, or document why cached |
| Generic "status" string | ENUM or VARCHAR with CHECK constraint |

## Time Budget
| Tables | Schema | Indexes | Migration | Total |
|--------|--------|---------|-----------|-------|
| < 10 | 30 min | 15 min | 10 min | 55 min |
| 10-20 | 1 hr | 30 min | 20 min | 1.75 hr |
| 20+ | 1.5 hr | 45 min | 30 min | 2.75 hr |

## Done
- DB technology decision with rationale
- Schema DDL (tables, columns, types, constraints, FK)
- Index strategy per query pattern
- Migration plan (versioned, reversible, zero-downtime)
- Seed data plan
- Backup/recovery spec (RPO, RTO, schedule)
- Data model matches tech spec entities

→ Next: `04-api-design.md`
Schema conflicts with tech spec? Revert to tech spec.
