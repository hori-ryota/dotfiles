#!/usr/bin/env bash

set -eu

cd "$(dirname "${BASH_SOURCE:-$0}")" || exit

{
	echo "# Auto generated by \"gen_gitignore.sh\". DO NOT EDIT."
	echo ""
	echo ",*"
	echo "*.log"
	echo ".envrc"
	echo "pyvenv.cfg"
	echo ".pyflyby"
	echo ".init.vim.local"
	echo ""

	# Use [simonwhitaker/gibo: Easy access to gitignore boilerplates](https://github.com/simonwhitaker/gibo).
	gibo dump Dropbox Eclipse JetBrains Linux macOS MicrosoftOffice Vagrant Ninja Tags Vim VisualStudioCode Xcode
} >gitignore
