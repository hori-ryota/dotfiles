brew install 1password
brew install alfred
brew install appcleaner
brew install google-japanese-ime
brew install iterm2
brew install karabiner-elements
brew install slack

# 以下はbrew管理するとアプリ自身の更新管理と競合するのでbrewで入れない
# brew install google-chrome

# Fonts
brew install --cask font-hackgen-nerd

# Quick Look
## Plugins
### https://github.com/sindresorhus/quick-look-plugins
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo

xattr -r ~/Library/QuickLook | grep -q "com.apple.quarantine" && xattr -d -r com.apple.quarantine ~/Library/QuickLook

## For QLClolorCode
### Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### color theme
defaults write org.n8gray.QLColorCode hlTheme orion

## Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder
