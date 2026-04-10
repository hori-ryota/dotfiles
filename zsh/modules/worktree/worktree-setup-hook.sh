#!/usr/bin/env bash
#
# worktree-setup-hook.sh - Claude Code WorktreeCreate hook
#
# Reads JSON from stdin, creates git worktree, runs worktree-setup.sh,
# and outputs the worktree path to stdout.
#
# This hook REPLACES Claude Code's default git worktree behavior.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

INPUT="$(cat)"

WORKTREE_PATH="$(echo "$INPUT" | jq -r '.worktree_path')"
BRANCH="$(echo "$INPUT" | jq -r '.branch // empty')"
DETACH="$(echo "$INPUT" | jq -r '.detach // false')"
CWD="$(echo "$INPUT" | jq -r '.cwd')"

cd "$CWD"

# Create the git worktree
if [[ "$DETACH" == "true" ]]; then
  git worktree add --detach "$WORKTREE_PATH" >&2
else
  git worktree add "$WORKTREE_PATH" "$BRANCH" >&2
fi

# Run worktree-setup.sh (all output to stderr)
REPO_ROOT="$(git rev-parse --show-toplevel)"
"${SCRIPT_DIR}/worktree-setup.sh" "$REPO_ROOT" "$WORKTREE_PATH" >&2

# Output the worktree path (Claude Code reads this from stdout)
echo "$WORKTREE_PATH"
