brew install git
brew install git-secrets
brew install hub
brew install ghq
brew install git-lfs
brew install lazygit
brew install gh

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

mkdir -p "$XDG_CONFIG_HOME/git"

ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitconfig" "$HOME/.gitconfig"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/gitignore" "$XDG_CONFIG_HOME/git/ignore"

mkdir -p "$XDG_CONFIG_HOME/lazygit"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/lazygit.yaml" "$XDG_CONFIG_HOME/lazygit/config.yml"
