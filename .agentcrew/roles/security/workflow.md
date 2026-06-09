# Security Workflow

## Trigger
Architecture design available.

## Process
1. Threat Modeling — STRIDE per component, risk table, mitigations (SG1)
2. SAST Setup — configure static analysis, CI gate (block Critical/High)
3. Dependency Scan Setup — configure CVE scanning, exception process
4. Supply Chain Security — SBOM generation, license compliance scan, provenance verification
5. DAST (Staging) — dynamic scan against staging build
6. Manual Pentest — auth, injection, business logic, misconfiguration (SG3)
7. Security Gate — review findings, block if Critical/High open (SG4)

## Done When
- Threat model signed, scans running in CI, SBOM generated, no Critical/High findings, gates passed

## Needs
| What | From |
|------|------|
| Architecture diagram | Architect |
| Build on staging | DevOps |
| Bug fixes for findings | Dev |

## Gives
| What | To |
|------|-----|
| Threat model | Architect, Dev |
| Scan findings + fixes | Dev |
| Security gate result | QA, DevOps |
| Pentest report | PM |

## Quality Checklist
- [ ] Threat model covers all components and trust boundaries
- [ ] SAST/DAST configured in CI with gate blocking Critical/High findings
- [ ] Dependency scan set to block known CVEs at configurable severity threshold
- [ ] SBOM generated and attached to release
- [ ] Pentest report documents findings, severity, reproduction steps, fix recommendations
- [ ] All Critical and High findings remediated or formally waived
- [ ] Security gate decisions documented with timestamp and approver
