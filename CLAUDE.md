# CLAUDE.md — Python Project (from todie/template-python)

## Template Family
This project was scaffolded from [todie/template-python](https://github.com/todie/template-python).
See also: [template-rust](https://github.com/todie/template-rust) | [template-node](https://github.com/todie/template-node) | [template-terraform](https://github.com/todie/template-terraform)

## Setup
- `uv sync` — install dependencies (uses uv, 10-100x faster than pip)
- `uv sync --dev` — install with dev dependencies
- `uv run <command>` — run commands in the virtual environment

## Test
- `uv run pytest` — run all tests
- `uv run pytest tests/test_foo.py` — run specific test file
- `uv run pytest -k "test_name"` — run specific test
- `uv run pytest -x` — stop on first failure
- `uv run pytest --cov=src --cov-report=xml` — coverage report
- `uv run pytest -n auto` — parallel execution (pytest-xdist)

## Lint & Format
- `uv run ruff check .` — lint (replaces flake8, pyflakes, etc.)
- `uv run ruff check . --fix` — lint with auto-fix
- `uv run ruff format .` — format (replaces black)
- `uv run ruff format --check .` — check formatting
- Pre-commit hooks: `pre-commit run --all-files`

## Type Checking
- `uv run pyright` — strict mode type checking (preferred over mypy)
- Config in pyproject.toml under [tool.pyright]

## Security
- `uv run pip-audit` — dependency vulnerability scan
- Bandit rules enabled via ruff `S` prefix rules

## CI Pipeline
CI runs on every PR: ruff check → ruff format --check → pyright → pytest → pip-audit.

## Release
Uses release-please for automated semver. Write conventional commits:
- `feat:` → minor bump, `fix:` → patch bump, `feat!:` → major bump
- `chore:`, `docs:`, `refactor:`, `test:`, `ci:` → no version bump

## Commit Discipline
- One logical change per commit
- One commit stack per feature branch
- File a PR for each feature branch
- Never bundle unrelated changes
- Never push directly to main

## Architecture Notes
- ruff config: 25+ rule sets enabled (see pyproject.toml [tool.ruff])
- pyright: strict mode, Python 3.12
- Docker: multi-stage with uv for dependency caching
- pyproject.toml is single source of truth (no setup.cfg, no requirements.txt)
