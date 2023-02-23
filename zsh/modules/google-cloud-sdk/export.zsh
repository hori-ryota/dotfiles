if [ -z "$BASH_VERSION" ] || [ "${BASH##*/}" != "bash" ]; then
  source ""${HOMEBREW_PREFIX}"/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source ""${HOMEBREW_PREFIX}"/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
else
  source ""${HOMEBREW_PREFIX}"/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
  source ""${HOMEBREW_PREFIX}"/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
fi
