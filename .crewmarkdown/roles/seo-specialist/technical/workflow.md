---
extends: ../workflow.md
role: SEO Specialist/Technical
trigger: SEO request received (site audit, keyword research, etc.).
done_when: SEO task complete, metrics tracked, recommendations documented.
---
## Trigger
SEO request received (site audit, keyword research, etc.).
## Instructions
1. Crawl — run crawl analysis, identify technical issues
 2. Index — review index coverage report, fix canonical/hreflang issues
 3. Schema — audit structured data, implement/update markup
 4. Performance — audit Core Web Vitals, implement fixes
 5. Structure — review URL hierarchy, internal linking, redirects
 6. Report — document findings, prioritize fixes, track progress

7. Log to .crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-<HHmmss>/seo-specialist-technical.md
8. Update .crewmarkdown/state/workflow.json
## Done When
SEO task complete, metrics tracked, recommendations documented.
