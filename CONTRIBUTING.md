# Contributing to Kashly

Thanks for your interest!

## Development workflow

- Create feature branches from `main`.
- Use Conventional Commits (e.g., `feat:`, `fix:`, `docs:`).
- Ensure `flutter analyze` passes and add tests where applicable.
- Run `flutter test --coverage` before opening a PR.

## Pull Requests

- Link issues if applicable.
- Keep PRs focused and small when possible.
- The CI must pass; coverage gate is set at 70%.

## Code Style

- Follow `flutter_lints`.
- Prefer BLoC for state management where already used.

## Commit Message Format (Conventional Commits)

Examples:

- `feat(auth): add Google sign-in on web`
- `fix(ios): update Info.plist url schemes`
- `docs(readme): add getting started and env files`

