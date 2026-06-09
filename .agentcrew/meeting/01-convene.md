# Meeting: Convene — Agenda + Role Assembly

## Need
- Meeting topic from user
- Role Selection Matrix loaded
- RPG party display ready

## Do

### 1. Parse Topic
Extract the core topic/question from user input.

| User Says | Parsed Topic |
|-----------|-------------|
| "/meeting brainstorm the new dashboard" | Dashboard feature brainstorm |
| "/meeting decide on database tech" | Database technology decision |
| "/meeting retro for sprint 5" | Sprint 5 retrospective |

### 2. Select Roles
Map topic keywords to roles using the Role Selection Matrix:

```
Topic: "new dashboard"
Keywords: feature, ui, frontend
Roles: PM, UX Designer, Frontend, Backend, Tech Lead
```

### 3. Show Party Screen
Display the RPG-style party screen with assembled meeting squad:

```
  ╔══════════════════════════════════════════════════════════╗
  ║            MEETING MODE — SQUAD ASSEMBLED                ║
  ╠══════════════════════════════════════════════════════════╣
  ║  Topic: Dashboard Feature Brainstorm                    ║
  ╠══════════════════════════════════════════════════════════╣
  ║                                                         ║
  ║  [MF] Meeting Facilitator  [========>    ]  45% Brainstorming ║
  ║  📋  PM                   [====>        ]  22% Setting agenda ║
  ║  ✏️  UX Designer           [======>      ]  33% Ideating    ║
  ║  🎨  Frontend              [=========>   ]  48% Prototyping ║
  ║  ⚙️  Backend               [=====>       ]  28% Planning API ║
  ║  👨‍💻  Tech Lead             [=======>     ]  38% Reviewing   ║
  ║                                                         ║
  ╠══════════════════════════════════════════════════════════╣
  ║  ⏱  00:00:15          Session active                    ║
  ╚══════════════════════════════════════════════════════════╝
```

### 3. Set Agenda
Write a structured agenda:

```
# Meeting: Dashboard Feature Brainstorm
- **Date**: 2026-06-09
- **Topic**: Define dashboard MVP features
- **Attendees**: PM, UX Designer, Frontend, Backend, Tech Lead
- **Timebox**: 30 min

## Agenda
1. Opening context — PM (2 min)
2. User personas overview — UX (3 min)
3. Feature ideation — All, round-robin (15 min)
4. MVP scope prioritization — PM, Tech Lead (5 min)
5. Next steps + action items (5 min)
```

### 4. Share Agenda
- [ ] Write agenda to `.agentcrew/log/meeting/<topic>/<timestamp>-agenda.md`
- [ ] Confirm timebox with user
- [ ] Proceed to brainstorm

## Output
```
## Convened
- Topic: [parsed topic]
- Attendees: [role1, role2, ...]
- Timebox: [N] minutes
- Agenda: [link]
```

## Done
- Topic parsed
- Roles selected via matrix
- Party screen displayed
- Agenda set and shared

## Next -> `02-brainstorm.md`
