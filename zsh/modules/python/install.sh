source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise install python $PYTHON3_VERSION
mise use --global python@$PYTHON3_VERSION

mise install uv $UV_VERSION
mise use --global uv@$UV_VERSION
