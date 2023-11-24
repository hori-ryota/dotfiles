source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install nodejs
rtx install nodejs $NODE_VERSION
rtx global nodejs $NODE_VERSION
rtx reshim

corepack enable

pnpm install -g \
  npm-check-updates \
  @antfu/ni
