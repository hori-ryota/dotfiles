source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"
source "$(dirname "${BASH_SOURCE:-$0}")/../0-base-envs/export.zsh"

brew_install java
if [ "$(readlink '/Library/Java/JavaVirtualMachines/openjdk.jdk')" != "${HOMEBREW_PREFIX}/opt/openjdk/libexec/openjdk.jdk" ]; then
	sudo ln -sfn "${HOMEBREW_PREFIX}"/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
fi
