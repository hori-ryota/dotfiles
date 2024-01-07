source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise plugins install gcloud
mise install gcloud "$GCLOUD_VERSION"
mise global gcloud "$GCLOUD_VERSION"
mise reshim

source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
