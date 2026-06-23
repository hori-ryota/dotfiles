source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

if [ "${DOTFILES_DOCKER_RUNTIME:-docker-desktop}" = "rancher" ]; then
  brew_install rancher --cask
else
  brew_install docker-desktop --cask
fi

brew_install hadolint
