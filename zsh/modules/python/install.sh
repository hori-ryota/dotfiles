source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

asdf plugin-add python
asdf install python $PYTHON3_VERSION
asdf global python $PYTHON3_VERSION
asdf reshim python

pip3 install --upgrade pip
pip3 install --upgrade setuptools

"$(asdf which pip)" install --upgrade mypy

if type "poetry" > /dev/null 2>&1; then
  poetry self update
else
  curl -sSL https://install.python-poetry.org | python3 -
fi
mkdir -p "$ZSH_COMPLETION_DIR"
poetry completions zsh > "$ZSH_COMPLETION_DIR/_poetry"
