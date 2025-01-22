source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise plugins install gcloud
mise install gcloud "$GCLOUD_VERSION"
mise use --global gcloud@"$GCLOUD_VERSION"
mise reshim

source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"
