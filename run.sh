#!/usr/bin/env bash
#
# run.sh — THE ORCHESTRATOR (the outer loop)
# ------------------------------------------------------------------------------
# Walks the roadmap one sprint at a time. For each unchecked sprint it launches a
# FRESH, headless Claude Code session (a clean brain) that reads prompt.md, builds
# the sprint, runs the run-qa gate until GREEN, ticks the roadmap, and documents.
# Then this loop re-reads the roadmap and launches the next one.
#
# It is intentionally tiny. The intelligence is in the files, not the script.
#
# Usage:
#   ./run.sh                      # emergent mode (default)
#   DEMO_MODE=planted ./run.sh    # guarantees a Sprint-3 RED -> fix -> GREEN
#
# Tunables (env vars):
#   MAX_SPRINTS    safety cap on total iterations           (default 6)
#   MAX_TURNS      per-session agentic turn cap (cost guard) (default 60)
#   BUILDER_MODEL  model the Builder runs on                 (default opus)
#   DEMO_MODE      emergent | planted                        (default emergent)
# ------------------------------------------------------------------------------
set -euo pipefail

MAX_SPRINTS="${MAX_SPRINTS:-6}"
MAX_TURNS="${MAX_TURNS:-60}"
MODEL="${BUILDER_MODEL:-opus}"
DEMO_MODE="${DEMO_MODE:-emergent}"
ROADMAP="roadmap.md"

n=0
echo "════════════════════════════════════════════════════════"
echo "  THE LOOP — starting in '${DEMO_MODE}' mode"
echo "  builder=${MODEL}  max_turns=${MAX_TURNS}  max_sprints=${MAX_SPRINTS}"
echo "════════════════════════════════════════════════════════"
echo
grep -E '^- \[' "$ROADMAP" || true
echo

# Loop while the roadmap still has an unchecked sprint and we're under the cap.
while grep -q '^- \[ \]' "$ROADMAP" && (( n < MAX_SPRINTS )); do
  n=$((n + 1))
  next=$(grep -m1 '^- \[ \]' "$ROADMAP")
  echo "────────────────────────────────────────────────────────"
  echo "▶ Iteration ${n} — next up: ${next#- \[ \] }"
  echo "────────────────────────────────────────────────────────"

  # PLANTED MODE: right before Sprint 3, seed a build that ships WITHOUT the
  # affordability guard. Sprint 3's acceptance test then catches it, guaranteeing
  # the RED -> fix -> GREEN inner loop on the projector. Emergent mode skips this
  # and lets the agent's own earlier output stand (RED is realistic, not forced).
  if [[ "$DEMO_MODE" == "planted" && "$next" == *"Sprint 3"* ]]; then
    echo "  (planted) seeding fixtures/index.sprint2-buggy.html -> index.html"
    cp fixtures/index.sprint2-buggy.html index.html
  fi

  # Launch a fresh headless session.
  #   -p                            : print/headless mode, one prompt, then exit
  #   --model                       : the Builder runs on the big model; QA subagents
  #                                   pick their own model in their frontmatter
  #   --max-turns                   : hard cap on agentic turns (runaway-cost guard)
  #   --dangerously-skip-permissions: no human at the keyboard to approve tool calls,
  #                                   so we pre-approve. Only safe because this repo is
  #                                   a throwaway sandbox. Do NOT do this on real code.
  # NOTE: no --bare on purpose — we WANT auto-discovery of CLAUDE.md, the run-qa skill,
  # and the .claude/agents subagents.
  if ! claude -p "$(cat prompt.md)" \
        --model "$MODEL" \
        --max-turns "$MAX_TURNS" \
        --dangerously-skip-permissions ; then
    echo "‼ session exited non-zero on iteration ${n} — stopping."
    break
  fi

  # Did the Builder flag a blocker it couldn't get past in 3 attempts?
  if grep -q '^- \[!\]' "$ROADMAP"; then
    echo "‼ a sprint is marked blocked [!] — stopping for a human."
    break
  fi
done

echo
echo "════════════════════════════════════════════════════════"
if grep -q '^- \[ \]' "$ROADMAP"; then
  echo "  STOPPED with work remaining (hit cap, blocked, or errored)."
else
  echo "  ALL SPRINTS COMPLETE 🌽"
fi
echo "════════════════════════════════════════════════════════"
grep -E '^- \[' "$ROADMAP" || true
echo
echo "Open index.html in a browser to play what the loop built."
