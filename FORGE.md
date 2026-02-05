# Forge

> A framework for AI-assisted engineering workspaces

Forge is a framework for structuring collaborative workspaces where engineers and AI assistants work together on
design and documentation. It provides conventions for organizing context, writing artifacts, and moving ideas from
rough exploration to implementation-ready decisions.

---

## Table of Contents

1. [What is Forge?](#what-is-forge)
2. [Workspace Structure](#workspace-structure)
3. [The `AGENTS.md` System](#the-agentsmd-system)
4. [Artifact Types](#artifact-types)
5. [Initiative Lifecycle](#initiative-lifecycle)
6. [Commands & Skills](#commands--skills)
7. [Best Practices](#best-practices)

---

## What is Forge?

Forge is a framework for building AI-assisted engineering workspaces: structured environments where AI tools have the
context they need to be genuinely useful collaborators rather than generic assistants.

### The Problem

AI assistants are powerful but context-starved. Without understanding our architecture, conventions, and goals, they
produce generic suggestions that require extensive correction. We spend time explaining the same background repeatedly,
and valuable design discussions happen in ephemeral chat sessions that leave no trace.

Built-in "project" or "memory" features in AI tools attempt to address this by letting us attach persistent instructions
and reference files. But they fall short for engineering work: there's no structure for organizing context
hierarchically, no access to actual source code, and no way to evolve documentation alongside the codebase. They're
better than starting from scratch each time, but they remain disconnected from the reality of our systems.

### The Solution

Forge addresses this by:

- **Structuring context** through hierarchical `AGENTS.md` files that give AI assistants progressively deeper
  understanding. From workspace-wide conventions down to initiative-specific goals, rather than flat instruction dumps.
- **Capturing knowledge** in durable artifacts (`Notes`, `Proposals`, `Decisions`) rather than transient conversations.
- **Connecting to reality** by linking workspaces to actual codebases and external systems. AI assistants can read real
  implementations, not just descriptions of them.
- **Defining workflows** that move systematically from exploration to actionable work.
- **Living alongside code** as a git-tracked workspace that evolves with the systems it documents.

### Guiding Principles

- **Context is King:** Layered `AGENTS.md` files give AI progressively deeper understanding.
- **Artifacts Over Meetings:** Capture substance in durable, searchable form (`Notes`, `Proposals`, `Decisions`).
- **Incremental Refinement:** Start messy in `Exploration`, formalize in `Proposal`, lock in `Decision`.
- **Link to Reality:** Connect to actual codebases via Related Repositories; flow artifacts into real systems.

### Who is Forge For?

Forge works with any AI coding assistant. Despite being marketed for coding, these tools excel at writing, ideation, and
design work. The conventions are tool-agnostic; adapt the context file naming to your tool's conventions.

Forge is designed for software engineering teams who:

- Use AI assistants for design and documentation work.
- Want to preserve and build on design discussions rather than lose them.
- Need AI collaborators that understand their specific systems and conventions.
- Value written artifacts over verbal discussions for technical decisions.

### When NOT to Use Forge

Forge adds value through structured thinking and preserved context, but that structure has overhead. Skip Forge entirely
when:

- **Quick bug fixes:** The problem is clear, the fix is obvious, and there's nothing to decide
- **Small, self-contained changes:** A single-file tweak that doesn't affect architecture or require trade-off analysis
- **Changes with obvious solutions:** When there's only one reasonable approach and no meaningful alternatives to
  evaluate
- **Trivial configuration changes:** Environment variables, feature flags, or settings where the "why" is self-evident

The test is simple: if you wouldn't call a meeting about it, you probably don't need a Forge `Initiative`. Use your
judgment. A "quick fix" that keeps growing might deserve an `Initiative` after all.

---

## Workspace Structure

A Forge workspace is a **design workspace**, not a code repository. It lives alongside your git repositories, not
inside them:

```
~/Projects/
├── forge/                  # Forge workspace (can be its own git repository)
│   ├── FORGE.md
│   ├── AGENTS.md
│   └── Products/...
├── backend-api/            # Code repositories are siblings
├── frontend-app/
└── shared-libraries/
```

This separation keeps concerns clean: Forge handles design and documentation, repositories handle code. The **Related
Repositories** pattern in product `AGENTS.md` files links the two by path, allowing AI assistants to read actual
implementations when discussing design.
This also hooks into the reality that the relationships between repositories are often more complex than being
one-to-one to our products (e.g., monorepos).

### Workspace Hierarchy

The internal structure of a Forge workspace:

```
forge/
├── AGENTS.EXAMPLE.md      # Template: rename for your AI tool (see below)
├── FORGE.md               # This framework document
├── Commands/              # Lifecycle commands – copy to your tool's location
├── Templates/             # Starter files to bootstrap artifacts consistently
├── Products/
│   └── <Product>/
│       ├── AGENTS.md      # Product context and linked repositories
│       ├── Initiatives/   # Active workstreams
│       │   └── <Initiative>/
│       │       ├── AGENTS.md        # Initiative context (optional)
│       │       ├── Exploration.md   # Research synthesis
│       │       ├── Proposal.md      # Formal proposals
│       │       ├── Decision.md      # Architecture decisions
│       │       ├── Notes/           # Raw meeting notes, brain dumps
│       │       ├── References/      # Initiative-specific references
│       │       └── Tickets/         # Work item drafts
│       └── References/    # Product-level reference materials
```

### Adapting Forge to Your AI Tool

Forge ships with generic files that you adapt for your specific AI tool:

1. **Context file:** Rename `AGENTS.EXAMPLE.md` to your tool's convention.

2. **Commands:** Copy files from `Commands/` to your tool's command location.

3. **Skills:** Skills (AI-invoked integrations like issue trackers or wikis) are user-maintained based on your
   integrations. Create them in your tool's skill/plugin location as needed.

The `Commands/` folder contains the "shipped with Forge" versions. Your tool-specific copies can be customized (e.g.,
adding frontmatter, tool-specific syntax) while the originals serve as reference.

### Naming Conventions

- **`Initiatives`:** Use descriptive names that capture the goal (e.g., `Standardized-Analytics`,
  `Event-Sourcing-Migration`).
- **`Proposals`:** Use `Proposal.md` within an `Initiative` folder. If an `Initiative` involves multiple distinct
  proposals
  (e.g., separate design decisions for caching and API design), use topic suffixes: `Proposal-Caching.md`,
  `Proposal-API.md`.
- **`Decisions`:** Use `Decision.md` within an `Initiative` folder. If an `Initiative` has multiple decisions, use topic
  suffixes matching the proposals: `Decision-Caching.md`, `Decision-API.md`.
- **`Exploration`:** Use `Exploration.md` within an `Initiative` folder. For `Initiatives` exploring multiple distinct
  topics,
  use topic suffixes: `Exploration-Caching.md`, `Exploration-Scaling.md`.
- **Documents:** Use clear, descriptive names; include dates or versions when relevant.

---

## The `AGENTS.md` System

`AGENTS.md` files are the heart of Forge. They provide context to AI assistants at each level of the workspace
hierarchy.

Throughout this documentation, we use `AGENTS.md` as the generic term for context files. When setting up your workspace,
rename these files to match your AI tool's convention.

### Root `AGENTS.md`

The root file establishes workspace-wide conventions: working style, writing conventions, folder structure, and
available skills/commands.

**Template:** See [AGENTS.EXAMPLE.md](./AGENTS.EXAMPLE.md). Rename to your tool's convention.

### Product `AGENTS.md`

Product-level files add domain-specific context: what the product does, its architecture, related repositories, and
connections to other products.

**Template:** See [Templates/Product-AGENTS.EXAMPLE.md](./Templates/Product-AGENTS.EXAMPLE.md)

### Initiative `AGENTS.md` (Optional)

For complex `Initiatives`, a dedicated context file captures the goal, background, current state, and guidance for
navigating the `Initiative's` artifacts.

**Template:** See [Templates/Initiative-AGENTS.EXAMPLE.md](./Templates/Initiative-AGENTS.EXAMPLE.md)

### Linking Parent and Child Context Files

Parent context files should explicitly reference their children. This ensures AI tools discover and load the full
context hierarchy. Without these references, nested context may be missed entirely.

**Root → Products:**

```markdown
## Products

- [Analytics](./Products/Analytics/AGENTS.md)
- [Payments](./Products/Payments/AGENTS.md)
```

**Product → Initiatives:**

```markdown
## Active Initiatives

- [Event-Sourcing-Migration](./Initiatives/Event-Sourcing-Migration/AGENTS.md)
- [API-Redesign](./Initiatives/API-Redesign/AGENTS.md)
```

Keep these links current. When you create a new `Product` or `Initiative`, add it to the parent's list. When an
`Initiative` completes, either remove it or move it to a "Completed" section.

### Customizing Forge

`FORGE.md` is the canonical framework. Don't edit it. Instead, add a `## Forge Customizations` section to the root
`AGENTS.md` for team-specific overrides:

```markdown
## Forge Customizations

### Artifact Conventions

- Decisions are numbered sequentially (Decision-001, Decision-002, ...)
- Exploration files are named by topic (e.g., `Exploration-Caching.md`)

### Required Sections

- All proposals must include "Rollback Plan"

### Naming

- Initiatives use ticket prefix: `PROJ-123-Feature-Name/`
```

This layering works at every level:

- **Root `AGENTS.md`:** Company-wide Forge customizations.
- **Product `AGENTS.md`:** Product-specific overrides (e.g., stricter review requirements for a high-risk domain).
- **Templates/:** Customized artifact structures with required sections baked in.

---

## Artifact Types

Forge uses several artifact types, each with a specific purpose. They form a progression from raw to refined:

```
Notes/          → Raw dumps (meeting notes, transcripts, brain dumps)
Exploration     → Refined synthesis of research
Proposal        → Formal proposal (also known as RFC)
Decision        → Locked decision record (also known as ADR)
```

### Notes: Raw Context

**Purpose:** Dump raw meeting notes, transcripts, and unfiltered information.

**Characteristics:**

- Completely unfiltered: paste transcripts, copy meeting notes verbatim.
- Multiple files are fine (one per meeting, source, etc.).
- No expectation of structure or coherence.
- Treat as background context, not as source of truth.

**AI guidance:** `Notes` are raw and potentially incomplete or contradictory. When in doubt, prefer `Exploration.md` for
the
current understanding, or ask the user to clarify.

`Notes` are raw input (what we heard). `Exploration` is synthesis (what we understand).

**When to use:** After any meeting, interview, or brainstorm. Capture first, synthesize later.

### Exploration: The Living Scratchpad

**Purpose:** Synthesize research into a coherent understanding of the problem space.

**Characteristics:**

- Refined from raw `Notes` into structured findings.
- Links to external resources, code snippets, observations.
- Updated as understanding evolves.
- One per `Initiative` (or topic): the "current state" of discovery.

**Template:** See [Templates/Exploration.md](./Templates/Exploration.md) for an example structure.

**When to use:** Whenever we're exploring a problem, researching options, or collecting information that might inform a
decision.

### Proposal: Technical Proposals

Also known as **RFC** (Request for Comments) in some organizations.

**Purpose:** Propose a significant change with clear problem statement, solution, and evaluated alternatives.

**Characteristics:**

- Formal structure but not bureaucratic.
- Clearly states the problem before jumping to solution.
- Evaluates alternatives honestly.
- Invites feedback and iteration.

**Template:** See [Templates/Proposal.md](./Templates/Proposal.md) for an example structure.

**When to use:** When proposing a change that affects architecture, introduces new dependencies, or requires team
alignment.

### Decision: Architecture Decision

Also known as **ADR** (Architecture Decision Record) in some organizations.

**Purpose:** Record significant technical decisions and the reasoning behind them.

**Characteristics:**

- Point-in-time record (not updated when context changes).
- Captures the "why" not just the "what".
- References the proposal or discussion that led to the decision.

**Template:** See [Templates/Decision.md](./Templates/Decision.md) for an example structure.

**When to use:** After making a significant technical decision, especially one we might question later.

**Superseding decisions:** Decisions are point-in-time records. We don't edit them when circumstances change. Instead,
create a new decision that explicitly supersedes the old one:

- Reference the original decision being superseded (e.g., "This supersedes Decision-Caching.md").
- Explain what changed: new requirements, learnings, or context that invalidates the original choice.
- The old decision stays in place as historical record; the new decision becomes authoritative.

This preserves the full decision history and makes it clear why we changed course.

### Tickets: Actionable Work Items

**Purpose:** Define concrete tasks with clear acceptance criteria.

**Characteristics:**

- Specific and actionable.
- Include acceptance criteria.
- Reference context (`Proposals`, `Decisions`) rather than repeating it.
- Ready to move into issue tracker.

**Template:** See [Templates/Ticket.md](./Templates/Ticket.md) for an example structure.

**When to use:** When we've decided what to build and need to define the work for implementation.

---

## Initiative Lifecycle

Every `Initiative` follows a lifecycle from problem to implementation-ready.
Forge covers **the 4 D's** before code gets written.

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                         THE 4 D'S – INITIATIVE LIFECYCLE                     │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   ┌───────────┐    ┌───────────┐    ┌───────────┐    ┌───────────┐           │
│   │  DISCOVER │───▶│  DESIGN   │───▶│  DECIDE   │───▶│ DECOMPOSE │           │
│   └─────┬─────┘    └─────┬─────┘    └─────┬─────┘    └─────┬─────┘           │
│         │                │                │                │                 │
│         ▼                ▼                ▼                ▼                 │
│    Exploration.md    Proposal.md     Decision.md        Tickets/             │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

Once you have tickets, Forge's job is done. **Implementation is intentionally not part of the framework.** There are
already established methodologies for writing code, managing sprints, and shipping software (also AI-assisted).
Forge focuses on what often gets lost: the design thinking and decision-making that happens *before* implementation.

Nevertheless, during implementation, reference your Forge `Initiative` for context. Link pull requests back to the
relevant `Proposal` and `Decision` documents so future readers understand not just *what* was built, but *why*.

### Stages

| Stage         | Purpose                                   | Entry Trigger                   | Exit Artifact                   |
|---------------|-------------------------------------------|---------------------------------|---------------------------------|
| **Discover**  | Capture problem, research, gather context | Ticket, incident, idea          | `Exploration` with findings     |
| **Design**    | Formalize proposal, evaluate trade-offs   | Enough understanding to propose | `Proposal` with alternatives    |
| **Decide**    | Get alignment, commit to approach         | `Proposal` ready for review     | `Decision` recording the choice |
| **Decompose** | Break into actionable work                | `Decision` made                 | `Tickets` ready for backlog     |

### Workflow Commands

Each stage has a corresponding command. See [Commands & Skills](#commands--skills) for details.

**Practical notes:** Stages are a guide, not a mandate. `Design` often reveals gaps that send us back to `Discover`.
Small changes might skip stages entirely. Some initiatives die early – keep them around to preserve the learning.

---

## Commands & Skills

Forge distinguishes between two types of extensibility:

| Type     | Invoked by | Purpose                                              | Shipped?            |
|----------|------------|------------------------------------------------------|---------------------|
| Commands | User       | Explicit lifecycle actions (`/forge-discover`, etc.) | Yes, in `Commands/` |
| Skills   | AI         | Contextual integrations (issue tracker, wiki)        | No, user-maintained |

### Commands

Commands are user-invoked actions. Forge ships with these in the `Commands/` folder (copy to your tool's location):

**Scaffolding commands** (create folder structures):

| Command                 | What it does                                                  |
|-------------------------|---------------------------------------------------------------|
| `/forge-new-product`    | Scaffold a new `Product` with `AGENTS.md` and empty folders   |
| `/forge-new-initiative` | Scaffold a new `Initiative` with `Exploration.md` and folders |

These create the full folder structure with `.gitkeep` files in empty directories so they can be committed to git.

**Lifecycle commands** (set up context for each stage; see [Initiative Lifecycle](#initiative-lifecycle)):

| Command            | Stage     | What it does                                   |
|--------------------|-----------|------------------------------------------------|
| `/forge-discover`  | Discover  | Prepares to explore a problem space            |
| `/forge-design`    | Design    | Prepares to formalize findings into a proposal |
| `/forge-decide`    | Decide    | Prepares to finalize and record the decision   |
| `/forge-decompose` | Decompose | Prepares to break work into tickets            |

**Utility commands** (available at any stage):

| Command           | What it does                                                        |
|-------------------|---------------------------------------------------------------------|
| `/forge-review`   | Reviews artifact quality and readiness                              |
| `/forge-status`   | Shows workspace overview with all products and initiatives by stage |
| `/forge-validate` | Validates workspace health, links, and staleness                    |

### Skills

Skills are contextual capabilities the AI invokes automatically when it recognizes a relevant situation, for example
fetching ticket details when discussing implementation work.

**Skills are not shipped with Forge.** They depend on your team's integrations and tooling. Create them based on your
needs:

| Category      | Purpose                                      | Examples                        |
|---------------|----------------------------------------------|---------------------------------|
| Issue tracker | Fetch ticket details and acceptance criteria | Jira, Linear, GitHub Issues     |
| Documentation | Search and read wiki pages                   | Confluence, Notion, GitBook     |
| Code review   | Run quality checks on changes                | Custom agents, linters          |
| Scaffolding   | Generate boilerplate for new features        | API designer, component builder |

### Defining Commands & Skills

Both use a similar format, typically a Markdown file with instructions (some tools add frontmatter):

```markdown
---
description: Short description shown in list
---

# Name

1. **Step one:** What to do first
2. **Step two:** What to do next
```

The exact location depends on your AI tool. See your tool's documentation.

Document available commands and skills in your root `AGENTS.md` so team members know what's available.

### Connecting to Repositories

The `## Related Repositories` section in product `AGENTS.md` files links to actual codebases:

```markdown
## Related Repositories

| Repository | Path                        | Description           |
|------------|-----------------------------|-----------------------|
| backend    | ~/Projects/myapp-backend    | API and business logic|
| frontend   | ~/Projects/myapp-frontend   | React application     |
```

This allows AI to read and understand actual implementation when discussing design.

---

## Best Practices

### Track the Workspace in version control

A Forge workspace works best when version-controlled; it provides:

- **History:** See how designs evolved over time.
- **Collaboration:** Multiple people can contribute to artifacts.
- **Branching:** Experiment with alternative approaches in branches.
- **Review:** Proposals and decisions can go through pull request review.
- **Backup:** The workspace is recoverable if something goes wrong.

Commit artifacts as they stabilize. Rough `Exploration` updates can be frequent, while `Proposal` commits should mark
meaningful milestones.
The `.gitignore` can exclude any local scratch files that shouldn't be shared.

### Keep Context Files Current

Stale context is worse than no context; it misleads. Update `AGENTS.md` files when:

- Architecture changes.
- New patterns are adopted.
- `Initiatives` complete or change in direction.
- Conventions evolve.

#### Staleness Detection

Use version control or filesystem to check when files were last updated:

- `git log -1 --format="%cr" -- <file>` – Shows relative time since last commit
- `git log -1 --format="%ci" -- <file>` – Shows absolute date of last commit
- File modification time as fallback for untracked files

The `/forge-validate` command uses these methods to flag files not updated in 30+ days.

#### Context Health Checklist

Review context files monthly or quarterly. For each `AGENTS.md`, verify:

- [ ] **Active Initiatives** are listed and linked correctly
- [ ] **Completed Initiatives** are moved or removed
- [ ] **Architecture** section reflects current state
- [ ] **Related Repositories** paths exist on disk
- [ ] **Related Products** links are still accurate
- [ ] **Open Questions** are still relevant

Run `/forge-validate` to automate structural checks. Manual review is still needed for semantic accuracy (e.g., "is
the architecture description still true?").

### Start Messy, Refine Progressively

Don't try to write perfect documents from the start:

1. **Brain dump** into `Exploration`.
2. **Organize** when patterns emerge.
3. **Formalize** when decisions crystallize.
4. **Decompose** into tickets when ready to implement.

### Use AI for What It's Good At

AI assistants excel at:

- Drafting structured documents from rough notes.
- Exploring trade-offs systematically.
- Generating alternatives we haven't considered.
- Consistency checking and gap identification.

AI assistants need human judgment for:

- Business context and priorities.
- Team dynamics and politics.
- Risk tolerance decisions.
- Thorough review of proposed changes.

### Link Liberally

Connect artifacts to each other and to external resources:

- `Exploration` should link to `References`.
- `Proposals` should reference related `Decisions`.
- `Tickets` should point to their parent `Proposal`.
- `AGENTS.md` files should link to key documents.
- `Products` should link to related `Products` they depend on or interact with.

Cross-product linking helps the AI build a "mental model" of how your systems interact: which services call which, what
data flows where, and where integration points exist.

Isolated documents lose context over time.

### Keep, Don't Delete

When work completes, leave initiatives where they are rather than deleting them. Future-us might need that context.

### Know When to Stop Documenting

Not every thought needs to be written down. Document when:

- The decision is significant or non-obvious.
- Others will need to understand the reasoning.
- We might forget why we made this choice.
- The work is complex enough to benefit from structure.

Skip documentation when:

- The change is trivial and obvious.
- Documentation would be pure overhead.
- The artifact would never be read.
