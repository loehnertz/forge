#!/usr/bin/env bash
# update-forge.sh - Pull latest Forge framework files
#
# This script updates the core framework files (FORGE.md, Commands/, Templates/)
# while preserving your customizations (AGENTS.md, product folders, etc.).
#
# Usage:
#   ./update-forge.sh           # Safe update - skips modified files
#   ./update-forge.sh --force   # Overwrite all files (backs up modified ones)

set -e

FORGE_REPO="https://raw.githubusercontent.com/loehnertz/forge/master"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false
SKIPPED=()
UPDATED=()
BACKED_UP=()

if [[ "$1" == "--force" ]]; then
  FORCE=true
fi

cd "$SCRIPT_DIR"

# Update a single file, handling local modifications
update_file() {
  local remote_path="$1"
  local local_path="$2"
  local temp_file
  temp_file=$(mktemp)

  # Download new version
  if ! curl -fsSL "$FORGE_REPO/$remote_path" -o "$temp_file" 2>/dev/null; then
    echo "  ⚠ Failed to download $remote_path"
    rm -f "$temp_file"
    return 1
  fi

  # If local file doesn't exist, just copy
  if [[ ! -f "$local_path" ]]; then
    mv "$temp_file" "$local_path"
    UPDATED+=("$local_path")
    return 0
  fi

  # Compare with existing
  if diff -q "$local_path" "$temp_file" >/dev/null 2>&1; then
    # Files are identical, nothing to do
    rm -f "$temp_file"
    return 0
  fi

  # Files differ - local has modifications
  if [[ "$FORCE" == true ]]; then
    # Backup and overwrite
    cp "$local_path" "${local_path}.local"
    mv "$temp_file" "$local_path"
    BACKED_UP+=("$local_path")
  else
    # Save upstream version alongside, skip overwriting
    mv "$temp_file" "${local_path}.upstream"
    SKIPPED+=("$local_path")
  fi
}

echo "Updating Forge framework files..."
echo

# Update FORGE.md
echo "  Checking FORGE.md"
update_file "FORGE.md" "FORGE.md"

# Update Commands/
echo "  Checking Commands/"
mkdir -p Commands
for file in forge-decide forge-decompose forge-design forge-discover \
            forge-new-initiative forge-new-product forge-review; do
  update_file "Commands/${file}.md" "Commands/${file}.md"
done

# Update Templates/
echo "  Checking Templates/"
mkdir -p Templates
for file in Decision Exploration Initiative-AGENTS.EXAMPLE \
            Product-AGENTS.EXAMPLE Proposal Ticket; do
  update_file "Templates/${file}.md" "Templates/${file}.md"
done

echo

# Summary
if [[ ${#UPDATED[@]} -gt 0 ]]; then
  echo "Updated ${#UPDATED[@]} file(s)."
fi

if [[ ${#SKIPPED[@]} -gt 0 ]]; then
  echo
  echo "Skipped ${#SKIPPED[@]} file(s) with local modifications:"
  for f in "${SKIPPED[@]}"; do
    echo "  $f"
  done
  echo
  echo "New upstream versions saved as *.upstream files."
  echo "To consolidate, compare and merge:"
  echo "  diff <file> <file>.upstream"
  echo
  echo "Or run with --force to overwrite (saves backup as *.local):"
  echo "  ./update-forge.sh --force"
fi

if [[ ${#BACKED_UP[@]} -gt 0 ]]; then
  echo
  echo "Backed up ${#BACKED_UP[@]} modified file(s) before overwriting:"
  for f in "${BACKED_UP[@]}"; do
    echo "  ${f}.local"
  done
  echo
  echo "To restore a backup: mv <file>.local <file>"
fi

if [[ ${#UPDATED[@]} -gt 0 ]] || [[ ${#BACKED_UP[@]} -gt 0 ]]; then
  echo
  echo "Run 'git diff' to review changes."
fi

if [[ ${#UPDATED[@]} -eq 0 ]] && [[ ${#SKIPPED[@]} -eq 0 ]] && [[ ${#BACKED_UP[@]} -eq 0 ]]; then
  echo "Already up to date."
fi
