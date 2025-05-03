source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/Xresources" "$HOME/.Xresources"
