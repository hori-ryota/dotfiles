brew install vim
brew install --HEAD neovim

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# symlinks for TabNine
mkdir -p "$HOME"/Library/Preferences/TabNine
ln -snf "$DOTFILEDIR"/nvim/TabNine.toml "$HOME"/Library/Preferences/TabNine/TabNine.toml
