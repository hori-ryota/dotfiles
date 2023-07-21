source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install terraform
rtx install terraform $TERRAFORM_VERSION
rtx global terraform $TERRAFORM_VERSION
rtx reshim

brew install hashicorp/tap/terraform-ls
