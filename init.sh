#!/bin/sh

set -eu

source "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/0-base-envs/export.zsh"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"

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

if ! xcode-select -p 1>/dev/null; then
  xcode-select --install
  echo 'execute again after installation of command line developer tools.'
  exit 2
fi

if type "brew" >/dev/null 2>&1; then
	brew update
else
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"

brew upgrade

brew install zsh

# change default shell to zsh (installed by homebrew)
grep -q "^${HOMEBREW_PREFIX}/bin/zsh$" /etc/shells || sudo sh -c "echo '${HOMEBREW_PREFIX}/bin/zsh' >> /etc/shells"
[ "$SHELL" != "${HOMEBREW_PREFIX}/bin/zsh" ] && chsh -s "${HOMEBREW_PREFIX}"/bin/zsh

source "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/0-base-envs/export.zsh"

for f in "$(dirname "${BASH_SOURCE:-$0}")/zsh/modules/"*"/install.sh"; do
	echo "Execute installation script ${f}"
	zsh -c "${f}"
	echo "Finish installation script ${f}"
done

# Library Preferences
## force sync local dir
for source in "$DOTFILEDIR/Library/Preferences/"*; do
	dest="$HOME/Library/Preferences/"
	rm -rf "${dest}${source##*/}"
	ln -snf $source "${dest}${source##*/}"
done
