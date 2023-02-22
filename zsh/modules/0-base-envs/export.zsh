export HISTTIMEFORMAT=' %F %T ' # Historyファイルのフォーマット
export PAGER="/usr/bin/less -R"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export ZSH_COMPLETION_DIR="$HOME/.zsh/completion"

# lang
export LC_ALL=en_US.UTF-8

export DOTFILEDIR="$HOME/.dotfiles"
export DEV_DIR="$HOME/dev"

eval "$(/opt/homebrew/bin/brew shellenv)"
