source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"

brew_install gcloud-cli --cask
