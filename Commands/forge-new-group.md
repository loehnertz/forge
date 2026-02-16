# Forge: New Product Group

Create or upgrade a product group (team) in the Forge workspace.

## Steps

1. **Get product group name**: If not provided, ask the user for the product group name. The product
   group directory will be created at `Products/<GroupName>/`.

2. **Check for existing directory**: If `Products/<GroupName>/` already exists (i.e., it is currently
   a "dumb" container with products but no product-group-level files), offer to upgrade it by adding
   the product-group-level files described below. If products exist in the directory, note them for
   Step 6.

3. **Create AGENTS.md** using `Templates/Group-AGENTS.EXAMPLE.md` as the starting point:
    - Copy the template to `AGENTS.md` (or your tool's context file name)
    - Replace `[Product Group Name]` with the actual product group name
    - Fill in the Context section with the team's domain and cross-cutting concerns

4. **Create GLOSSARY.md** using `Templates/GLOSSARY.md` as the starting point:
    - Copy `Templates/GLOSSARY.md` to `Products/<GroupName>/GLOSSARY.md`
    - Replace `[Product Name]` with the product group name (the glossary format is shared)

5. **Create TEAM.md** using `Templates/TEAM.md` as the starting point:
    - Copy `Templates/TEAM.md` to `Products/<GroupName>/TEAM.md`
    - Replace `[Product Name]` with the product group name (the team roster format is shared)

6. **Pre-populate Products table**: If product subdirectories already exist in the product group
   directory (directories containing an `Initiatives/` folder or their own `AGENTS.md`), add them to
   the `## Products` table in the new product group `AGENTS.md`.

7. **Optional — STYLE.md**: Ask the user if they want a shared team writing style:
    - If yes: copy `Templates/Group-STYLE.EXAMPLE.md` to `Products/<GroupName>/STYLE.md` and
      replace `[Product Group Name]` with the actual product group name
    - If no: skip

8. **Optional — Template overrides**: Ask the user if they want to override any root-level templates
   for this product group:
    - If yes: show the list of templates in `Templates/` (Exploration.md, Proposal.md, Decision.md,
      Ticket.md) and ask which to override
    - Create `Products/<GroupName>/Templates/` and copy the selected base templates into it
    - Remind the user to customize the copied templates for their team's needs
    - If no: skip

9. **Report**: Show the user what was created and suggest next steps:
    - Fill in the product group context file with team domain and conventions
    - Add Forge Customizations if the team has specific overrides
    - Populate `GLOSSARY.md` with shared terminology
    - Add team members to `TEAM.md`
    - Customize template overrides (if created)
    - Update the root `AGENTS.md` `## Products` section to reference the product group and its products
    - Create products within the product group with `/forge-new-product`

---

**Awaiting your direction.** What is the name of the new product group?
