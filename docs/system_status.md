# Current System Status

Last updated: 2026-01-25

This document summarizes the current, shipped gameplay loop and tooling across completed sprints so new contributors can quickly understand what the system already does.

## Gameplay loop (Manual Mode)
- Deterministic grid-based movement (one tile per input) with wall blocking.
- Manual input bindings for arrows + WASD, routed through a use-case layer.
- Action log UI that records each attempted move, including blocked moves.
- Visual-only "bonk" feedback on blocked movement (simulation remains deterministic).
- Goal detection with a win overlay and deterministic restart to the initial state.

## Architecture boundaries (current)
- Domain logic lives in `game/src/domain/` and is headless-friendly (no Node/Input/time usage).
- App orchestration (use cases) lives in `game/src/app/`.
- Godot-facing adapters (scenes, UI, input) live in `game/src/adapters/`.

## Testing & CI
- Headless test runner scans `game/tests/unit/` and `game/tests/integration/` for `test_*.gd` scripts and fails the run on any failed case.
- PR CI runs headless tests; web deploys are gated on successful tests and upload export logs/artifacts.

## Release process
- Release checklist and web export steps live in `docs/release_checklist.md` and `docs/release_process.md`.

## Telemetry (doc-only)
- Event schema and privacy rules are documented in `docs/event_schema.md`; runtime emission is intentionally deferred.
