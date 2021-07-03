brew install vim
brew install neovim

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# install python
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../python/export.zsh"
pip3 install --upgrade pynvim

# install npm
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/export.zsh"

# install go
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../go/export.zsh"

# For Languages

## General LSP of linters
echo 'Install github.com/mattn/efm-langserver'
go install github.com/mattn/efm-langserver@latest
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/efm-langserver" "$XDG_CONFIG_HOME/efm-langserver"

## Vim
npm install -g vim-language-server

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake'
go install github.com/mrtazz/checkmake@latest

## Yaml
### LSP
npm install -g yaml-language-server

## Python
### LSP
pip3 install --upgrade 'python-lsp-server[all]'
pip3 install --upgrade pyls-flake8
pip3 install --upgrade python-lsp-black
pip3 install --upgrade mypy-ls
pip3 install --upgrade pyls-isort

### for Jupyter notebook
pip3 install --upgrade jupytext

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
go install github.com/Clever/csvlint/cmd/csvlint@latest

## Go
### LSP
echo 'Install golang.org/x/tools/gopls'
go install golang.org/x/tools/gopls@latest
echo 'Install golang.org/x/tools/cmd/goimports'
go install golang.org/x/tools/cmd/goimports@latest
