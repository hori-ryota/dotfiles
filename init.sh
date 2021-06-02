#!/bin/sh

set -eu

source "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/0-base-envs/export.zsh"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew upgrade

brew install zsh
# change default shell to zsh (installed by homebrew)
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
chsh -s /usr/local/bin/zsh

source "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/0-base-envs/export.zsh"

for f in "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/"*"/install.sh"
do
  echo "Execute installation script ${f}"
  zsh -c "${f}"
  echo "Finish installation script ${f}"
done

# symlinks for zsh configs
ln -snf "$DOTFILEDIR/zsh" "$HOME"/.zsh

# symlinks for prezto
ln -snf "$DOTFILEDIR/zprezto" "$HOME/.zprezto"
ln -snf "$DOTFILEDIR/zsh/runcoms/zlogin" "$HOME/.zlogin"
ln -snf "$DOTFILEDIR/zsh/runcoms/zlogout" "$HOME/.zlogout"
ln -snf "$DOTFILEDIR/zsh/runcoms/zpreztorc" "$HOME/.zpreztorc"
ln -snf "$DOTFILEDIR/zsh/runcoms/zprofile" "$HOME/.zprofile"
ln -snf "$DOTFILEDIR/zsh/runcoms/zshenv" "$HOME/.zshenv"
ln -snf "$DOTFILEDIR/zsh/runcoms/zshrc" "$HOME/.zshrc"

# Library Preferences
## force sync local dir
for source in "$DOTFILEDIR/Library/Preferences/"*
do
  dest="$HOME/Library/Preferences/"
  rm -rf "${dest}${source##*/}"
  ln -snf $source "${dest}${source##*/}"
done
