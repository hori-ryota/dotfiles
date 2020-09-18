brew install vim
brew install --HEAD neovim

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

## install python
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
pip3 install --upgrade pynvim

# LSP
pip3 install --upgrade 'python-language-server[all]'

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

## install go
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"

echo 'Install golang.org/x/tools/gopls'
go get -u golang.org/x/tools/gopls
echo 'Install github.com/mattn/efm-langserver'
go get -u github.com/mattn/efm-langserver
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/efm-langserver" "$XDG_CONFIG_HOME/efm_langserver"

echo 'Install github.com/mrtazz/checkmake'
go get -u github.com/mrtazz/checkmake
echo 'Install github.com/Clever/csvlint/cmd/csvlint'
go get -u github.com/Clever/csvlint/cmd/csvlint
