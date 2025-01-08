source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

# mise plugins install python # NOTE: installed as core plugin by mise
mise install python $PYTHON3_VERSION
mise use --global python $PYTHON3_VERSION
mise reshim

mise plugins install uv
mise install uv $UV_VERSION
mise use --global uv $UV_VERSION

mise reshim

mkdir -p "$ZSH_COMPLETION_DIR"
