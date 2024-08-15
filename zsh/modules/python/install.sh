source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

# mise plugins install python # NOTE: installed as core plugin by mise
mise install python $PYTHON3_VERSION
mise global python $PYTHON3_VERSION
mise reshim

mise plugins install poetry
mise install poetry $POETRY_VERSION
mise global poetry $POETRY_VERSION
mise reshim

pip install --upgrade \
  pip \
  setuptools \
  mypy

mkdir -p "$ZSH_COMPLETION_DIR"
poetry completions zsh > "$ZSH_COMPLETION_DIR/_poetry"
