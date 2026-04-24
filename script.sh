#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="$BASE_DIR/src"
TARGET_ROOT="$HOME"
BACKUP_ROOT="$HOME/dotenv-backup-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$TARGET_ROOT/.config"

link_path() {
  local relative_path="$1"
  local src="$SOURCE_ROOT/$relative_path"
  local dest="$TARGET_ROOT/$relative_path"

  if [[ ! -e "$src" ]]; then
    echo "source not found: $src" >&2
    return 1
  fi

  if [[ -L "$dest" ]] && [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
    echo "already linked: $dest -> $src"
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local backup_path="$BACKUP_ROOT/$relative_path"
    mkdir -p "$(dirname "$backup_path")"
    mv "$dest" "$backup_path"
    echo "backed up: $dest -> $backup_path"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "linked: $dest -> $src"
}

link_path ".config/nvim"
link_path ".config/fish"
link_path ".config/home-manager"
