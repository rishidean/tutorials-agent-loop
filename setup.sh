#!/usr/bin/env bash
#
# setup.sh — one-time environment setup for the workshop.
# Installs Playwright + Chromium and checks your prerequisites.
#
set -euo pipefail

echo "Click Farm — workshop setup"
echo "──────────────────────────────"

# 1. Node.js (18+)
if ! command -v node >/dev/null 2>&1; then
  echo "✗ Node.js not found. Install Node 18+ from https://nodejs.org and re-run."
  exit 1
fi
echo "✓ node $(node -v)"

# 2. Claude Code CLI
if ! command -v claude >/dev/null 2>&1; then
  echo "✗ Claude Code CLI not found."
  echo "    install:  npm install -g @anthropic-ai/claude-code"
  echo "    then auth: run 'claude' once and log in, OR export ANTHROPIC_API_KEY."
  exit 1
fi
echo "✓ claude ($(claude --version 2>/dev/null || echo installed))"

# 3. Playwright + a browser
echo "Installing Playwright + Chromium (this can take a minute)…"
npm install
npx playwright install chromium

# 4. Make the scripts executable
chmod +x run.sh

echo
echo "✓ Setup complete."
echo
echo "Before you run, make sure Claude Code is authenticated:"
echo "  • run 'claude' once and sign in, OR"
echo "  • export ANTHROPIC_API_KEY=sk-ant-..."
echo
echo "Then:"
echo "  ./run.sh                    # emergent run"
echo "  DEMO_MODE=planted ./run.sh  # guaranteed Sprint-3 RED -> GREEN"
