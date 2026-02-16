# Forge: Validate Workspace

Validate the health of the Forge workspace by checking for structural issues, staleness, and inconsistencies.

## Purpose

Detect problems in the workspace that could mislead AI agents or indicate stale context:

- Missing or broken links
- Orphaned artifacts
- Stale context files
- Stage inconsistencies
- Broken or circular dependencies
- REPOS.md drift (repositories listed in AGENTS.md but missing from REPOS.md, or vice versa)

## Validation Checks

Perform the following checks and report results:

### 1. Link Integrity

For each `AGENTS.md` file (or your tool's equivalent), verify that linked items exist:

- Products listed in root `AGENTS.md` have corresponding folders
- Initiatives listed in Product `AGENTS.md` have corresponding folders
- Each product with Related Repositories has a `REPOS.md` in its directory (warn if missing)
- Repository names in Product `AGENTS.md` have matching entries in that product's `REPOS.md` (warn if missing)
- Repository paths in `REPOS.md` exist on disk (error if missing)
- Key Documents links point to existing files

### 2. Orphan Detection

Find artifacts that exist but aren't linked:

- Product folders without a link in root `AGENTS.md`
- Initiative folders without a link in their Product's `AGENTS.md`
- Stray files that don't fit the expected structure

### 3. Freshness Check

For each `AGENTS.md` file, check when it was last modified using version control or filesystem:

- Use `git log -1 --format="%cr" -- <file>` to get relative time since last commit
- Use `git log -1 --format="%ci" -- <file>` to get absolute date of last commit
- Fall back to file modification time for untracked files
- Flag files not updated in 30+ days as warnings
- Flag files not updated in 90+ days as errors

### 4. Stage Consistency

For each Initiative, compare the stated stage in `AGENTS.md` with actual artifacts:

| Stated Stage | Expected Artifacts       | Inconsistency Flag                         |
|--------------|--------------------------|--------------------------------------------|
| Discover     | Exploration.md may exist | Decision.md exists = likely past Discover  |
| Design       | Exploration.md exists    | Decision.md exists = likely past Design    |
| Decide       | Proposal.md exists       | Decision.md missing = still in Decide      |
| Decompose    | Decision.md exists       | Tickets/ empty = decomposition not started |

Flag mismatches as warnings for human review.

### 5. Dependency Validation

For each Initiative with `depends-on` or `blocks` in its YAML frontmatter:

**Path validation:**

- Verify each dependency path points to an existing Initiative folder
- Flag broken paths as errors

**Circular dependency detection:**

- Build a dependency graph from all `depends-on` relationships
- Detect cycles (A depends on B depends on C depends on A)
- Flag circular dependencies as errors

**Symmetry check:**

- If A lists B in `depends-on`, B should list A in `blocks` (and vice versa)
- Flag asymmetric dependencies as warnings

| Check       | Level   | Example                                           |
|-------------|---------|---------------------------------------------------|
| Broken path | ❌ Error | `depends-on: Products/X/Initiatives/Gone` missing |
| Circular    | ❌ Error | A → B → C → A forms a cycle                       |
| Asymmetric  | ⚠️ Warn | A depends-on B, but B doesn't list A in blocks    |

### 6. REPOS.md Drift Check

For each product that has **both** a `## Related Repositories` table in its `AGENTS.md` **and** a
`REPOS.md` file, compare the repository names in each direction:

- **❌ Error:** Repository is listed in `AGENTS.md` but has no entry in `REPOS.md` — this user has
  no local path configured for it and AI agents cannot access it.
- **⚠️ Warning:** Repository is listed in `REPOS.md` but not in `AGENTS.md` — the entry may be
  stale or belong to a different product.

Skip silently if the product has no `## Related Repositories` section or no `REPOS.md` (a separate
warning for the missing `REPOS.md` is already emitted by Check 1).

> **Note:** `REPOS.md` is gitignored — this check is per-user. Other team members may have
> different entries in their own copies.

| Check                               | Level      | Example                                                    |
|-------------------------------------|------------|------------------------------------------------------------|
| In AGENTS.md, missing from REPOS.md | ❌ Error    | `backend` listed in AGENTS.md but no row in REPOS.md       |
| In REPOS.md, not in AGENTS.md       | ⚠️ Warning | `legacy-api` in REPOS.md has no matching repo in AGENTS.md |

### 7. Product Group Validation

For each product group directory (directories under `Products/` that contain product subdirectories):

**Product group link integrity:**

- If the product group has an `AGENTS.md`, verify that its `## Products` table links to existing product directories
- Verify the root `AGENTS.md` references the product group and its products

**Template override validation:**

- If the product group has a `Templates/` directory, check that every file in it has a counterpart in the
  root `Templates/` directory
- Flag files without root counterparts as errors — product groups can override existing templates but
  cannot add new template types

**Product group orphan detection:**

- Find product group directories that exist but are not referenced in the root `AGENTS.md`
- Find products within product groups that are not referenced in the product group's `AGENTS.md` (if it
  exists)

**Product group staleness:**

- Apply the same freshness checks (30/90 day thresholds) to product-group-level `AGENTS.md`, `GLOSSARY.md`,
  `TEAM.md`, and `STYLE.md`

**Glossary term conflict warnings:**

- If both a product group and its product define the same term in their `GLOSSARY.md`, flag a warning
  (product-level wins, but the conflict should be intentional)

| Check                             | Level      | Example                                                              |
|-----------------------------------|------------|----------------------------------------------------------------------|
| Template without root counterpart | ❌ Error    | `Products/Platform/Templates/Custom.md` has no root equivalent       |
| Unlinked product group            | ⚠️ Warning | `Products/Platform/` not referenced in root AGENTS.md                |
| Unlinked product in product group | ⚠️ Warning | `Products/Platform/Auth/` not in product group's `## Products` table |
| Stale product group file          | ⚠️/❌       | Product group `AGENTS.md` not updated in 45 days                     |
| Glossary term conflict            | ⚠️ Warning | "Event" defined in both product group and product GLOSSARY.md        |

## Output Format

Present results in a clear, scannable format:

```
🔍 Forge Workspace Validation
══════════════════════════════════════════════════════════════════════

📁 Products/PaymentService
   ✅ AGENTS.md exists and linked
   ✅ REPOS.md exists
   ✅ All repository paths accessible
   ✅ REPOS.md in sync with Related Repositories
   ✅ Last modified: 12 days ago

   📁 Initiatives/Checkout-V2
      ✅ Stage consistent with artifacts
      ⚠️  depends-on: OAuth-Migration, but OAuth-Migration doesn't list this in blocks

📁 Products/UserAuth
   ⚠️  AGENTS.md last modified 45 days ago
   ⚠️  REPOS.md missing — repo paths not configured for this product
   ✅ Related repositories listed

   📁 Initiatives/OAuth-Integration
      ⚠️  AGENTS.md says "Discover" but Decision.md exists
      ⚠️  AGENTS.md last modified 60 days ago

   📁 Initiatives/Legacy-Auth-Cleanup
      ❌ depends-on: Products/Infra/Initiatives/Gone – path does not exist

📁 Products/Legacy
   ❌ Linked in root AGENTS.md but folder doesn't exist

🔗 Dependency Graph
   ❌ Circular dependency detected: A → B → C → A

══════════════════════════════════════════════════════════════════════
Summary: 4 errors, 3 warnings

Recommendations:
- Remove or fix broken link to Products/Legacy
- Fix broken dependency path in Legacy-Auth-Cleanup
- Resolve circular dependency: A → B → C → A
- Update stage in Products/UserAuth/Initiatives/OAuth-Integration/AGENTS.md
- Add symmetric blocks/depends-on entries for Checkout-V2 ↔ OAuth-Migration
- Review stale AGENTS.md files and update content
```

## How to Run

1. Start from the workspace root
2. Recursively scan all Products and Initiatives
3. Perform each validation check
4. Compile and present results
5. Optionally suggest fixes for common issues

## Severity Levels

| Level   | Meaning                                | Examples                           |
|---------|----------------------------------------|------------------------------------|
| ✅ Pass  | Item is healthy                        | Links valid, recently modified     |
| ⚠️ Warn | Potential issue, human judgment needed | Stale file, stage mismatch         |
| ❌ Error | Definite structural problem            | Broken link, missing required file |

## Limitations

This command validates **structure**, not **content**. It cannot determine:

- Whether an architecture description is accurate
- Whether an Initiative's goal is still relevant
- Whether Related Products relationships are complete

These require human review. Use the Context Health Checklist in FORGE.md for semantic validation.

---

**Awaiting your direction.** Would you like me to validate the workspace now?
