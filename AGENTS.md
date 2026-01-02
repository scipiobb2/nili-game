# AGENTS.md — Repo instructions for Codex + coding agents

This file contains **stable, repo-wide** instructions.
Per-sprint and per-task scope lives under `docs/sprints/` and in the user prompt.

Codex loads instruction files from repo root down to the current working directory
(and prefers `AGENTS.override.md` over `AGENTS.md` when present). Keep this file concise. 

---

## Read these first (authoritative docs)

Before coding, read and follow:
- `docs/ai/coding_agent_playbook.md` (required workflow + required final response structure A–F)
- `docs/conventions.md` (folder boundaries + determinism rules + testing expectations)
- `docs/product/vision.md` (product intent + non-goals)

Sprint context (the prompt will name which one):
- `docs/sprints/<sprint_id>/sprint_<n>_plan.txt`
- `docs/sprints/<sprint_id>/sprint_<n>_tasks.yaml` (treat as the contract for acceptance criteria)

If any of these conflict, call it out explicitly and propose a safe resolution path.
Do not silently “pick one.”

---

## Quick commands (copy/paste)

### Tests (canonical entrypoint)
From repo root:
- `./game/run_tests.sh`

Do not invent alternative test commands unless the task explicitly requires it.
(If you need to debug the runner itself, see `docs/conventions.md` for direct Godot invocations.)

---

## Working directory guidance

- The Godot project root is `game/` (`game/project.godot`).
- Most code changes will be under `game/src/` and tests under `game/tests/`.

If you are changing anything under `game/`, also read and follow:
- `game/AGENTS.md`
- `game/src/README.md`

---

## Non‑negotiable guardrails

### Scope discipline
- Implement **only** the task(s) explicitly listed in the user prompt (TASK_SCOPE) and described in the sprint YAML.
- If something is helpful but out-of-scope, list it under “Follow-ups / Recommendations” (do not implement).

### Determinism-first direction
- Do not introduce gameplay outcomes that depend on frame rate, physics timing, wall-clock time, or hidden randomness.
- Keep domain logic deterministic and testable (per `docs/conventions.md`).

### Safety / privacy (kid-focused)
- No chat or accounts unless explicitly tasked. **Telemetry is encouraged** for internal operations and may use stable pseudonymous identifiers (player_id/session_id) per `docs/event_schema.md`. Do not collect **direct PII** or **free-form user text**. Network calls still require explicit task scope.

### Dependencies
- Do not add third-party deps or large frameworks unless explicitly asked.

---

## Generated / third-party content

- `game/build/` is export output. Do not hand-edit or “fix” files under it unless the task explicitly targets export/deploy artifacts.
- `game/addons/` is third-party. Do not modify unless explicitly tasked.
- Godot `.uid` files are part of project metadata. Do not delete them casually.

---

## Review guidelines (used by Codex GitHub reviews)

Treat these as P0/P1 issues when reviewing or preparing changes:
- P0: determinism regressions; crashes; broken tests; broken web export assumptions for committed scope
- P1: missing/insufficient tests for changed deterministic logic; scope creep beyond task; unsafe logging/PII; modifying generated export output without being asked; telemetry events not following the schema / logging free-form text / introducing fingerprint identifiers

Codex applies review guidance from the closest `AGENTS.md` file to each changed file. For game code,
`game/AGENTS.md` adds additional Godot-specific review rules.

