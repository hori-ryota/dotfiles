brew install vim
brew install --HEAD neovim

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
pip3 install --upgrade pynvim

# LSP
## install npm
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"

npm install -g vscode-css-languageserver-bin
npm install -g dockerfile-language-server-nodejs
npm install -g vscode-html-languageserver-bin
npm install -g vscode-json-languageserver
npm install -g typescript-language-server
npm install -g vim-language-server
npm install -g vls
npm install -g yaml-language-server
