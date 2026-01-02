0) Executive Summary (<= 12 bullets)
Product intent: Build a kid-friendly maze/dungeon crawler where players learn programming by planning and debugging the hero’s actions, progressing from manual control → recorded sequences → automation.
Who it serves: Primary: kids ~6–10 learning early programming concepts; Secondary: parents/guardians and educators seeking a safe, intuitive learning game.
What it enables: Concrete-to-abstract learning through a “Manual → Automatic” spine, where kids first do, then record, then edit, then automate behaviors.
MVP (one sentence): A web-playable grid maze game with Manual Mode + Recorder Mode (queue commands then run), deterministic step execution, and a friendly visual debugger (highlight + step-through + replay) across a small tutorial campaign.
Core differentiator: “Python-oriented” experience via Simulated Python (indentation/colon structure and code-view), without executing real Python in runtime.
Top risks (3): (1) Scope creep into building an IDE; (2) “educational but not fun”; (3) web runtime/perf/compat pitfalls (esp. Chromebooks).
Top success metrics (3): (1) Time-to-first-win (median) for tutorial level 1; (2) Tutorial completion rate (levels 1–N) among first-time players; (3) Debug loop engagement (≥1 replay/step-through used before level completion).
Recommended delivery strategy: Ship in crisp slices aligned to the learning progression: Toy → Recorder → Editor → Automation → Dungeon, validating fun + clarity at each step.
Quality bar: Deterministic simulation + rich feedback (“bonk not syntax error”) + replay/debug as first-class gameplay, not a developer tool.
Execution principle: Ruthless scope guardrails early (small command set) to avoid building a full language/editor before the game is fun.

1) Vision Capture (faithful, solution-agnostic)
Problem statement (user + pain + why now)
Kids struggle to learn programming when it’s abstract, syntax-heavy, and failure feedback is “compiler errors” instead of observable cause/effect.
A maze world makes programming concepts physical: actions are visible, failures are playful (“bonk”), and repetition naturally motivates loops and abstraction.
Target users & primary personas (2–5)
P1: Curious Kid Player (6–10) – wants to move a cute hero, solve puzzles, and feel smart.
P2: Parent/Guardian – wants safe, low-friction learning with visible progress and minimal setup.
P3: Educator (optional early / stronger later) – wants predictable learning progression and classroom-friendly sessions.
P4: Game Builder (internal) – needs a pipeline for levels, hints, and progression without hand-editing scenes forever.
Jobs-to-be-done (JTBD) per persona
Kid Player JTBD
“Help the hero reach the goal by giving instructions I can see.”
“Fix my plan when it doesn’t work, without feeling stupid.”
“Earn new powers (like repeating actions) because I want them.”
Parent JTBD
“Give my child a learning game that’s fun, safe, and works on our device.”
“Know they’re learning (not just clicking), without needing to teach.”
Educator JTBD
“Run a predictable lesson arc: sequencing → loops → conditionals → debugging.”
“See outcomes quickly in short sessions.”
Game Builder JTBD
“Create/adjust levels and hints quickly; ensure deterministic replays; ship web builds reliably.”
Value proposition (what changes for the user)
Kids learn programming as planning + debugging in a playful world: they can see each instruction execute, observe failure, and iterate—mirroring real coding but without early syntax pain.
Differentiators
Stated differentiators:
Manual → Recorder → Editor → Automation learning spine.
Deterministic, grid-based execution to enable replay/debug and kid mental models.
Python-like visual DSL (“Simulated Python”) rather than real Python runtime.
Inferred differentiators (clearly labeled inference):
“Bridge product” between Scratch (low typing friction) and CodeCombat (adventure motivation).
Guiding principles (product + technical)
Product principles:
Make failure playful and fixable (visible cause/effect, not abstract errors).
Debugging is curriculum: highlight, step-through, replay, scrub.
Scaffolding by stages; avoid cognitive overload for young kids.
Technical principles:
Deterministic step simulation; bounded execution (avoid infinite loops); test core logic as pure modules.
Web-friendly footprint (avoid heavy runtimes).

2) Goals, Non-Goals, and Scope Boundaries
Product goals (measurable)
G1: Ship a web-playable MVP that runs smoothly on mainstream laptops/Chromebooks (target: stable 60 FPS on simple scenes; see NFRs).
G2: Achieve a low-friction “first success” experience (target metric: median time-to-first-win < 5 minutes in tutorial level 1; instrumented).
G3: Make debugging a default loop (target: ≥50% of level attempts use replay/step once in the first 5 levels).
G4: Establish an extensible content pipeline (levels, signs, progression) that does not require rewriting core systems for every new level.
Non-goals (explicit exclusions to prevent scope creep)
NG1: A full general-purpose coding IDE or full Python interpreter in the runtime.
NG2: Twitch/reflex combat in MVP (combat, if any, is later and rule-based).
NG3: Multiplayer, social chat, or UGC sharing in MVP (high moderation/privacy risk for kids).
NG4: Complex RPG systems (inventory economy, gear stats) in MVP; keep “dungeon juice” lightweight.
MVP scope (must-have)
Manual Mode (arrow keys) to teach the “API” and rules.
Recorder Mode: queue commands, press Play to run.
Deterministic grid movement: one command = one tile step.
Basic visual debugger: current-step highlight, step-through, failure pause with friendly feedback.
Small curated tutorial campaign (8–12 levels) + local progress save.
Post-MVP scope (later)
Editor-first levels (“fix this broken program” with drag reorder/delete).
Loop abstraction (Repeat container).
Signs/hints and conditionals; basic sensors (look_ahead/can_move).
Procedural maze generation with scaling difficulty.
Out of scope (explicit)
Real Python execution in web runtime (desktop-only “expert mode” can be revisited later).
Advanced OOP teaching mechanics (inheritance/polymorphism) until late stage.

3) Assumptions, Constraints, and Open Questions
Assumptions (tagged)
(User) A1: Primary audience is children ~6–10 with limited typing patience and early reading ability.
(Product) A2: Players learn best with concrete, visible metaphors (queue, ghost replay, “bonk”).
(Delivery) A3: MVP success requires shipping “fun + juice” early, not just mechanics.
(Tech) A4: Deterministic simulation is feasible and necessary for replay/debug correctness.
(Market) A5: A “bridge” between Scratch and typed-code games is a compelling positioning (inference).
Constraints (hard requirements / current commitments)
(Tech) C1: Web delivery is a target; avoid heavyweight runtime dependencies that bloat web builds.
(Tech/Repo) C2: The current repository is already set up as a Godot project with GitHub Actions web deploy workflow; MVP plan should preserve continuous web export/deploy. (Observed from repo.)
(Tech) C3: Core gameplay must support discrete, deterministic steps for replay/debug.
(Product) C4: Early command set must be intentionally small to prevent IDE/language scope explosion.
Open questions (grouped; why it matters + what it blocks)
Audience & learning design
Q1: What is the primary age band (6–7 vs 8–10)?
Why: impacts reading load, UI density, tutorial pacing.
Blocks: tutorial text length, accessibility defaults, difficulty curve.
Q2: Is “reading signs” required in MVP, or can MVP be purely navigation?
Why: conditionals introduce new UI and cognitive load.
Blocks: MVP content plan and required command set.
Platform & distribution
Q3: Must MVP run on iPad/tablet (touch) or only desktop web?
Why: touch UI affects editor/drag behaviors.
Blocks: input system design, UI layout decisions.
Q4: Where will web be hosted (GitHub Pages is implied by current workflow, but is it final)?
Why: header requirements, caching, CDN behavior.
Blocks: deployment hardening, analytics endpoint choices.
Privacy & compliance (kids)
Q5: Telemetry strategy (decision)
Decision: Telemetry is a first-class product capability. We will collect robust internal-operations telemetry, including stable pseudonymous identifiers (player_id/session_id) to enable longitudinal analysis, debugging, and experimentation.
Guardrails: avoid direct PII and avoid free-form user text. Telemetry contract lives in docs/event_schema.md.
Blocks: telemetry implementation sequencing, consent UX wording, data retention policy, backend selection.
Content & production
Q6: Target number of levels in MVP and expected session length?
Why: drives backlog scope and balancing effort.
Blocks: milestone plan and release criteria.
Q7: Do we want local SLM-assisted content generation in the dev toolchain for MVP or later?
Why: can speed iteration but adds tooling overhead.
Blocks: whether to include a content generation pipeline now.

4) User Journeys and Key Flows
Persona P1: Curious Kid Player (6–10)
Flow A: First-time tutorial (Happy path)
Launch game → sees hero + simple goal (“Reach the exit”).
Uses arrow keys to move (Manual Mode) and learns rules (walls, grid).
Sees an action log (“move_left()”) while playing.
Switches to Recorder Mode: arrows add icons/blocks to a queue.
Presses Play: hero executes steps; current step highlights.
Hits wall (“bonk”), execution pauses, points at the step that caused it.
Adjusts plan (delete/reorder, or re-record depending on stage), replays, wins.
Common alternatives
Kid stays in Manual Mode and finishes a few micro-levels before Recorder is introduced.
Kid uses “Step” instead of “Play” to go instruction-by-instruction.
Failure/edge cases
Queue too long → kid loses track (needs chunking + highlights + maybe “read-aloud”).
Accidental infinite loops later → must cap steps and show friendly stop message.
Moments that matter
First “Recorder” moment: understanding “plan first, then execute.”
First debug moment: failure points to a step and feels fixable.
Celebration: winning feels delightful (sound/particles) so learning feels rewarding.
System touchpoints
UI: Title/tutorial overlays, queue panel, play/step controls, highlight state
Engine: deterministic step executor + collision rules
Data: local save (progress), replay trace (optional), settings (sound/reduced motion)
Persona P2: Parent/Guardian
Flow B: “Set up and feel good about it” (Happy path)
Opens link (web) → game loads quickly.
Sees a “Kid Safe” baseline: no chat, no account needed, minimal text.
Checks Settings: audio toggle, reduced motion.
Observes child progress (local progress screen).
Edge cases
Old Chromebook performance: needs low GPU load and compatibility mode.
Concern about tracking: needs transparent “what data is collected”, consent controls (where applicable), and a clear reset/disable option.
Moments that matter
Load time and stability: if it doesn’t run, trust is lost immediately.
System touchpoints
UI: Settings, Progress screen
Data: local storage, telemetry gating
Persona P3: Educator (optional early)
Flow C: “Run a 20–30 min session” (Happy path)
Opens a fixed set of levels aligned to lesson plan.
Students complete levels; teacher observes debug usage and completion.
Teacher resets levels or assigns next set.
Edge cases
Shared devices: local progress conflicts (requires “reset progress” or profiles later).
Accessibility needs: audio off by default in classrooms.
System touchpoints
UI: level select with grouping, optional educator view (post-MVP)
Data: session stats (if allowed)
Persona P4: Game Builder (internal)
Flow D: “Add a new level” (Happy path)
Creates a LevelConfig (grid, walls, start, goal, optional hints).
Runs game, validates deterministic replay, ensures tutorial copy is kid-friendly.
Ships via CI → web deployment.
Edge cases
Nondeterministic bug breaks replays: must catch with tests and seeds.
System touchpoints
Level config format (JSON/resource), build pipeline, test suite, CI deploy

5) Requirements
5.1 Functional Requirements (FR)
FR-001 (P0) The system shall provide a Manual Mode where the player can move the hero using immediate inputs so that the player learns movement rules and the action “API” through direct cause/effect.
Rationale: Stage 1 “Remote Control” scaffolding.
Success condition: New player can move, collide, and reach a goal in the first tutorial level without using Recorder.
FR-002 (P0) The system shall provide a Recorder Mode where player inputs are recorded into a visible queue so that the player can plan before execution.
Rationale: Recorder is the conceptual leap: intent vs execution.
Success condition: Player can build a queue ≥5 steps and execute it end-to-end.
FR-003 (P0) The system shall execute queued instructions in discrete grid steps so that each instruction has a predictable, observable outcome.
Rationale: “One command = one tile step.”
Success condition: Each executed step results in exactly one tile move or a clearly defined failure event.
FR-004 (P0) The system shall be deterministic given the same initial state and instruction sequence so that replay/debug remains consistent.
Rationale: Determinism is required for meaningful replay/debug.
Success condition: Re-running the same level seed + program yields identical trace output (events/positions).
FR-005 (P0) The system shall present an execution highlight of the currently running instruction so that players can connect outcomes to the specific step that caused them.
Rationale: Step-by-step highlighting is core to learning and debugging.
Success condition: During execution, one and only one step is “active” at a time and visually indicated.
FR-006 (P0) The system shall provide a friendly execution log (narrative + method name) so that players can build vocabulary and reasoning about actions.
Rationale: “move_left()” style log supports transfer toward code.
Success condition: Every executed instruction emits a human-readable log entry.
FR-007 (P0) The system shall pause execution on failure (e.g., wall collision) and show contextual guidance so that failure feels fixable and not punitive.
Rationale: “bonk into wall” not “syntax error.”
Success condition: On collision, execution stops within one step and UI points to the failing step.
FR-008 (P0) The system shall provide step-through execution so that players can debug one instruction at a time.
Rationale: Debugging is the curriculum.
Success condition: Player can advance execution step-by-step without timing-based motion.
FR-009 (P1) The system shall provide replay of the last run so that players can review what happened and learn from mistakes.
Rationale: Replay/ghost trail helps kids self-correct.
Success condition: Player can rewatch last run without re-entering instructions.
FR-010 (P0) The system shall support a minimal command set (e.g., move/turn/wait/read) in MVP so that learning remains focused and scope remains bounded.
Rationale: Guardrails to avoid IDE scope creep.
Success condition: MVP ships with ≤5 core commands and ≥8 levels solvable with them.
FR-011 (P0) The system shall provide a win condition (reach goal tile) with celebration feedback so that learning is rewarding.
Rationale: “Juice” early keeps the game fun.
Success condition: On win, show distinct victory UI + sound/visual celebration.
FR-012 (P0) The system shall provide level restart/reset so that players can iterate quickly after failure.
Rationale: Rapid iteration supports learning loop.
Success condition: Reset is available within one click/key and returns to initial state.
FR-013 (P0) The system shall provide a level selection/progression view so that players can see progress and continue the learning arc.
Rationale: Supports pacing and motivation.
Success condition: Completed levels are marked and next level unlock is clear.
FR-014 (P0) The system shall save local player progress so that players can return without losing progress.
Rationale: Parent/child expectation.
Success condition: Progress persists across reloads on same device/browser.
FR-015 (P0) The system shall include a curated tutorial campaign that introduces mechanics in staged scaffolding so that kids are not cognitively overloaded.
Rationale: Staged progression recommended.
Success condition: Levels 1–3 can be completed without requiring reading-heavy instructions.
FR-016 (P1) The system shall support “fix the broken program” levels (prefilled queue/program) so that kids learn debugging by editing rather than starting from scratch.
Rationale: Stage 3 “Editor” teaching loop.
Success condition: At least 2 levels ship with prefilled sequences and an edit task.
FR-017 (P1) The system shall allow editing recorded instructions (reorder/delete/insert) so that “editing is programming.”
Rationale: Stage 3 roadmap.
Success condition: Player can reorder steps and observe changed outcome.
FR-018 (P2) The system shall introduce a Repeat construct so that players can compress repetitive sequences and experience the power of loops.
Rationale: Loops motivated by tedium.
Success condition: At least one level requires Repeat to meet a “max steps” constraint (post-MVP).
FR-019 (P2) The system shall support signs/hints with a Read action so that conditionals can be taught using visible cues.
Rationale: Signs/hints system is core to conditionals stage.
Success condition: At least one level includes a sign and a readable message.
FR-020 (P2) The system shall support a simple conditional (“if sign says X then …”) so that players can begin automation rules.
Rationale: Stage 4 “Automation” roadmap.
Success condition: Player can create a conditional sequence that changes behavior based on sign content.
5.2 Non-Functional Requirements (NFR)
NFR-001 Performance & responsiveness: The game shall maintain responsive input and smooth animation on typical school/home devices so that kids do not experience frustration.
Suggested SLO: 60 FPS on simple tutorial scenes; 30 FPS minimum on low-end devices.
NFR-002 Determinism: The simulation shall be deterministic across supported platforms so that replays and debugging remain consistent.
NFR-003 Reliability: The game shall avoid crashes and corrupted local saves; recovery path exists if save data is invalid.
NFR-004 Web readiness: The game shall run in a desktop browser without special installs and without heavy runtime payloads.
NFR-005 Security & privacy: The game shall avoid direct PII and free-form user text by default. Telemetry is enabled for internal operations and may use stable pseudonymous identifiers (player_id/session_id) as defined in docs/event_schema.md. Telemetry must never block gameplay and should support disable/reset flows.
NFR-006 Accessibility: The game shall provide at minimum: mute toggle, reduced motion toggle, readable fonts, and non-audio-only feedback for success/failure.
NFR-007 Inclusivity: UI language and symbols shall be understandable for early readers; avoid reliance on long text instructions.
NFR-008 Observability: The system shall emit structured events for key actions (start level, run program, fail, replay, win) to support learning and product iteration.
NFR-009 Maintainability: Core logic (maze rules, command execution) shall be modular and testable as pure logic where feasible.
NFR-010 Extensibility: Level definitions shall be data-driven so new levels and mechanics can be added without rewriting core systems.
NFR-011 Compatibility: Support modern Chromium-based browsers (Chromebooks) as a priority; define fallback “compatibility mode” if needed.
NFR-012 Data retention: Local progress data shall be stored locally and cleared via an in-game “Reset Progress” control (educator/shared device friendly).
5.3 Out-of-Scope / Deferred Requirements
Real Python runtime execution in the browser (deferred; simulated DSL preferred).
Combat systems and multiple hero classes/polymorphism (deferred).
Multiplayer/social/sharing (deferred due to safety, moderation, privacy).
Full Blockly integration in MVP (possible later; complexity trade-off).

6) Solution-Agnostic Design Notes (Optional, separated)
Not mandates—options and trade-offs. Stack choices are constraints only where already committed by repo.
Architecture option A: Engine-native deterministic core + custom “Python-like blocks” UI
Pros: tight integration, consistent behavior across exports, best control over kid-friendly UX.
Cons: must build editor UX carefully to avoid scope creep.
Architecture option B: Embed a mature block editor (Blockly) and translate to command AST
Pros: powerful editor features “for free.”
Cons: embedding web tech into engine exports can complicate desktop/web parity; may slow delivery.
Architecture option C: Separate “editor” (web) from “runner” (engine)
Pros: fastest iteration on editor UX; easy experimentation.
Cons: integration complexity and offline packaging complexity.
Key components/modules (high-level)
Input & Mode Manager (Manual vs Recorder vs Step)
Command Queue + Program Model (AST-like representation)
Deterministic Simulation (grid + collisions + state)
Command Runner (bounded steps; emits events)
Debugger UI (highlight, logs, replay controls)
Level System (LevelConfig loader; progression)
Save/Settings Store (local)
Telemetry/Analytics (opt-in/out gating)
Integration points
Web export/deploy pipeline (CI → hosting)
Optional dev tooling for content generation (local SLM to JSON)
High-level data entities (ERD-style list)
LevelConfig (grid_size, seed, tiles/walls, start, goal, tutorial_text, prefilled_program?, constraints)
Program (list of Instruction nodes; source_line_id)
ExecutionTrace (timestamped events: step_run, move, bonk, read_sign, win)
PlayerProgress (unlocked_levels, completed_levels, settings)
Risks per option
A: editor UX complexity (scope creep)
B: integration/packaging complexity + web export fragility
C: syncing behavior between editor/runner; determinism drift


