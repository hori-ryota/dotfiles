BASEDIR=$HOME/.dotfiles
ZDOTDIR=$BASEDIR/zsh/prezto

# zsh with prezto
ln -s $BASEDIR/zprezto
ln -s $ZDOTDIR/zprezto/runcoms/zlogin $HOME/.zlogin
ln -s $ZDOTDIR/zprezto/runcoms/zlogout $HOME/.zlogout
ln -s $ZDOTDIR/zprezto/runcoms/zpreztorc $HOME/.zpreztorc
ln -s $ZDOTDIR/zprezto/runcoms/zprofile $HOME/.zprofile
ln -s $ZDOTDIR/zprezto/runcoms/zshenv $HOME/.zshenv
ln -s $ZDOTDIR/zprezto/runcoms/zshrc $HOME/.zshrc
