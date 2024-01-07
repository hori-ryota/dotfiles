source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise plugins install nodejs
mise install nodejs $NODE_VERSION
mise global nodejs $NODE_VERSION
mise reshim

corepack enable

pnpm install -g \
  npm-check-updates \
  @antfu/ni
