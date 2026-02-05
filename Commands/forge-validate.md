# Forge: Validate Workspace

Validate the health of the Forge workspace by checking for structural issues, staleness, and inconsistencies.

## Purpose

Detect problems in the workspace that could mislead AI assistants or indicate stale context:

- Missing or broken links
- Orphaned artifacts
- Stale context files
- Stage inconsistencies
- Broken or circular dependencies

## Validation Checks

Perform the following checks and report results:

### 1. Link Integrity

For each `AGENTS.md` file (or your tool's equivalent), verify that linked items exist:

- Products listed in root `AGENTS.md` have corresponding folders
- Initiatives listed in Product `AGENTS.md` have corresponding folders
- Related Repository paths exist on disk
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

| Stated Stage | Expected Artifacts                    | Inconsistency Flag                               |
|--------------|---------------------------------------|--------------------------------------------------|
| Discover     | Exploration.md may exist              | Decision.md exists = likely past Discover        |
| Design       | Exploration.md exists                 | Decision.md exists = likely past Design          |
| Decide       | Proposal.md exists                    | Decision.md missing = still in Decide            |
| Decompose    | Decision.md exists                    | Tickets/ empty = decomposition not started       |

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

| Check              | Level   | Example                                           |
|--------------------|---------|---------------------------------------------------|
| Broken path        | ❌ Error | `depends-on: Products/X/Initiatives/Gone` missing |
| Circular           | ❌ Error | A → B → C → A forms a cycle                       |
| Asymmetric         | ⚠️ Warn  | A depends-on B, but B doesn't list A in blocks    |

## Output Format

Present results in a clear, scannable format:

```
🔍 Forge Workspace Validation
══════════════════════════════════════════════════════════════════════

📁 Products/PaymentService
   ✅ AGENTS.md exists and linked
   ✅ Related repositories accessible
   ✅ Last modified: 12 days ago

   📁 Initiatives/Checkout-V2
      ✅ Stage consistent with artifacts
      ⚠️  depends-on: OAuth-Migration, but OAuth-Migration doesn't list this in blocks

📁 Products/UserAuth
   ⚠️  AGENTS.md last modified 45 days ago
   ✅ Related repositories accessible

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

| Level   | Meaning                                              | Examples                                |
|---------|------------------------------------------------------|-----------------------------------------|
| ✅ Pass  | Item is healthy                                      | Links valid, recently modified          |
| ⚠️ Warn  | Potential issue, human judgment needed               | Stale file, stage mismatch              |
| ❌ Error | Definite structural problem                          | Broken link, missing required file      |

## Limitations

This command validates **structure**, not **content**. It cannot determine:

- Whether an architecture description is accurate
- Whether an Initiative's goal is still relevant
- Whether Related Products relationships are complete

These require human review. Use the Context Health Checklist in FORGE.md for semantic validation.

---

**Awaiting your direction.** Would you like me to validate the workspace now?
