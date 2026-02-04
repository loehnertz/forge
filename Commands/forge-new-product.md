# Forge: New Product

Create the folder structure for a new product in the Forge workspace.

## Steps

1. **Get product name**: If not provided, ask the user for the product name.

2. **Create folder structure**:
   ```
   Products/<ProductName>/
   ├── AGENTS.md (or your tool's context file name)
   ├── Initiatives/
   │   └── .gitkeep
   └── References/
       └── .gitkeep
   ```

3. **Create context file** with this template:
   ```markdown
   # <Product Name>

   Brief description of this product area.

   ## Context

   - What problem does this product solve?
   - Who are the users?
   - What are the key constraints?

   ## Architecture

   - High-level system overview
   - Key components and their relationships
   - Important patterns used

   ## Related Repositories

   | Repository | Path | Description |
   |------------|------|-------------|
   | | | |

   ## Related Products

   | Product | Relationship |
   |---------|--------------|
   | | |

   ## Current Focus

   - Active initiatives
   - Upcoming priorities
   ```

4. **Create .gitkeep files** in empty folders (Initiatives/, References/).

5. **Report**: Show the user what was created and suggest next steps:
    - Fill in the context file with product context
    - Add related repositories
    - Create first initiative with `/forge-new-initiative`
