#!/bin/sh

# TODO export.zshと多重管理なので上手いこと寄せたい
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache

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

. $IDOTDIR/eclipse_jdt_ls.sh
