#!/bin/sh

## memo: ignore duplication

# Update Homebrew
brew update
brew upgrade

# General
brew install zsh

brew install ack
brew install curl
brew install tree
brew install wget

brew install the_silver_searcher
brew install ghq
brew install peco
brew install jq

# Version control system
brew install git
brew install hub
brew install git-secrets

# For development
## docker
brew install hadolint
## golang
brew install go
## JVM
brew install gradle
brew install kotlin
brew install ktlint
## nodejs
brew install nodebrew
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs

## ruby
brew install rbenv
brew install ruby-build
## Python
brew install boost
## Orchestration tools
brew install terraform
## mysql
brew install mycli
## Javascript
brew install eslint
## Protobuf
brew install protobuf
brew install prototool
brew tap bufbuild/buf
brew install buf
## yaml
brew install yamllint
# sh
brew install shellcheck
brew install shfmt

## ffmpeg
brew install ffmpeg

# Pandoc
brew install pandoc

# Graphviz
brew install graphviz

# PlantUML
brew install plantuml

# Vim
brew install vim
brew install neovim

# tmux
brew install tmux
brew install fpp
brew install urlview

# formatter
brew install astyle
brew install prettier

# env
brew install direnv

# image
# brew install jpgoptim # deprecated
brew install pngquant

# blog
brew install hugo


##########
#  Cask  #
##########

brew tap homebrew/cask-versions

# General
brew cask install iterm2 #--force
brew cask install 1password #--force

# Java
brew cask install java
brew cask install adoptopenjdk8

# Launcher
brew cask install alfred #--force

# Browser
brew cask install google-chrome #--force

# IME
brew cask install google-japanese-ime #--force

# Fast Keywords Concatenator
brew cask install karabiner-elements #--force

# Chat
brew cask install slack #--force

## Docker
brew cask install docker

# For QuickLook
## For no filename extension
brew cask install qlstephen #--force
## For markdown
brew cask install qlmarkdown #--force
## For json
brew cask install quicklook-json #--force
## For csv
brew cask install quicklook-csv #--force
## For .pkg
brew cask install suspicious-package #--force
## For code highlight
brew cask install qlcolorcode #--force

# Kindle
brew cask install kindle #--force

# Others
brew cask install appcleaner #--force
brew cask install dropbox #--force
brew cask install skitch #--force
brew cask install licecap #--force
brew cask install teamviewer
brew cask install pomodone
brew cask install flux

#########
# Fonts #
#########

# install
brew cask install font-cica

###########################
#  Install from AppStore  #
###########################

# Growl
# Line
# Pocket
# todoist
# moom

############
#  Others  #
############

# TrueCrypt
