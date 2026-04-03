# ── builder ───────────────────────────────────────────────────────────────────
FROM python:3.12-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

COPY pyproject.toml uv.lock* ./
COPY src ./src

RUN uv sync --frozen --no-dev --no-editable

# ── runtime ───────────────────────────────────────────────────────────────────
FROM python:3.12-slim AS runtime

RUN groupadd --gid 1001 appgroup     && useradd --uid 1001 --gid appgroup --shell /bin/bash --create-home appuser

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Program Files/Git/mingw64/bin:/mnt/c/Program Files/Git/usr/bin:/mnt/c/Users/chris/bin:/mnt/c/Program Files/Python314/Scripts/:/mnt/c/Program Files/Python314/:/mnt/c/windows/system32:/mnt/c/windows:/mnt/c/windows/System32/Wbem:/mnt/c/windows/System32/WindowsPowerShell/v1.0/:/mnt/c/windows/System32/OpenSSH/:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA App/NvDLISR:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/Microsoft VS Code/bin:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files/PowerShell/7/:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/Git/mingw64/bin:/mnt/c/Program Files/Git/usr/bin:/mnt/c/Program Files/GitHub CLI/:/Docker/host/bin:/mnt/c/Users/chris/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/chris/AppData/Local/PowerToys/DSCModules/"     PYTHONUNBUFFERED=1     PYTHONDONTWRITEBYTECODE=1

USER appuser

ENTRYPOINT ["template-python"]
