# Forge: New Initiative

Create the folder structure for a new initiative within a product.

## Steps

1. **Get parameters**:
    - If product and initiative name are provided, use those.
    - Otherwise, ask the user:
        - Which product? (list existing products in Products/)
        - What's the initiative name?

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
   - Fill in the Goal section

4. **Create Exploration.md** using `Templates/Exploration.md` as the starting point:
   - Copy the template to `Exploration.md`
   - Replace `[Topic Name]` with the initiative name

5. **Create .gitkeep files** in empty folders (Notes/, References/, Tickets/).

6. **Report**: Show the user what was created and suggest next steps:
    - Fill in the goal and background in context file
    - Start capturing research in `Exploration.md`
    - Use `/forge-discover` to begin the Discover stage
