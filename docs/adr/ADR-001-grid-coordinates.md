# ADR-001 — Grid coordinate conventions and move directions

## Status
Accepted (Sprint 1)

## Context
Manual movement and future program execution need a single, unambiguous grid convention so domain rules and Godot visuals stay aligned. Picking a standard early avoids mirrored axes, off-by-one errors, and confusing collision results for kids.

## Decision
Use screen-space coordinates with origin at the **top-left** of the grid.

- **Axes:** `+x` moves right; `+y` moves down (matches Godot 2D and sprite assets).
- **Tiles:** Each tile is addressed by an integer `Vector2i(x, y)` in this space.
- **Hero start/goal:** Stored as `Vector2i` using the same origin/axes; walls are stored as a set of `Vector2i` positions.
- **Move actions → offsets:**
  - `move_up` → `Vector2i(0, -1)`
  - `move_down` → `Vector2i(0, 1)`
  - `move_left` → `Vector2i(-1, 0)`
  - `move_right` → `Vector2i(1, 0)`

## Examples
- The top-left tile is `(0, 0)`; its right neighbor is `(1, 0)`; the tile below is `(0, 1)`.
- Starting at `(2, 3)`, applying `move_left` then `move_up` lands at `(1, 2)`.
- A wall at `(4, 1)` blocks movement when the hero is at `(4, 0)` and runs `move_down`.
- A 5×4 grid (width 5, height 4) has valid positions `x: 0–4`, `y: 0–3`; attempting to move beyond these bounds is treated as blocked.

## Consequences
- Matches Godot’s default 2D coordinate system, reducing adapter complexity.
- Keeps movement math deterministic and consistent across input handling, domain logic, and rendering.
- Test fixtures and level data should use `Vector2i` literals with this convention.

## References
- Sprint decision ADR-001 recommendation (screen-space, y-down) in `docs/sprints/sprint_1/sprint_1_tasks.yaml`.
