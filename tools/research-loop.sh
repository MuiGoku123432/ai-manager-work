#!/usr/bin/env bash
# research-loop.sh -- Unattended recursive research loop for Crush CLI
#
# Usage:
#   ./tools/research-loop.sh <topic-slug> [max-iterations] [interval-seconds]
#
# Example:
#   tmux new-session -d -s research './tools/research-loop.sh graphql-federation 15'
#
# Requirements:
#   - crush CLI installed and on PATH
#   - Git repo initialized
#   - projects/<topic-slug>/program.md must exist (run /recursive-research start first)

set -euo pipefail

SLUG="${1:?Usage: $0 <topic-slug> [max-iterations] [interval-seconds]}"
MAX_ITER="${2:-10}"
INTERVAL="${3:-30}"

STALL_LIMIT=3
stall_count=0
iteration=0

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

check_prerequisites() {
  if ! command -v crush &>/dev/null; then
    echo "Error: crush CLI not found on PATH. Install from https://github.com/charmbracelet/crush"
    exit 1
  fi
  if [ ! -f "projects/${SLUG}/program.md" ]; then
    echo "Error: projects/${SLUG}/program.md not found."
    echo "Run '/recursive-research start ${SLUG}' first to initialize the research project."
    exit 1
  fi
  if [ ! -d ".git" ]; then
    echo "Error: not a git repository. The ratchet pattern requires git."
    exit 1
  fi
}

get_git_commit_count() {
  git log --oneline --grep="research(${SLUG}):" 2>/dev/null | wc -l | tr -d ' '
}

run_iteration() {
  local before
  before=$(get_git_commit_count)

  log "Starting iteration $((iteration + 1)) of ${MAX_ITER} for '${SLUG}'"

  # Run one research iteration via Crush headless mode
  # NOTE: Crush headless invocation -- update this command if Crush CLI flags change
  crush --no-interactive --prompt "Run /recursive-research iterate ${SLUG}" \
    2>&1 | tee -a "projects/${SLUG}/loop.log"

  local after
  after=$(get_git_commit_count)

  if [ "$after" -gt "$before" ]; then
    log "Iteration committed (total commits: ${after})"
    stall_count=0
    return 0
  else
    log "No commit this iteration (stall count: $((stall_count + 1))/${STALL_LIMIT})"
    stall_count=$((stall_count + 1))
    return 1
  fi
}

check_completeness() {
  # Read the last completeness percentage from results.md
  # Looks for the most recent row in the Scores table
  if [ -f "projects/${SLUG}/results.md" ]; then
    grep -oP '\d+(?=%)' "projects/${SLUG}/results.md" | tail -1
  else
    echo "0"
  fi
}

synthesize_and_export() {
  log "Running synthesis and export for '${SLUG}'"
  crush --no-interactive --prompt "Run /recursive-research synthesize ${SLUG}" \
    2>&1 | tee -a "projects/${SLUG}/loop.log"
  sleep "${INTERVAL}"
  crush --no-interactive --prompt "Run /recursive-research export ${SLUG}" \
    2>&1 | tee -a "projects/${SLUG}/loop.log"
}

main() {
  check_prerequisites

  log "=== Research Loop Starting ==="
  log "Topic: ${SLUG}"
  log "Max iterations: ${MAX_ITER}"
  log "Interval: ${INTERVAL}s"

  while [ "${iteration}" -lt "${MAX_ITER}" ]; do
    iteration=$((iteration + 1))

    run_iteration || true

    # Check stall limit
    if [ "${stall_count}" -ge "${STALL_LIMIT}" ]; then
      log "Stall limit reached (${STALL_LIMIT} consecutive no-commits)."
      log "Recommendation: revise projects/${SLUG}/program.md search strategy."
      log "Stopping loop."
      break
    fi

    # Check completeness threshold (85% by default)
    completeness=$(check_completeness)
    if [ "${completeness}" -ge 85 ]; then
      log "Completeness threshold reached: ${completeness}%"
      synthesize_and_export
      log "=== Research Loop Complete ==="
      exit 0
    fi

    if [ "${iteration}" -lt "${MAX_ITER}" ]; then
      log "Waiting ${INTERVAL}s before next iteration..."
      sleep "${INTERVAL}"
    fi
  done

  log "Max iterations (${MAX_ITER}) reached."
  synthesize_and_export
  log "=== Research Loop Complete ==="
}

main
