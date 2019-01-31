#!/bin/sh

echo 'Install github.com/mattn/files'
go get -u -v github.com/mattn/files
echo 'Install github.com/rakyll/hey'
go get -u -v github.com/rakyll/hey
echo 'Install github.com/saibing/bingo'
go get -u -v github.com/saibing/bingo
echo 'Install github.com/golangci/golangci-lint'
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
