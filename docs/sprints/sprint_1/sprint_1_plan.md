0) Sprint Snapshot

Sprint name / number: Sprint 0+1 — Foundation + “Toy” Manual Maze Loop

Sprint duration (assume 2 weeks unless provided): 2 weeks

Planning date: 2025-12-28

Assumptions made (bullet list):

We prioritize desktop Web (Chromium/Chromebooks) as the primary platform; desktop native builds are “nice to have” this sprint.

No touch-first UI this sprint (mouse/keyboard only); touch comes later if needed.

Placeholder art/audio is acceptable; focus is determinism + clarity + playability first.

Current repo already includes a headless test runner and initial conventions, but CI does not yet run tests before deploy (we’ll fix that).

We will not implement Recorder Mode / Debugger systems in this sprint (kept for later backlog items).

Target platforms (if known): Web (primary), Desktop (secondary) (assumption based on web export workflow + MVP focus). 

UPSTREAM_SPEC_MARKDOWN

Team capacity model:

Assumed roles & capacity (2-week sprint, 10 working days):

Gameplay (2 engineers): 16 days planned

UI/Tools (1 engineer): 8 days planned

QA (shared): 5 days planned

Build/Release (0.5 support): 3 days planned

Security/Privacy review: 1 day planned

Buffer reserved (bugs, integration, playtesting, unplanned): ~25%

1) Alignment Check (Vision → Goals → This Sprint)

We are building the “Manual → Recorder → Debug” learning spine, but this sprint focuses on the Manual “toy” plus the engineering foundation that keeps everything deterministic. 

UPSTREAM_SPEC_MARKDOWN

Outcome we’re driving: A kid can open the web build, move immediately, bonk into walls, reach a goal, and restart quickly—and the behavior is consistent every time. 

UPSTREAM_SPEC_MARKDOWN

This directly supports:

Deterministic simulation required for replay/debug later. 

UPSTREAM_SPEC_MARKDOWN

Web readiness / iteration velocity via CI export and predictable test harness. 

UPSTREAM_SPEC_MARKDOWN

Early fun/clarity: “bonk not syntax error” philosophy in a simple loop. 

UPSTREAM_SPEC_MARKDOWN

What we explicitly will NOT do this sprint (scope guardrails):

Recorder queue UI, command execution engine, debugger highlight/step/replay.

Data-driven LevelConfig loader, saves/progression UI.

Telemetry capture implementation (we’ll only document the schema + identifier model).

Misalignment callout:

STORY-013 (juice + accessibility toggles) is a Sprint 1 story, but its dependency includes saved settings (via STORY-010) which is not in our allowed scope. We will not pull STORY-013 as a committed story; instead, we’ll ensure bonk + win feedback hooks exist through STORY-003/004 and create a refinement note to split STORY-013 later. 

BACKLOG_YAML

2) Readiness Gate (Definition of Ready)

Readiness evaluation for the highest-priority candidate stories (we only pull “ready” stories; otherwise we add refinement/spikes). 

BACKLOG_YAML

STORY-001 — Establish engineering foundation for deterministic gameplay

Clear acceptance criteria? Y

Art/audio/design dependencies identified and scheduled? Y (none needed)

Engine/platform constraints understood? Y (Godot 4.x web export in repo)

Dependencies resolved? Y

Telemetry expectations defined? Y (doc-only this sprint)

Security/privacy concerns identified? Y (no PII; doc will reflect)

Test/playtest approach feasible in sprint? Y

STORY-015 — Harden web export deployment workflow and define release checklist

Clear acceptance criteria? Y

Art/audio/design dependencies? Y (none)

Engine/platform constraints understood? Y

Dependencies resolved? Y (depends on STORY-001; handled early)

Telemetry expectations defined? N/A

Security/privacy concerns identified? Y (hosting assumptions + headers)

Test/playtest approach feasible? Y (smoke checklist)

STORY-002 — Implement deterministic grid representation and collision rules

Clear acceptance criteria? Y

Art/audio/design dependencies? Y (placeholders fine)

Engine/platform constraints understood? Y (avoid physics; grid authoritative)

Dependencies resolved? Y (STORY-001 in same sprint, done first)

Telemetry expectations defined? N (doc only; events listed)

Security/privacy concerns identified? N/A

Test/playtest approach feasible? Y (unit tests for movement rules)

STORY-003 — Deliver Manual Mode movement with an action log

Clear acceptance criteria? Y

Art/audio/design dependencies? Y (placeholder UI ok)

Engine/platform constraints understood? Y

Dependencies resolved? Y (depends on STORY-002)

Telemetry expectations defined? Doc-only

Security/privacy concerns? N/A

Test/playtest approach feasible? Y (integration-ish test + manual playtest)

STORY-004 — Add goal tile, win screen, and quick restart

Clear acceptance criteria? Y

Dependencies resolved? Y (depends on STORY-002)

Test/playtest approach feasible? Y

STORY-013 — Add core juice feedback and accessibility toggles

NOT READY to pull: depends on settings persistence (STORY-010) which is outside scope. We will create a refinement decision: split into (A) feedback hooks/assets and (B) toggles + persistence. 

BACKLOG_YAML

3) Sprint Goal

Sprint Goal (one sentence):
Deliver a deterministic, web-deployable “toy” maze loop—move + bonk + win + restart—backed by CI tests and a release checklist.

Demo Outcomes (observable success):

CI runs headless unit tests and fails fast with readable logs. 

BACKLOG_YAML

CI produces a working Web export and deploys (or validates export) gated on tests. 

BACKLOG_YAML

In the web build, player can move one tile per input deterministically; walls block with a “blocked” outcome. 

BACKLOG_YAML

Action log shows each attempted action (including blocked moves). 

BACKLOG_YAML

Reaching goal triggers a win overlay with replay/restart behavior and deterministic reset. 

BACKLOG_YAML

4) Scope Selection (What we commit to)
Committed scope (stories)
STORY-001 — Establish engineering foundation for deterministic gameplay

Priority: P0 (foundation for everything) 

BACKLOG_YAML

Rationale: Without reliable tests + CI gating, determinism will rot unnoticed.

Key dependencies: none 

BACKLOG_YAML

Risk level: Med

Expected deliverable: PR CI runs tests; deploy pipeline is validated; event schema doc exists.

STORY-015 — Harden web export deployment workflow and define release checklist

Priority: P0 

BACKLOG_YAML

Rationale: Web iteration speed is a core constraint; deployment must be boring and reliable.

Key dependencies: STORY-001 

BACKLOG_YAML

Risk level: Med

Expected deliverable: Release checklist + improved CI logs/artifacts + documented hosting assumptions.

STORY-002 — Implement deterministic grid representation and collision rules

Priority: P0 

BACKLOG_YAML

Rationale: Grid determinism is the bedrock for future recorder/replay/debug.

Key dependencies: STORY-001 

BACKLOG_YAML

Risk level: Med

Expected deliverable: Domain movement rules + unit tests; “blocked” surfaced to UI layer.

STORY-003 — Deliver Manual Mode movement with an action log

Priority: P0 

BACKLOG_YAML

Rationale: Validates fun/clarity before programming features.

Key dependencies: STORY-002 

BACKLOG_YAML

Risk level: Low

Expected deliverable: Playable manual movement + visible action log + bonk feedback.

STORY-004 — Add goal tile, win screen, and quick restart

Priority: P0 

BACKLOG_YAML

Rationale: “Win + retry” completes the toy loop and enables rapid iteration.

Key dependencies: STORY-002 

BACKLOG_YAML

Risk level: Low

Expected deliverable: Goal detection + win overlay + deterministic restart.

Stretch goals (only if capacity allows)

“Backlog refinement” deliverable: Split STORY-013 into (A) feedback pack vs (B) toggles+persistence so Sprint 2 doesn’t get blocked. 

BACKLOG_YAML

Add a simple dev-only debug overlay (FPS + grid coords) behind a flag (if time).

Explicit out-of-scope items for the sprint

Recorder Mode queue UI + recording (STORY-006). 

BACKLOG_YAML

Command runner + step limit (STORY-007). 

BACKLOG_YAML

Debug highlight/step/replay (STORY-008/009). 

BACKLOG_YAML

LevelConfig loader + multiple levels (STORY-005) and saves/progression (STORY-010/011). 

BACKLOG_YAML

5) Architecture & OO Design Plan (Godot-Nic, Pragmatic, Not Overbuilt)

We’ll honor the repo’s existing “deterministic boundary” conventions: domain is pure, adapters are Godot-facing, app orchestrates. (This aligns with the current game/src/README.md and docs/conventions.md already present in the repo.)

Domain/Gameplay Model (Entities)

GridPos (already exists): immutable-ish value object for tile coordinates.

GridWorld (new, domain): bounds + wall set + goal tile.

WorldState (new, domain): player position (and later: facing, inventory, etc).

MoveResult (new, domain): { outcome: Moved|Blocked|OutOfBounds, from, to, reason }.

Application Layer (Use cases / Services)

ManualPlayUseCase (new, app): holds current WorldState + GridWorld, exposes:

try_move(direction) -> MoveResult

reset()

check_goal() -> bool

Keep this layer free of Nodes/signals; return plain results to adapters.

Interfaces/Adapters

GameRoot scene (Node2D): the playable scene for Sprint 1.

WorldView (Node2D): renders grid + walls + goal (simple draw or lightweight TileMap).

HeroView (Node2D/Sprite2D): visual representation; position derived from GridPos.

HUD (Control): action log, restart button, win overlay.

InputAdapter: translates InputMap actions → ManualPlayUseCase.try_move.

Infrastructure

Tests: unit tests for domain movement and goal detection (game/tests/unit/).

CI: GitHub Actions workflow that runs headless tests and web export/deploy gating.

Cross-cutting

Logging: structured-ish prints in dev builds; add an event schema doc now.

Feature flags: use simple consts or project settings for dev-only overlays.

Project module map (minimal)

res://src/domain/

value_objects.gd (existing GridPos)

grid/ (new: grid_world.gd, move_result.gd, movement_service.gd)

rules/ (new: goal_rules.gd or keep inside world)

res://src/app/

manual_play_use_case.gd

res://src/adapters/

scenes/game_root.tscn + game_root.gd

ui/hud.tscn, ui/action_log.gd, ui/win_overlay.tscn

input/manual_input_adapter.gd

view/world_view.gd, view/hero_view.gd

res://tests/

unit/test_movement_service.gd, unit/test_goal_rules.gd

ADRs/decisions needed (this sprint)

Grid coordinate convention + direction mapping

Rendering approach (draw vs TileMap)

Reset semantics (what resets and what persists within a run)

6) Decisions & Dependencies (Move the sprint forward)
Decision Log

ADR-001: Grid coordinate convention

Why it matters: Avoids endless off-by-one bugs and mismatched UI/world mapping.

Options:

Origin top-left, +x right, +y down (screen-like)

Origin bottom-left, +x right, +y up (math-like)

Recommended: Option 1 (top-left, y-down) to match 2D screen intuition for kid games.

Owner role: Gameplay

Due date within sprint: Day 2

ADR-002: World rendering implementation (Sprint 1)

Why it matters: Impacts speed of delivery and merge conflicts.

Options:

Custom Node2D draw (rects for walls/goal) + simple hero sprite

TileMap + TileSet from day one

Recommended: Option 1 for Sprint 1 (fast, minimal asset/tooling churn). Move to TileMap later when LevelConfig/content pipeline arrives.

Owner role: UI/Tools

Due date: Day 3

ADR-003: Determinism boundary for movement

Why it matters: Replay/debug requires that physics/timing never changes outcomes.

Options:

Authoritative simulation in domain (GridPos), visuals follow (snap or tween)

Physics-based movement (CharacterBody2D) and “snap” occasionally

Recommended: Option 1 (domain authoritative).

Owner role: Gameplay

Due date: Day 2

ADR-004: CI gating strategy

Why it matters: Prevents broken deploys and ensures deterministic rules stay tested.

Options:

Add tests step inside deploy workflow only

Separate PR CI workflow + tests step inside deploy workflow

Recommended: Option 2 (fast PR feedback + deploy safety).

Owner role: Build-Release

Due date: Day 2

External dependencies

None required for MVP toy loop (placeholder assets ok).

Hosting assumption: GitHub Pages (current workflow deploys to gh-pages branch); document constraints and headers.

Internal dependencies

STORY-002 depends on STORY-001; STORY-003/004 depend on STORY-002. 

BACKLOG_YAML

7) Quality Plan (Definition of Done + Quality Gates)
Definition of Done (Sprint-standard)

Code merged via PR with review (at least 1 reviewer).

Scene changes reviewed for:

Node naming, minimal coupling, signals used cleanly

No “mystery singletons” introduced

Tests:

Unit tests for domain logic (movement/collision, goal detection)

At least one “integration-ish” test that exercises the app/use-case boundary

Static checks:

Typed GDScript where it reduces ambiguity in core logic

Performance:

Target: 60 FPS on simple tutorial scene; no per-frame allocations in core loop

Observability:

Print/log events in dev builds; document event schema (no telemetry capture yet)

Security/privacy:

No direct PII; no free-form user text; no network calls; event schema defines stable pseudonymous identifiers (player_id/session_id) for internal operations.

Docs/runbooks:

“How to run tests locally” kept accurate

Release checklist added and usable

Quality Gates for the sprint

CI must be green:

Headless tests pass

Web export completes (and deploy step not attempted if tests fail)

Playtest checklist completed for committed scope:

Controls work in browser

Movement deterministic (repeat same inputs → same outcome)

Win + restart behave correctly

No P0 bugs open at sprint end for committed scope

8) Task Breakdown (Story → Tasks → Subtasks)
STORY-001 — Establish engineering foundation for deterministic gameplay 

BACKLOG_YAML

TASK-001-1 — Add PR CI workflow to run headless tests

Owner role: Build-Release

Description: Add a GitHub Actions workflow triggered on pull_request (and optionally push) that runs godot --headless tests and reports pass/fail.

Implementation notes:

Reuse existing Godot CI container strategy.

Ensure output is readable and fails fast.

Acceptance criteria (task-level):

PR shows failing tests in logs; passing tests produce summary.

Dependencies/blockers: none

Estimate: S (new workflow + wiring)

Risk notes / fallback:

If Godot headless fails in CI container, fallback to running tests in the same container used for export (as a first step).

TASK-001-2 — Gate deploy-web workflow on test pass

Owner role: Build-Release

Description: Add “Run headless tests” step before export/deploy in the existing deploy workflow.

Implementation notes:

Keep tests step early; do not waste time exporting if tests fail.

Acceptance criteria:

A test failure prevents export/deploy from running.

Dependencies: TASK-001-1 (recommended), but can proceed in parallel

Estimate: XS

Risk notes / fallback:

If deploy pipeline becomes slow, keep PR CI fast and only gate deploy on main.

TASK-001-3 — Document telemetry event schema + identifier model (internal operations)

Owner role: Security (with Docs Agent)

Description: Create a short doc listing event names + properties we intend to emit later (manual_move, blocked, level_win, etc.) and explicit “NO direct PII / NO free-form text” rules, plus the identifier model (player_id/session_id) and standard envelope fields.

Implementation notes:

Use upstream telemetry needs lists as the source of truth.

Acceptance criteria:

Doc exists, includes privacy constraints, and aligns with planned gameplay loop.

Dependencies: none

Estimate: XS

Risk notes / fallback:

Keep doc minimal; we can expand once telemetry capture is in scope.

STORY-015 — Harden web export deployment workflow and define release checklist 

BACKLOG_YAML

TASK-015-1 — Create release checklist + smoke test script

Owner role: Build-Release

Description: Add a docs/release_checklist.md covering versioning, CI expectations, web smoke test steps (load → move → bonk → win → restart), and rollback notes.

Acceptance criteria:

A new contributor can follow it to validate a release build.

Dependencies: none

Estimate: XS

Risk notes / fallback:

If rollout plan is unclear, define a minimal “rollback = redeploy previous gh-pages build” procedure.

TASK-015-2 — Improve CI failure visibility (logs + artifacts)

Owner role: Build-Release

Description: Ensure export logs are preserved and the exported web folder can be uploaded as an artifact on CI (especially on failure).

Implementation notes:

Add artifact upload step for game/build/web/.

Ensure verbose export output is present.

Acceptance criteria:

On failure, we can inspect logs/artifacts without re-running locally.

Dependencies: TASK-001-2 (gating) recommended

Estimate: S

Risk notes / fallback:

If artifact size is too large, upload only key logs and index.html + *.wasm + *.pck.

STORY-002 — Implement deterministic grid representation and collision rules 

BACKLOG_YAML

TASK-002-1 — Write ADR-001 (grid conventions + directions)

Owner role: Gameplay

Description: Document grid origin, axes directions, and mapping from input actions to direction vectors.

Acceptance criteria:

Everyone agrees on one convention; tests reflect it.

Dependencies: none

Estimate: XS

Risk notes / fallback:

If disagreement persists, choose y-down (screen-space) for speed.

TASK-002-2 — Implement domain GridWorld + MoveResult

Owner role: Gameplay

Description: Create pure domain objects:

Grid bounds

Wall set

Goal position

MoveResult outcomes and reasons

Implementation notes:

No Node/Input/SceneTree usage.

Favor plain data, explicit parameters.

Acceptance criteria:

Can represent a small test maze with walls, start, goal.

Dependencies: TASK-002-1

Estimate: S

Risk notes / fallback:

If domain becomes too abstract, keep minimal: bounds + walls set + goal.

TASK-002-3 — Implement deterministic MovementService (pure logic)

Owner role: Gameplay

Description: Add movement rules:

Move into wall → no position change + blocked result

Move into open tile → position changes exactly one tile

Acceptance criteria:

Movement outcomes match story acceptance criteria.

Dependencies: TASK-002-2

Estimate: M

Risk notes / fallback:

If complexity grows, restrict to orthogonal movement only; no turning/facing yet.

TASK-002-4 — Add unit tests for movement/collision

Owner role: QA (pair with Gameplay)

Description: Tests for:

Moving into wall blocks

Moving into open tile succeeds

Out-of-bounds handling (if applicable)

Acceptance criteria:

Tests run headlessly and are stable.

Dependencies: TASK-002-3

Estimate: S

Risk notes / fallback:

Keep tests table-driven to reduce churn.

TASK-002-5 — Expose blocked outcome to adapters via ManualPlayUseCase

Owner role: Gameplay

Description: Implement app-layer use case that returns MoveResult to adapters and owns reset.

Acceptance criteria:

Adapter can read blocked outcome without duplicating rules.

Dependencies: TASK-002-3

Estimate: S

Risk notes / fallback:

If use-case feels redundant, keep it thin; don’t over-architect.

STORY-003 — Deliver Manual Mode movement with an action log 

BACKLOG_YAML

TASK-003-1 — Define InputMap actions + manual input adapter

Owner role: UI/Tools

Description: Add input actions (move_up/down/left/right, restart) and a script that maps them to direction requests.

Acceptance criteria:

Arrow keys (and WASD optionally) trigger deterministic step attempts.

Dependencies: TASK-002-5

Estimate: S

Risk notes / fallback:

If InputMap edits are noisy, document required bindings and keep minimal.

TASK-003-2 — Build GameRoot scene with WorldView + HeroView

Owner role: UI/Tools (pair with Gameplay)

Description: Create the playable scene:

World renders a tiny maze

Hero position updates from grid pos

Implementation notes:

Visuals follow domain state; avoid physics movement.

Acceptance criteria:

Pressing movement keys updates hero tile position deterministically.

Dependencies: TASK-003-1

Estimate: M

Risk notes / fallback:

If rendering slows down, use simple rect drawing; avoid heavy assets.

TASK-003-3 — Implement Action Log UI

Owner role: UI/Tools

Description: Create HUD panel showing recent actions (e.g., move_left()), including blocked attempts.

Acceptance criteria:

Log is visible, readable, and updates on every attempt.

Dependencies: TASK-003-2

Estimate: S

Risk notes / fallback:

If UI layout churn, keep it as a simple vertical list with max N lines.

TASK-003-4 — Add playful “bonk” feedback (non-audio baseline)

Owner role: UI/Tools

Description: On blocked move, show a small visual feedback (shake/bump) and ensure log still records attempt.

Acceptance criteria:

Blocked move feels distinct (without relying on sound).

Dependencies: TASK-003-2

Estimate: S

Risk notes / fallback:

If shake causes motion concerns, keep it subtle and short; later we’ll add reduced-motion toggle.

STORY-004 — Add goal tile, win screen, and quick restart 

BACKLOG_YAML

TASK-004-1 — Implement goal detection in domain + unit test

Owner role: Gameplay

Description: Add a simple goal rule and test:

If player pos == goal pos → win

Acceptance criteria:

Unit test verifies goal detection deterministically.

Dependencies: TASK-002-2

Estimate: XS

Risk notes / fallback:

Keep as simple comparison; no triggers/physics.

TASK-004-2 — Add win overlay UI with replay/restart

Owner role: UI/Tools

Description: Add overlay shown on win with:

Replay (restart level)

Next (stub for now; can restart or show “Next coming soon”)

Acceptance criteria:

Win overlay appears immediately on reaching goal.

Dependencies: TASK-004-1, TASK-003-2

Estimate: S

Risk notes / fallback:

If “Next” is confusing without progression, label as “Next (coming soon)” and keep Replay primary.

TASK-004-3 — Deterministic restart/reset

Owner role: Gameplay

Description: Reset world to initial state:

player returns to start

win overlay hidden

action log cleared (or optionally retained—decide and document)

Acceptance criteria:

Restart always returns to identical initial state.

Dependencies: TASK-002-5, TASK-004-2

Estimate: S

Risk notes / fallback:

If state grows, store an immutable initial snapshot and replace state on reset.

TASK-004-4 — QA web smoke playtest + regression checklist

Owner role: QA

Description: Run the release smoke test on the deployed build:

Load time acceptable

Move/bonk/win/restart work

Repeat run yields same outcomes

Acceptance criteria:

Checklist filled and issues filed with repro steps.

Dependencies: TASK-004-3

Estimate: S

Risk notes / fallback:

If deployment timing is unpredictable, smoke test the CI artifact locally via a simple static server.

9) AI-Agent Operating Model (How we use AI safely and effectively)
Recommended agent roles

Gameplay Engineering Agent (domain/app logic, deterministic rules)

UI/UX Agent (Control scenes, layout, anchors)

QA Agent (test cases + playtest scripts + regression list)

Build/Release Agent (CI workflows, export presets, artifact strategy)

Telemetry/Privacy Agent (event schema, identifiers, no PII/free text)

Docs Agent (conventions, release checklist, ADR templates)

Rules of engagement

AI output must be reviewed and run inside Godot.

No secrets/keys in prompts or repo artifacts.

AI must list assumptions and edge cases for every generated plan or code suggestion.

Prefer small, mergeable PRs; avoid huge scene diffs.

No copy/paste of unknown-licensed assets/code.

Per-story AI work packets (what to ask)

STORY-001:

Gameplay Agent: “Suggest minimal deterministic test patterns and how to keep domain pure.”

Build/Release Agent: “Draft CI YAML for headless tests + export gating; propose artifact upload.”

Security Agent: “Review event schema doc for PII risks; suggest safe payload rules.”

Docs Agent: “Draft event schema doc format + examples.”

STORY-015:

Build/Release Agent: “Draft release checklist; propose troubleshooting for common web export failures.”

QA Agent: “Draft smoke test checklist for web build.”

STORY-002:

Gameplay Agent: “Design MoveResult and movement API; propose unit tests table.”

QA Agent: “Edge case tests: walls, bounds, repeated moves.”

STORY-003/004:

UI Agent: “Propose HUD layout (action log + restart + win overlay) with large readable text.”

QA Agent: “Manual test cases; check blocked feedback and win overlay behavior.”

10) Sprint Execution Plan (Cadence, Tracking, Playtests, Demo)

Daily plan (standup focus):

“What is playable today in the web build?”

“Any determinism risks introduced yesterday?”

“Any CI/export flakiness?”

Mid-sprint checkpoint (by end of Day 5):

CI runs headless tests on PR

A playable scene exists: move + blocked outcome visible

Integration strategy:

Trunk-based with short-lived branches

Scene ownership:

UI/Tools owns game_root.tscn + HUD scenes

Gameplay owns domain/app scripts + tests

How we avoid merge hell in scenes:

Prefer small scenes (HUD separate from world)

Keep node trees stable; add child scenes rather than editing huge root trees

Playtest strategy:

Daily 2-minute smoke test locally

Twice-per-sprint web build test (mid + end)

Demo plan:

Live in browser: show deterministic moves, bonk, win overlay, restart, and mention CI gating in GitHub Actions

11) Risk Register (Sprint-Level)

CI headless Godot instability

Likelihood: Med | Impact: High

Early signal: flaky CI runs, unexplained crashes

Mitigation: isolate XDG dirs; verbose logs; keep tests pure

Owner: Build-Release

Export templates/path issues in CI container

Likelihood: Med | Impact: Med

Early signal: export step fails intermittently

Mitigation: keep current template relocation logic; add artifact logs

Owner: Build-Release

Grid coordinate mismatches between domain and render

Likelihood: Med | Impact: High

Early signal: “moving up goes sideways,” off-by-one collisions

Mitigation: ADR-001 + unit tests + visual debug grid labels

Owner: Gameplay

Accidental physics usage introduces nondeterminism

Likelihood: Low | Impact: High

Early signal: replaying same input yields different results

Mitigation: domain authoritative movement; no CharacterBody2D movement for logic

Owner: Gameplay

Input differences in browser (key focus / canvas focus)

Likelihood: Med | Impact: Med

Early signal: works in editor, fails on web

Mitigation: ensure canvas focus on start; add on-screen hint if no focus

Owner: UI/Tools

UI readability for early readers

Likelihood: Med | Impact: Med

Early signal: log too small / cluttered

Mitigation: large font, icon-first later, cap log lines

Owner: UI/Tools

Bonk feedback feels harsh or motion-heavy

Likelihood: Low | Impact: Med

Early signal: testers report discomfort

Mitigation: subtle visual feedback; later reduced-motion toggle

Owner: UI/Tools

Reset semantics unclear (what clears?)

Likelihood: Med | Impact: Low

Early signal: arguments about expected behavior; tests hard to write

Mitigation: decide early; document in ADR or comments; test it

Owner: Gameplay

Scene merge conflicts

Likelihood: Med | Impact: Med

Early signal: frequent .tscn conflicts

Mitigation: scene ownership + smaller composed scenes

Owner: Team Lead

Scope creep into Recorder/Debugger

Likelihood: Med | Impact: Med

Early signal: PRs adding queue/executor early

Mitigation: hard guardrails; finish toy loop first

Owner: Team Lead

12) “Next Sprint” Preview (Optional but recommended)

(Still within Sprint 0/1 story scope; no recorder/levels pipeline planned here.)

If we finish committed scope early, next sprint focus stays “Toy polish + clarity”:

Tighten movement feel (tiny tween interpolation that does not affect simulation)

Improve win UX copy (kid-friendly, minimal reading)

Refine STORY-013 split (feedback pack vs toggles+persistence) so it can be scheduled cleanly when STORY-010 is allowed. 

BACKLOG_YAML
