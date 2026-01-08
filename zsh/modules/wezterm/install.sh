source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

brew_install wezterm

# Symlink wezterm config
mkdir -p "$XDG_CONFIG_HOME/wezterm"
ln -snf "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)/wezterm.lua" "$XDG_CONFIG_HOME/wezterm/wezterm.lua"
