# Event schema and privacy rules

## Purpose
This schema outlines the minimal gameplay events we plan to emit to measure the toy-loop metrics from Sprint 1 (time-to-first-win, level completion rate, and blocked-move frequency) without collecting any personal data. Events are designed to be deterministic mirrors of in-game state changes so replays stay consistent.

## Privacy and safety principles
- **No PII or identifiers**: Do not collect names, emails, IPs, device fingerprints, or free-form user text. Use ephemeral, random session IDs generated client-side only for session grouping.
- **Minimal fields only**: Capture just enough context to compute the targeted metrics (level progression and move outcomes). Avoid payloads that could infer identity (e.g., precise timestamps with location data are forbidden; timestamps are relative to session start).
- **Kid-safe defaults**: Telemetry must be opt-out capable if added later, and must never block gameplay. Logs should be safe to display in support/debug contexts.
- **Determinism alignment**: Event payloads should be derived from the deterministic simulation state (grid position, direction, level id) rather than frame-based or timing-dependent data.

## Event catalog
| Event name | When emitted | Properties | Notes |
| --- | --- | --- | --- |
| `session_start` | Game client launches or resets local storage. | `session_id` (uuidv4, ephemeral), `app_version` (semver) | Used only to bound relative timestamps; no user/device identifiers. |
| `level_start` | A level becomes active (after selecting or restarting). | `session_id`, `level_id` (string), `attempt_id` (uuidv4 per run), `start_time_ms` (0 relative to attempt) | Establishes context for subsequent move and win events. |
| `manual_move` | Each manual movement attempt (one input). | `session_id`, `level_id`, `attempt_id`, `sequence_index` (0-based), `direction` (`up`/`down`/`left`/`right`), `outcome` (`moved`\|`blocked`), `position_after` (grid coords `{x:int,y:int}`) | Single event covers both success and block; `outcome` enables blocked frequency metric. |
| `level_win` | Player reaches the goal tile. | `session_id`, `level_id`, `attempt_id`, `elapsed_ms` (since attempt start), `steps_taken` (count of move events in attempt) | Supports time-to-first-win and completion rate calculations. |
| `level_fail` | Attempt ends without reaching goal (e.g., player quits/restarts). | `session_id`, `level_id`, `attempt_id`, `elapsed_ms`, `reason` (`restart`\|`quit`\|`blocked_cap`) | Optional but clarifies denominators for completion rate. |

## Derived metrics (examples)
- **Time-to-first-win**: Difference between the first `level_start` for a level and the first `level_win` with the same `level_id` and `session_id`.
- **Level completion rate**: Count of `level_win` per `level_start` grouped by `level_id` and `session_id`.
- **Blocked move frequency**: Ratio of `manual_move` events where `outcome = blocked` to total `manual_move` events for a level/attempt.

## Implementation guardrails
- Event emission should be centralized (e.g., a telemetry service) to enforce field whitelists and PII bans.
- Store only coarse timing (milliseconds relative to attempt) rather than wall-clock timestamps.
- If telemetry is disabled, game logic must remain fully functional; keep emission side effects isolated from simulation.
