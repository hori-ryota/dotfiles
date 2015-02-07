#!/bin/sh

## memo: ignore duplication

# Update Homebrew
brew update
brew upgrade

# General
brew install zsh
brew install zsh-completions
brew install tree
brew install curl
brew install wget
brew install tmux

# Version control system
brew install git
brew install hub

# Vim
brew install python
brew install lua
brew install vim --with-lua

# For development
## golang
brew install go
## nodejs
brew install nodebrew
brew install phantomjs
## ruby
brew install rbenv
brew install ruby-build


##########
#  Cask  #
##########

# Install cask
brew install caskroom/cask/brew-cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# General
brew cask install iterm2
brew cask install 1password

# Launcher
brew cask install alfred

# Browser
brew cask install google-chrome

# IME
brew cask install google-japanese-ime

# Fast Keywords Concatenator
brew cask install karabiner

# Replace finder
brew cask install path-finder

# Window manager
brew cask install shiftit

# Document manager
brew cask install dash

# Todo manager
brew cask install todoist

# Chat
brew cask install hipchat

# Virtual environment
brew cask install virtualbox
brew cask install genymotion

# Image optimization
brew cask install imageoptim

# Others
brew cask install dropbox
brew cask install sourcetree
brew cask install send-to-kindle


###########################
#  Install from AppStore  #
###########################

# Active Users
# Caffeine
# Evernote
# Growl
# Line
# Pocket
# PopClip
# Reeder 2
# Skitch
# Skype
# Visits
# Xcode
# 夜フクロウ

############
#  Others  #
############

# Tunnelblick
# TrueCrypt
