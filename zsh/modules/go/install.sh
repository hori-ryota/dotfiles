brew install go
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
mkdir -p "$GOPATH"

echo 'Install golang.org/x/tools/gopls'
go get -u -v golang.org/x/tools/gopls
echo 'Install github.com/mattn/efm-langserver'
go get -u github.com/mattn/efm-langserver
ln -snf "$(dirname "${BASH_SOURCE:-$0}")/efm-langserver" "$XDG_CONFIG_HOME/efm_langserver"

echo 'Install github.com/golangci/golangci-lint'
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
ln -snf "$(dirname "${BASH_SOURCE:-$0}")/golangci.toml" "$HOME/.golangci.toml"

echo 'Install github.com/mrtazz/checkmake'
go get -u github.com/mrtazz/checkmake
echo 'Install github.com/Clever/csvlint/cmd/csvlint'
go get -u github.com/Clever/csvlint/cmd/csvlint

echo 'Install github.com/mattn/files'
go get -u github.com/mattn/files

echo 'Install github.com/hori-ryota/go-codegen'
go get -u github.com/hori-ryota/go-codegen
echo 'Install github.com/hori-ryota/go-genappevent'
go get -u github.com/hori-ryota/go-genappevent
