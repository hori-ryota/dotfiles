source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install tmux
brew_install fpp
brew_install urlview
brew_install tmuxinator

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for tmux
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/tmux.conf" "$HOME/.tmux.conf"

TMUX_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_DIR" ]; then
  mkdir -p "$(dirname "$TMUX_DIR")"
  git clone https://github.com/tmux-plugins/tpm "$TMUX_DIR"
fi
