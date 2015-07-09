#!/bin/sh

# zsh with prezto
ln -snf "$BASEDIR"/zprezto "$HOME"/.zprezto
ln -snf "$ZDOTDIR"/zprezto/runcoms/zlogin "$HOME"/.zlogin
ln -snf "$ZDOTDIR"/zprezto/runcoms/zlogout "$HOME"/.zlogout
ln -snf "$ZDOTDIR"/zprezto/runcoms/zpreztorc "$HOME"/.zpreztorc
ln -snf "$ZDOTDIR"/zprezto/runcoms/zprofile "$HOME"/.zprofile
ln -snf "$ZDOTDIR"/zprezto/runcoms/zshenv "$HOME"/.zshenv
ln -snf "$ZDOTDIR"/zprezto/runcoms/zshrc "$HOME"/.zshrc

# vim
ln -snf "$BASEDIR"/vim "$HOME"/.vim
ln -snf "$VDOTDIR"/vimrc "$HOME"/.vimrc

# tmux
ln -snf "$BASEDIR"/tmux.conf "$HOME"/.tmux.conf

# tmuxinator
ln -snf "$BASEDIR"/tmuxinator "$HOME"/.tmuxinator

# git
ln -snf "$BASEDIR"/gitconfig "$HOME"/.gitconfig
ln -snf "$BASEDIR"/gitignore "$HOME"/.gitignore_global

# alfred
ln -snf "$BASEDIR"/alfred "$HOME"/.alfred

# tern (For javascript)
ln -snf "$BASEDIR"/tern-project "$HOME"/.tern-project

