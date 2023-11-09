#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

(cd ./zprezto && git pull origin master && git submodule update --init)

rtx plugins update

sed -i '' -E "s/(DENO_VERSION=).*/\1$(rtx latest deno)/" ./zsh/modules/deno/export.zsh

sed -i '' -E "s/(GO_VERSION=).*/\1$(rtx latest golang@1.21)/" ./zsh/modules/go/export.zsh
sed -i '' -E "s/(GOLANGCI_LINT_VERSION=).*/\1$(rtx latest golangci-lint)/" ./zsh/modules/go/export.zsh

sed -i '' -E "s/(RUST_VERSION=).*/\1$(rtx latest rust)/" ./zsh/modules/rust/export.zsh

sed -i '' -E "s/(NODE_VERSION=).*/\1$(rtx latest nodejs@20)/" ./zsh/modules/nodejs/export.zsh

sed -i '' -E "s/(PYTHON3_VERSION=).*/\1$(rtx latest python@3.9)/" ./zsh/modules/python/export.zsh
sed -i '' -E "s/(POETRY_VERSION=).*/\1$(rtx latest poetry)/" ./zsh/modules/python/export.zsh

sed -i '' -E "s/(RUBY_VERSION=).*/\1$(rtx latest ruby)/" ./zsh/modules/ruby/export.zsh

sed -i '' -E "s/(TERRAFORM_VERSION=).*/\1$(rtx latest terraform)/" ./zsh/modules/terraform/export.zsh

sed -i '' -E "s/(GCLOUD_VERSION=).*/\1$(rtx latest gcloud)/" ./zsh/modules/google-cloud-sdk/export.zsh
