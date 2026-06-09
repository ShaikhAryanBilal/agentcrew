# Database Design

## Need
- Data models from tech spec (entities, fields, relationships)
- Query patterns (which queries run, how often, with what filters)
- Non-functional requirements (scale: rows, throughput; consistency; durability)
- Constraints (existing DB technology, licensing, team skills)

## Decision Tree

```
Primary data model?
├── Highly relational (invoices, customers, payments with JOINs) → PostgreSQL / MySQL
├── Document-shaped (JSON blobs, varying schema) → MongoDB / DynamoDB
├── Graph-shaped (friend-of-friend, recommendation) → Neo4j
└── Time-series (metrics, logs, events) → InfluxDB / TimescaleDB

Consistency requirement?
├── Strongly consistent (banking, inventory) → Relational DB (ACID)
├── Eventually consistent OK → Any technology works
└── Mix → Consider separate DBs per domain (polyglot persistence)

Expected data volume (5yr horizon)?
├── < 100GB, < 1M rows per table → No special scaling needed
├── < 1TB, < 100M rows → Indexing strategy, archiving, read replicas
└── > 1TB, > 100M rows → Sharding, partitioning, or specialized DB
```

## Do

### 1. DB Technology Selection

| Criterion | Winner (example) | Why not alternatives |
|-----------|-----------------|---------------------|
| ACID required | PostgreSQL | MySQL: weaker consistency in some configs |
| JSON fields | PostgreSQL | Native JSONB, can index |
| Team familiarity | PostgreSQL | Already in stack |
| Hosting | RDS PostgreSQL | Self-hosted: too much ops overhead |
| Budget | $XXX/mo for 100GB | Aurora: 2x cost, not needed |

- [ ] Select DB type with explicit rationale
- [ ] Confirm with DevOps (licensing, hosting, ops capacity)

### 2. Schema Design

```sql
-- Migration: V001__create_invoices.sql
CREATE TABLE invoices (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    number          VARCHAR(20) NOT NULL,
    customer_id     UUID NOT NULL REFERENCES customers(id),
    amount          DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    status          VARCHAR(20) NOT NULL DEFAULT 'pending'
                        CHECK (status IN ('pending','paid','cancelled','refunded')),
    due_date        DATE NOT NULL,
    paid_at         TIMESTAMPTZ,
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ  -- soft delete
);

-- Indexes based on query patterns
CREATE INDEX idx_invoices_customer_id ON invoices(customer_id);
CREATE INDEX idx_invoices_status ON invoices(status) WHERE deleted_at IS NULL;
CREATE INDEX idx_invoices_due_date ON invoices(due_date) WHERE status = 'pending';
CREATE UNIQUE INDEX idx_invoices_number ON invoices(number);
```

- [ ] Every table needs: PK, created_at, updated_at
- [ ] Every FK needs an index
- [ ] Naming: snake_case, singular, descriptive
- [ ] Soft delete with `deleted_at` (NULL = active). Index with `WHERE deleted_at IS NULL`.

#### Relationship decisions

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

```
| Query | Frequency | Filter | Sort | Index Needed |
|-------|-----------|--------|------|-------------|
| GET invoice by ID | High | id = X | — | PK (already exists) |
| List customer invoices | High | customer_id = X | created_at DESC | (customer_id, created_at) |
| Dashboard: pending count | Low | status = 'pending' | — | status (partial, WHERE pending) |
| Monthly export | Batch | created_at BETWEEN | — | (created_at) |
| Search by number | Medium | number LIKE '%X%' | — | trigram index (pg_trgm) |
```

- [ ] Index per query pattern. No index without a query to justify it.
- [ ] Partial indexes for filtered queries (`WHERE status = 'pending'`)
- [ ] Covering indexes for read-heavy hot paths
- [ ] Avoid over-indexing: each index slows writes. Max 5-7 indexes per table.

### 4. Migration Strategy

```yaml
# migrations/V001__initial_schema.sql
# migrations/V002__add_invoice_notes.sql
# migrations/V003__create_line_items.sql

Pattern: versioned SQL files, applied in order, never modified after merge.

Migration types:
  - Additive (CREATE TABLE, ADD COLUMN) → Safe, can roll forward
  - Destructive (DROP TABLE, DROP COLUMN) → Multi-phase:
      Phase 1: Stop writing to column. Deploy.
      Phase 2: Verify no reads. Drop column. Deploy.
  - Data migration (backfill, transform) → Separate script from DDL

Rollback: each migration should have a down migration (V001__down.sql).
Exception: destructive migrations already multi-phase, no rollback needed.

Zero-downtime rule:
  - No ALTER TABLE that locks for > 1s on prod
  - Use pt-online-schema-change or pgroll for large tables
  - Add columns as nullable, backfill, then add NOT NULL
```

- [ ] Naming: `V001__descriptive_name.sql` + `V001__descriptive_name.down.sql`
- [ ] Each migration is idempotent (use `IF NOT EXISTS`, `IF EXISTS`)

### 5. Data Seeding

```
| Seed Data | Type | Environment | Applied By |
|-----------|------|-------------|------------|
| Countries list | Reference | All | Migration |
| Admin user | System | All | Migration |
| Sample invoices | Demo | Dev only | Seed script |
| Default config | Config | All | Migration |
```

- [ ] Reference data → migration (always applied)
- [ ] Demo data → seed script (dev/staging only)
- [ ] Production data → data import script, never migration

### 6. Backup + Recovery

```
Recovery Point Objective (RPO): 5 minutes (acceptable data loss)
Recovery Time Objective (RTO): 1 hour (time to restore)

Backup strategy:
  - Full backup: daily (retention: 30 days)
  - WAL archiving: continuous (retention: 7 days, for PITR)
  - Cross-region copy: WAL files copied to S3 in other region

Restore test: Full restore test every month. Document result.
```

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

## Next → `04-api-design.md`
Schema conflicts with tech spec? Revert to tech spec.
