brew install go
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

echo 'Install github.com/golangci/golangci-lint'
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/golangci.toml" "$HOME/.golangci.toml"

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
