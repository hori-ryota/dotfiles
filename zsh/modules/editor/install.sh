source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

brew install vim
brew install neovim

brew install universal-ctags

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# install python
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../python/export.zsh"
pip install --upgrade pynvim

# install npm
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/export.zsh"

# install go
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../go/export.zsh"

# install deno
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../deno/install.sh"

# For Languages

## Vim
npm install -g vim-language-server

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake/cmd/checkmake'
go install github.com/mrtazz/checkmake/cmd/checkmake@latest

## Yaml
### LSP
npm install -g yaml-language-server

### GitHub Actions
go install github.com/rhysd/actionlint/cmd/actionlint@latest

## Python
### LSP
pip install --upgrade 'python-lsp-server[all]'
pip install --upgrade pyls-flake8
pip install --upgrade python-lsp-black
if ! (type "mypy" > /dev/null 2>&1); then
	pip install --upgrade mypy
fi
pip install --upgrade pylsp-mypy
pip install --upgrade pyls-isort
pip install --upgrade pylsp-rope

### for Jupyter notebook
pip install --upgrade jupytext

### auto imports
pip install --upgrade pyflyby
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/pyflyby" "$HOME/.pyflyby"

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

## TypeScript and JavaScript
### LSP
npm install -g typescript
npm install -g typescript-language-server
npm install -g eslint_d
npm install -g @fsouza/prettierd

## HTML,CSS,JSON
### LSP
npm install -g vscode-langservers-extracted

## JSON
### Formatter
npm install -g fixjson

## CSV
### LSP
echo 'Install github.com/Clever/csvlint/cmd/csvlint'
go install github.com/Clever/csvlint/cmd/csvlint@latest

## GraphQL
### LSP
npm install -g graphql-language-service-cli

## Astro
npm install -g @astrojs/language-server

## Go
### LSP
echo 'Install golang.org/x/tools/gopls'
go install golang.org/x/tools/gopls@latest
echo 'Install golang.org/x/tools/cmd/goimports'
go install golang.org/x/tools/cmd/goimports@latest
