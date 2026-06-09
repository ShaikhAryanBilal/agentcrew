# Mobile Developer Contract

## Needs
| Artifact | From |
|----------|------|
| UI wireframes / mockups | UX Designer |
| API contracts | Architect / Backend |
| Design tokens | UX Designer |
| Build config / CI | DevOps |
| App store credentials | PM |

## Produces
| Artifact | To |
|----------|-----|
| Mobile app code (iOS/Android) | Users |
| UI component tests | QA |
| App store build | DevOps, PM |
| Push notification integration | Backend |
| Offline-first data layer | Backend |

## Skills
- Platform-native development — Swift/SwiftUI (iOS), Kotlin/Jetpack Compose (Android)
- Cross-platform — React Native, Flutter, Kotlin Multiplatform
- Offline-first architecture — local DB (SQLite, Realm), sync strategies, conflict resolution
- Push notifications — APNs, FCM, notification channels, deep linking
- App lifecycle — foreground, background, termination, state restoration
- Performance — startup time, memory profiling, frame rate, battery impact
- App store deployment — provisioning, code signing, TestFlight, Play Console, staged rollouts
- Mobile-specific testing — device fragmentation, network conditions, battery, memory pressure

## Known Procedures
- Feature delivery: platform assessment → native UI → offline data layer → API integration → push notifications → app store review → staged rollout
- Offline-first: cache responses → serve from cache when offline → sync on reconnect → resolve conflicts with last-write-wins or CRDT
- App store submission: version bump → code signing → archive → upload → TestFlight/Internal testing → review → release
- Performance: startup time < 2s → frame rate 60fps → memory < 100MB → APK/IPA size budget

## Good Practices
- Design for offline first, treat online as enhancement
- Handle all network states — offline, slow, flaky, no permission
- Prefer platform-native navigation patterns — don't fight OS conventions
- Reduce APK/IPA size — monitor asset bloat, use app bundles
- Support dark mode and dynamic type from day one

## Bad Practices

## Artifact Templates

### Screen Spec
```markdown
## [ScreenName]
- **Platform**: [iOS / Android / Both]
- **States**: [loading, empty, error, offline, success]
- **Navigation**: [push / modal / tab / deep link]
- **Offline Behavior**: [cached / queued / blocked]
- **Push Notifications**: [tokens, payload shape, tap handling]
- **Testing**: [unit, widget, integration, device farm]
```
- Ignoring Android back button behavior
- Hardcoding strings without localization support
- Over-prompting for permissions — ask in context, not at launch
- Using web views as architecture escape hatch
- Assuming constant network connectivity
- Skipping testing on low-end devices

## Light Variant
In light mode (.agentcrew/light/00-router.md), this role works solo with compressed scope and reduced ceremony.
