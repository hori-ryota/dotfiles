source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-asdf/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

asdf plugin-add python
asdf install python $PYTHON3_VERSION
asdf global python $PYTHON3_VERSION

pip3 install --upgrade pip
pip3 install --upgrade setuptools

brew install poetry
