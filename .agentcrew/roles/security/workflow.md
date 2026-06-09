---
role: Security
trigger: Architecture design available.
process:
  - Threat Modeling — STRIDE per component, risk table, mitigations (SG1)
  - SAST Setup — configure static analysis, CI gate (block Critical/High)
  - Dependency Scan Setup — configure CVE scanning, exception process
  - Supply Chain Security — SBOM generation, license compliance scan, provenance verification
  - DAST (Staging) — dynamic scan against staging build
  - Manual Pentest — auth, injection, business logic, misconfiguration (SG3)
  - Security Gate — review findings, block if Critical/High open (SG4)
done_when: Threat model signed, scans running in CI, SBOM generated, no Critical/High findings, gates passed
needs:
  - what: Architecture diagram
    from: Architect
  - what: Build on staging
    from: DevOps
  - what: Bug fixes for findings
    from: Dev
gives:
  - what: Threat model
    to: Architect, Dev
  - what: Scan findings + fixes
    to: Dev
  - what: Security gate result
    to: QA, DevOps
  - what: Pentest report
    to: PM
quality_checklist:
  - Threat model covers all components and trust boundaries
  - SAST/DAST configured in CI with gate blocking Critical/High findings
  - Dependency scan set to block known CVEs at configurable severity threshold
  - SBOM generated and attached to release
  - Pentest report documents findings, severity, reproduction steps, fix recommendations
  - All Critical and High findings remediated or formally waived
  - Security gate decisions documented with timestamp and approver
---

## Trigger
Architecture design available.

## Instructions
1. Threat modeling — run STRIDE per component, produce risk table and mitigations (SG1).
2. SAST setup — configure static analysis with CI gate blocking Critical/High findings.
3. Dependency scan setup — configure CVE scanning with exception process.
4. Supply chain security — generate SBOM, run license compliance scan, verify provenance.
5. DAST (staging) — run dynamic scan against the staging build.
6. Manual pentest — test auth, injection, business logic, and misconfiguration (SG3).
7. Security gate — review findings, block release if Critical/High findings are open (SG4).
8. Log to `.agentcrew/log/security/<timestamp>.md`
9. Update `.agentcrew/state/workflow.json`

## Done When
Threat model signed, scans running in CI, SBOM generated, no Critical/High findings, gates passed.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Architecture diagram | Architect | Threat model | Architect, Dev |
| Build on staging | DevOps | Scan findings + fixes | Dev |
| Bug fixes for findings | Dev | Security gate result | QA, DevOps |
| — | — | Pentest report | PM |

## Quality Checklist
- Threat model covers all components and trust boundaries
- SAST/DAST configured in CI with gate blocking Critical/High findings
- Dependency scan set to block known CVEs at configurable severity threshold
- SBOM generated and attached to release
- Pentest report documents findings, severity, reproduction steps, fix recommendations
- All Critical and High findings remediated or formally waived
- Security gate decisions documented with timestamp and approver
