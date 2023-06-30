source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install nodejs
rtx install nodejs $NODE_VERSION
rtx global nodejs $NODE_VERSION

npm install -g \
  npm \
  yarn \
  npm-check-updates
