brew install --cask 1password
brew install --cask alfred
brew install --cask appcleaner
brew install --cask dropbox
brew install --cask flux
brew install --cask google-chrome
brew install --cask google-japanese-ime
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask slack

# Fonts
brew install --cask font-cica

# Quick Look
## Plugins
### https://github.com/sindresorhus/quick-look-plugins
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase qlvideo

## For QLClolorCode
### Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### color theme
defaults write org.n8gray.QLColorCode hlTheme orion

## Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

