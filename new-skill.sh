#!/bin/bash

# new-skill.sh
# Creates a new skill note in the WP-Skills-Study repo,
# automatically assigning the next numeric prefix (01, 02, 03...).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="$SCRIPT_DIR/_templates/_skill.md"

# ── Gather skill title ────────────────────────────────────────────────────────
echo ""
read -p "Skill title: " SKILL_TITLE

if [[ -z "$SKILL_TITLE" ]]; then
  echo "Error: skill title cannot be empty."
  exit 1
fi

# Convert title to a snake_case filename slug
SKILL_SLUG=$(echo "$SKILL_TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g' | sed 's/^_//;s/_$//')

# ── Choose or create a category ───────────────────────────────────────────────
echo ""
echo "Available categories:"
CATEGORIES=()
i=1
for dir in "$SCRIPT_DIR"/*/; do
  # Skip hidden dirs and _templates
  dirname=$(basename "$dir")
  [[ "$dirname" == _* ]] && continue
  [[ "$dirname" == .* ]] && continue
  echo "  $i) $dirname"
  CATEGORIES+=("$dirname")
  ((i++))
done
echo "  n) New category"
echo ""
read -p "Select category [1-${#CATEGORIES[@]} or n]: " CAT_CHOICE

if [[ "$CAT_CHOICE" == "n" || "$CAT_CHOICE" == "N" ]]; then
  read -p "New category name: " NEW_CAT_NAME
  if [[ -z "$NEW_CAT_NAME" ]]; then
    echo "Error: category name cannot be empty."
    exit 1
  fi
  # Slugify the category name
  CATEGORY=$(echo "$NEW_CAT_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/__*/_/g' | sed 's/^_//;s/_$//')
  mkdir -p "$SCRIPT_DIR/$CATEGORY"
  echo "Created category: $CATEGORY"
else
  # Validate numeric selection
  if ! [[ "$CAT_CHOICE" =~ ^[0-9]+$ ]] || (( CAT_CHOICE < 1 || CAT_CHOICE > ${#CATEGORIES[@]} )); then
    echo "Error: invalid selection."
    exit 1
  fi
  CATEGORY="${CATEGORIES[$((CAT_CHOICE - 1))]}"
fi

CATEGORY_DIR="$SCRIPT_DIR/$CATEGORY"

# ── Determine next prefix ─────────────────────────────────────────────────────
MAX_PREFIX=-1

for f in "$CATEGORY_DIR"/[0-9][0-9]_*.md; do
  [[ -e "$f" ]] || continue
  basename_f=$(basename "$f")
  num="${basename_f:0:2}"
  # Strip leading zero for arithmetic
  num_int=$((10#$num))
  if (( num_int > MAX_PREFIX )); then
    MAX_PREFIX=$num_int
  fi
done

if (( MAX_PREFIX < 0 )); then
  # No prefixed files found — start at 01
  NEXT_PREFIX="01"
else
  NEXT_NUM=$(( MAX_PREFIX + 1 ))
  NEXT_PREFIX=$(printf "%02d" "$NEXT_NUM")
fi

# ── Build filename and path ───────────────────────────────────────────────────
FILENAME="${NEXT_PREFIX}_${SKILL_SLUG}.md"
FILEPATH="$CATEGORY_DIR/$FILENAME"

if [[ -f "$FILEPATH" ]]; then
  echo "Error: file already exists: $FILEPATH"
  exit 1
fi

# ── Create file from template ─────────────────────────────────────────────────
TODAY=$(date +%Y-%m-%d)

if [[ -f "$TEMPLATE" ]]; then
  sed \
    -e "s/{{title}}/$SKILL_TITLE/g" \
    -e "s/{{date}}/$TODAY/g" \
    -e "s/{{category}}/$CATEGORY/g" \
    -e "s/{{slug}}/$SKILL_SLUG/g" \
    "$TEMPLATE" > "$FILEPATH"
else
  # Fallback minimal template if _skill.md is missing
  cat > "$FILEPATH" <<EOF
---
title: $SKILL_TITLE
date: $TODAY
category: $CATEGORY
---

# $SKILL_TITLE

## What It Is

## Why It Matters

## Examples

## Practice Notes

EOF
fi

echo ""
echo "✓ Created: $CATEGORY/$FILENAME"
