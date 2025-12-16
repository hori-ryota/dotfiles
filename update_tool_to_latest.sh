#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

(cd ./zprezto && git pull origin master && git submodule update --init)

sed -i '' -E "s/(BUF_VERSION=).*/\1$(mise latest buf)/" ./zsh/modules/buf/export.zsh

sed -i '' -E "s/(DENO_VERSION=).*/\1$(mise latest deno)/" ./zsh/modules/deno/export.zsh

sed -i '' -E "s/(GO_VERSION=).*/\1$(mise latest golang@1.25)/" ./zsh/modules/go/export.zsh
sed -i '' -E "s/(GOLANGCI_LINT_VERSION=).*/\1$(mise latest golangci-lint)/" ./zsh/modules/go/export.zsh

sed -i '' -E "s/(RUST_VERSION=).*/\1$(mise latest rust)/" ./zsh/modules/rust/export.zsh

sed -i '' -E "s/(NODE_VERSION=).*/\1$(mise latest nodejs@24)/" ./zsh/modules/nodejs/export.zsh

sed -i '' -E "s/(PYTHON3_VERSION=).*/\1$(mise latest python@3.13)/" ./zsh/modules/python/export.zsh
sed -i '' -E "s/(UV_VERSION=).*/\1$(mise latest uv)/" ./zsh/modules/python/export.zsh

sed -i '' -E "s/(RUBY_VERSION=).*/\1$(mise latest ruby)/" ./zsh/modules/ruby/export.zsh

sed -i '' -E "s/(TERRAFORM_VERSION=).*/\1$(mise latest terraform)/" ./zsh/modules/terraform/export.zsh
