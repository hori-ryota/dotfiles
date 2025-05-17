source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
source "$(dirname "${BASH_SOURCE:-$0}")/../1-mise/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise install rust "$RUST_VERSION"
mise use --global rust@"$RUST_VERSION"

rustup component add rust-analyzer
