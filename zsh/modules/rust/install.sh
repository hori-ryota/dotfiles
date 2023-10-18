source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"
zsh -c "$(dirname "${BASH_SOURCE:-$0}")/../1-rtx/install.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

rtx plugins install rust
rtx install rust "$RUST_VERSION"
rtx global rust "$RUST_VERSION"
rtx reshim

rustup component add rust-analyzer
