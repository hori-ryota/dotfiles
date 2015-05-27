#!/bin/sh

# change default shell to zsh (installed by homebrew)
if ! grep /usr/local/bin/zsh /etc/shells > /dev/null 2>&1; then
  sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
  chsh -s /usr/local/bin/zsh
fi
