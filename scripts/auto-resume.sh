#!/bin/bash
# auto-resume.sh — Run claude autonomously with auto-retry on rate limits
#
# Usage:
#   auto-resume.sh <project-dir> "task description"
#   auto-resume.sh ~/.openclaw/workspaces/sales/repo "Redesign the landing page"
#
# Runs in background, retries on rate limits, logs output.

set -euo pipefail

PROJECT_DIR="${1:?Usage: auto-resume.sh <project-dir> \"task\"}"
TASK="${2:?Usage: auto-resume.sh <project-dir> \"task\"}"
MAX_RETRIES="${3:-10}"
WAIT_SECONDS="${4:-90}"

# Generate session ID for resumability
SESSION_ID="auto-$(date +%s)-$$"
LOG_DIR="$PROJECT_DIR/.claude-flow/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/$SESSION_ID.log"

echo "[auto-resume] Session: $SESSION_ID" | tee "$LOG_FILE"
echo "[auto-resume] Project: $PROJECT_DIR" | tee -a "$LOG_FILE"
echo "[auto-resume] Task: $TASK" | tee -a "$LOG_FILE"
echo "[auto-resume] Max retries: $MAX_RETRIES, wait: ${WAIT_SECONDS}s" | tee -a "$LOG_FILE"
echo "---" | tee -a "$LOG_FILE"

RETRY=0
SUCCESS=false

while [ $RETRY -lt $MAX_RETRIES ]; do
  RETRY=$((RETRY + 1))
  echo "[auto-resume] Attempt $RETRY/$MAX_RETRIES — $(date)" | tee -a "$LOG_FILE"

  if [ $RETRY -eq 1 ]; then
    # First run — new session
    cd "$PROJECT_DIR"
    claude -p \
      --dangerously-skip-permissions \
      --session-id "$SESSION_ID" \
      "$TASK" \
      >> "$LOG_FILE" 2>&1 && { SUCCESS=true; break; }
  else
    # Retry — resume previous session
    cd "$PROJECT_DIR"
    claude -p \
      --dangerously-skip-permissions \
      --resume "$SESSION_ID" \
      "Continue the task. Pick up where you left off. Check task list and memory for progress." \
      >> "$LOG_FILE" 2>&1 && { SUCCESS=true; break; }
  fi

  EXIT_CODE=$?
  echo "[auto-resume] Exited with code $EXIT_CODE, waiting ${WAIT_SECONDS}s..." | tee -a "$LOG_FILE"
  sleep "$WAIT_SECONDS"
done

if $SUCCESS; then
  echo "[auto-resume] Completed successfully after $RETRY attempt(s)" | tee -a "$LOG_FILE"
else
  echo "[auto-resume] Failed after $MAX_RETRIES attempts" | tee -a "$LOG_FILE"
fi
