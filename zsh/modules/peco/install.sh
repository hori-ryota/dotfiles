source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install peco

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

mkdir -p "$XDG_CONFIG_HOME/peco"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/peco.json" "$XDG_CONFIG_HOME/peco/config.json"
