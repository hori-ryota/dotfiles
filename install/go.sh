#!/bin/sh

echo 'Install github.com/mattn/files'
go get -u -v github.com/mattn/files
echo 'Install github.com/rakyll/hey'
go get -u -v github.com/rakyll/hey
echo 'Install golang.org/x/tools/cmd/gopls'
go get -u -v golang.org/x/tools/cmd/gopls
echo 'Install github.com/golangci/golangci-lint'
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint

echo 'Install github.com/hori-ryota/go-codegen'
go get -u -v github.com/hori-ryota/go-codegen
echo 'Install github.com/hori-ryota/go-genappevent'
go get -u -v github.com/hori-ryota/go-genappevent
