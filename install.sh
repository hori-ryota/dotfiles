#!/bin/sh

BASEDIR="$HOME"/.dotfiles
ZDOTDIR=$BASEDIR/zsh
VDOTDIR=$BASEDIR/vim

# zsh with prezto
ln -ins "$BASEDIR"/zprezto "$HOME"/.zprezto
ln -ins "$ZDOTDIR"/zprezto/runcoms/zlogin "$HOME"/.zlogin
ln -ins "$ZDOTDIR"/zprezto/runcoms/zlogout "$HOME"/.zlogout
ln -ins "$ZDOTDIR"/zprezto/runcoms/zpreztorc "$HOME"/.zpreztorc
ln -ins "$ZDOTDIR"/zprezto/runcoms/zprofile "$HOME"/.zprofile
ln -ins "$ZDOTDIR"/zprezto/runcoms/zshenv "$HOME"/.zshenv
ln -ins "$ZDOTDIR"/zprezto/runcoms/zshrc "$HOME"/.zshrc

# vim
ln -ins "$BASEDIR"/vim "$HOME"/.vim
ln -ins "$VDOTDIR"/vimrc "$HOME"/.vimrc

# tmux
ln -ins "$BASEDIR"/tmux.conf "$HOME"/.tmux.conf

# tmuxinator
ln -ins "$BASEDIR"/tmuxinator "$HOME"/.tmuxinator

# git
ln -ins "$BASEDIR"/gitconfig "$HOME"/.gitconfig
ln -ins "$BASEDIR"/gitignore "$HOME"/.gitignore_global

# alfred
ln -ins "$BASEDIR"/alfred "$HOME"/.alfred

# tern (For javascript)
ln -ins "$BASEDIR"/tern-project "$HOME"/.tern-project

# change default shell to zsh (installed by homebrew)
if ! grep /usr/local/bin/zsh /etc/shells > /dev/null 2>&1; then
  sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi
