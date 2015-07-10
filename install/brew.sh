#!/bin/sh

export HOMEBREW_BREWFILE=~/.brewfile
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew install rcmdnk/file/brew-file
brew file install --preupdate --yes
