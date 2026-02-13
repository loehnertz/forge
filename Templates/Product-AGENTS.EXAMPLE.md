# [Product Name]

<!--
This is an example Product context file template. Adapt sections to your needs.
Rename to your AI tool's convention.
-->

Brief description of this product area.

## Context

- What problem does this product solve?
- Who are the users?
- What are the key constraints?

## Architecture

- High-level system overview
- Key components and their relationships
- Important patterns used

## Glossary

See [GLOSSARY.md](./GLOSSARY.md) for the product's ubiquitous language and term definitions.

## Related Repositories

<!--
Repository names and descriptions are shared context (committed to git).
Local paths live in REPOS.md in this same directory (gitignored, per-user).
See Templates/REPOS.EXAMPLE.md for the path file format.
-->

| Repository | Description      |
|------------|------------------|
| backend    | Main API service |
| frontend   | Web application  |

## Related Products

| Product      | Relationship                              |
|--------------|-------------------------------------------|
| Payments     | We call their API for checkout            |
| User Service | Provides authentication, we consume users |

## External Services

<!--
Configuration for /forge-push and /forge-pull.
Each subsection defines a service type and instructs the AI on how to interact with it.
The type name (e.g., "confluence-page", "jira-issue", "notion-page", "linear-issue") is referenced in artifact
frontmatter. Add or remove subsections based on your team's tools.

Example subsection:

### [service-type]

Used for: [Artifact types this service handles]
[Service-specific config keys, e.g., Space, Project, Labels, etc.]

To push: [Instructions for converting Markdown and creating/updating the external resource]
To pull: [Instructions for fetching the resource and converting back to Markdown]
-->

## Active Initiatives

<!--
Link to each initiative's context file so AI tools discover the full hierarchy.
Stage can be set manually or inferred by /forge-status from artifacts present.
Lead is optional — set it to the name or @handle of the person driving the initiative.
Move completed initiatives to a "Completed Initiatives" section or remove them.
-->

| Initiative                                                       | Stage    | Lead |
|------------------------------------------------------------------|----------|------|
| [Example-Initiative](./Initiatives/Example-Initiative/AGENTS.md) | Discover |      |

## References

<!-- Product-level documentation, wikis, runbooks -->
