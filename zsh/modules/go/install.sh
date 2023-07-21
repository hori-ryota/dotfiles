source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

rtx plugins install golang
rtx install golang $GO_VERSION
rtx global golang $GO_VERSION
rtx reshim

echo 'Install github.com/golangci/golangci-lint'
rtx plugins install golangci-lint
rtx install golangci-lint $GOLANGCI_LINT_VERSION
rtx global golangci-lint $GOLANGCI_LINT_VERSION
rtx reshim

# install Debugger
echo "Install github.com/go-delve/delve/cmd/dlv"
go install github.com/go-delve/delve/cmd/dlv@latest

# install Tools
echo 'Install github.com/mattn/files'
go install github.com/mattn/files@latest
