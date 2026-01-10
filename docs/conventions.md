# Project conventions and boundaries

This document keeps Sprint 0 changes discoverable and makes it clear where deterministic gameplay logic belongs. It should be a fast reference (5 minutes) for new contributors.

## Folder map (high-level)

- `docs/` — contributor-facing guides. Start here for conventions and release process.
- `game/` — Godot project root.
  - `game/src/domain/` — **pure deterministic logic** (no Node/SceneTree access). Value objects, rules, and services that can run in headless tests.
  - `game/src/app/` — orchestration/use-cases that coordinate domain logic. Minimal glue; avoid UI/Node dependencies here.
  - `game/src/adapters/` — Godot-facing code (scenes, UI controllers, input handlers, signal wiring, resource loaders).
  - `game/src/shared/` — small shared helpers that stay deterministic (math/collections/time abstractions). Keep this tiny to avoid a dumping ground.
  - `game/tests/` — automated tests. `unit/` will house pure logic tests exercised via the headless runner.
  - `build/` — generated export artifacts (not hand-edited).

## Deterministic boundary rules

- **Domain scripts must not call** `Node`, `SceneTree`, `Input`, or frame/time APIs. They should be importable in a headless context with no Godot scene loaded.
- **No hidden randomness**: if randomness is needed, pass in a seeded RNG interface from the caller; avoid direct `RandomNumberGenerator` inside domain code.
- **Pure data in/pure data out**: domain functions take explicit arguments and return new values/structs instead of mutating global state.
- **Adapters own side effects**: file I/O, signals, input polling, timers, and animations belong in adapters; they call into domain/app services with explicit data.

## Telemetry and observability conventions

- Telemetry emission is a **side effect** and belongs in `game/src/adapters/` (or a dedicated autoload service in adapters).
- Domain logic (`game/src/domain/`) must remain telemetry-agnostic:
  - Domain may return rich result structs that contain everything needed to emit telemetry (outcome, positions, reasons).
  - Do not call OS/time/network APIs from domain.
- Telemetry must never influence authoritative simulation state:
  - Failures in telemetry emission must be swallowed or surfaced only as non-gameplay debug logs.
- Follow `docs/event_schema.md`:
  - use the standard event envelope (player_id/session_id/t_ms/app_version)
  - no direct PII, no free-form user text
  - prefer enums over arbitrary strings

## Naming conventions

- **Scripts**: kebab or snake style for files is allowed by Godot, but prefer `snake_case.gd` that mirrors the main class (e.g., `movement_service.gd` contains `class_name MovementService`).
- **Classes**: `PascalCase` with `class_name` when the type is meant to be reused; keep one primary class per script.
- **Tests**: `test_<topic>.gd` files placed under `game/tests/unit/` (subfolders allowed). Each test script can expose multiple `test_*` methods; optional `_before()`/`_after()` hooks run around every test method.
- **Scenes**: place scene files under `game/src/adapters/` (or deeper feature folders) and keep script side effects confined to that layer.

## Formatting & whitespace

- GDScript tabs-only; enforced by game/.editorconfig + CI.

## Adding a new deterministic module (example walk-through)

1. Create the script under `game/src/domain/<feature>/` (e.g., `game/src/domain/grid/movement_service.gd`). Keep it free of Node APIs.
2. Add unit tests under `game/tests/unit/` (e.g., `game/tests/unit/test_movement_service.gd`) exercising both success and failure cases.
3. Ensure any orchestration that calls the domain module lives in `game/src/app/` and passes plain data objects (value structs, enums).
4. Adapter/UI scripts should only call into `app` or `domain` via clear methods and should translate Godot signals/input into data the domain understands.

## Good vs. bad dependency examples

- ✅ **Good**: `MovementService` (domain) depends on `GridPos` value object and is invoked by a controller in `app/` that passes the current state.
- ✅ **Good**: A UI scene script in `adapters/` listens for button presses and calls an `app` use-case, which returns a `MoveResult` struct.
- 🚫 **Bad**: A script in `domain/` calls `get_tree().create_timer()` or polls `Input`—time/input belong in adapters.
- 🚫 **Bad**: A scene script directly mutates domain state without going through the use-case/service boundary.

## Testing expectations (Sprint 0 baseline)

- Domain code added in this sprint must have at least one unit test in `game/tests/unit/` demonstrating deterministic behavior.
- Tests should avoid frame timing and rely on pure functions/structs. Prefer explicit asserts over broad try/except patterns.
- The headless test runner (added in Sprint 0) will execute all `test_*.gd` scripts and fail fast on the first error; ensure new tests are isolated.

### Running tests locally (headless)

From the repo root, run:
```
./game/run_tests.sh
```
Direct runner invocation (debug fallback):
```
godot --headless --path game -s res://tests/run_tests.gd
```

The runner recursively discovers every `test_*.gd` file under `game/tests/unit/`, finds each `test_*` method inside, wraps them with optional `_before()`/`_after()` hooks, and prints pass/fail per test case. Floating-point and vector comparisons use approximate equality by default for `assert_equal` and `assert_near`.

### Running tests from the Godot Editor

Open `game/tests/run_tests.tscn` and press **F6** (Run Current Scene). This uses the same runner logic and exits the editor session with the appropriate code when finished.

## Quick answers

- **Where do I put deterministic logic?** `game/src/domain/` (pure functions/value objects/services, no Node/SceneTree).
- **Where does UI/input/scene wiring live?** `game/src/adapters/`.
- **Where do I coordinate multi-step flows?** `game/src/app/`.
- **Where do I add tests?** `game/tests/unit/` using the headless runner.

## Release workflow basics

- CI validation lives in `.github/workflows/ci.yml` and runs on PRs and pushes to `main`.
- Web deployments run only from SemVer tags prefixed with `v` via `.github/workflows/deploy-web.yml`.
- For the full release playbook, see `docs/release_process.md`.

Keeping these boundaries now minimizes refactors when gameplay systems arrive and preserves the determinism required for replay/debug features.
