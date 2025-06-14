source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

# Install bats-core (Bash Automated Testing System)
brew_install bats-core

# Install bats helper libraries
# Since bats helper libraries are not available via brew,
# we'll install them via git clone to a standard location
BATS_LIBS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/bats/libs"
mkdir -p "$BATS_LIBS_DIR"

# Helper function to clone bats libraries
install_bats_lib() {
  local lib_name="$1"
  local lib_dir="$BATS_LIBS_DIR/$lib_name"

  if [[ ! -d "$lib_dir" ]]; then
    echo "Installing $lib_name..."
    git clone "https://github.com/bats-core/$lib_name.git" "$lib_dir"
  else
    echo "$lib_name is already installed"
  fi
}

# Install bats helper libraries
install_bats_lib "bats-support"
install_bats_lib "bats-assert"
install_bats_lib "bats-file"

# Create symlink for easy access to test runner
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/run_all_tests.sh" "$HOME/.local/bin/run_all_tests"
