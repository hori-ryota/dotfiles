export NODE_VERSION=20.14.0

export PNPM_HOME="$XDG_DATA_HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
