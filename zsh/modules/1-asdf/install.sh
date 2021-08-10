brew install asdf
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/asdfrc" "$HOME/.asdfrc"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
