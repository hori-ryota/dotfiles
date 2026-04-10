source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

# Add worktree scripts to PATH
mkdir -p "$HOME/.local/bin"
ln -snf "$SCRIPT_DIR/worktree-setup.sh" "$HOME/.local/bin/worktree-setup"
ln -snf "$SCRIPT_DIR/worktree-create.sh" "$HOME/.local/bin/worktree-create"
ln -snf "$SCRIPT_DIR/worktree-setup-hook.sh" "$HOME/.local/bin/worktree-setup-hook"
