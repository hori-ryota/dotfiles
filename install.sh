#!/bin/sh

BASEDIR="$HOME"/.dotfiles
ZDOTDIR=$BASEDIR/zsh
VDOTDIR=$BASEDIR/vim
IDOTDIR=$BASEDIR/install

. $IDOTDIR/brew.sh
. $IDOTDIR/symlinks.sh
. $IDOTDIR/changedefaultshell.sh
. $IDOTDIR/go.sh
. $IDOTDIR/quickLook.sh
