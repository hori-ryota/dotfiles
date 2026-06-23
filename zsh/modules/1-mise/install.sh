source "$(dirname "${BASH_SOURCE:-$0}")/../helper.sh"

brew_install mise
source "$(dirname "${BASH_SOURCE:-$0}")/export.zsh"

mise settings set go_set_gobin false
# `set` で全置換する (idempotent)。 `add` は重複排除せず追記するため、
# install.sh を複数回流すと配列が肥大化する
mise settings set disable_backends "asdf,vfox"

mise settings set idiomatic_version_file_enable_tools "go,node,python,ruby"
