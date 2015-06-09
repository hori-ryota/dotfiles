#!/bin/sh

BASEDIR="$HOME"/.dotfiles
ZDOTDIR=$BASEDIR/zsh
VDOTDIR=$BASEDIR/vim
IDOTDIR=$BASEDIR/install

. $IDOTDIR/brew.sh
. $IDOTDIR/symlinks.sh
. $IDOTDIR/changedefaultshell.sh

. $IDOTDIR/vim-plug.sh
. $IDOTDIR/quickLook.sh
