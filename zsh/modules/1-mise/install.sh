source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install mise
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise settings set go_set_gobin false
mise settings add disable_backends asdf
mise settings add disable_backends vfox

mise settings add idiomatic_version_file_enable_tools go
mise settings add idiomatic_version_file_enable_tools node
mise settings add idiomatic_version_file_enable_tools python
mise settings add idiomatic_version_file_enable_tools ruby
