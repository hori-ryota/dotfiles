brew cask install 1password
brew cask install alfred
brew cask install appcleaner
brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install google-japanese-ime
brew cask install iterm2
brew cask install karabiner-elements
brew cask install slack

# Fonts
brew cask install font-cica

# Quick Look
## Plugins
### https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase qlvideo

## For QLClolorCode
### Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### color theme
defaults write org.n8gray.QLColorCode hlTheme orion

## Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

