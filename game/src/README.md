# Source layout

This folder holds the gameplay code split into three layers to keep deterministic logic testable:

- `domain/` — pure logic and value objects (no Node/SceneTree/Input references). Use this for deterministic rules and services.
- `app/` — orchestrates domain logic for a given flow/use-case; keeps side effects at the edges.
- `adapters/` — Godot-facing scripts (scenes, UI, input). Translate signals and inputs into calls to `app`/`domain`.
  - `adapters/` also owns side effects like telemetry emission (domain remains deterministic and telemetry-agnostic).
- `shared/` — tiny deterministic helpers reused across layers.

See `docs/conventions.md` for the full conventions, examples, and testing expectations.
