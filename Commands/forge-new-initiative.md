# Forge: New Initiative

Create the folder structure for a new initiative within a product.

## Steps

1. **Get parameters**:
    - If product and initiative name are provided, use those.
    - Otherwise, ask the user:
        - Which product? (list existing products in Products/)
        - What's the initiative name?
        - Who is the lead for this initiative? (name or @handle; optional — leave blank if unknown)

2. **Create folder structure**:
   ```
   Products/<Product>/Initiatives/<InitiativeName>/
   ├── `AGENTS.md` (or your tool's context file name)
   ├── `Exploration.md`
   ├── Notes/
   │   └── .gitkeep
   ├── References/
   │   └── .gitkeep
   └── Tickets/
       └── .gitkeep
   ```

3. **Create context file** using `Templates/Initiative-AGENTS.EXAMPLE.md` as the starting point:
    - Copy the template to `AGENTS.md` (or your tool's context file name)
    - Replace `[Initiative Name]` with the actual initiative name
    - Set `lead:` in the frontmatter to the provided value (leave blank if none given)
    - Fill in the Goal section
    - Ask the user if this initiative depends on any other initiative or blocks any other. If yes, populate
      the `depends-on` and `blocks` frontmatter arrays with the relative paths to those initiatives
      (e.g., `Products/Auth/Initiatives/OAuth-Migration`), and fill in the `## Dependencies` section with
      a brief note explaining why each dependency exists. Also ask the blocking/depending initiative's owner
      to add the symmetric entry to keep `forge-validate` happy.

4. **Create Exploration.md** using `Templates/Exploration.md` as the starting point:
    - Copy the template to `Exploration.md`
    - Replace `[Topic Name]` with the initiative name

5. **Create .gitkeep files** in empty folders (Notes/, References/, Tickets/).

6. **Report**: Show the user what was created and suggest next steps:
    - Fill in the goal and background in context file
    - Start capturing research in `Exploration.md`
    - Update the product's `## Active Initiatives` table in the product `AGENTS.md` — add a new row
      with the initiative name (linked), the starting stage (`Discover`), and the lead if provided
    - Use `/forge-discover` to begin the Discover stage

---

**Awaiting your direction.** Which product should the new initiative be created under, and what is the initiative name?
