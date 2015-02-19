#!/bin/sh

# For QLClolorCode
## Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
## color theme
defaults write org.n8gray.QLColorCode hlTheme orion

# Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder
