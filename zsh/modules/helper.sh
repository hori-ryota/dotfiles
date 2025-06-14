# Function to install a package using Homebrew.
# If the second argument is "--cask", it installs a cask.
# Usage: brew_install <package_name> [--cask]
brew_install() {
  local package_name="$1"

  # Check if package name is provided
  if [ -z "$package_name" ]; then
    echo "Error: Package name is missing." >&2
    return 1
  fi

  brew list -1 | grep "^${package_name}$" -q && return 0

  local cask_option=""
  # Check if the second argument is "--cask"
  if [ "$2" = "--cask" ]; then
    cask_option="--cask"
  fi

  # Install the package using eval to handle the optional --cask argument
  # brew install handles the case where the package is already installed.
  echo "Attempting to install $package_name..."
  eval "brew install $cask_option \"$package_name\""
}
