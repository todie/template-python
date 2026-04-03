# template-python

Modern Python project template with uv, ruff, pyright, and GitHub Actions CI.

## Scaffolding

| Tool | Purpose |
|------|---------|
| [uv](https://docs.astral.sh/uv/) | Package manager & virtual environment |
| [ruff](https://docs.astral.sh/ruff/) | Linter & formatter |
| [pyright](https://github.com/microsoft/pyright) | Static type checker (strict) |
| [pytest](https://pytest.org/) | Test runner with coverage |
| [pre-commit](https://pre-commit.com/) | Git hooks |
| [pip-audit](https://github.com/pypa/pip-audit) | Dependency vulnerability scanner |

## Commands

```bash
# Setup
uv sync                            # install all deps (frozen lockfile)

# Run
uv run template-python             # run the CLI entry point

# Test
uv run pytest                      # run tests with coverage
uv run pytest -x                   # stop on first failure
uv run pytest -k "test_name"       # run specific test

# Lint & Format
uv run ruff check .                # lint
uv run ruff check . --fix          # lint + auto-fix
uv run ruff format .               # format in place
uv run ruff format --check .       # CI mode — no writes

# Type check
uv run pyright

# Security
uv run pip-audit

# Pre-commit
pre-commit install
pre-commit run --all-files
```

## Project Layout

```
src/
  template_python/
    __init__.py
    main.py                 # CLI entry point (template_python.main:main)
tests/
  __init__.py
  test_main.py
pyproject.toml              # all config: ruff, pyright, pytest, coverage
Dockerfile                  # multi-stage build
.python-version             # pins Python 3.12
```

## CI Pipeline

The CI workflow (`.github/workflows/ci.yml`) runs:

1. **ruff check** — linting
2. **ruff format --check** — formatting gate
3. **pyright** — strict type checking
4. **pytest** — tests with coverage → Codecov upload
5. **pip-audit** — dependency vulnerability scan

## Release Flow

Releases are automated via [release-please](https://github.com/googleapis/release-please).
Merge a commit with a [Conventional Commit](https://www.conventionalcommits.org/) message to
`main` and release-please will open a versioned PR. Merging that PR creates a GitHub Release.

## Configuration Notes

- **ruff** uses 100-char lines, targets Python 3.12, enables a broad rule set (see `pyproject.toml`)
- **pyright** runs in strict mode
- **pytest** auto-generates coverage for `src/template_python` with branch coverage enabled
- Entry point is `template_python.main:main` — registered as a console script

## Related Templates

| Language | Repository |
|----------|------------|
| Rust | [todie/template-rust](https://github.com/todie/template-rust) |
| Node.js | [todie/template-node](https://github.com/todie/template-node) |
| Terraform | [todie/template-terraform](https://github.com/todie/template-terraform) |
