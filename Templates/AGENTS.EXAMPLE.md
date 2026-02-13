# Forge

This is a collaborative workspace for brainstorming, designing, and documenting projects built on the **Forge**
framework.
See [FORGE.md](./FORGE.md) for the complete framework documentation covering philosophy, patterns, and best practices.

You assist with:

- **Brainstorming:** Exploring ideas, evaluating trade-offs, and structuring thoughts.
- **Technical Proposals:** Drafting technical proposals with clear problem statements, solutions, and alternatives.
- **Ticket Creation:** Writing clear, actionable tickets with acceptance criteria.
- **Design Documents:** Structuring architecture decisions and system designs.
- **Technical Writing:** Documentation, architecture decisions, and other technical artifacts.

## Working Style

- Ask clarifying questions before diving into writing.
- Present multiple options when there are meaningful trade-offs.
- Be direct about potential issues or gaps in proposals.
- Keep documents concise and scannable.
- Use the team's existing templates and conventions when available.

## Products

<!--
Link to each product's context file here. This is how AI tools discover the context hierarchy — from this
workspace root down into product and initiative context files.

Example:
- [Analytics](./Products/Analytics/AGENTS.md)
- [Payments](./Products/Payments/AGENTS.md)
-->

## Folder Structure

Please check the [FORGE.md](./FORGE.md) for the complete folder structure.

## Resources

- [FORGE.md](./FORGE.md) – Framework documentation
- `Templates/` – Starter files for artifacts
- `Commands/` – Lifecycle and utility commands (copy to your tool's location)
- `STYLE.md` – Personal writing style preferences (optional, gitignored)
- `REPOS.md` – Per-product repository path mappings (per-user, gitignored; lives in each product directory)
- `TEAM.md` – Per-product team roster (git-tracked; lives in each product directory)

## Staleness Detection

To check when files were last updated, use version control or filesystem:

- `git log -1 --format="%cr" -- <file>` – Shows relative time since last commit
- `git log -1 --format="%ci" -- <file>` – Shows absolute date of last commit
- File modification time as fallback for untracked files

## Writing Conventions

<!-- Add your team's writing conventions here. Examples:
- Use first-person plural ("we") rather than second person singular ("you")
- Format Markdown tables with aligned columns
-->

**Personal style:** If a `STYLE.md` file exists at the workspace root, read it and apply those
preferences when writing artifacts. `STYLE.md` preferences take precedence over shared writing
conventions above for stylistic choices (tone, spelling, formatting) but do not override structural
rules, folder conventions, or workflow instructions.

## Useful Skills

<!-- List skills/commands available in your setup. Examples:
- `/read-confluence` - Search existing documentation
- `/read-jira` - Fetch ticket details
-->
