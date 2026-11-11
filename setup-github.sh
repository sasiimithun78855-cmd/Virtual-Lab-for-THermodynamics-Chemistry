#!/usr/bin/env bash
# Creates a PRIVATE GitHub repo from this folder and pushes it.
# Usage: ./setup-github.sh [repo-name]
set -euo pipefail
NAME="${1:-thermodynamics-lab}"

command -v git >/dev/null || { echo "Install git first: https://git-scm.com/downloads"; exit 1; }
command -v gh  >/dev/null || { echo "Install GitHub CLI first: https://cli.github.com"; exit 1; }

if ! gh auth status >/dev/null 2>&1; then
  echo "Not logged in to GitHub. Starting login..."
  gh auth login --web --git-protocol https
fi

[ -d .git ] || git init -b main
git add .

# Safety check: refuse to continue if .env or key-looking strings are staged
if git diff --cached --name-only | grep -E '(^|/)\.env($|\.)' | grep -v '\.env\.example$'; then
  echo "ERROR: a .env file is staged. Aborting."; exit 1
fi
if git diff --cached -U0 | grep -E -i 'sk-ant-|AIza[0-9A-Za-z_-]{30,}|ghp_[0-9A-Za-z]{30,}|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY'; then
  echo "ERROR: something that looks like a secret is staged. Aborting."; exit 1
fi

git commit -m "Initial commit" || true
gh repo create "$NAME" --private --source=. --remote=origin --push
echo "Done: $(gh repo view --json url -q .url)"
