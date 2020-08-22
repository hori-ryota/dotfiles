brew install git
brew install hub
brew install git-secrets

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

ln -snf "$(dirname "${BASH_SOURCE:-$0}")/gitconfig" "$HOME/.gitconfig"
ln -snf "$(dirname "${BASH_SOURCE:-$0}")/gitignore" "$HOME/.gitignore_global"
