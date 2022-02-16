source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

asdf plugin-add python
asdf install python $PYTHON3_VERSION
asdf global python $PYTHON3_VERSION
asdf reshim python

asdf plugin-add poetry
asdf install poetry $POETRY_VERSION
asdf global poetry $POETRY_VERSION
asdf reshim poetry

pip3 install --upgrade pip
pip3 install --upgrade setuptools

"$(asdf which pip)" install --upgrade mypy

mkdir -p "$ZSH_COMPLETION_DIR"
poetry completions zsh > "$ZSH_COMPLETION_DIR/_poetry"
