brew install java
if [ "$(readlink '/Library/Java/JavaVirtualMachines/openjdk.jdk')" != '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk' ]; then
	sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
fi
