#!/usr/bin/env bash
#
# worktree-create.sh - Create a git worktree with setup
#
# Usage: worktree-create.sh <branch-or-feature-name>
#
# Creates a git worktree and runs worktree-setup.sh on it.
# Outputs the worktree absolute path to stdout.

set -euo pipefail

REAL_PATH="$(readlink "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$REAL_PATH")" && pwd)"
readonly SCRIPT_DIR

log_info() { echo "[INFO] $1" >&2; }
log_error() { echo "[ERROR] $1" >&2; }

usage() {
  echo "Usage: $(basename "$0") <branch-or-feature-name>" >&2
  exit 1
}

get_repo_root() {
  local git_common_dir
  git_common_dir="$(git rev-parse --git-common-dir)"
  (cd "$git_common_dir/.." && pwd)
}

get_repo_name() {
  basename "$(get_repo_root)"
}

# Add feature/hori/ prefix if branch name has no slashes
generate_branch_name() {
  local name="$1"
  if [[ "$name" == */* ]]; then
    echo "$name"
  else
    echo "feature/hori/$name"
  fi
}

# Convert branch name to filesystem-safe directory name
sanitize_for_path() {
  echo "$1" | tr '/' '-'
}

generate_worktree_path() {
  local repo_root="$1"
  local repo_name="$2"
  local feature_name="$3"
  local sanitized
  sanitized="$(sanitize_for_path "$feature_name")"
  echo "${repo_root}/../${repo_name}-${sanitized}"
}

main() {
  if [[ $# -ne 1 ]] || [[ -z "$1" ]]; then
    usage
  fi

  local feature_name="$1"

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    log_error "Not inside a git repository"
    exit 1
  fi

  local repo_root repo_name branch_name worktree_path
  repo_root="$(get_repo_root)"
  repo_name="$(get_repo_name)"
  branch_name="$(generate_branch_name "$feature_name")"
  worktree_path="$(generate_worktree_path "$repo_root" "$repo_name" "$feature_name")"

  # Resolve to absolute path
  worktree_path="$(cd "$(dirname "$worktree_path")" && pwd)/$(basename "$worktree_path")"

  # Check if worktree already exists
  if git worktree list --porcelain | grep -q "^worktree ${worktree_path}$"; then
    log_info "Worktree already exists: $worktree_path"
  else
    log_info "Creating worktree: $worktree_path (branch: $branch_name)"
    git worktree add "$worktree_path" -b "$branch_name" >&2
  fi

  # Run setup
  "${SCRIPT_DIR}/worktree-setup.sh" "$repo_root" "$worktree_path" >&2

  # Output path to stdout (for callers to capture)
  echo "$worktree_path"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
