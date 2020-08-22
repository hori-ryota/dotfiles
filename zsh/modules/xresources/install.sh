source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

ln -snf "$(dirname "${BASH_SOURCE:-$0}")/Xresources" "$HOME/.Xresources"
