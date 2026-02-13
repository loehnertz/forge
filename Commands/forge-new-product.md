# Forge: New Product

Create the folder structure for a new product in the Forge workspace.

## Steps

1. **Get product name**: If not provided, ask the user for the product name.

2. **Create folder structure**:
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

3. **Create context file** using `Templates/Product-AGENTS.EXAMPLE.md` as the starting point:
    - Copy the template to `AGENTS.md` (or your tool's context file name)
    - Replace `[Product Name]` with the actual product name
    - Fill in the Context section

4. **Create GLOSSARY.md** using `Templates/GLOSSARY.md` as the starting point:
    - Copy `Templates/GLOSSARY.md` to `Products/<ProductName>/GLOSSARY.md`
    - Replace `[Product Name]` with the actual product name

5. **Create TEAM.md** using `Templates/TEAM.md` as the starting point:
    - Copy `Templates/TEAM.md` to `Products/<ProductName>/TEAM.md`
    - Replace `[Product Name]` with the actual product name

6. **Create .gitkeep files** in empty folders (Initiatives/, References/).

7. **Report**: Show the user what was created and suggest next steps:
    - Fill in the context file with product context
    - Add related repositories
    - Copy `Templates/REPOS.EXAMPLE.md` to `Products/<ProductName>/REPOS.md` and fill in local repository paths
    - Populate `GLOSSARY.md` with the product's ubiquitous language
    - Add team members to `TEAM.md`
    - Create first initiative with `/forge-new-initiative`
