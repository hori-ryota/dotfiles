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

if [ "$(uname -m)" = "arm64" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi

# brewコマンド実行のたびに色々されるとパフォーマンスが悪いのでoffにする。
# brewコマンドはscriptで実行することがほとんどなので必要ならスクリプトで処理する方針。
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

if [[ ! ":$PATH:" =~ ":${HOMEBREW_PREFIX}/bin:" ]]; then
  if [ -f ""${HOMEBREW_PREFIX}"/bin/brew" ]; then
    eval "$("${HOMEBREW_PREFIX}"/bin/brew shellenv)"
  fi
fi
