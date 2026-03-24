#!/bin/bash
# embed-elevenlabs.sh — Embed all ElevenLabs docs into ruflo shared memory
#
# Usage:
#   embed-elevenlabs.sh                    # Embed into default namespace
#   embed-elevenlabs.sh <project-dir>      # Embed into project-specific memory
#
# Embeds 189 markdown docs from ~/ruflo/docs/elevenlabs/ into memory namespace "elevenlabs-docs"

set -euo pipefail

DOCS_DIR="$HOME/ruflo/docs/elevenlabs"
CLI="node $HOME/ruflo/v3/@claude-flow/cli/bin/cli.js"
NAMESPACE="elevenlabs-docs"
COUNT=0
ERRORS=0
TOTAL=$(find "$DOCS_DIR" -name "*.md" | wc -l)

echo "[embed-elevenlabs] Embedding $TOTAL ElevenLabs docs into namespace '$NAMESPACE'"
echo "[embed-elevenlabs] Source: $DOCS_DIR"
echo "---"

# If project dir specified, cd into it
if [ -n "${1:-}" ]; then
  echo "[embed-elevenlabs] Project dir: $1"
  cd "$1"
fi

find "$DOCS_DIR" -name "*.md" -type f | sort | while read -r file; do
  # Create a key from the relative path
  REL_PATH="${file#$DOCS_DIR/}"
  KEY="elevenlabs/${REL_PATH%.md}"

  # Read file content
  CONTENT=$(cat "$file" 2>/dev/null || echo "")

  if [ -z "$CONTENT" ]; then
    echo "[SKIP] Empty: $REL_PATH"
    continue
  fi

  # Truncate to ~8000 chars to avoid memory limits
  CONTENT=$(echo "$CONTENT" | head -c 8000)

  # Store in memory via CLI
  $CLI memory store \
    --namespace "$NAMESPACE" \
    --key "$KEY" \
    --value "$CONTENT" \
    2>/dev/null && {
      COUNT=$((COUNT + 1))
      echo "[OK $COUNT/$TOTAL] $REL_PATH"
    } || {
      ERRORS=$((ERRORS + 1))
      echo "[ERR] $REL_PATH"
    }
done

echo "---"
echo "[embed-elevenlabs] Done: $COUNT embedded, $ERRORS errors out of $TOTAL total"
