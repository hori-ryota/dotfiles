source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install ripgrep

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mkdir -p "$(dirname "$RIPGREP_CONFIG_PATH")"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/ripgreprc" "$RIPGREP_CONFIG_PATH"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/rgignore" "$HOME/.rgignore"
