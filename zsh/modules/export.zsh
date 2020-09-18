for f in "$(dirname "${BASH_SOURCE:-$0}")/"*"/export.zsh"
do
  source "$f"
done
