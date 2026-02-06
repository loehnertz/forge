# Forge: Push

You are pushing a local Forge artifact to its linked external service (wiki, issue tracker, etc.).

## Purpose

Push finalized artifacts to external systems for broader team visibility. Forge remains the authoring environment; this
command handles the handoff.

**Important:** Pushing is an inherently lossy process. Markdown and external formats do not map 1:1 – some elements will
be approximated or lost during conversion. Always inform the user about what was adapted and let them review the result.

## Context

- **Entry trigger**: User wants to publish or update an artifact externally
- **Exit artifact**: Updated frontmatter with `external` link fields; resource created or updated in the external
  service

## Parameters

- **Path**: A specific artifact path (e.g., `Products/MyProduct/Initiatives/Analytics/Proposal.md`)
- **Folder**: A folder path for batch push (e.g., `Products/MyProduct/Initiatives/Analytics/Tickets/`)
- **None**: Prompt the user to select an artifact

## Relevant Files

- The artifact(s) being pushed
- Product `AGENTS.md` – Contains `## External Services` configuration
- `Templates/` – Reference for artifact type identification

## What Happens Here

1. **Identify artifacts** from the provided arguments (specific file, folder for batch, or prompt user to select)
2. **Determine service type:**
    - If the artifact already has `external.type` in frontmatter, use that
    - Otherwise, find the Product's `## External Services` section and match the artifact type to a service via the
      `Used for:` line (e.g., Proposals map to `confluence-page`)
    - If no `## External Services` section exists, ask the user to configure it in their Product `AGENTS.md`
    - If no match is found for this artifact type, ask the user which service type to use
3. **Load service instructions** – read the matching subsection in the Product's `## External Services` (in the Product
   `AGENTS.md`). This subsection is the primary source of truth for how to interact with the external service – it
   contains the user's "To push" instructions, service-specific configuration (space, project, labels, etc.), and any
   conversion hints. Follow those instructions for all subsequent steps
4. **Check push state:**
    - `external.id` populated → this is an **update** to an existing resource
    - `external.id` empty → this is a **create** of a new resource
    - If updating, compare `external.last-synced` with the remote resource's last-modified date. If the remote was
      modified after the last sync, warn about potential conflicts and suggest pulling first
5. **Convert content** following the Content Adaptation guidelines below
6. **Push** – follow the service's "To push" instructions using available tools (MCP servers, REST APIs, etc.)
7. **Update frontmatter** – set `external.type`, `external.id`, and `external.last-synced`
8. **Report** a summary with URLs and create/update status for each artifact

## Content Adaptation (Markdown → External Format)

When converting local Markdown content for the external service:

- **Convert standard elements** – headings, lists, tables, code blocks, links, bold/italic → closest equivalent in the
  target format
- **Strip YAML frontmatter** – it's local metadata, not content
- **Strip HTML comments** (`<!-- ... -->`) – these are local authoring notes
- **Resolve relative links** – for links between Forge artifacts (e.g., `./Decision.md`): if the linked artifact has an
  `external.id`, resolve the URL using the service configuration and convert to an absolute link to the external
  resource. Otherwise, convert to plain text noting the reference exists locally (e.g., "[see Decision.md in Forge]")
- **Handle unsupported content** – for Mermaid diagrams or other embedded content the target format doesn't support:
  present the user with options (e.g., include as a code block, render as an image and attach, or omit with a
  placeholder)

These are generic defaults. The user's "To push" instructions in `## External Services` may override or extend them with
service-specific conversion rules – always defer to those instructions when present.

## Batch Pushing

When given a folder path (e.g., `Tickets/`), process all `.md` files in that folder. Stop on first failure – do not
continue pushing remaining files if one fails.

## Safeguards

- **Confirm before first push:** Always confirm with the user before creating a new external resource (when
  `external.id` is empty)
- **Draft warning:** Warn before pushing artifacts with `status: Draft` – these may not be ready for external
  consumption
- **Failure safety:** If the push fails, do not update the frontmatter – the local artifact should still reflect the
  pre-push state

---

**Awaiting your direction.** Which artifact would you like to push?
