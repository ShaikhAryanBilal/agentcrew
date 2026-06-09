# Meeting: Convene — Agenda + Role Assembly

## Need
- Meeting topic from user
- Role Selection Matrix loaded
- RPG party display ready

## Instructions

### 1. Parse Topic
1. Extract the core topic/question from user input

### 2. Select Roles
1. Map topic keywords to roles using the Role Selection Matrix

### 3. Show Party Screen
1. Display the RPG-style party screen with assembled meeting squad:

```
  ╔══════════════════════════════════════════════════════════╗
  ║            MEETING MODE — SQUAD ASSEMBLED                ║
  ╠══════════════════════════════════════════════════════════╣
  ║  Topic: Dashboard Feature Brainstorm                    ║
  ╠══════════════════════════════════════════════════════════╣
  ║  [MF] Meeting Facilitator  [========>    ]  45% Brainstorming ║
  ║  📋  PM                   [====>        ]  22% Setting agenda ║
  ║  ✏️  UX Designer           [======>      ]  33% Ideating    ║
  ╚══════════════════════════════════════════════════════════╝
```

### 4. Set Agenda
1. Write a structured agenda with timeboxed items
2. Write agenda to `.agentcrew/log/meeting/<topic>/<timestamp>-agenda.md`
3. Confirm timebox with user
4. Proceed to brainstorm

## Done
- Topic parsed
- Roles selected via matrix
- Party screen displayed
- Agenda set and shared

→ Next: `02-brainstorm.md`
