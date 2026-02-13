# Forge: Search Workspace

Search all artifacts in the Forge workspace for a keyword or phrase.

## Purpose

Find relevant documents across products and initiatives without manually browsing the folder
structure. Useful for:

- Locating prior decisions on a topic
- Finding all mentions of a component, service, or concept
- Reviewing all proposals in a given area

## Steps

### 1. Get Search Query

If not provided as an argument, ask the user for the keyword or phrase to search for.
Ask whether the search should be case-sensitive (default: case-insensitive).

### 2. Scan Workspace

Search all `.md` files recursively in the workspace. Exclude:

- `Templates/` directory
- `Commands/` directory
- `FORGE.md` (framework documentation, not workspace content)

### 3. Classify Each Match

For each matching file, determine the artifact type from its filename or path:

| Pattern                        | Artifact Type |
|--------------------------------|---------------|
| `Decision*.md`                 | Decision      |
| `Proposal*.md`                 | Proposal      |
| `Exploration*.md`              | Exploration   |
| `Tickets/*.md` or `Ticket*.md` | Ticket        |
| `Notes/*.md`                   | Note          |
| `AGENTS.md` or context file    | Context       |
| Anything else                  | Other         |

### 4. Sort Results

Within each group, sort by artifact priority:

1. Decision
2. Proposal
3. Exploration
4. Ticket
5. Note
6. Context
7. Other

### 5. Output Format

Group results by Product, then by Initiative within each product. For each match, show:

- The artifact type and filename (linked if possible)
- A 2–3 line snippet centered on the first match within the file

```
🔍 Search Results: "event sourcing"
══════════════════════════════════════════════════════════════════════

📦 Analytics
   📁 Initiatives/Standardized-Events
      📐 Decision.md
         "...adopt **event sourcing** for the analytics pipeline to ensure..."

      📝 Proposal.md
         "...considered **event sourcing** vs. CQRS; ultimately recommended..."

   📁 Initiatives/Dashboard-Redesign
      🔍 Exploration.md
         "...previous attempt at **event sourcing** stalled due to schema..."

📦 Payments
   📁 Initiatives/Checkout-V2
      🎫 Tickets/Ticket-001.md
         "...implement **event sourcing** handler for payment events..."

══════════════════════════════════════════════════════════════════════
Found 4 matches across 2 products, 3 initiatives.
```

### Artifact Type Icons

| Artifact Type | Icon |
|---------------|------|
| Decision      | 📐   |
| Proposal      | 📝   |
| Exploration   | 🔍   |
| Ticket        | 🎫   |
| Note          | 📋   |
| Context       | ⚙️   |
| Other         | 📄   |

## Notes

- Only the first match per file is shown with a snippet; if a file has multiple matches, note
  the total count (e.g., "3 matches in this file").
- If no results are found, say so clearly and suggest broadening the search term.

---

**Awaiting your direction.** What would you like to search for?
