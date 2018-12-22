#!/bin/sh

echo 'Install github.com/mattn/files'
go get github.com/mattn/files
echo 'Install github.com/rakyll/hey'
go get github.com/rakyll/hey
echo 'Install github.com/saibing/bingo'
go get github.com/saibing/bingo
echo 'Install github.com/golangci/golangci-lint'
go get github.com/golangci/golangci-lint/cmd/golangci-lint
