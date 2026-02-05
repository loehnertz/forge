# Forge: Status

Display a quick overview of the entire Forge workspace.

## Purpose

Provide a bird's-eye view of all products and initiatives without diving into individual files. Useful for:

- Daily standup context
- Onboarding new team members
- Identifying where attention is needed

## What Happens Here

1. Scan all Products in the workspace
2. For each Product, list all Initiatives with their current stage
3. Flag staleness, blocked status, and potential issues
4. Present a compact, scannable summary

## Output Format

Present results grouped by product:

```
📊 Forge Workspace Status
══════════════════════════════════════════════════════════════════════

📦 Analytics
   🔍 Standardized-Events        Discover    ⚠️ 45d stale
   📝 Dashboard-Redesign         Design      ✅ Active
   ✅ Real-Time-Alerts           Complete

📦 Payments
   🔍 Multi-Currency             Discover    ✅ Active
   📐 Checkout-V2                Decide      ⏸️ Blocked by: OAuth-Migration
   🎫 Refund-Automation          Decompose   ✅ Active

📦 Auth
   🔍 OAuth-Migration            Discover    ✅ Active (blocks 1)

══════════════════════════════════════════════════════════════════════
Summary: 3 products, 6 initiatives (1 stale, 1 blocked, 1 complete)
```

## Stage Detection

Infer stage from artifacts present:

| Artifacts Present                  | Inferred Stage |
|------------------------------------|----------------|
| Only Exploration.md (or nothing)   | Discover       |
| Proposal.md exists, no Decision    | Design         |
| Decision.md exists, Tickets/ empty | Decide         |
| Decision.md + Tickets/ has content | Decompose      |
| Status field = "Complete"          | Complete       |

If Initiative AGENTS.md has an explicit stage, prefer that over inference.

## Stage Icons

| Stage     | Icon |
|-----------|------|
| Discover  | 🔍   |
| Design    | 📝   |
| Decide    | 📐   |
| Decompose | 🎫   |
| Complete  | ✅    |

## Staleness Indicators

Staleness is determined by checking when files were last modified using version control or filesystem:

- Use `git log -1 --format="%cr" -- <file>` to get relative time since last commit
- Fall back to file modification time for untracked files

| Condition                | Indicator   |
|--------------------------|-------------|
| Last modified < 30 days  | ✅ Active    |
| Last modified 30-60 days | ⚠️ Xd stale |
| Last modified > 60 days  | ❌ Xd stale  |

## Dependency Indicators

When an Initiative has `depends-on` or `blocks` in its frontmatter:

| Condition                                  | Indicator                        |
|--------------------------------------------|----------------------------------|
| Has incomplete dependencies (`depends-on`) | ⏸️ Blocked by: [Initiative-Name] |
| Blocks other initiatives (`blocks`)        | (blocks N) appended to status    |

Dependencies are only shown if the blocking initiative is not yet Complete.

---

**Awaiting your direction.** Would you like me to show the workspace status?
