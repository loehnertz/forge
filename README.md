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

## Getting Started

**Option A: Use GitHub's template feature**

Click the green **"Use this template"** button at the top of this repository to create your own Forge workspace.
This gives you a fresh copy with all the framework files.

**Option B: Copy files manually**

If you prefer to add Forge to an existing repository or don't use GitHub:

```bash
# Clone the repository temporarily
git clone https://github.com/loehnertz/forge.git /tmp/forge

# Copy the framework files to your project
cp /tmp/forge/FORGE.md /tmp/forge/AGENTS.EXAMPLE.md /tmp/forge/update-forge.sh your-project/
cp -r /tmp/forge/Commands /tmp/forge/Templates your-project/

# Clean up
rm -rf /tmp/forge
```

---

## What is Forge?

Forge gives AI assistants the context they need to be genuinely useful collaborators – through layered context files,
durable artifacts, and connections to real code. It works with any AI coding assistant (Claude Code, Cursor, Copilot,
etc.).

See **[FORGE.md](./FORGE.md)** for the complete framework documentation covering philosophy, problem statement, and
detailed guidance.

> **When NOT to use Forge:** Skip it for quick bug fixes, small self-contained changes, throwaway prototypes, or
> anything with an obvious solution. If you wouldn't call a meeting about it, you probably don't need an initiative.

### Golden Rules

- **Start simple:** Add structure only when it helps, not preemptively.
- **Keep context current:** Stale `AGENTS.md` files mislead more than they help.
- **Keep, don't delete:** Future-us might need that context.
- **Link liberally:** Connect artifacts to each other and to code.
- **Refine incrementally:** Messy exploration first, formal documents later.
- **Know when to skip:** Not every change needs a proposal.

### Key Elements

| Element           | Purpose                                  |
|-------------------|------------------------------------------|
| `AGENTS.md` files | Provide layered context to AI assistants |
| `Notes`           | Dump raw meeting notes and transcripts   |
| `Exploration`     | Synthesize research into understanding   |
| `Proposal`        | Formalize proposals with alternatives    |
| `Decision`        | Record decisions and reasoning           |
| `Tickets`         | Define actionable work                   |
| Skills            | Connect to external systems              |
| Templates         | Bootstrap new artifacts consistently     |

---

## Quick Start

**1. Adapt for your AI tool**

Rename `AGENTS.EXAMPLE.md` to your tool's convention and fill in the placeholders in the file:

| Tool           | Context file                      |
|----------------|-----------------------------------|
| Claude Code    | `CLAUDE.md`                       |
| Cursor         | `.cursorrules`                    |
| Windsurf       | `.windsurfrules`                  |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Aider          | `CONVENTIONS.md`                  |
| Generic        | `AGENTS.md`                       |

**2. Copy commands**

Move files from `Commands/` to your tool's command location:

| Tool        | Command location      |
|-------------|-----------------------|
| Claude Code | `.claude/commands/`   |
| OpenCode    | `.opencode/commands/` |

Not all tools support custom commands; check your tool's documentation.

**3. Create your first product**

```
/forge-new-product MyProduct
```

Then fill in the generated `AGENTS.md` with product context, link related repositories, and seed `References/` with
existing documentation.

**4. Start an initiative**

```
/forge-new-initiative MyProduct My-First-Initiative
```

Fill in the goal and background in the initiative's `AGENTS.md`, then start capturing research in `Exploration.md`.

**5. Start ideating**

Work with your AI agent to explore ideas, draft proposals, and make decisions. See [FORGE.md](./FORGE.md) for guidance
on the workflow and artifact types.

---

## Updating the Framework

To pull the latest framework files:

```bash
./update-forge.sh
```

This updates:

- `FORGE.md`: framework documentation
- `Commands/`: workflow commands
- `Templates/`: artifact templates

**Handling local modifications:**

If you've customized any framework files, the script detects this and saves the new upstream version as
`<file>.upstream` instead of overwriting. You can then:

```bash
# Compare your version with upstream
diff Commands/forge-design.md Commands/forge-design.md.upstream

# Merge changes manually, then clean up
rm Commands/forge-design.md.upstream
```

To force-update all files (backs up your versions as `*.local`):

```bash
./update-forge.sh --force
```

**Always preserved** (never touched by the script):

- Your agent context file (`CLAUDE.md`, `.cursorrules`, etc.)
- Product folders and their contents
- Any other files you've added

---

## Documentation

| Document                                     | Description                                                                                       |
|----------------------------------------------|---------------------------------------------------------------------------------------------------|
| **[FORGE.md](./FORGE.md)**                   | Complete framework documentation: philosophy, workspace structure, artifact types, best practices |
| **[AGENTS.EXAMPLE.md](./AGENTS.EXAMPLE.md)** | Template for your root context file. Adapt this for your AI tool.                                 |

---

<p align="center">
  <sub><a href="./LICENSE">MIT License</a></sub>
</p>
