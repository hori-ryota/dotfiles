source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

mise install golang $GO_VERSION
mise use --global golang@$GO_VERSION

echo 'Install github.com/golangci/golangci-lint'
mise install golangci-lint $GOLANGCI_LINT_VERSION
mise use --global golangci-lint@$GOLANGCI_LINT_VERSION

# install Debugger
echo "Install github.com/go-delve/delve/cmd/dlv"
go install github.com/go-delve/delve/cmd/dlv@latest

# install Tools
echo 'Install github.com/mattn/files'
go install github.com/mattn/files@latest
