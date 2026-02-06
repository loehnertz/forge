# Forge: Pull

You are pulling the latest state from a linked external service back into a local Forge artifact.

## Purpose

Sync remote changes back into local artifacts when external collaborators have made updates. This is a targeted pull,
not continuous sync – use it when we need to incorporate changes made outside Forge.

**Important:** Pulling is an inherently lossy process – the lossier direction of the two. External formats have features
with no Markdown equivalent (macros, custom fields, rich layouts, etc.). Some content will be approximated or may
require user decisions on how to handle. Always present conversion issues to the user before applying changes.

## Context

- **Entry trigger**: User wants to check for or incorporate external changes
- **Exit artifact**: Updated local artifact with remote changes applied; `external.last-synced` updated

## Parameters

- **Path**: A specific artifact path (e.g., `Products/MyProduct/Initiatives/Analytics/Proposal.md`)
- **Type**: An artifact type for batch pull (e.g., `Tickets`)
- **None**: Prompt the user to select an artifact

## Relevant Files

- The artifact(s) being pulled
- Product `AGENTS.md` – Contains `## External Services` configuration
- `Templates/` – Reference for artifact type identification

## What Happens Here

1. **Identify artifacts** from the provided arguments (specific file, type for batch, or prompt user to select)
2. **Validate external link** – `external.type` and `external.id` must be present in the artifact's frontmatter. If
   missing, tell the user to push first using `/forge-push`
3. **Load service instructions** – read the matching subsection in the Product's `## External Services` (in the Product
   `AGENTS.md`). This subsection is the primary source of truth for how to interact with the external service – it
   contains the user's "To pull" instructions, service-specific configuration, and any conversion hints. Follow those
   instructions for all subsequent steps
4. **Fetch and convert** – follow the user's "To pull" instructions using available tools (MCP servers, REST APIs, etc.)
5. **Show diff** with metadata (who changed it, when) before applying anything. Preserve local-only frontmatter fields (
   `status`, `depends-on`, `blocks`)
6. **User decides**: apply all changes, apply selectively (section by section), or skip
7. **Update frontmatter** – set `external.last-synced` to the current timestamp
8. **Report** a summary of what was changed

## Content Adaptation (External Format → Markdown)

This is the lossier direction. External systems have features with no Markdown equivalent (Confluence macros, Jira
custom fields, Notion databases, etc.).

**Conversion strategy:**

1. **Directly convertible elements** – headings, paragraphs, lists, tables, code blocks, links, bold/italic → convert
   faithfully to Markdown
2. **Approximately convertible elements** – things that can be represented with some loss (e.g., a Confluence "expand"
   macro → a blockquote with a note, an info/warning panel → a blockquote with a prefix). Convert to the closest
   Markdown approximation and add a comment noting the original format: `<!-- Originally a Confluence expand macro -->`
3. **Unconvertible elements** – things with no reasonable Markdown equivalent (complex macros, embedded apps, inline
   comments/annotations, advanced layouts). For each unconvertible element:
    - **Ask the user** what to do: include as-is (raw markup), summarize the content in plain text, or omit entirely
    - If the user chooses to omit, add a placeholder comment: `<!-- Omitted: [description of what was here] -->`

Present a summary of conversion issues *before* showing the diff, so the user understands what was adapted and can make
informed decisions.

These are generic defaults. The user's "To pull" instructions in `## External Services` may override or extend them with
service-specific conversion rules – always defer to those instructions when present.

## Edge Cases

- **Remote resource deleted (404):** Warn the user. Offer to clear the `external` fields in frontmatter so the artifact
  becomes unlinked
- **No remote changes detected:** Report "no changes since last sync" and skip – do not update `last-synced`
- **Batch pull:** Show an aggregate summary first (which artifacts have changes), then ask whether to review diffs
  individually or skip unchanged artifacts

---

**Awaiting your direction.** Which artifact would you like to pull?
