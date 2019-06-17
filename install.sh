#!/bin/sh

# TODO export.zshと多重管理なので上手いこと寄せたい
XDG_CONFIG_HOME=$HOME/.config
mkdir -p $XDG_CONFIG_HOME
XDG_CACHE_HOME=$HOME/.cache
mkdir -p $XDG_CACHE_HOME

BASEDIR="$HOME"/.dotfiles
ZDOTDIR=$BASEDIR/zsh
IDOTDIR=$BASEDIR/install

. $IDOTDIR/brew.sh
. $IDOTDIR/symlinks.sh
. $IDOTDIR/changedefaultshell.sh

. $IDOTDIR/preferences.sh
. $IDOTDIR/alfred.sh
. $IDOTDIR/quickLook.sh
. $IDOTDIR/go.sh
. $IDOTDIR/tmux.sh

. $IDOTDIR/eclipse_jdt_ls.sh
