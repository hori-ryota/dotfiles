#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

(cd ./zprezto && git pull origin master && git submodule update --init)

asdf plugin update --all

sed -i '' -E "s/(DENO_VERSION=).*/\1$(asdf latest deno)/" ./zsh/modules/deno/export.zsh

sed -i '' -E "s/(GO_VERSION=).*/\1$(asdf latest golang 1.20)/" ./zsh/modules/go/export.zsh
sed -i '' -E "s/(GOLANGCI_LINT_VERSION=).*/\1$(asdf latest golangci-lint)/" ./zsh/modules/go/export.zsh

sed -i '' -E "s/(NODE_VERSION=).*/\1$(asdf latest nodejs 18)/" ./zsh/modules/nodejs/export.zsh

sed -i '' -E "s/(PYTHON3_VERSION=).*/\1$(asdf latest python 3.9)/" ./zsh/modules/python/export.zsh
sed -i '' -E "s/(POETRY_VERSION=).*/\1$(asdf latest poetry)/" ./zsh/modules/python/export.zsh

sed -i '' -E "s/(RUBY_VERSION=).*/\1$(asdf latest ruby)/" ./zsh/modules/ruby/export.zsh

sed -i '' -E "s/(TERRAFORM_VERSION=).*/\1$(asdf latest terraform)/" ./zsh/modules/terraform/export.zsh
