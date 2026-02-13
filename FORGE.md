# Forge

> A framework for agentic AI software engineering workspaces

Forge is a framework for structuring collaborative workspaces where software engineers and AI agents work together
on design and documentation. It provides conventions for organizing context, writing artifacts, and moving ideas from
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

Forge is a framework for building agentic AI software engineering workspaces: structured environments where AI tools
have the context they need to be genuinely useful collaborators rather than generic agents.

### The Problem

AI agents are powerful but context-starved. Without understanding our architecture, conventions, and goals, they
produce generic suggestions that require extensive correction. We spend time explaining the same background repeatedly,
and valuable design discussions happen in ephemeral chat sessions that leave no trace.

Built-in "project" or "memory" features in AI tools attempt to address this by letting us attach persistent instructions
and reference files. But they fall short for software engineering work: there's no structure for organizing context
hierarchically, no access to actual source code, and no way to evolve documentation alongside the codebase. They're
better than starting from scratch each time, but they remain disconnected from the reality of our systems.

### The Solution

Forge addresses this by:

- **Structuring context** through hierarchical `AGENTS.md` files that give AI agents progressively deeper
  understanding. From workspace-wide conventions down to initiative-specific goals, rather than flat instruction dumps.
- **Capturing knowledge** in durable artifacts (`Notes`, `Proposals`, `Decisions`) rather than transient conversations.
- **Connecting to reality** by linking workspaces to actual codebases and external systems. AI agents can read real
  implementations, not just descriptions of them.
- **Defining workflows** that move systematically from exploration to actionable work.
- **Living alongside code** as a git-tracked workspace that evolves with the systems it documents.

> **Note:** This documentation uses `AGENTS.md` as the generic name for context files. Rename to your AI tool's
> convention: `CLAUDE.md` for Claude Code, `.cursorrules` for Cursor, `COPILOT.md` for GitHub Copilot, etc.

### Guiding Principles

- **Context is King:** Layered `AGENTS.md` files give AI progressively deeper understanding.
- **Artifacts Over Meetings:** Capture substance in durable, searchable form (`Notes`, `Proposals`, `Decisions`).
- **Incremental Refinement:** Start messy in `Exploration`, formalize in `Proposal`, lock in `Decision`.
- **Link to Reality:** Connect to actual codebases via Related Repositories; flow artifacts into real systems.

### Who is Forge For?

Forge works with any AI coding agent. Despite being marketed for coding, these tools excel at writing, ideation, and
design work. The conventions are tool-agnostic; adapt the context file naming to your tool's conventions.

Forge is designed for software engineering teams who:

- Use AI agents for design and documentation work.
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
Repositories** pattern in product `AGENTS.md` files (with paths in the companion `REPOS.md`) links the two, allowing
AI agents to read actual implementations when discussing design.
This also hooks into the reality that the relationships between repositories are often more complex than being
one-to-one to our products (e.g., monorepos).

### Workspace Hierarchy

The internal structure of a Forge workspace:

```
forge/
├── FORGE.md               # This framework document
├── Commands/              # Lifecycle commands – copy to your tool's location
├── Templates/             # Starter files and example configs (see below)
├── Products/
│   └── <Product>/
│       ├── AGENTS.md      # Product context and linked repositories
│       ├── GLOSSARY.md    # Ubiquitous language for this product
│       ├── TEAM.md        # Product team roster
│       ├── REPOS.md       # Personal repository paths (gitignored)
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

1. **Context file:** Copy `Templates/AGENTS.EXAMPLE.md` to the workspace root, renamed to your tool's convention.

2. **Commands:** Copy files from `Commands/` to your tool's command location.

3. **Skills:** Skills (AI-invoked integrations like issue trackers or wikis) are user-maintained based on your
   integrations. Create them in your tool's skill/plugin location as needed.

4. **Personal style (optional):** Copy `Templates/STYLE.EXAMPLE.md` to `STYLE.md` at the workspace root and
   add your personal writing preferences. This file is gitignored – each team member can have their own.

5. **Repository paths:** Each product directory includes a `REPOS.md` — fill in the local paths where you have
   each repository cloned. This file is gitignored – each team member maintains their own.

6. **Team roster (optional):** Each product directory includes a `TEAM.md` where you can add the team members
   working on that product. This file is git-tracked – each product has its own roster reflecting who works on it.

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

`AGENTS.md` files are the heart of Forge. They provide context to AI agents at each level of the workspace
hierarchy.

Throughout this documentation, we use `AGENTS.md` as the generic term for context files. When setting up your workspace,
rename these files to match your AI tool's convention.

### Root `AGENTS.md`

The root file establishes workspace-wide conventions: working style, writing conventions, folder structure, and
available skills/commands.

**Template:** See [Templates/AGENTS.EXAMPLE.md](./Templates/AGENTS.EXAMPLE.md). Copy to workspace root, renamed to your
tool's convention.

### Product `AGENTS.md`

Product-level files add domain-specific context: what the product does, its architecture, related repositories, and
connections to other products.

**Template:** See [Templates/Product-AGENTS.EXAMPLE.md](./Templates/Product-AGENTS.EXAMPLE.md)

### Initiative `AGENTS.md` (Optional)

For complex `Initiatives`, a dedicated context file captures the goal, background, current state, and guidance for
navigating the `Initiative's` artifacts. The YAML frontmatter includes a `lead:` field (name or @handle of the
person driving the initiative) in addition to `depends-on` and `blocks` for dependency tracking. The `lead:` value
is displayed by `/forge-status`.

**Template:** See [Templates/Initiative-AGENTS.EXAMPLE.md](./Templates/Initiative-AGENTS.EXAMPLE.md)

### Personal Writing Style (`STYLE.md`)

For personal writing preferences – tone, spelling, formatting habits – that shouldn't be shared across
the team, Forge supports an optional `STYLE.md` file at the workspace root.

- **Gitignored by default.** Each team member can have their own without conflicts.
- **Overrides writing conventions only.** `STYLE.md` takes precedence over the shared Writing
  Conventions in `AGENTS.md` for stylistic choices but does not override structural rules, folder
  conventions, or workflow instructions.
- **Root-only.** Personal style is about the person, not the product or initiative. Product-level style
  overrides already have a mechanism – the `AGENTS.md` hierarchy.

**Template:** See [Templates/STYLE.EXAMPLE.md](./Templates/STYLE.EXAMPLE.md). Copy to `STYLE.md` at the workspace root
and customize.

### Repository Paths (`REPOS.md`)

Repository names and descriptions belong in the product `AGENTS.md` (shared context). But local filesystem
paths differ per developer, so they live in a separate `REPOS.md` inside each product directory.

- **Gitignored by default.** Each team member maintains their own paths.
- **Per-product.** Each `Products/<Name>/` directory has its own `REPOS.md`, keeping paths co-located with
  the product context that references those repositories.
- **Flat mapping.** A simple `Repository` → `Path` table. The repository name must match the name used in
  the product `AGENTS.md`'s `## Related Repositories` table.
- **Required for repo access.** AI agents use `REPOS.md` to resolve repository names to actual paths on
  disk. Without it, they cannot read source code for that product's repositories.

**Template:** See [Templates/REPOS.EXAMPLE.md](./Templates/REPOS.EXAMPLE.md). Copy to
`Products/<Product>/REPOS.md` and fill in your local paths.

Run `/forge-validate` to check for drift between `REPOS.md` and the product `AGENTS.md` — it will flag
repositories present in one but missing from the other.

### Team Roster (`TEAM.md`)

`TEAM.md` inside each product directory lists the people working on that product.

- **Git-tracked.** Unlike `STYLE.md` and `REPOS.md`, this file is shared — it records who works on the
  product and which AI tool each person uses.
- **Per-product.** Each `Products/<Name>/` directory has its own `TEAM.md`, reflecting that different
  products often have different teams.
- **Members table.** Columns: Name, Role, AI Tool, Contact.

**Template:** See [Templates/TEAM.md](./Templates/TEAM.md). Copy to `Products/<Product>/TEAM.md` for each product.
`/forge-onboard` can add the current user to each product's roster interactively.

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

### Glossary: Ubiquitous Language

**Purpose:** Capture the product's ubiquitous language — shared terms and their precise meanings — to
reduce ambiguity in artifacts and AI conversations.

**Characteristics:**

- Lives at the product level (`Products/<Product>/GLOSSARY.md`), not inside an `Initiative`.
- A single `## Terms` table: Term, Definition, Notes.
- Notes column holds synonyms, deprecated terms, or cross-references.
- Evolves over time as the domain is better understood.

**Template:** See [Templates/GLOSSARY.md](./Templates/GLOSSARY.md) for an example structure.

**When to use:** Whenever a term carries product-specific meaning or is ambiguous across teams (e.g.,
"account", "event", "order"). A populated ubiquitous language glossary helps AI agents use consistent
terminology and helps new team members ramp up quickly.

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
already established methodologies for writing code, managing sprints, and shipping software (also agentic AI).
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

**Setup commands** (one-time workspace configuration):

| Command          | What it does                                                                               |
|------------------|--------------------------------------------------------------------------------------------|
| `/forge-onboard` | Walk a new team member through tool detection, `REPOS.md`, `STYLE.md`, and `TEAM.md` setup |

**Scaffolding commands** (create folder structures):

| Command                 | What it does                                                                           |
|-------------------------|----------------------------------------------------------------------------------------|
| `/forge-new-product`    | Scaffold a new `Product` with `AGENTS.md`, `GLOSSARY.md`, `TEAM.md`, and empty folders |
| `/forge-new-initiative` | Scaffold a new `Initiative` with `Exploration.md`, folders, and optional lead prompt   |

These create the full folder structure with `.gitkeep` files in empty directories so they can be committed to git.

**Lifecycle commands** (set up context for each stage; see [Initiative Lifecycle](#initiative-lifecycle)):

| Command            | Stage     | What it does                                   |
|--------------------|-----------|------------------------------------------------|
| `/forge-discover`  | Discover  | Prepares to explore a problem space            |
| `/forge-design`    | Design    | Prepares to formalize findings into a proposal |
| `/forge-decide`    | Decide    | Prepares to finalize and record the decision   |
| `/forge-decompose` | Decompose | Prepares to break work into tickets            |

**Utility commands** (available at any stage):

| Command           | What it does                                                                            |
|-------------------|-----------------------------------------------------------------------------------------|
| `/forge-review`   | Reviews artifact quality and readiness                                                  |
| `/forge-search`   | Searches all workspace artifacts for a keyword or phrase, grouped by Product/Initiative |
| `/forge-status`   | Shows workspace overview with all products, initiatives by stage, and leads             |
| `/forge-validate` | Validates workspace health, links, staleness, and `REPOS.md` drift                      |
| `/forge-push`     | Pushes artifacts to linked external services (wiki, issue tracker)                      |
| `/forge-pull`     | Pulls remote changes from linked external services back into local artifacts            |

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

Repository information is split across two files per product:

**Product `AGENTS.md`** — shared context (committed to git):

```markdown
## Related Repositories

| Repository | Description            |
|------------|------------------------|
| backend    | API and business logic |
| frontend   | React application      |
```

**Product `REPOS.md`** — personal paths (gitignored):

```markdown
| Repository | Path                      |
|------------|---------------------------|
| backend    | ~/Projects/myapp-backend  |
| frontend   | ~/Projects/myapp-frontend |
```

Names and descriptions are team knowledge; paths are personal. AI agents resolve repository names by
looking up the path in `REPOS.md`, then read actual source code at that location.

### Connecting to External Services

Forge follows a **lifecycle handoff** model for external systems: we author artifacts locally, then push them out when
they're ready for broader visibility. If external collaborators make changes, we pull those changes back in. This is
intentionally not bidirectional sync. Forge remains the authoring environment during design time.

> **Be aware:** Pushing and pulling are inherently **lossy processes**. Markdown and external formats (Confluence
> storage format, Jira fields, Notion blocks, etc.) do not have a 1:1 mapping. Every conversion loses or approximates
> something – Mermaid diagrams may become code blocks, Confluence macros may become blockquotes, rich layouts may
> flatten. Repeated round-trips amplify this drift. Treat push/pull as a handoff mechanism, not a sync tool. When
> fidelity matters, review the conversion output carefully before confirming.

#### The `external` Frontmatter Block

Every publishable artifact can optionally link to one external resource via a generic `external` block in its
frontmatter:

```yaml
---
status: Draft
external:
  type: confluence-page
  id: "12345678"
  last-synced: 2025-01-15T10:30:00Z
---
```

| Field         | Purpose                                                                                                                                  |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `type`        | Identifies the external resource kind (e.g., `confluence-page`, `jira-issue`). Maps to a service type defined in the Product `AGENTS.md` |
| `id`          | The external resource's identifier (page ID, issue key, etc.)                                                                            |
| `last-synced` | ISO 8601 timestamp of the last push or pull – enables staleness detection                                                                |

All fields start empty in templates. They are populated by `/forge-push` on first push and updated on subsequent
push/pull operations.

#### Configuring Services in Product `AGENTS.md`

External service configuration lives in the `## External Services` section of each Product's `AGENTS.md`. Each
subsection defines a service type (e.g., a wiki page type, an issue tracker type) with freeform instructions that tell
the AI how to interact with it. A subsection should include:

- A `Used for:` line mapping artifact types to this service (e.g., Explorations, Proposals, Decisions, Tickets)
- Service-specific configuration (space, project, labels, etc.)
- `To push:` instructions for creating/updating resources in the external system
- `To pull:` instructions for fetching content and converting back to Markdown

The `Used for:` line maps artifact types to service types – this is how `/forge-push` knows which service to use when
pushing an artifact for the first time. See `Templates/Product-AGENTS.EXAMPLE.md` for the full template.

#### Push and Pull Commands

- **`/forge-push`** – Pushes a local artifact to its linked external resource. Creates a new resource on first push,
  updates the existing one on subsequent pushes. See `Commands/forge-push.md`.
- **`/forge-pull`** – Pulls the latest state from a linked external resource back into the local artifact. Shows a diff
  before applying changes. See `Commands/forge-pull.md`.

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

- [ ] **Architecture** section reflects current state
- [ ] **Related Repositories** names match entries in the product's `REPOS.md`
- [ ] **`REPOS.md`** paths exist on disk
- [ ] **`REPOS.md` drift** — no repositories in `AGENTS.md` missing from `REPOS.md`, and no stale extras in `REPOS.md`
- [ ] **Related Products** links are still accurate

Run `/forge-validate` to automate structural checks (including `REPOS.md` drift detection). Manual review is still
needed for semantic accuracy (e.g., "is the architecture description still true?").

### Start Messy, Refine Progressively

Don't try to write perfect documents from the start:

1. **Brain dump** into `Exploration`.
2. **Organize** when patterns emerge.
3. **Formalize** when decisions crystallize.
4. **Decompose** into tickets when ready to implement.

### Use AI for What It's Good At

AI agents excel at:

- Drafting structured documents from rough notes.
- Exploring trade-offs systematically.
- Generating alternatives we haven't considered.
- Consistency checking and gap identification.

AI agents need human judgment for:

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

### Push When Ready

Push finalized artifacts to external systems for team visibility using `/forge-push`. Keep Forge as the authoring
environment during design time and push when the artifact is stable enough for external consumption. Avoid pushing
`Draft` artifacts unless the team expects to collaborate externally during early stages. Use `/forge-pull` to
incorporate changes made by external collaborators before resuming local edits.

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
