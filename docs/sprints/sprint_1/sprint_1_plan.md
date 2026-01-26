# Sprint 1 Summary (Closed)

Closed: 2026-01-25  
Planning date: 2025-12-28

Sprint goal: Ship a deterministic, web-deployable “toy” maze loop (move/bonk/win/restart), gated by headless tests and a repeatable web release process.

## Outcomes (what shipped)
- **Deterministic grid world + movement rules** implemented in `game/src/domain/grid/` with unit coverage in `game/tests/unit/`.
- **Manual play loop** wired through `ManualPlayUseCase` (`game/src/app/manual_play_use_case.gd`) and a playable scene (`game/src/adapters/scenes/game_root.tscn`).
- **Player-facing feedback**: InputMap bindings (arrows + WASD), an action log, and a view-only “bonk” tween for blocked moves.
- **Win + restart loop**: goal tile, win overlay, and deterministic reset back to the initial state.
- **Release hardening**: PR CI runs headless tests; tag-based web releases require CI success and upload export logs/artifacts for debugging.
- **Telemetry contract (doc-only)**: event envelope + data policy codified in [`docs/event_schema.md`](../../event_schema.md) (implementation intentionally deferred).

## Decisions (now canonical)
- [ADR-001 — Grid coordinate conventions and move directions](../../adr/ADR-001-grid-coordinates.md).
- Test layout: the headless runner executes both `game/tests/unit/` and `game/tests/integration/` suites (documented in [`docs/conventions.md`](../../conventions.md)).

## Carryover / Deferred
- **TASK-004-4 (Deferred)**: no web smoke playtest notes/checklist were committed to the repo. Use the smoke test steps in [`docs/release_process.md`](../../release_process.md) and capture evidence next sprint. The carryover entry is tracked in [`docs/sprints/backlog.md`](../backlog.md).
- Recorder/executor/debugger, saves/progression, multi-level content pipeline, and telemetry emission all remain **explicitly out-of-scope** after Sprint 1.
- (Optional future doc) If/when level pipeline work starts, document the current `LevelData` Resource format in `game/src/adapters/resources/level_data.gd`.
