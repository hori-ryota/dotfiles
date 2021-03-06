brew install 1password
brew install alfred
brew install appcleaner
brew install dropbox
brew install flux
brew install google-chrome
brew install google-japanese-ime
brew install iterm2
brew install karabiner-elements
brew install slack

# Fonts
brew install homebrew/cask-fonts/font-cica

# Quick Look
## Plugins
### https://github.com/sindresorhus/quick-look-plugins
brew install qlcolorcode qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase qlvideo

## For QLClolorCode
### Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### color theme
defaults write org.n8gray.QLColorCode hlTheme orion

## Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

