source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install 1password
brew_install alfred
brew_install appcleaner
brew_install google-japanese-ime
brew_install iterm2
brew_install karabiner-elements
brew_install slack
brew_install moom

# 以下はbrew管理するとアプリ自身の更新管理と競合するのでbrewで入れない
# brew install google-chrome

# Fonts
brew_install font-hackgen-nerd

# Quick Look
## Plugins
### https://github.com/sindresorhus/quick-look-plugins
brew_install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo

xattr -r ~/Library/QuickLook | grep -q "com.apple.quarantine" && xattr -d -r com.apple.quarantine ~/Library/QuickLook

## For QLClolorCode
### Show line number
defaults write org.n8gray.QLColorCode extraHLFlags '-l'
### color theme
defaults write org.n8gray.QLColorCode hlTheme orion

## Enable text Selection
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder
