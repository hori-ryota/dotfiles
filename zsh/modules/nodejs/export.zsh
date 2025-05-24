export NODE_VERSION=22.16.0

export PNPM_HOME="$XDG_DATA_HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
