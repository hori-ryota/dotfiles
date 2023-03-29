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
pip_install_targets=("pynvim")

# install npm
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/export.zsh"

# install go
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../go/export.zsh"

# install deno
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../deno/install.sh"

# For Languages

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake/cmd/checkmake'
go install github.com/mrtazz/checkmake/cmd/checkmake@latest

## Yaml
### GitHub Actions
go install github.com/rhysd/actionlint/cmd/actionlint@latest

## Python
### LSP
if ! (type "mypy" > /dev/null 2>&1); then
  pip_install_targets+=(mypy)
fi
if ! (type "rope" > /dev/null 2>&1); then
  pip_install_targets+=(rope)
fi

### for Jupyter notebook
pip_install_targets+=(jupytext)

## Dockerfile
### Linter
brew install hadolint

## Shell
### Linter
brew install shellcheck
### Formatter
brew install shfmt

## Go
### LSP
echo 'Install golang.org/x/tools/gopls'
go install golang.org/x/tools/gopls@latest
echo 'Install golang.org/x/tools/cmd/goimports'
go install golang.org/x/tools/cmd/goimports@latest
echo 'Install github.com/fatih/gomodifytags'
go install github.com/fatih/gomodifytags@latest
echo 'Install github.com/josharian/impl'
go install github.com/josharian/impl@latest

echo "pip install --upgrade $pip_install_targets"
pip install --upgrade $pip_install_targets
