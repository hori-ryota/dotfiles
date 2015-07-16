#!/bin/sh

BASEDIR="$HOME"/.dotfiles
ZDOTDIR=$BASEDIR/zsh
VDOTDIR=$BASEDIR/vim
IDOTDIR=$BASEDIR/install

. $IDOTDIR/brew.sh
. $IDOTDIR/symlinks.sh
. $IDOTDIR/changedefaultshell.sh

. $IDOTDIR/vim-plug.sh
. $IDOTDIR/preferences.sh
. $IDOTDIR/alfred.sh
. $IDOTDIR/quickLook.sh
. $IDOTDIR/go.sh
