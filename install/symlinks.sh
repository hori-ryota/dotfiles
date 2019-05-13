#!/bin/sh

# zsh with prezto
ln -snf "$BASEDIR"/zprezto "$HOME"/.zprezto
ln -snf "$ZDOTDIR"/runcoms/zlogin "$HOME"/.zlogin
ln -snf "$ZDOTDIR"/runcoms/zlogout "$HOME"/.zlogout
ln -snf "$ZDOTDIR"/runcoms/zpreztorc "$HOME"/.zpreztorc
ln -snf "$ZDOTDIR"/runcoms/zprofile "$HOME"/.zprofile
ln -snf "$ZDOTDIR"/runcoms/zshenv "$HOME"/.zshenv
ln -snf "$ZDOTDIR"/runcoms/zshrc "$HOME"/.zshrc

# zsh
ln -snf "$ZDOTDIR" "$HOME"/.zsh

mkdir -p "$XDG_CONFIG_HOME"

# nvim
ln -snf "$BASEDIR"/nvim "$XDG_CONFIG_HOME"/nvim
ln -snf "$BASEDIR"/nvim/cache/dein "$XDG_CACHE_HOME"/dein

mkdir -p "$HOME"/Library/Preferences/TabNine
ln -snf "$BASEDIR"/nvim/TabNine.toml "$HOME"/Library/Preferences/TabNine/TabNine.toml

# tmux
ln -snf "$BASEDIR"/tmux.conf "$HOME"/.tmux.conf

# tmuxinator
ln -snf "$BASEDIR"/tmuxinator "$HOME"/.tmuxinator

# Xresources
ln -snf "$BASEDIR"/Xresources "$HOME"/.Xresources

# git
ln -snf "$BASEDIR"/gitconfig "$HOME"/.gitconfig
ln -snf "$BASEDIR"/gitignore "$HOME"/.gitignore_global

# alfred
ln -snf "$BASEDIR"/alfred "$HOME"/.alfred

# IntelliJ IDEA
ln -snf "$BASEDIR"/ideavimrc "$HOME"/.ideavimrc

# astyle
ln -snf "$BASEDIR"/astylerc "$HOME"/.astylerc

# gtags
ln -snf "$BASEDIR"/globalrc "$HOME"/.globalrc

# peco
mkdir -p "$XDG_CONFIG_HOME"/peco
ln -snf "$BASEDIR"/peco.json "$XDG_CONFIG_HOME"/peco/config.json

# python
ln -snf "$BASEDIR"/flake8 "$XDG_CONFIG_HOME"/flake8
