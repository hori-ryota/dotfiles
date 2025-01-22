source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

# mise plugins install ruby # NOTE: installed as core plugin by mise
mise install ruby $RUBY_VERSION
mise use --global ruby@$RUBY_VERSION
mise reshim
