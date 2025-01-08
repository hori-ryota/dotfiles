source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

# mise plugins install deno # NOTE: installed as core plugin by mise
mise install deno $DENO_VERSION
mise use --global deno $DENO_VERSION
mise reshim
