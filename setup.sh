#!/usr/bin/env bash
#
# setup.sh — one-time environment setup for the workshop.
# Installs Playwright + Chromium and checks your prerequisites.
#
set -euo pipefail

echo "Click Farm — workshop setup"
echo "──────────────────────────────"

# 1. Project files
required_files=(
  "CLAUDE.md"
  "prompt.md"
  "roadmap.md"
  "PROGRESS.md"
  ".claude/skills/run-qa/SKILL.md"
  ".claude/agents/linter.md"
  ".claude/agents/code-reviewer.md"
  ".claude/agents/playwright-tester.md"
  "reset-demo.sh"
)

missing=()
for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    missing+=("$file")
  fi
done

if (( ${#missing[@]} > 0 )); then
  echo "✗ Missing project-level agent files:"
  printf '    %s\n' "${missing[@]}"
  echo
  echo "This repo should include those files. Re-clone or pull the latest main branch,"
  echo "then re-run setup."
  exit 1
fi
echo "✓ project agent files present"

# 2. Node.js (18+)
if ! command -v node >/dev/null 2>&1; then
  echo "✗ Node.js not found. Install Node 18+ from https://nodejs.org and re-run."
  exit 1
fi
echo "✓ node $(node -v)"

# 3. Claude Code CLI
if ! command -v claude >/dev/null 2>&1; then
  echo "✗ Claude Code CLI not found."
  echo "    install:  npm install -g @anthropic-ai/claude-code"
  echo "    then auth: run 'claude' once and log in, OR export ANTHROPIC_API_KEY."
  exit 1
fi
echo "✓ claude ($(claude --version 2>/dev/null || echo installed))"

# 4. Playwright + a browser
echo "Installing Playwright + Chromium (this can take a minute)…"
npm install
npx playwright install chromium

# 5. Make the scripts executable
chmod +x run.sh scaffold-loop.sh reset-demo.sh

echo
echo "✓ Setup complete."
echo
echo "Before you run, make sure Claude Code is authenticated:"
echo "  • run 'claude' once and sign in, OR"
echo "  • export ANTHROPIC_API_KEY=sk-ant-..."
echo
echo "Then:"
echo "  ./run.sh                    # emergent run"
echo "  DEMO_MODE=planted ./run.sh  # seeds the Sprint-3 bug for QA to catch"
