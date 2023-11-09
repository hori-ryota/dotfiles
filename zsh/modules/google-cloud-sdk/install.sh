source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install gcloud
rtx install gcloud "$GCLOUD_VERSION"
rtx global gcloud "$GCLOUD_VERSION"
rtx reshim

source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
