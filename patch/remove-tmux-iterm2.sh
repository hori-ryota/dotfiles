#!/usr/bin/env bash

set -eu

# Uninstall tmux and related tools
brew uninstall --force tmux
brew uninstall --force fpp
brew uninstall --force urlview
brew uninstall --force tmuxinator

# Remove tmux config and plugins
rm -f ~/.tmux.conf
rm -rf ~/.tmux

# Uninstall iTerm2
brew uninstall --force iterm2

# Remove iTerm2 preferences and support files
rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
rm -rf ~/Library/Application\ Support/iTerm2
rm -rf ~/Library/Saved\ Application\ State/com.googlecode.iterm2.savedState
