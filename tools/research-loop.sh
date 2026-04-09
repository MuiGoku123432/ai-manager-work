#!/usr/bin/env bash
# tools/research-loop.sh
#
# Outer loop for the recursive-research ratchet. Re-invokes Claude Code for
# each iteration, checks termination criteria, and auto-synthesizes + exports
# when done. Designed for unattended runs in tmux.
#
# Usage:
#   ./tools/research-loop.sh <topic-slug> [max-iterations] [interval-seconds]
#
# Examples:
#   ./tools/research-loop.sh battery-chemistry
#   ./tools/research-loop.sh mcp-server-patterns 15 60
#   tmux new-session -d -s research './tools/research-loop.sh mcp-server-patterns 15'
#
# Prerequisites:
#   - Run from the ai-projects repo root
#   - Claude Code CLI must be on PATH (command: claude)
#   - projects/<slug>/program.md must exist (run /recursive-research start <topic> first)

set -euo pipefail

# ---- Args ----
SLUG="${1:-}"
MAX_ITERATIONS="${2:-10}"
INTERVAL_SECONDS="${3:-30}"

if [[ -z "$SLUG" ]]; then
  echo "Usage: $0 <topic-slug> [max-iterations] [interval-seconds]"
  echo "Example: $0 battery-chemistry 10 30"
  exit 1
fi

PROJECT_DIR="projects/$SLUG"
PROGRAM_FILE="$PROJECT_DIR/program.md"
RESULTS_FILE="$PROJECT_DIR/results.md"

# ---- Validate ----
if [[ ! -f "$PROGRAM_FILE" ]]; then
  echo "ERROR: $PROGRAM_FILE not found."
  echo "Run '/recursive-research start $SLUG' in a Claude Code session first."
  exit 1
fi

echo "========================================"
echo "Recursive Research Loop"
echo "Topic slug: $SLUG"
echo "Max iterations: $MAX_ITERATIONS"
echo "Interval: ${INTERVAL_SECONDS}s between iterations"
echo "Started: $(date)"
echo "========================================"

# ---- Extract termination criteria from program.md ----
MAX_FROM_PROGRAM=$(grep -oP 'Max iterations:\s*\K[0-9]+' "$PROGRAM_FILE" 2>/dev/null || echo "")
COMPLETENESS_THRESHOLD=$(grep -oP 'Completeness threshold:\s*\K[0-9]+' "$PROGRAM_FILE" 2>/dev/null || echo "85")

if [[ -n "$MAX_FROM_PROGRAM" && "$MAX_FROM_PROGRAM" -lt "$MAX_ITERATIONS" ]]; then
  MAX_ITERATIONS="$MAX_FROM_PROGRAM"
  echo "Using max iterations from program.md: $MAX_ITERATIONS"
fi

echo "Completeness target: ${COMPLETENESS_THRESHOLD}%"
echo ""

# ---- Loop ----
ITERATION=0
CONSECUTIVE_NO_COMMITS=0

for ((i=1; i<=MAX_ITERATIONS; i++)); do
  ITERATION=$i
  echo "----------------------------------------"
  echo "Iteration $i / $MAX_ITERATIONS -- $(date)"
  echo "----------------------------------------"

  # Invoke Claude Code for one research iteration
  if claude --print --dangerously-skip-permissions \
    -p "Run /recursive-research iterate $SLUG. Output the iteration summary table and commit decision." \
    2>&1; then
    echo "Iteration $i complete."
  else
    echo "WARNING: Claude Code exited non-zero on iteration $i. Retrying after pause..."
    sleep "$INTERVAL_SECONDS"
    continue
  fi

  # Check if this iteration committed (look for a new commit with the slug)
  LAST_COMMIT_MSG=$(git log --oneline -1 2>/dev/null | grep "research($SLUG)" || echo "")
  if [[ -z "$LAST_COMMIT_MSG" ]]; then
    CONSECUTIVE_NO_COMMITS=$((CONSECUTIVE_NO_COMMITS + 1))
    echo "No commit this iteration ($CONSECUTIVE_NO_COMMITS consecutive)."
    if [[ "$CONSECUTIVE_NO_COMMITS" -ge 3 ]]; then
      echo ""
      echo "STALLED: 3 consecutive iterations without improvement."
      echo "Recommend: Edit $PROGRAM_FILE to adjust search strategy, then restart."
      break
    fi
  else
    CONSECUTIVE_NO_COMMITS=0
    echo "Committed: $LAST_COMMIT_MSG"
  fi

  # Check completeness from results.md
  if [[ -f "$RESULTS_FILE" ]]; then
    LATEST_COMPLETENESS=$(grep -oP '\d+(?=%)' "$RESULTS_FILE" | tail -1 || echo "0")
    echo "Current completeness: ${LATEST_COMPLETENESS}%"

    if [[ "$LATEST_COMPLETENESS" -ge "$COMPLETENESS_THRESHOLD" ]]; then
      echo ""
      echo "TERMINATION: Completeness threshold reached (${LATEST_COMPLETENESS}% >= ${COMPLETENESS_THRESHOLD}%)."
      break
    fi
  fi

  # Pause between iterations (skip on last iteration)
  if [[ "$i" -lt "$MAX_ITERATIONS" ]]; then
    echo "Pausing ${INTERVAL_SECONDS}s..."
    sleep "$INTERVAL_SECONDS"
  fi
done

# ---- Auto-synthesize and export ----
echo ""
echo "========================================"
echo "Loop complete after $ITERATION iterations."
echo "Running synthesis and export..."
echo "========================================"

claude --print --dangerously-skip-permissions \
  -p "Run /recursive-research synthesize $SLUG. Then run /recursive-research export $SLUG." \
  2>&1 || echo "WARNING: Auto-synthesis/export failed. Run manually."

echo ""
echo "========================================"
echo "Research loop finished."
echo "Topic: $SLUG"
echo "Iterations run: $ITERATION"
echo "Ended: $(date)"
echo ""
echo "Review:"
echo "  git log --oneline --grep=\"research($SLUG)\""
echo "  cat $RESULTS_FILE"
echo "  cat projects/$SLUG/reports/*.md | head -50"
echo "========================================"
