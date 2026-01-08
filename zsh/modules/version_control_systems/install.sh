source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install git
brew_install git-secrets
brew_install ghq
brew_install git-lfs
brew_install lazygit
brew_install gh

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

mkdir -p "$XDG_CONFIG_HOME/git"

ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitconfig" "$HOME/.gitconfig"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitignore" "$XDG_CONFIG_HOME/git/ignore"

mkdir -p "$XDG_CONFIG_HOME/lazygit"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/lazygit.yaml" "$XDG_CONFIG_HOME/lazygit/config.yml"
