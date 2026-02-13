# Forge: Onboard New Team Member

Walk a new team member through the one-time setup of their local Forge workspace.

## Steps

### 1. Detect AI Tool

Ask the user which AI tool they are using (or detect from context):

- **Claude Code** → context file: `CLAUDE.md`, commands: `~/.claude/commands/`
- **Cursor** → context file: `.cursorrules`, commands: `.cursor/rules/`
- **GitHub Copilot** → context file: `COPILOT-INSTRUCTIONS.md`, commands: `.github/copilot/`
- **Windsurf** → context file: `.windsurfrules`, commands: `.windsurf/rules/`
- **Other** → ask user to confirm their context filename and command location

Confirm the detected tool with the user before proceeding. All subsequent steps use the confirmed
tool's conventions.

### 2. Configure Repository Paths (`REPOS.md`)

For each directory under `Products/`:

1. Read the product's `AGENTS.md` (or tool's context file) and find the `## Related Repositories`
   table.
2. If the product has related repositories, show the table and prompt the user for the local path
   where each repository is cloned on their machine.
3. If `Products/<Product>/REPOS.md` already exists, show the current contents and ask whether to
   keep it as-is or update specific entries.
4. If it does not exist, write the completed `REPOS.md` using `Templates/REPOS.EXAMPLE.md` as the
   format, filled in with the paths provided.
5. If a product has no `## Related Repositories` table, skip it silently.

### 3. Set Up Personal Writing Style (`STYLE.md`) — Optional

Ask the user if they want to create a personal `STYLE.md` at the workspace root.

- If yes: copy `Templates/STYLE.EXAMPLE.md` to `STYLE.md`, remind the user to fill in their
  preferences.
- If `STYLE.md` already exists, mention it is already configured and ask if they want to review it.
- If no: skip.

### 4. Install Commands

Ask the user if they want to copy the `Commands/` folder contents to their tool's command location
(detected in Step 1).

- If yes: copy all `.md` files from `Commands/` to the appropriate location. Warn if files already
  exist there (offer to overwrite or skip).
- If no: let the user know they can do this manually later.

### 5. Add to Product Team Rosters (`TEAM.md`) — If Present

For each product directory under `Products/`:

1. If `Products/<Product>/TEAM.md` exists, show the current `## Members` table.
2. Ask the user if they want to add themselves as a new row for that product.
3. If yes: collect Name, Role, AI Tool (from Step 1), and Contact (email or handle). Append the
   row to the table.
4. If the user is not involved in a particular product, skip it.

If no `TEAM.md` files exist anywhere, mention that each product can have one (from
`Templates/TEAM.md`) and that `/forge-new-product` creates it automatically.

### 6. Orientation Overview

Run the equivalent of `/forge-status` to show the user the current state of the workspace:

- All products with their active initiatives
- Each initiative's current stage and lead (if set)
- Any staleness or blocking issues to be aware of

### Summary

After completing all steps, present a concise summary:

- Which `REPOS.md` files were created or updated
- Whether `STYLE.md` was created
- Whether commands were installed and where
- Which product `TEAM.md` files the user was added to
- A quick note on what to do next (e.g., "Start exploring an initiative with `/forge-discover`")

---

**Awaiting your direction.** Ready to begin onboarding — shall I start with detecting your AI tool setup?
