#!/bin/sh

echo 'Install github.com/mattn/files'
go get -u -v github.com/mattn/files
echo 'Install github.com/rakyll/hey'
go get -u -v github.com/rakyll/hey
echo 'Install golang.org/x/tools/cmd/gopls'
go get -u -v golang.org/x/tools/cmd/gopls
echo 'Install github.com/golangci/golangci-lint'
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
echo 'Install github.com/mattn/efm-langserver'
go get -u -v github.com/mattn/efm-langserver
echo 'Install github.com/nametake/golangci-lint-langserver'
go get -u -v github.com/nametake/golangci-lint-langserver
echo 'Install github.com/mrtazz/checkmake'
go get -u -v github.com/mrtazz/checkmake
echo 'Install github.com/Clever/csvlint/cmd/csvlint'
go get -u -v github.com/Clever/csvlint/cmd/csvlint
echo 'Install github.com/juliosueiras/terraform-lsp'
go get -v github.com/juliosueiras/terraform-lsp

echo 'Install github.com/hori-ryota/go-codegen'
go get -u -v github.com/hori-ryota/go-codegen
echo 'Install github.com/hori-ryota/go-genappevent'
go get -u -v github.com/hori-ryota/go-genappevent
