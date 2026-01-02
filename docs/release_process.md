# Release process (CI vs. Release)

This project uses separate workflows for validation (CI) and publishing (Release) to avoid shipping unverified builds.

## Workflows
- **CI (`.github/workflows/ci.yml`)**
  - Runs on every Pull Request and on pushes to `main`.
  - Executes the headless Godot test suite only; it never deploys artifacts.
- **Release (`.github/workflows/deploy-web.yml`)**
  - Runs only when a Git tag with the `v*` pattern is pushed (for example, `v0.1.2`).
  - Builds the Web export and deploys to `gh-pages`.
  - Derives the release version from the tag and injects it into `game/project.godot` before exporting so the game knows its own version.

## Tag-driven releases
1. Wait for CI on the target commit to finish successfully (check the PR status or the `main` branch checks).
2. Create and push a SemVer tag prefixed with `v` (e.g., `git tag v0.1.2 && git push origin v0.1.2`).
3. The Release workflow will pick up the tag, update the project version, export the Web build, and publish to `gh-pages`.

## Guardrails
- Do not push tags for commits that have failing or pending CI checks. The release workflow will fail if it cannot find a successful CI run for the tagged commit, preventing accidental publication of unverified builds.
- Avoid manually editing `config/version` in `game/project.godot`; it is managed automatically by the Release workflow.
- Ensure `app_version` is correctly injected from the release tag, since it is a required telemetry envelope field (see `docs/event_schema.md`).

## Web release checklist (follow every time)

### Versioning and triggers
- Use semantic version tags prefixed with `v` (example: `v0.1.2`).
- Do not push a tag until CI for the target commit is green.
- The `deploy-web` workflow picks up the tag, injects the version into `game/project.godot`, builds the Web export, and publishes to `gh-pages`.

### Pre-release validation
- Confirm PR CI succeeded for the commit to be tagged (`.github/workflows/ci.yml`).
- Run the headless test suite locally if anything changed since the last CI: `./game/run_tests.sh`.
- Verify this document reflects the current tagging rules.

### Deterministic gameplay smoke test (Web build)
Perform these steps against the exported Web build (local or `gh-pages`). The expected results must be deterministic.
1. Load the game: canvas renders hero, walls, and goal without errors in browser console.
2. Move: press each arrow key; hero moves exactly one tile in the matching direction.
3. Blocked move: attempt to move into a wall; hero position stays unchanged and a “blocked/bonk” feedback appears.
4. Win: navigate to the goal tile; a win overlay or success indicator appears.
5. Restart: trigger the restart/reset control; hero and log/state reset to initial positions.

### Tagging and publish steps
1. Ensure working tree is clean and on the target commit.
2. Create the SemVer tag and push it: `git tag vX.Y.Z && git push origin vX.Y.Z`.
3. Monitor the `deploy-web` workflow run; confirm export completes and publishes to `gh-pages`.

### Rollback guidance (gh-pages)
- If a release is bad, delete the offending tag (`git tag -d vX.Y.Z && git push origin :refs/tags/vX.Y.Z`) to prevent re-triggering it.
- Redeploy the last known good version by re-pushing its tag (e.g., `git push origin vPREV`) or triggering the `deploy-web` workflow from the Actions UI on that tag.
- If the `gh-pages` branch is corrupted, force-push the artifact from the last successful workflow run or restore the branch via GitHub UI while keeping history of tags.

### Post-release checks
- Open the live `gh-pages` URL; repeat the smoke test to confirm the deployed build matches expectations.
- Record the released version, date, and link to workflow run in release notes or team tracker.

## Updating documentation
- Reference this file anywhere the release process is described (instead of duplicating content in other files).
- If you add new deployment targets, document their tag patterns and versioning rules alongside the existing Web release notes above.
