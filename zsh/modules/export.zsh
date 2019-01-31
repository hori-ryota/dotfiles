export HISTTIMEFORMAT=' %F %T ' # Historyファイルのフォーマット
export PAGER="/usr/bin/less -R"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Homebrewのための設定
export PATH=/usr/local/bin:$PATH
export PATH=${HOME}/local/bin:$PATH
# For brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# tmuxinator
export EDITOR='nvim'

# go
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# lang
export LC_ALL=en_US.UTF-8

# python
export PYTHON_CONFIGURE_OPTS="--enable-framework --enable-unicode=ucs2"
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$CUDA_HOME/lib
export PATH=$CUDA_HOME/bin:$PATH

export DYLD_LIBRARY_PATH=/usr/local/cuda/lib

# direnv
eval "$(direnv hook zsh)"

# mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# android-platform-tools
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
