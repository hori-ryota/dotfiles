export HISTTIMEFORMAT=' %F %T ' # Historyファイルのフォーマット
export PAGER="/usr/bin/less -R"
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Homebrewのための設定
export PATH=/usr/local/bin:$PATH
export PATH=${HOME}/local/bin:$PATH
# For brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# tmuxinator
export EDITOR='vim'

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1

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
