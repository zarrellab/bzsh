#!/bin/bash

zsh ./link-rcs.zsh
source ./install-apps.bash
source ./config-keys.bash
source ./config-git.bash

echo 'Enabling key repetition...'
defaults write -g ApplePressAndHoldEnabled -bool false

echo 'Setting zsh as default user shell...'
sudo zsh -c "echo $(brew --prefix)/bin/zsh >> /etc/shells"
chsh -s "$(brew --prefix)"/bin/zsh "$(id -un)"

echo 'Finished! Please restart now!'
