#!/bin/sh

TMUX_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm $TMUX_DIR
fi
