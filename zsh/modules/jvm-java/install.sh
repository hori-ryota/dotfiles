brew install java
if [ "$(readlink '/Library/Java/JavaVirtualMachines/openjdk.jdk')" != '/usr/local/opt/openjdk/libexec/openjdk.jdk' ]; then
	sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
fi
