brew install go
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

echo 'Install github.com/golangci/golangci-lint'
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/golangci.toml" "$HOME/.golangci.toml"

echo 'Install github.com/mattn/files'
go get -u github.com/mattn/files

echo 'Install github.com/hori-ryota/go-codegen'
go get -u github.com/hori-ryota/go-codegen
echo 'Install github.com/hori-ryota/go-genappevent'
go get -u github.com/hori-ryota/go-genappevent
