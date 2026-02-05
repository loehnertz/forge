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

3. **Create context file** with this template:
   ```markdown
   # <Initiative Name>

   ## Goal

   One-sentence summary of what we're trying to achieve.

   ## Background

   - Why this initiative exists
   - Key decisions already made
   - Constraints we're working within

   ## Current State

   - Where we are in the process
   - Open questions
   - Recent decisions

   ## Key Documents

   - Links to relevant proposals, decisions, external docs

   ## Context Guidance

   - **Notes/**: Raw meeting notes and transcripts – unfiltered, may be incomplete or contradictory
   - **`Exploration.md`**: Refined synthesis – use this as the source of truth for current understanding
   - When Notes and Exploration conflict, trust Exploration or ask for clarification
   ```

4. **Create Exploration.md** with this template:
   ```markdown
   # <Initiative Name>

   ## Problem Statement

   What problem are we trying to solve?

   ## Links

   - Relevant external resources, docs, prior art

   ## Observations

   - What have we learned so far?

   ## Questions

   - What do we still need to find out?

   ## Ideas

   - Potential approaches to explore
   ```

5. **Create .gitkeep files** in empty folders (Notes/, References/, Tickets/).

6. **Report**: Show the user what was created and suggest next steps:
    - Fill in the goal and background in context file
    - Start capturing research in `Exploration.md`
    - Use `/forge-discover` to begin the Discover stage
