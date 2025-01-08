export GCLOUD_VERSION=505.0.0

if GCLOUD_DIR=$(mise where gcloud 2>/dev/null); then
  if [ -z "$BASH_VERSION" ] || [ "${BASH##*/}" != "bash" ]; then
    source ""${GCLOUD_DIR}"/path.zsh.inc"
    source ""${GCLOUD_DIR}"/completion.zsh.inc"
  else
    source ""${GCLOUD_DIR}"/path.bash.inc"
    source ""${GCLOUD_DIR}"/completion.bash.inc"
  fi
fi
