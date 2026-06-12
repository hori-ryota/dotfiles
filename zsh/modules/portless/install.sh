source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install portless

# Skip if the startup service is already installed (avoids sudo prompt)
portless service status 2>/dev/null | grep -q "Installed: yes" || portless service install
