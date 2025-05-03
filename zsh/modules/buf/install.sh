source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

# mise plugins install buf # NOTE: installed as core plugin by mise
mise install buf $BUF_VERSION
mise use --global buf@$BUF_VERSION
mise reshim
