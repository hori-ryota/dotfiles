#!/bin/sh

# force sync local dir
sources="$BASEDIR"/Library/Preferences/*
dest="$HOME"/Library/Preferences/

for source in ${sources}
do
  rm -rf "${dest}/${source##*/}"
  ln -snf $source "${dest}/${source##*/}"
done
