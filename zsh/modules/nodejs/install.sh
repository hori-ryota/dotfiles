source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

asdf plugin-add nodejs
asdf install nodejs $NODE_VERSION
asdf global nodejs $NODE_VERSION

"$(asdf which npm)" install -g \
  npm \
  yarn \
  npm-check-updates

asdf reshim nodejs
