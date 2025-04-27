brew install mise
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise settings add idiomatic_version_file_enable_tools go
mise settings add idiomatic_version_file_enable_tools node
mise settings add idiomatic_version_file_enable_tools python
mise settings add idiomatic_version_file_enable_tools ruby
