if [ -z "$BASH_VERSION" ] || [ "${BASH##*/}" != "bash" ]; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
else
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
fi
