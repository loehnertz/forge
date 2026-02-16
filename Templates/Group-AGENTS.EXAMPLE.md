# [Product Group Name]

<!--
This is an example Product Group (team) context file template. Adapt sections to your needs.
Rename to your AI tool's convention.

A product group represents a team that owns multiple products. This context file sits between the
root AGENTS.md and individual product AGENTS.md files in the hierarchy:

    Root AGENTS.md → Product Group AGENTS.md → Product AGENTS.md → Initiative AGENTS.md

Conventions defined here cascade to all products within the product group unless overridden at the
product level.
-->

Brief description of what this team covers and its cross-cutting concerns.

## Context

- What domain does this team own?
- What cross-cutting concerns span the product group's products?
- What are the key constraints or principles the team follows?

## Conventions

<!--
Team-wide conventions that supplement the root AGENTS.md. These apply to all products in
this product group. Individual products can override specific conventions in their own AGENTS.md.
-->

## Forge Customizations

<!--
Product-group-level Forge overrides that cascade to all products within this product group.
These sit between root-level and product-level customizations:

    Root AGENTS.md → Product Group AGENTS.md → Product AGENTS.md

See FORGE.md "Customizing Forge" for the full layering explanation.
-->

## Glossary

See [GLOSSARY.md](./GLOSSARY.md) for shared terminology across the product group's products.

## Products

<!--
Link to each product's context file within this product group. This is how AI tools discover
the context hierarchy — from this product group down into product and initiative context files.
-->

| Product   | Description                                |
|-----------|--------------------------------------------|
| [Product] | [Brief description](./[Product]/AGENTS.md) |

## Related Product Groups

<!--
Cross-references to collaborating product groups. Helps AI understand inter-team boundaries
and integration points.
-->

| Product Group   | Relationship                                                      |
|-----------------|-------------------------------------------------------------------|
| [Product Group] | [How this product group interacts with the related product group] |

## References

<!-- Product-group-level documentation, wikis, runbooks, team charters -->
