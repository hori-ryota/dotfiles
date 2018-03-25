#!/bin/sh

## memo: ignore duplication

# Update Homebrew
brew update
brew upgrade

# General
brew install zsh

brew install ack
brew install curl --with-openssl --with-rtmpdump --with-nghttp2
brew install tree
brew install wget

brew install the_silver_searcher
brew install ghq
brew install peco
brew install jq

# Version control system
brew install git
brew install hub

# For development
## golang
brew install go
## Java
brew install gradle
## nodejs
brew install nodebrew
## ruby
brew install rbenv
brew install ruby-build
## Python
brew install pyenv
brew install pyenv-virtualenv
brew install boost
# Orchestration tools
brew install terraform
# mysql
brew install mycli
# ffmpeg
brew install ffmpeg \
  --with-chromaprint \
  --with-fdk-aac \
  --with-fontconfig \
  --with-freetype \
  --with-frei0r \
  --with-game-music-emu \
  --with-libass \
  --with-libbluray \
  --with-libbs2b \
  --with-libcaca \
  --with-libebur128 \
  --with-libgsm \
  --with-libmodplug \
  --with-libsoxr \
  --with-libssh \
  --with-libvidstab \
  --with-libvorbis \
  --with-libvpx \
  --with-opencore-amr \
  --with-openh264 \
  --with-openjpeg \
  --with-openssl \
  --with-opus \
  --with-rtmpdump \
  --with-rubberband \
  --with-schroedinger \
  --with-sdl2 \
  --with-snappy \
  --with-speex \
  --with-tesseract \
  --with-theora \
  --with-tools \
  --with-two-lame \
  --with-wavpack \
  --with-webp \
  --with-x265 \
  --with-xz \
  --with-zeromq \
  --with-zimg

# Graphviz
brew install graphviz

# PlantUML
brew install plantuml

# Vim
brew install vim --with-lua --with-luajit --with-python3 --with-override-system-vi
brew install neovim/neovim/neovim

# tmux
brew install tmux --with-utf8proc

# formatter
brew install astyle

# env
brew install direnv


##########
#  Cask  #
##########

# General
brew cask install iterm2 #--force
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
brew cask install insomniax #--force
brew cask install skitch #--force
brew cask install licecap #--force
brew cask install teamviewer

## k8s
brew cask install minikube

#########
# Fonts #
#########

# Add repository
brew tap caskroom/fonts

# install
brew cask install font-cica #--force

###########################
#  Install from AppStore  #
###########################

# Growl
# Line
# Pocket
# PopClip
# Xcode
# todoist
# moom

############
#  Others  #
############

# TrueCrypt
