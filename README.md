<p align="center">
  <img src="logo.png" alt="Forge logo" width="300">
  <br><br>
  <strong>A framework for AI-assisted engineering workspaces</strong>
  <br><br>
  <a href="./FORGE.md">Documentation</a> ·
  <a href="./AGENTS.EXAMPLE.md">Template</a> ·
  <a href="#quick-start">Quick Start</a>
</p>

---

## What is Forge?

Forge is a framework for structuring collaborative workspaces where engineers and AI assistants work together on
design and documentation.

**The problem:** AI assistants are powerful but context-starved. Without understanding your architecture, conventions,
and goals, they produce generic suggestions that require extensive correction.

**The solution:** Forge gives AI the context it needs through:

|                            |                                                                     |
|----------------------------|---------------------------------------------------------------------|
| **Layered context files**  | AGENTS.md files that give AI progressively deeper understanding     |
| **Durable artifacts**      | Explorations, Proposals, and Decisions that capture design thinking |
| **Connections to reality** | Links to actual codebases and external systems                      |
| **Structured workflows**   | A path from exploration to actionable work                          |

> **When NOT to use Forge:** Skip it for quick bug fixes, small self-contained changes, throwaway prototypes, or
> anything with an obvious solution. If you wouldn't call a meeting about it, you probably don't need an initiative.

---

## Quick Start

**1. Adapt for your AI tool**

Rename `AGENTS.EXAMPLE.md` to your tool's convention:

| Tool        | Context file   |
|-------------|----------------|
| Claude Code | `CLAUDE.md`    |
| Cursor      | `.cursorrules` |

**2. Copy commands**

Move files from `Commands/` to your tool's command location (e.g., `.claude/commands/` for Claude Code).

**3. Create your first product**

```
/forge-new-product MyProduct
```

**4. Start an initiative**

```
/forge-new-initiative MyProduct My-First-Initiative
```

---

## Documentation

| Document                                     | Description                                                                                        |
|----------------------------------------------|----------------------------------------------------------------------------------------------------|
| **[FORGE.md](./FORGE.md)**                   | Complete framework documentation – philosophy, workspace structure, artifact types, best practices |
| **[AGENTS.EXAMPLE.md](./AGENTS.EXAMPLE.md)** | Template for your root context file – adapt this for your AI tool                                  |

---

<p align="center">
  <sub>MIT License</sub>
</p>
