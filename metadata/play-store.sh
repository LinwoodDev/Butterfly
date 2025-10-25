#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="${1:-$(pwd)}"
SOURCE_SUBDIR="en-US"

if [[ ! -d "$BASE_DIR/$SOURCE_SUBDIR" ]]; then
  printf 'Source directory not found: %s\n' "$BASE_DIR/$SOURCE_SUBDIR" >&2
  exit 1
fi

TITLE_PATH="$BASE_DIR/$SOURCE_SUBDIR/title.txt"

if [[ ! -f "$TITLE_PATH" ]]; then
  printf 'Missing title.txt in source: %s\n' "$TITLE_PATH" >&2
  exit 1
fi

for dir in "$BASE_DIR"/*/; do
  dir="${dir%/}"
  subdir_name="${dir##*/}"

  [[ "$subdir_name" == "$SOURCE_SUBDIR" ]] && continue

  dest="$dir"
  if [[ ! -d "$dest" ]]; then
    printf 'Skipping %s (missing metadata directory)\n' "$dir" >&2
    continue
  fi

  cp "$TITLE_PATH" "$dest/title.txt"
done