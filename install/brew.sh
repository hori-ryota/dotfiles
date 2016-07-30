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
brew install peco
brew install jq

# Version control system
brew install git
brew install hub

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
## Python
brew install pyenv
brew install pyenv-virtualenv
# Orchestration tools
brew install terraform
brew install ansible
# mysql
brew install mycli
# ffmpeg
brew install ffmpeg --with-freetype --with-fdk-aac --with-libvo-aacenc  --with-libvorbis --with-libvpx --with-openjpeg --with-theora --with-opencore-amr --with-openssl

# Vim
brew install vim --with-lua --with-luajit --with-python3 --override-system-vi

# tmux
brew install tmux
brew install reattach-to-user-namespace


##########
#  Cask  #
##########

# Install cask
brew tap caskroom/cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew tap caskroom/versions

# clean
#brew cask cleanup

# General
brew cask install iterm2-beta #--force
brew cask install 1password #--force

# Java
brew cask install java

# Launcher
brew cask install alfred #--force

# Browser
brew cask install google-chrome #--force

# IME
brew cask install google-japanese-ime #--force

# Fast Keywords Concatenator
brew cask install karabiner #--force

# Window manager
brew cask install xquartz #--force
brew cask install shiftit #--force

# Document manager
brew cask install dash #--force

# Chat
brew cask install slack #--force

# Virtual environment
brew cask install virtualbox #--force
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
## For zip
brew cask install betterzipql #--force
## For .pkg
brew cask install suspicious-package #--force
## For code highlight
brew cask install qlcolorcode #--force

# Kindle
brew cask install kindle #--force

# Others
brew cask install appcleaner #--force
brew cask install dropbox #--force
brew cask install insomniax #--force
brew cask install skitch #--force
brew cask install vagrant #--force

#########
# Fonts #
#########

# Add repository
brew tap caskroom/fonts

# install
brew cask install font-source-code-pro-for-powerline #--force

###########################
#  Install from AppStore  #
###########################

# Growl
# Line
# Pocket
# PopClip
# Reeder 2
# Xcode
# todoist

############
#  Others  #
############

# TrueCrypt
