# Forge: New Product

Create the folder structure for a new product in the Forge workspace.

## Steps

1. **Get product name**: If not provided, ask the user for the product name.

2. **Create folder structure**:
   ```
   Products/<ProductName>/
   ├── `AGENTS.md` (or your tool's context file name)
   ├── Initiatives/
   │   └── .gitkeep
   └── References/
       └── .gitkeep
   ```

3. **Create context file** using `Templates/Product-AGENTS.EXAMPLE.md` as the starting point:
   - Copy the template to `AGENTS.md` (or your tool's context file name)
   - Replace `[Product Name]` with the actual product name
   - Fill in the Context section

4. **Create .gitkeep files** in empty folders (Initiatives/, References/).

5. **Report**: Show the user what was created and suggest next steps:
    - Fill in the context file with product context
    - Add related repositories
    - Create first initiative with `/forge-new-initiative`
