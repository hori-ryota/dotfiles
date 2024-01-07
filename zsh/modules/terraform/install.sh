source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise plugins install terraform
mise install terraform $TERRAFORM_VERSION
mise global terraform $TERRAFORM_VERSION
mise reshim

brew install hashicorp/tap/terraform-ls
