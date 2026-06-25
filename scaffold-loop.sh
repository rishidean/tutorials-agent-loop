#!/usr/bin/env bash
#
# scaffold-loop.sh — generate a fresh agentic-loop skeleton in a target directory.
#
# Run from inside this repo. It copies the app-agnostic machinery as-is, copies the
# skill + agents as editable templates, and writes TODO stubs for the parts that are
# yours to fill (CLAUDE.md, roadmap.md, specs, PROGRESS.md).
#
#   ./scaffold-loop.sh ../my-loop
#
set -euo pipefail

TARGET="${1:-./my-loop}"
SRC="$(cd "$(dirname "$0")" && pwd)"

# Sanity: are we inside the tutorial repo?
if [[ ! -f "$SRC/run.sh" || ! -d "$SRC/.claude" ]]; then
  echo "✗ Run this from inside the tutorials-agent-loop repo." ; exit 1
fi
if [[ -e "$TARGET" ]]; then
  echo "✗ '$TARGET' already exists. Pick an empty path." ; exit 1
fi

echo "Scaffolding a new loop in: $TARGET"
mkdir -p "$TARGET/specs" "$TARGET/.claude/skills/run-qa" "$TARGET/.claude/agents"

# 1. App-agnostic machinery — copied verbatim.
cp "$SRC/prompt.md"  "$TARGET/prompt.md"
cp "$SRC/run.sh"     "$TARGET/run.sh"
chmod +x "$TARGET/run.sh"

# 2. Skill + agents — copied as editable templates (they're Click-Farm-flavored; generalize them).
cp "$SRC/.claude/skills/run-qa/SKILL.md"      "$TARGET/.claude/skills/run-qa/SKILL.md"
cp "$SRC/.claude/agents/linter.md"            "$TARGET/.claude/agents/linter.md"
cp "$SRC/.claude/agents/code-reviewer.md"     "$TARGET/.claude/agents/code-reviewer.md"
cp "$SRC/.claude/agents/playwright-tester.md" "$TARGET/.claude/agents/playwright-tester.md"

# 3. Yours to fill — TODO stubs.
cat > "$TARGET/CLAUDE.md" <<'EOF'
# <Your Project> — Project Context

> Auto-loaded at the start of every session. Broad context only — true for every sprint.

## Definition of done
A sprint is DONE only when: the spec is implemented, `run-qa` returns GREEN, and nothing
that worked before is broken.

## The map (architecture)
TODO: your stack, your entry points, where state lives.

## Conventions
TODO: language/framework rules, naming, anything the Builder must not violate.

## How to verify
Invoke the `run-qa` skill. It returns one verdict: GREEN or RED.
EOF

cat > "$TARGET/roadmap.md" <<'EOF'
# <Your Project> — Roadmap

> `- [ ]` todo · `- [x]` done · `- [!]` blocked. The orchestrator greps this to find work.

- [ ] Sprint 1: <name> — specs/sprint-1.md
EOF

cat > "$TARGET/PROGRESS.md" <<'EOF'
# Progress Log

> Starts empty. The Builder appends one handoff entry per GREEN sprint.

<!-- entries appended below -->
EOF

cat > "$TARGET/specs/sprint-1.md" <<'EOF'
# Sprint 1: <name>

## What to build
TODO: the smallest useful first slice.

## Acceptance Criteria
- TODO: precise, testable statements — your tester turns these into assertions.

## Watch out for
- TODO: known edge cases.
EOF

echo
echo "✓ Done. Next:"
echo "  1. Fill in CLAUDE.md, roadmap.md, and specs/sprint-1.md."
echo "  2. Generalize .claude/skills/run-qa/SKILL.md and the three .claude/agents/* files for your stack."
echo "  3. Set BUILDER_MODEL at the top of run.sh."
echo "  4. cd $TARGET && ./run.sh"
