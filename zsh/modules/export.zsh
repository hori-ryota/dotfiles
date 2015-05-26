export HISTTIMEFORMAT=' %F %T ' # Historyファイルのフォーマット
export PAGER="/usr/bin/less -R"

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

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
