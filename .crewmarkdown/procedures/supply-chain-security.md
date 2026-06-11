# Supply Chain Security

## Need
- Third-party dependencies in the project
- Build pipeline configured

## Instructions

### Every Build (CI Gate)
1. Run `npm audit` / `pip audit` / `cargo audit` — check known CVEs
2. Fail build on Critical/High severity in production dependencies
3. Alert on new CVEs in existing dependencies

### Weekly
1. Review dependabot / renovate PRs for threshold violations
2. Update transitive pins if direct upgrade not possible

### Pre-Release
1. Full SBOM generation (CycloneDX or SPDX format)
2. License compliance scan — flag GPL/AGPL in commercial products
3. Provenance verification — check package signatures (SLSA)

## SBOM Generation
| Tool | Command |
|------|---------|
| npm | `npx @cyclonedx/cyclonedx-npm --output-file sbom.json` |
| Python | `pip-licenses --format=json > sbom.json` |
| Go | `cyclonedx-gomod -json -o sbom.json` |
| Generic | `syft scan --platform sbom` (Syft) |

## License Compliance
| License | Action |
|---------|--------|
| MIT / Apache 2.0 / BSD | Allow |
| GPL v2/v3 | Block (commercial) / Allow (OSS) |
| AGPL / SSPL | Review required |
| Unknown / Custom | Legal review required |

## Provenance & SLSA
- Use package managers with integrity verification (lockfiles, checksums)
- Verify publisher signatures where available
- Generate SLSA provenance for own build artifacts
- Pin base images by digest, not tag

## Incident Response for Supply Chain
1. CVE published in dependency → assess impact (reachable code?)
2. If reachable + Critical → emergency patch within SLA
3. If reachable + High → patch in current sprint
4. If not reachable → defer, document rationale

## Done
- Dependency audit runs every build
- SBOM generated pre-release
- License compliance checked
- Provenance verified
- Supply chain incident response process defined
