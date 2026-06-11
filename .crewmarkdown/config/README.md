# Agent Config — Setup Guide

Config files for each AI tool, stored here with unique names so they don't
overwrite your project's existing configs when you clone.

## Quick Setup

Run the setup script for your shell:

```powershell
# PowerShell
.\.crewmarkdown\config\setup.ps1
```

```bash
# Bash
./.crewmarkdown/config/setup.sh
```

The script detects which AI tools you use and copies the right configs
to your project root with the correct filenames.

## Manual Setup

| AI Tool | Copy This File | To Project Root As |
|---------|---------------|-------------------|
| opencode | `opencode.AGENTS.md` | `AGENTS.md` |
| opencode | `opencode.jsonc` | `opencode.jsonc` |
| opencode skill | `opencode.SKILL.md` | `SKILL.md` |
| Cursor | `cursor.rules` | `.cursorrules` |
| Claude Code | `claude.MD` | `CLAUDE.md` |
| GitHub Copilot | `copilot.instructions` | `copilot-instructions.md` |
