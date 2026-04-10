#!/usr/bin/env bash
#
# worktree-setup.sh - Set up a worktree from .worktreesetup config
#
# Usage: worktree-setup.sh [--force] <source-repo> <target-worktree>
#
# Reads .worktreesetup from source-repo and applies copy/symlink/run
# directives to target-worktree. Idempotent - safe to re-run.

set -euo pipefail

readonly SETUP_FILE=".worktreesetup"

log_info() { echo "[INFO] $1"; }
log_warn() { echo "[WARN] $1" >&2; }
log_error() { echo "[ERROR] $1" >&2; }

usage() {
  echo "Usage: $(basename "$0") [--force] <source-repo> <target-worktree>" >&2
  exit 1
}

# Resolve symlink target: if path is a symlink, return its target; otherwise return the path itself
resolve_link_source() {
  local path="$1"
  if [[ -L "$path" ]]; then
    readlink "$path"
  else
    echo "$path"
  fi
}

# Copy a file from source to target (skip if exists unless --force)
do_copy() {
  local src="$1" dst="$2" force="$3"

  if [[ ! -e "$src" ]]; then
    log_warn "Copy source does not exist: $src"
    return 0
  fi

  if [[ -e "$dst" ]] && [[ "$force" != "true" ]]; then
    log_info "Already exists, skipping copy: $dst"
    return 0
  fi

  local dst_dir
  dst_dir="$(dirname "$dst")"
  mkdir -p "$dst_dir"

  if [[ -d "$src" ]]; then
    cp -R "$src" "$dst"
  else
    cp "$src" "$dst"
  fi
  log_info "Copied: $dst"
}

# Create a symlink from source to target (idempotent)
do_symlink() {
  local src="$1" dst="$2"

  if [[ ! -e "$src" ]] && [[ ! -L "$src" ]]; then
    log_warn "Symlink source does not exist: $src"
    return 0
  fi

  # If source is a symlink, follow it to get the real target
  local link_target
  if [[ -L "$src" ]]; then
    link_target="$(readlink "$src")"
  else
    link_target="$src"
  fi

  # If destination is already a symlink pointing to the same target, skip
  if [[ -L "$dst" ]]; then
    local existing_target
    existing_target="$(readlink "$dst")"
    if [[ "$existing_target" == "$link_target" ]]; then
      log_info "Symlink already correct: $dst -> $link_target"
      return 0
    fi
    rm "$dst"
  elif [[ -e "$dst" ]]; then
    log_warn "Backing up existing: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  local dst_dir
  dst_dir="$(dirname "$dst")"
  mkdir -p "$dst_dir"

  ln -s "$link_target" "$dst"
  log_info "Symlinked: $dst -> $link_target"
}

# Run a command in the target worktree directory
do_run() {
  local cmd="$1" dir="$2"
  log_info "Running: $cmd (in $dir)"
  (cd "$dir" && eval "$cmd")
}

# Parse and execute .worktreesetup
run_setup() {
  local source_repo="$1"
  local target_worktree="$2"
  local force="$3"
  local config_file="${source_repo}/${SETUP_FILE}"

  if [[ ! -f "$config_file" ]]; then
    log_info "No ${SETUP_FILE} found in ${source_repo}, nothing to do."
    return 0
  fi

  while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip empty lines and comments
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue

    local directive="${line%%:*}"
    local value="${line#*:}"

    case "$directive" in
      copy)
        do_copy "${source_repo}/${value}" "${target_worktree}/${value}" "$force"
        ;;
      symlink)
        do_symlink "${source_repo}/${value}" "${target_worktree}/${value}"
        ;;
      run)
        do_run "$value" "$target_worktree"
        ;;
      *)
        log_warn "Unknown directive: $directive"
        ;;
    esac
  done <"$config_file"
}

main() {
  local force="false"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --force)
        force="true"
        shift
        ;;
      -*)
        log_error "Unknown option: $1"
        usage
        ;;
      *)
        break
        ;;
    esac
  done

  if [[ $# -ne 2 ]]; then
    usage
  fi

  local source_repo="$1"
  local target_worktree="$2"

  if [[ ! -d "$source_repo" ]]; then
    log_error "Source repository does not exist: $source_repo"
    exit 1
  fi

  if [[ ! -d "$target_worktree" ]]; then
    log_error "Target worktree does not exist: $target_worktree"
    exit 1
  fi

  run_setup "$source_repo" "$target_worktree" "$force"
}

# Allow sourcing for testing
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
