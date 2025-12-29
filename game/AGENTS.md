# game/AGENTS.md — Godot project instructions (scoped to /game)

This file applies to work under `game/`.

---

## Quick commands (copy/paste)

### Tests (canonical entrypoint)
From `game/`:
- `./run_tests.sh`

If you need runner details (what it discovers/runs), see `docs/conventions.md` and `game/tests/`.

---

## Where code goes (follow conventions)

Authoritative rules live in:
- `docs/conventions.md` (domain/app/adapters/shared boundaries)
- `game/src/README.md`

High-level intent:
- `src/domain/` stays deterministic and headless-friendly (no Node/SceneTree/Input/time APIs).
- `src/app/` orchestrates domain logic (minimal glue, still avoid UI/Node dependencies).
- `src/adapters/` owns Godot-facing code (scenes, UI controllers, input handlers, signals, loaders).
- `tests/` contains headless tests (add/extend unit tests for deterministic logic changes).

If a folder doesn’t exist yet (e.g., `src/app/`), create it only if the scoped task requires it.

---

## Godot-specific guardrails

### Determinism boundary
- Keep authoritative simulation state in deterministic logic.
- Visual feedback (tweens, animations, shakes) must not change authoritative state.

### Scenes & merge safety
- Prefer composing smaller scenes over editing one giant `.tscn`.
- Avoid unnecessary node renames/reorders.

### Project/config files
- Be cautious editing `project.godot` and `export_presets.cfg`.
  Only touch them if the task requires it and explain why.

---

## Export output

- `build/web/` is export output. Do not hand-edit it unless explicitly tasked.

