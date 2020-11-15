brew install git
brew install git-secrets
brew install hub
brew install ghq
brew install git-lfs

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitconfig" "$HOME/.gitconfig"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitignore" "$HOME/.gitignore_global"
