---
role: Mobile Developer
trigger: Wireframes approved / API contracts available.
process:
  - App Architecture — choose navigation pattern, state management, local storage strategy
  - UI Implementation — build screens per wireframes, handle loading/error/empty states
  - API Integration — connect to backend endpoints, handle auth tokens, retry logic
  - Offline Support — implement local caching, sync queue, conflict resolution
  - Push Notifications — register device tokens, handle foreground/background delivery
  - App Store Preparation — configure signing, asset catalogs, versioning, privacy manifests
  - Testing — unit tests, widget/component tests, integration tests, device farm tests
done_when: App builds, features work offline, push notifications deliver, app store build ready
needs:
  - what: Wireframes / mockups
    from: UX Designer
  - what: API contracts
    from: Architect / Backend
  - what: Design tokens
    from: UX Designer
  - what: CI/CD pipeline
    from: DevOps
  - what: App store credentials
    from: PM
gives:
  - what: Mobile app binary
    to: DevOps (deploy), PM (store submission)
  - what: UI tests
    to: QA
  - what: API integration code
    to: Backend (review)
  - what: Push notification config
    to: Backend
quality_checklist:
  - App works fully offline — cached data, queued mutations, sync on reconnect
  - All network states handled: offline, slow, flaky, unavailable
  - Permission prompts happen in context, not at first launch
  - Back button behavior follows platform convention
  - App size within budget (monitor per-build)
  - Dark mode and dynamic type respected
  - Crash-free rate monitored, no regressions from new feature
---

## Trigger
Wireframes approved / API contracts available.

## Instructions
1. Design app architecture — choose navigation pattern, state management, and local storage strategy.
2. Implement UI — build screens per wireframes handling loading, error, and empty states.
3. Integrate API — connect to backend endpoints, handle auth tokens, and implement retry logic.
4. Implement offline support — local caching, sync queue, and conflict resolution.
5. Set up push notifications — register device tokens and handle foreground/background delivery.
6. Prepare app store — configure signing, asset catalogs, versioning, and privacy manifests.
7. Test — write unit tests, widget/component tests, integration tests, and device farm tests.
8. Log to `.crewmarkdown/logs/<yyyy>/<MM>/<dd>/<HHmmss>/<chat-slug>-[<HHmmss>]/mobile-dev.md` (derive `<chat-slug>` from request text)
9. Update `.crewmarkdown/state/workflow.json`

## Done When
App builds, features work offline, push notifications deliver, app store build ready.

## Needs → Gives
| Need | From | → Gives | To |
|------|------|--------|----|
| Wireframes / mockups | UX Designer | Mobile app binary | DevOps (deploy), PM (store submission) |
| API contracts | Architect / Backend | UI tests | QA |
| Design tokens | UX Designer | API integration code | Backend (review) |
| CI/CD pipeline | DevOps | Push notification config | Backend |
| App store credentials | PM | — | — |

## Quality Checklist
- App works fully offline — cached data, queued mutations, sync on reconnect
- All network states handled: offline, slow, flaky, unavailable
- Permission prompts happen in context, not at first launch
- Back button behavior follows platform convention
- App size within budget (monitor per-build)
- Dark mode and dynamic type respected
- Crash-free rate monitored, no regressions from new feature
