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

## Updating documentation
- Reference this file anywhere the release process is described.
- If you add new deployment targets, document their tag patterns and versioning rules alongside the existing Web release notes above.
