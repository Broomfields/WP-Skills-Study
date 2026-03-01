#!/usr/bin/env bash
# new-skill.sh — scaffold a new skill file for WP-Skills-Study
#
# Usage:   ./new-skill.sh "Skill Name" <category>
# Example: ./new-skill.sh "Free Indirect Discourse" story-writing
#
# Categories:
#   character-writing   → character_writing/
#   prose-techniques    → prose_techniques/
#   story-writing       → story_writing/

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 \"Skill Name\" <category>"
  echo ""
  echo "Categories:"
  echo "  character-writing"
  echo "  prose-techniques"
  echo "  story-writing"
  exit 1
fi

SKILL_DISPLAY="$1"
CATEGORY="$2"
DATE=$(date +%Y-%m-%d)

case "$CATEGORY" in
  character-writing) FOLDER="character_writing"; CRAFT_TAG="character-craft" ;;
  prose-techniques)  FOLDER="prose_techniques";  CRAFT_TAG="prose-craft"    ;;
  story-writing)     FOLDER="story_writing";      CRAFT_TAG="story-craft"   ;;
  *)
    echo "Error: Unknown category '${CATEGORY}'"
    echo "Valid categories: character-writing | prose-techniques | story-writing"
    exit 1
    ;;
esac

# Convert display name to snake_case filename
SNAKE=$(echo "$SKILL_DISPLAY" \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/[^a-z0-9]/_/g' \
  | sed 's/__*/_/g' \
  | sed 's/^_//;s/_$//')

FILENAME="${FOLDER}/${SNAKE}.md"

if [[ -f "$FILENAME" ]]; then
  echo "Error: File already exists — $FILENAME"
  exit 1
fi

sed \
  -e "s|{{SKILL_NAME}}|${SKILL_DISPLAY}|g" \
  -e "s|{{CATEGORY}}|${CATEGORY}|g" \
  -e "s|{{CRAFT_TAG}}|${CRAFT_TAG}|g" \
  -e "s|{{DATE}}|${DATE}|g" \
  "_templates/_skill.md" > "$FILENAME"

echo "✓ Created: $FILENAME"
