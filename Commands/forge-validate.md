# Forge: Validate Workspace

Validate the health of the Forge workspace by checking for structural issues, staleness, and inconsistencies.

## Purpose

Detect problems in the workspace that could mislead AI assistants or indicate stale context:

- Missing or broken links
- Orphaned artifacts
- Stale context files
- Stage inconsistencies

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

For each `AGENTS.md` with a `last-reviewed` frontmatter field:

- Parse the date from YAML frontmatter
- Flag files not reviewed in 30+ days as warnings
- Flag files not reviewed in 90+ days as errors
- Flag files with missing or invalid `last-reviewed` as needing attention

### 4. Stage Consistency

For each Initiative, compare the stated stage in `AGENTS.md` with actual artifacts:

| Stated Stage | Expected Artifacts                    | Inconsistency Flag                               |
|--------------|---------------------------------------|--------------------------------------------------|
| Discover     | Exploration.md may exist              | Decision.md exists = likely past Discover        |
| Design       | Exploration.md exists                 | Decision.md exists = likely past Design          |
| Decide       | Proposal.md exists                    | Decision.md missing = still in Decide            |
| Decompose    | Decision.md exists                    | Tickets/ empty = decomposition not started       |

Flag mismatches as warnings for human review.

## Output Format

Present results in a clear, scannable format:

```
🔍 Forge Workspace Validation
══════════════════════════════════════════════════════════════════════

📁 Products/PaymentService
   ✅ AGENTS.md exists and linked
   ✅ Related repositories accessible
   ✅ Last reviewed: 12 days ago

📁 Products/UserAuth
   ⚠️  AGENTS.md last reviewed 45 days ago
   ✅ Related repositories accessible

   📁 Initiatives/OAuth-Integration
      ⚠️  AGENTS.md says "Discover" but Decision.md exists
      ⚠️  AGENTS.md last reviewed 60 days ago

📁 Products/Legacy
   ❌ Linked in root AGENTS.md but folder doesn't exist

══════════════════════════════════════════════════════════════════════
Summary: 2 errors, 3 warnings

Recommendations:
- Remove or fix broken link to Products/Legacy
- Update stage in Products/UserAuth/Initiatives/OAuth-Integration/AGENTS.md
- Review stale AGENTS.md files and update last-reviewed timestamps
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
| ✅ Pass  | Item is healthy                                      | Links valid, recently reviewed          |
| ⚠️ Warn  | Potential issue, human judgment needed               | Stale timestamp, stage mismatch         |
| ❌ Error | Definite structural problem                          | Broken link, missing required file      |

## Limitations

This command validates **structure**, not **content**. It cannot determine:

- Whether an architecture description is accurate
- Whether an Initiative's goal is still relevant
- Whether Related Products relationships are complete

These require human review. Use the Context Health Checklist in FORGE.md for semantic validation.

---

**Awaiting your direction.** Would you like me to validate the workspace now?
