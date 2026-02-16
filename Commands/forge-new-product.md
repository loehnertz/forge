# Forge: New Product

Create the folder structure for a new product in the Forge workspace.

## Steps

1. **Get product name**: If not provided, ask the user for the product name. For workspaces using
   product groups, the name can include a product group prefix (e.g., `Checkout/Payments` creates
   `Products/Checkout/Payments/`). Create any intermediate product group directories as needed.

2. **Product group detection**: If the product is being created inside a product group directory
   (e.g., `Products/Checkout/Payments/`):
    - Check if the product group directory has an `AGENTS.md`. If not, suggest running `/forge-new-group`
      first to set up product-group-level context, conventions, and shared files — but allow the user to
      skip this and proceed with just the product.
    - If the product group has a `TEAM.md`, mention that the product will inherit the product group's team
      roster and ask if the product needs its own sub-team `TEAM.md` override.

3. **Template resolution**: When creating files from templates, check for product-group-level template
   overrides first:
    - If the product is inside a product group that has `Products/<Group>/Templates/<Template>.md`, use
      the product group's version instead of the root `Templates/<Template>.md`.
    - Otherwise, fall back to the root `Templates/` directory.

4. **Create folder structure**:
   ```
   Products/<ProductName>/
   ├── `AGENTS.md` (or your tool's context file name)
   ├── `GLOSSARY.md`
   ├── `TEAM.md`
   ├── Initiatives/
   │   └── .gitkeep
   └── References/
       └── .gitkeep
   ```

5. **Create context file** using `Templates/Product-AGENTS.EXAMPLE.md` as the starting point
   (applying template resolution from Step 3):
    - Copy the template to `AGENTS.md` (or your tool's context file name)
    - Replace `[Product Name]` with the actual product name
    - Fill in the Context section

6. **Create GLOSSARY.md** using `Templates/GLOSSARY.md` as the starting point
   (applying template resolution from Step 3):
    - Copy the template to `Products/<ProductName>/GLOSSARY.md`
    - Replace `[Product Name]` with the actual product name

7. **Create TEAM.md** using `Templates/TEAM.md` as the starting point
   (applying template resolution from Step 3):
    - Copy the template to `Products/<ProductName>/TEAM.md`
    - Replace `[Product Name]` with the actual product name
    - Skip this step if the user opted to inherit the product group's `TEAM.md` (Step 2)

8. **Create .gitkeep files** in empty folders (Initiatives/, References/).

9. **Update product group context**: If the product is inside a product group that has an `AGENTS.md`,
   add the new product to the product group's `## Products` table.

10. **Report**: Show the user what was created and suggest next steps:
    - Fill in the context file with product context
    - Add related repositories
    - Copy `Templates/REPOS.EXAMPLE.md` to `Products/<ProductName>/REPOS.md` and fill in local repository paths
    - Populate `GLOSSARY.md` with the product's ubiquitous language
    - Add team members to `TEAM.md` (if created)
    - Create first initiative with `/forge-new-initiative`

---

**Awaiting your direction.** What is the name of the new product?
