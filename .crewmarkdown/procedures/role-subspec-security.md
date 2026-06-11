# Role Sub-Spec — Security Implications

## Threat Model

Sub-specs introduce role multiplication. Each sub-spec is a distinct identity with its own contract, workflow, and access assumptions.

### STRIDE Per Concern

| Category | Threat | Risk | Mitigation |
|----------|--------|------|------------|
| Spoofing | Request routes to wrong sub-spec (e.g., Frontend/Vue loads Frontend/React contract) | Medium | Keyword matching MUST match framework name exactly. `react` ≠ `vue`. Fallback to parent on ambiguity, never guess. |
| Tampering | Sub-spec contract modified to inject malicious procedures | Low | Contracts are markdown (instructional, not executable). Code generation follows agent's safety layer, not contract text. |
| Repudiation | Which sub-spec handled the request is not logged | Medium | Log MUST include sub-spec name: `frontend-ui-react` not just `frontend`. See `procedures/role-subspec.md` logging section. |
| Info Disclosure | Sub-spec contract leaks framework-specific vulnerabilities | Low | Contracts describe patterns, not secrets. No credentials or endpoints in contracts. |
| Elevation of Privilege | Same agent loads parent contract then sub-spec — inherits superset skills | High | **Session isolation:** sub-spec load = new context. Parent cache is read-only reference, not merged session state. Parent skills are NOT auto-available in sub-spec session unless explicitly listed in `skills_add`. |

## Session Isolation Rules

### Rule 1: One Sub-Spec Per Session
A single agent session must load exactly one sub-spec (or the parent). Never merge multiple sub-specs into one session.

```
CORRECT: Session loads Frontend/UI-React → produces React components
WRONG:   Session loads Frontend/UI-React + Frontend/UI-Vue → mixed output
```

### Rule 2: Parent as Fallback, Not Merge
Parent contract is a fallback when no sub-spec matches. It is NOT a base that sub-spec stacks on. Sub-spec uses `extends:` for inheritance in YAML frontmatter only — at load time, the resolved contract is a flat document.

### Rule 3: Audit Trail
Every log line includes the resolved role name:
```
role: Frontend/UI-React          # sub-spec loaded
role: Frontend                   # parent fallback
role: Backend/API-Express        # sub-spec loaded
```

## Red Team Independence (from prior decision D4)

If sub-specs include Security/Red-Team and Security/Blue-Team:
- Red Team sessions MUST be logged with `session: red-team` tag
- Red Team findings MUST go through a separate artifact path (`logs/.../security-red-team/`)
- Blue Team MUST NOT review or modify Red Team findings (avoids conflict of interest)
- Same model provider allowed but different conversation session

## Access Control Per Sub-Spec

| Sub-Spec Type | Code Access | CI Config Access | Secrets Access | Prod Access |
|---------------|------------|-----------------|----------------|-------------|
| Frontend/UI-* | Source only | No | No (env vars via CI) | No |
| Backend/API-* | Source + migration scripts | Pipeline config | DB credentials (staging) | No |
| Backend/Worker-* | Source | Queue config | Queue credentials | No |
| QA/BlackBox | Test env only | No | No | No |
| QA/WhiteBox | Source + test infra | Pipeline config | Test DB credentials | No |
| Security/RedTeam | Staging env only | No | Test credentials | No (staging only) |
| Security/BlueTeam | Source + CI config | Pipeline config | Vault read-only | Read-only monitoring |

## Compliance Checklist

- [ ] Sub-spec logs include resolved role name (parent or sub-spec)
- [ ] Session isolation enforced — one sub-spec per session
- [ ] Red Team sessions tagged with `session: red-team`
- [ ] Access control per sub-spec type documented in contracts
- [ ] No sub-spec exposes credentials or internal endpoints in its contract
- [ ] Fallback to parent never exposes sub-spec-only data
