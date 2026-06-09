# Configuration

Ready-made configuration files for popular AI coding tools, all in `.agentcrew/config/`.

## Supported Tools

| Tool | Config File | Location |
|------|------------|----------|
| **opencode** | `opencode.jsonc` + `AGENTS.md` + `SKILL.md` | Project root |
| **Cursor** | `.cursor/rules` | Project root |
| **Claude Code** | `CLAUDE.md` | Project root |
| **GitHub Copilot** | `.github/copilot-instructions.md` | `.github/` |

## Setup Script

The easiest way to configure AI agents for your project:

```powershell
# Windows (PowerShell)
./.agentcrew/config/setup.ps1
```

```bash
# Linux/macOS
./.agentcrew/config/setup.sh --all
```

## Manual Setup

### opencode

```jsonc
{
  "skills": [".agentcrew/skills"],
  "commands": [
    {
      "name": "agentcrew",
      "description": "Run AgentCrew SDLC workflow",
      "command": "opencode --agent .agentcrew/roles/orchestrator/contract.md"
    }
  ]
}
```

### Other Tools

- **Cursor:** Copy `.agentcrew/config/cursor.rules` to `.cursor/rules`
- **Claude Code:** Copy `.agentcrew/config/claude.MD` to `CLAUDE.md`
- **GitHub Copilot:** Copy `.agentcrew/config/copilot.instructions` to `.github/copilot-instructions.md`

## Light Variant

A compressed 7-step variant for MVPs, prototypes, and solo development.

| | Full | Light |
|--|------|-------|
| **When** | Production systems, teams | MVPs, solo dev, rapid experiments |
| **Objectives** | 8 with full squads (7 SDLC + Meeting) | 7 compressed steps |
| **Roles** | 18 specialized roles | Reduced role set |
| **Ceremony** | Security gates, ADRs, debate | Minimal documentation |
| **Location** | `.agentcrew/` (default) | `.agentcrew/light/` |

Switch any time. Start with Light → move to Full as complexity grows.

---

*MIT Licensed — Built for AI-native development*
