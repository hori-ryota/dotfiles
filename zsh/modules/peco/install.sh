brew install peco

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

mkdir -p "$XDG_CONFIG_HOME/peco"
ln -snf "$(dirname "${BASH_SOURCE:-$0}")/peco.json" "$XDG_CONFIG_HOME/peco/config.json"
