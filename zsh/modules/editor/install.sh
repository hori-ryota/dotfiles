brew install vim
brew install --HEAD neovim

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# install python
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
pip3 install --upgrade pynvim

# install npm
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"

# install go
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"

# For Languages

## General LSP of linters
echo 'Install github.com/mattn/efm-langserver'
go get -u github.com/mattn/efm-langserver
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/efm-langserver" "$XDG_CONFIG_HOME/efm-langserver"

## Vim
npm install -g vim-language-server

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake'
go get -u github.com/mrtazz/checkmake

## Yaml
### LSP
npm install -g yaml-language-server

## Python
### LSP
pip3 install --upgrade 'python-language-server[all]'

## Dockerfile
### LSP
npm install -g dockerfile-language-server-nodejs
### Linter
brew install hadolint

## Shell
### LSP
npm i -g bash-language-server
### Linter
brew install shellcheck
### Formatter
brew install shfmt

## TypeScript
### LSP
npm install -g typescript-language-server

## HTML
### LSP
npm install -g vscode-html-languageserver-bin

## CSS
### LSP
npm install -g vscode-css-languageserver-bin

## JSON
### LSP
npm install -g vscode-json-languageserver
### Formatter
npm install -g fixjson

## CSV
### LSP
echo 'Install github.com/Clever/csvlint/cmd/csvlint'
go get -u github.com/Clever/csvlint/cmd/csvlint

## Go
### LSP
echo 'Install golang.org/x/tools/gopls'
go get -u golang.org/x/tools/gopls
