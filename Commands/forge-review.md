# Forge: Review

You are reviewing a Forge artifact to assess its quality, completeness, and readiness.

## Purpose

Provide structured feedback on artifacts to identify gaps, surface questions, and suggest improvements.

## Context

- **Entry trigger**: User requests review of an artifact before the next stage
- **Exit artifact**: Review summary with actionable feedback

## Parameters

- **Path**: A specific artifact path (e.g., `Products/MyProduct/Initiatives/Analytics/Proposal.md`)
- **Type**: An artifact type in current initiative (`Exploration`, `Proposal`, `Decision`, `Tickets`)
- **None**: Review all artifacts in the current initiative

## Relevant Files

- The artifact being reviewed
- `Templates/` – Reference templates for conformance checking
- Related artifacts (e.g., Exploration when reviewing a Proposal)

## What Happens Here

1. Identify the artifact(s) to review
2. Load the corresponding template to check conformance
3. Assess completeness, clarity, and quality
4. Surface questions and concerns
5. Provide actionable improvement suggestions
6. Summarize readiness for the next stage

## Review Criteria by Type

**Exploration**:

- Problem statement is clear and bounded
- Observations are factual and sourced
- Questions identify open uncertainties
- Ideas present multiple approaches

**Proposal**:

- Problem stated before solution
- Alternatives honestly evaluated (not straw-manned)
- Design detail appropriate for the scope and complexity of the change
- Migration plan addresses rollout
- Open questions are specific

**Decision**:

- Context sufficient for future readers
- Rationale explains "why" not just "what"
- Consequences include trade-offs, not just benefits
- Traceable to the proposal it resolves

**Tickets**:

- Independently deliverable scope
- Acceptance criteria are testable
- Context referenced, not duplicated
- Dependencies documented

## Review Principles

- Focus on actionable feedback, not nitpicking
- Surface gaps and questions, don't solve them
- Compare against templates but allow intentional deviations
- Highlight strengths as well as concerns

---

**Awaiting your direction.** Which artifact would you like reviewed?
