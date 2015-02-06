BASEDIR=$HOME/.dotfiles
ZDOTDIR=$BASEDIR/zsh
VDOTDIR=$BASEDIR/vim

# zsh with prezto
ln -s $BASEDIR/zprezto $HOME/.zprezto
ln -s $ZDOTDIR/zprezto/runcoms/zlogin $HOME/.zlogin
ln -s $ZDOTDIR/zprezto/runcoms/zlogout $HOME/.zlogout
ln -s $ZDOTDIR/zprezto/runcoms/zpreztorc $HOME/.zpreztorc
ln -s $ZDOTDIR/zprezto/runcoms/zprofile $HOME/.zprofile
ln -s $ZDOTDIR/zprezto/runcoms/zshenv $HOME/.zshenv
ln -s $ZDOTDIR/zprezto/runcoms/zshrc $HOME/.zshrc

# vim
ln -s $BASEDIR/vim $HOME/.vim
ln -s $VDOTDIR/vimrc $HOME/.vimrc

# tmux
ln -s $BASEDIR/tmux.conf $HOME/.tmux.conf

# git
ln -s $BASEDIR/gitconfig $HOME/.gitconfig
ln -s $BASEDIR/gitignore $HOME/.gitignore_global
