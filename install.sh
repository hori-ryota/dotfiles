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

# git
ln -ins "$BASEDIR"/gitconfig "$HOME"/.gitconfig
ln -ins "$BASEDIR"/gitignore "$HOME"/.gitignore_global
