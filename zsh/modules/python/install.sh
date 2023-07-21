source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install python
rtx install python $PYTHON3_VERSION
rtx global python $PYTHON3_VERSION
rtx reshim

rtx plugins install poetry
rtx install poetry $POETRY_VERSION
rtx global poetry $POETRY_VERSION
rtx reshim

pip install --upgrade \
  pip \
  setuptools \
  mypy

mkdir -p "$ZSH_COMPLETION_DIR"
poetry completions zsh > "$ZSH_COMPLETION_DIR/_poetry"
