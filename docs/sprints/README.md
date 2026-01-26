# Sprints

This folder contains sprint planning artifacts used to execute work in small, reviewable slices.

## Sprint index

- ✅ [Sprint 1 Summary (Closed)](sprint_1/sprint_1_plan.md) — Closed 2026-01-25

## Folder convention

Each sprint lives in its own folder:

- `docs/sprints/sprint_<N>/`

Example:
- `docs/sprints/sprint_1/`

## Files inside a sprint folder

Each sprint folder should contain:

- `sprint_<N>_plan.md` or `sprint_<N>_plan.txt`
  - Human-readable plan: sprint goal, scope, risks, decisions, notes.
  - Useful for context and sequencing.

- `sprint_<N>_tasks.yaml`
  - **Source of truth for implementation scope and acceptance criteria.**
  - Coding agents should treat this file as the contract.
  - For **closed** sprints, this file may be bonsai-pruned to status + implementation pointers.

Optional (but encouraged over time):
- `adr/` — sprint-specific ADRs if a decision is temporary or experimental.
- `notes/` — playtest notes, demo checklist, retrospectives.
- `backlog.md` — aggregated deferred items from closed sprints.

## Source of truth and precedence

When there’s disagreement between documents:

1. The user prompt’s TASK SCOPE (explicit task IDs) is authoritative for what to implement.
2. `sprint_<N>_tasks.yaml` is authoritative for acceptance criteria, expected deliverables, and file impacts.
3. `sprint_<N>_plan.*` is supporting context and sequencing, but must not expand scope beyond the YAML + prompt.
4. Repo-wide rules still apply (see `AGENTS.md`, `docs/conventions.md`, `docs/product/vision.md`).

## How to start a new sprint

1. Create a new folder: `docs/sprints/sprint_<N>/`
2. Add:
   - `sprint_<N>_plan.md` (or `.txt`)
   - `sprint_<N>_tasks.yaml`
3. Ensure task IDs are unique within the sprint and stable over time.

## Task ID convention

Use stable IDs that remain the same even if the task title evolves:

- `TASK-001-1`, `TASK-002-4`, etc.

Each task should include (as applicable):
- `title`
- `description`
- `acceptance_criteria`
- `path_impacts`
- `dependencies`
- `owner_role` / `estimate`
- `ai_agents` prompts (optional)
- telemetry impacts (if applicable): event names touched and whether `docs/event_schema.md` is updated

## Agent usage (recommended prompt pattern)

When asking a coding agent to implement work:

- Reference the sprint folder explicitly (do not say “current sprint”).
- Name the task IDs explicitly.

Example:

> Sprint context: `docs/sprints/sprint_1/`  
> Read: `sprint_1_plan.*` and `sprint_1_tasks.yaml`  
> TASK SCOPE: `TASK-001-1` only

This keeps work deterministic and prevents scope creep.
