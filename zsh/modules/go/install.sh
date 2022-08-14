source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

asdf plugin-add golang
asdf install golang $GO_VERSION
asdf global golang $GO_VERSION

echo 'Install github.com/golangci/golangci-lint'
asdf plugin-add golangci-lint
asdf install golangci-lint $GOLANGCI_LINT_VERSION
asdf global golangci-lint $GOLANGCI_LINT_VERSION

# install Debugger
echo "Install github.com/go-delve/delve/cmd/dlv"
go install github.com/go-delve/delve/cmd/dlv@latest

# install Tools
echo 'Install github.com/mattn/files'
go install github.com/mattn/files@latest

echo 'Install github.com/hori-ryota/go-codegen'
go install github.com/hori-ryota/go-codegen@latest
echo 'Install github.com/hori-ryota/go-genappevent'
go install github.com/hori-ryota/go-genappevent@latest
