# Mobile Developer Workflow

## Trigger
Wireframes approved / API contracts available.

## Process
1. App Architecture — choose navigation pattern, state management, local storage strategy
2. UI Implementation — build screens per wireframes, handle loading/error/empty states
3. API Integration — connect to backend endpoints, handle auth tokens, retry logic
4. Offline Support — implement local caching, sync queue, conflict resolution
5. Push Notifications — register device tokens, handle foreground/background delivery
6. App Store Preparation — configure signing, asset catalogs, versioning, privacy manifests
7. Testing — unit tests, widget/component tests, integration tests, device farm tests

## Done When
- App builds, features work offline, push notifications deliver, app store build ready

## Needs
| What | From |
|------|------|
| Wireframes / mockups | UX Designer |
| API contracts | Architect / Backend |
| Design tokens | UX Designer |
| CI/CD pipeline | DevOps |
| App store credentials | PM |

## Gives
| What | To |
|------|-----|
| Mobile app binary | DevOps (deploy), PM (store submission) |
| UI tests | QA |
| API integration code | Backend (review) |
| Push notification config | Backend |

## Quality Checklist
- [ ] App works fully offline — cached data, queued mutations, sync on reconnect
- [ ] All network states handled: offline, slow, flaky, unavailable
- [ ] Permission prompts happen in context, not at first launch
- [ ] Back button behavior follows platform convention
- [ ] App size within budget (monitor per-build)
- [ ] Dark mode and dynamic type respected
- [ ] Crash-free rate monitored, no regressions from new feature
