---
lead: # name or @handle of the person driving this
depends-on: [ ]
# - Products/Auth/Initiatives/OAuth-Migration
blocks: [ ]
# - Products/Frontend/Initiatives/New-Login-Flow
---

# [Initiative Name]

<!--
This is an example Initiative context file template. Adapt sections to your needs.
Rename to your AI tool's convention.
-->

## Goal

One-sentence summary of what we're trying to achieve.

## Background

- Why this initiative exists
- Key decisions already made
- Constraints we're working within

## Current State

- Where we are in the process (`Discover`/`Design`/`Decide`/`Decompose`)
- Open questions
- Recent decisions

## Key Documents

- [Exploration.md](./Exploration.md): Research and findings
- [Proposal.md](./Proposal.md): Proposal (when created)
- [Decision.md](./Decision.md): Decision (when made)

## Dependencies

<!--
Track cross-initiative dependencies here. The frontmatter enables automated validation;
this section provides human-readable context about *why* each dependency exists.
-->

### Depends On

<!-- Initiatives that must complete before this one can proceed -->
<!-- - [OAuth-Migration](../../../Auth/Initiatives/OAuth-Migration/AGENTS.md) – Need new auth tokens before we can integrate -->

### Blocks

<!-- Initiatives waiting on this one to complete -->
<!-- - [New-Login-Flow](../../../Frontend/Initiatives/New-Login-Flow/AGENTS.md) – Waiting on our API changes -->

## Context Guidance

- **Notes/:** Raw meeting notes and transcripts. Unfiltered, may be incomplete or contradictory.
- **`Exploration.md`:** Refined synthesis. Use this as the source of truth for current understanding.
- When Notes and Exploration conflict, trust Exploration or ask for clarification.
