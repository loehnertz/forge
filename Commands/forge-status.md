# Forge: Status

Display a quick overview of the entire Forge workspace.

## Purpose

Provide a bird's-eye view of all products and initiatives without diving into individual files. Useful for:

- Daily standup context
- Onboarding new team members
- Identifying where attention is needed

## What Happens Here

1. Scan all Products in the workspace
2. Detect product groups (directories containing product subdirectories) and nest products under
   their product group headers
3. For each Product, list all Initiatives with their current stage
4. Flag staleness, blocked status, and potential issues
5. Present a compact, scannable summary

## Output Format

Present results grouped by product. When products belong to a product group, nest them under a product
group header using the `👥` icon. Ungrouped products appear at the top level as before:

```
📊 Forge Workspace Status
══════════════════════════════════════════════════════════════════════

📦 Analytics
   🔍 Standardized-Events        Discover    ⚠️ 45d stale    Lead: Jane Smith
   📝 Dashboard-Redesign         Design      ✅ Active        Lead: —

👥 Checkout
   📦 Payments
      🔍 Multi-Currency           Discover    ✅ Active        Lead: @alice
      🎫 Refund-Automation        Decompose   ✅ Active        Lead: —

   📦 Refunds
      📐 Return-Policy-V2         Decide      ✅ Active        Lead: @carol

👥 Platform
   📦 Auth
      🔍 OAuth-Migration          Discover    ✅ Active (blocks 1)   Lead: @bob

   📦 Events
      📝 Schema-Registry          Design      ✅ Active        Lead: —

══════════════════════════════════════════════════════════════════════
Summary: 2 product groups, 5 products, 6 initiatives (1 stale, 0 blocked)
```

## Stage Detection

Infer stage from artifacts present:

| Artifacts Present                                   | Inferred Stage     |
|-----------------------------------------------------|--------------------|
| Only Exploration.md (or nothing)                    | Discover           |
| Proposal.md exists, status `Draft`, no Decision     | Design             |
| Proposal.md exists, status `In Review`, no Decision | Design (In Review) |
| Decision.md exists, Tickets/ empty                  | Decide             |
| Decision.md + Tickets/ has content                  | Decompose          |
| Decision.md frontmatter `status: Accepted`          | Complete           |

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
| Last modified 30-90 days | ⚠️ Xd stale |
| Last modified > 90 days  | ❌ Xd stale  |

## Lead Display

Read the `lead:` field from each initiative's `AGENTS.md` YAML frontmatter:

- If `lead:` has a value, display it as `Lead: <value>` after the staleness indicator.
- If `lead:` is blank or absent, display `Lead: —`.
- Omit the Lead column entirely for completed initiatives to keep output compact.

## Dependency Indicators

When an Initiative has `depends-on` or `blocks` in its frontmatter:

| Condition                                  | Indicator                        |
|--------------------------------------------|----------------------------------|
| Has incomplete dependencies (`depends-on`) | ⏸️ Blocked by: [Initiative-Name] |
| Blocks other initiatives (`blocks`)        | (blocks N) appended to status    |

Dependencies are only shown if the blocking initiative is not yet Complete.

---

**Awaiting your direction.** Would you like me to show the workspace status?
