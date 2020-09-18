source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

brew install nodebrew
/usr/local/opt/nodebrew/bin/nodebrew setup_dirs

nodebrew install-binary $NODE_VERSION
nodebrew use $NODE_VERSION

npm install -g npm
npm install -g yarn
