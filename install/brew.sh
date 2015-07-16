#!/bin/sh

## memo: ignore duplication

# Update Homebrew
brew update
brew upgrade

# General
brew install zsh
brew install zsh-completions

brew install ack
brew install curl
brew install tree
brew install wget

# Version control system
brew install git
brew install hub

# Vim
brew install python
brew install lua
brew install vim --with-lua

# tmux
brew install tmux
brew install reattach-to-user-namespace

# For development
## golang
brew install go --with-cc-common
brew install hg
## nodejs
brew install nodebrew
brew install phantomjs
## ruby
brew install rbenv
brew install ruby-build
## Docker
#brew install boot2docker
brew install docker
brew install docker-machine
brew install docker-compose
# Orchestration tools
brew install terraform
brew install ansible
# Image
brew install optipng



##########
#  Cask  #
##########

# Install cask
brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# clean
#brew cask cleanup

# General
brew cask install --force iterm2
brew cask install --force 1password

# Launcher
brew cask install --force alfred

# Browser
brew cask install --force google-chrome

# IME
brew cask install --force google-japanese-ime

# Fast Keywords Concatenator
brew cask install --force karabiner

# Replace finder
brew cask install --force path-finder

# Window manager
brew cask install --force xquartz
brew cask install --force shiftit

# Document manager
brew cask install --force dash

# Todo manager
brew cask install --force todoist

# Chat
brew cask install --force goofy
brew cask install --force hipchat
brew cask install --force slack

# Virtual environment
brew cask install --force virtualbox
brew cask install --force genymotion

# Image optimization
brew cask install --force imageoptim

# For QuickLook
## For no filename extension
brew cask install --force qlstephen
## For markdown
brew cask install --force qlmarkdown
## For json
brew cask install --force quicklook-json
## For csv
brew cask install --force quicklook-csv
## For zip
brew cask install --force betterzipql
## For .pkg
brew cask install --force suspicious-package
## For code highlight
brew cask install --force qlcolorcode

# Website link checker
brew cask install --force integrity

# Kindle
brew cask install --force kindle
brew cask install --force send-to-kindle

# Others
brew cask install --force appcleaner
brew cask install --force dropbox
brew cask install --force insomniax
brew cask install --force skitch
brew cask install --force vagrant

#########
# Fonts #
#########

# Add repository
brew tap caskroom/fonts

# install
brew cask install --force font-source-han-code-jp

###########################
#  Install from AppStore  #
###########################

# Growl
# Line
# Pocket
# PopClip
# Reeder 2
# Xcode

############
#  Others  #
############

# Tunnelblick
# TrueCrypt
