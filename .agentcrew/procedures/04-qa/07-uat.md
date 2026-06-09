# User Acceptance Testing

## Need
- Build deployed to UAT/staging environment
- Signed-off PRD (acceptance criteria per user story)
- Test scenarios (happy paths per user role)
- Test users set up (with realistic data that matches personas)

## Instructions

### 1. Scenario Preparation

Per user role (from PRD personas), write scenarios:

- [ ] One scenario per major user goal
- [ ] Each scenario ends with: "Did this work? What would make it better?"
- [ ] Instructions: simple enough that anyone can follow without QA guidance

### 2. Execution

- [ ] Guide user through first scenario, then let them proceed independently
- [ ] Watch for: confusion, hesitation, errors — these are UX issues even if the feature "works"
- [ ] Record: pass/fail, satisfaction score (1-5), verbatim feedback
- [ ] Don't defend the design. Listen.

### 3. Issue Classification

UAT issues are NOT bugs (unless behavior violates spec). They are:

| Type | Definition | Action |
|------|-----------|--------|
| UX gap | Feature works but is confusing | Route to PM + UX designer |
| Feature gap | Missing capability user expected | PM decides: add, defer, or explain |
| Training gap | Feature exists but user didn't know | Documentation or walkthrough |
| Bug | Feature violates spec | Route to bug tracking |
| Enhancement | User wants improvement to working feature | PM prioritizes for future |

- [ ] Classify each issue by type

### 4. Satisfaction Scoring

- [ ] Score per scenario, not per feature
- [ ] Score < 3 = does not meet user needs. Escalate to PM.

### 5. UAT Sign-off

- [ ] PM signs off: accepts the feature with or without conditions
- [ ] If PM will not sign off → blockers logged, route back to dev

## Anti-Patterns
| Don't | Instead |
|-------|---------|
| Guide users through every click | Let them explore. See what confuses them naturally. |
| Dismiss feedback ("it's by design") | Record it. Design can be wrong. |
| Only test happy path | Let users try to break it. They will. |
| Skip UAT because "dev tested it" | Dev and users have different expectations. Always UAT. |
| Ask leading questions ("it's easy, right?") | "What was confusing? What would you change?" |
| Ignore satisfaction scores | 2/5 means something is wrong. Investigate. |

## Time Budget
| Participants | Scenarios | Per Session | Analysis | Total |
|-------------|-----------|-------------|----------|-------|
| 1-2 | 3-5 | 45 min | 30 min | 1.5-2 hr |
| 3-5 | 5-8 | 1 hr | 45 min | 2-3 hr |
| 6+ | 8-12 | 1.5 hr | 1 hr | 3-4 hr |

## Done
- UAT execution report (scenario results, satisfaction scores)
- User feedback log (verbatim quotes, observations)
- Issues classified (UX gap / feature gap / training / bug / enhancement)
- PM sign-off (or blocker list with decisions)
- Known issues handed off to QA sign-off

→ Next: `08-qa-signoff.md`
Blocker found (PM won't sign)? Route to bug tracking or design review.
