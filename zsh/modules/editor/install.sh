source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

brew_install vim

brew_install luarocks # for lazy.nvim
brew_install neovim

brew_install universal-ctags

# symlinks for editorconfig
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/editorconfig" "$HOME/.editorconfig"

# symlinks for shellcheck
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/shellcheckrc" "$HOME/.shellcheckrc"

# symlinks for Neovim
ln -snf "$DOTFILEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$DOTFILEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

# install python
source "$(dirname "${BASH_SOURCE:-$0}")/../python/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../python/export.zsh"
uv tool install --upgrade pynvim

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

# AI
npm_install_targets+=("mcp-hub")

# VSCode language servers
npm_install_targets+=("vscode-langservers-extracted")

# For Languages

## Markdown
### LSP
brew_install marksman

## Vim
### LSP
npm_install_targets+=("vim-language-server")

## Lua
### LSP
brew_install lua-language-server

## Makefile
### Linter
echo 'Install github.com/mrtazz/checkmake/cmd/checkmake'
go install github.com/mrtazz/checkmake/cmd/checkmake@latest

## C/C++
### LSP
brew_install llvm

## Shell
### LSP
npm_install_targets+=("bash-language-server")

## Yaml
### GitHub Actions
npm_install_targets+=("yaml-language-server")
go install github.com/rhysd/actionlint/cmd/actionlint@latest

## Python
### LSP
uv tool install --upgrade basedpyright
uv tool install --upgrade ruff
uv tool install --upgrade rope

### for Jupyter notebook
uv tool install --upgrade jupytext

## Node.js and frontend development
### LSP
npm_install_targets+=("typescript" "typescript-language-server")
npm_install_targets+=("@prisma/language-server")

### Astro
npm_install_targets+=("@astrojs/language-server")

## Dockerfile
### LSP
npm_install_targets+=("dockerfile-language-server-nodejs")
npm_install_targets+=("@microsoft/compose-language-service")
### Linter
brew_install hadolint

## Shell
### Linter
brew_install shellcheck

### Formatter
brew_install shfmt

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
echo 'Install github.com/nametake/golangci-lint-langserver'
go install github.com/nametake/golangci-lint-langserver@latest

echo "pnpm install -g ${npm_install_targets[@]}"
pnpm install -g ${npm_install_targets[@]}
