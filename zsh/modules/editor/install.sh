source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

brew install vim
brew install neovim

brew install universal-ctags

# symlinks for editorconfig
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/editorconfig" "$HOME/.editorconfig"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# install python
source "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../python/export.zsh"
pip_install_targets=("pynvim")

# install npm
source "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../nodejs/export.zsh"
npm_install_targets=()

# install go
source "$(dirname "${BASH_SOURCE:-$0}")/../go/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../go/export.zsh"

# install deno
source "$(dirname "${BASH_SOURCE:-$0}")/../deno/install.sh"

# install rust
source "$(dirname "${BASH_SOURCE:-$0}")/../rust/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../rust/export.zsh"

# VSCode language servers
npm_install_targets+=("vscode-langservers-extracted")

# For Languages

## Markdown
### LSP
brew install marksman

## Vim
### LSP
npm_install_targets+=("vim-language-server")

## Lua
### LSP
brew install lua-language-server

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake/cmd/checkmake'
go install github.com/mrtazz/checkmake/cmd/checkmake@latest

## C/C++
### LSP
brew install llvm

## Shell
### LSP
npm_install_targets+=("bash-language-server")

## Yaml
### GitHub Actions
npm_install_targets+=("yaml-language-server")
go install github.com/rhysd/actionlint/cmd/actionlint@latest

## Python
### LSP
if ! (type "basedpyright" > /dev/null 2>&1); then
  pip_install_targets+=("basedpyright")
fi
if ! (type "ruff" > /dev/null 2>&1); then
  pip_install_targets+=("ruff")
fi
if ! (type "rope" > /dev/null 2>&1); then
  pip_install_targets+=("rope")
fi

### for Jupyter notebook
pip_install_targets+=(jupytext)

## Node.js and frontend development
### LSP
npm_install_targets+=("typescript" "typescript-language-server")
npm_install_targets+=("@olrtg/emmet-language-server")
npm_install_targets+=("@tailwindcss/language-server")
npm_install_targets+=("@prisma/language-server")

### Astro
npm_install_targets+=("@astrojs/language-server")

## Dockerfile
### LSP
npm_install_targets+=("dockerfile-language-server-nodejs")
npm_install_targets+=("@microsoft/compose-language-service")
### Linter
brew install hadolint

## Shell
### Linter
brew install shellcheck
#### symlinks for shellcheckrc
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/shellcheckrc" "$XDG_CONFIG_HOME/.shellcheckrc"

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

echo "pip install --upgrade ${pip_install_targets[@]}"
pip install --upgrade ${pip_install_targets[@]}

echo "pnpm install -g ${npm_install_targets[@]}"
pnpm install -g ${npm_install_targets[@]}
