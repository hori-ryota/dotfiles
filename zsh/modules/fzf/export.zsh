export FZF_DEFAULT_OPTS="--tmux"
export FZF_CTRL_T_COMMAND=""
export FZF_ALT_C_COMMAND=""

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
