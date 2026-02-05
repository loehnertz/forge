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

### The Problem

AI assistants are powerful but context-starved. Without understanding your architecture, conventions, and goals, they
produce generic suggestions that require extensive correction. We spend time explaining the same background repeatedly,
and valuable design discussions happen in ephemeral chat sessions that leave no trace.

Features like `Projects` in Claude or ChatGPT, or `Gems` in Gemini, attempt to address this by letting us attach
persistent instructions and reference files. But they fall short for engineering work:

- No structure for organizing context hierarchically
- No access to actual source code
- No way to evolve documentation alongside the codebase

They're better than starting from scratch each time, but they remain disconnected from the reality of our systems.

### The Solution

Forge gives AI the context it needs through:

- **Layered context files:** Hierarchical `AGENTS.md` files, not flat instruction dumps
- **Durable artifacts:** Explorations, Proposals, and Decisions that capture design thinking
- **Connections to reality:** AI reads real implementations, not just descriptions
- **Structured workflows:** A path from exploration to actionable work
- **Living documentation:** Git-tracked workspace that evolves with the systems it documents

### Who is Forge For?

Forge works with any AI coding assistant (Claude Code, Cursor, Copilot, etc.). Despite being marketed for coding, these
tools excel at writing, ideation, and design work – exactly what Forge is built for. It's designed for teams who:

- Use AI assistants for design and documentation work
- Want to preserve and build on design discussions rather than lose them
- Need AI collaborators that understand their specific systems
- Value written artifacts over verbal discussions for technical decisions

> **When NOT to use Forge:** Skip it for quick bug fixes, small self-contained changes, throwaway prototypes, or
> anything with an obvious solution. If you wouldn't call a meeting about it, you probably don't need an initiative.

---

## Quick Start

**1. Adapt for your AI tool**

Rename `AGENTS.EXAMPLE.md` to your tool's convention and fill in the placeholders in the file:

| Tool           | Context file                       |
|----------------|------------------------------------|
| Claude Code    | `CLAUDE.md`                        |
| Cursor         | `.cursorrules`                     |
| Windsurf       | `.windsurfrules`                   |
| GitHub Copilot | `.github/copilot-instructions.md`  |
| Aider          | `CONVENTIONS.md`                   |
| Generic        | `AGENTS.md`                        |

**2. Copy commands**

Move files from `Commands/` to your tool's command location:

| Tool        | Command location      |
|-------------|-----------------------|
| Claude Code | `.claude/commands/`   |
| OpenCode    | `.opencode/commands/` |

Not all tools support custom commands – check your tool's documentation.

**3. Create your first product**

```
/forge-new-product MyProduct
```

**4. Start an initiative**

```
/forge-new-initiative MyProduct My-First-Initiative
```

**5. Start ideating**

Work with your AI agent to explore ideas, draft proposals, and make decisions. See [FORGE.md](./FORGE.md) for guidance on the workflow and artifact types.

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
