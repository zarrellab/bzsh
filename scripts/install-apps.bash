#!/bin/bash

brew_prefix=/opt/homebrew

if (! command -v brew &>/dev/null); then
  echo 'Installing homebrew...'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$($brew_prefix/bin/brew shellenv)"

brew bundle --file=./support/Brewfile
# install fzf completions and key bindings only if not already present
if [ ! -f ~/.fzf.zsh ]; then
  echo "fzf init files missing — installing..."
  "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc
fi

echo 'Checking for issues...'
brew doctor

echo 'Configuring related utils...'

# Helper for mise installs
function try_mise_use() {
  lang=$1
  echo "Installing $lang..."
  if ! mise use -g "$lang"; then
    echo "⚠️  Failed to install $lang via mise"
  fi
}

if (! command -v mise &>/dev/null); then
  echo 'Error: mise not found!'
  echo 'Make sure mise version manager is installed from brew!'
  exit 1
else
  echo 'Installing mise completions...'
  mise use -g usage

  try_mise_use node
  npm i -g npm
  # Enable yarn
  corepack enable

  try_mise_use bun
  try_mise_use java
  mise plugins i maven
  try_mise_use maven
  try_mise_use python
  pip3 install --upgrade pip
  try_mise_use ruby
  try_mise_use rust
fi

echo 'Installing iterm utils...'
# iterm shell integration
echo 'Installing iTerm shell integration...'
curl -fsSL https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh

if (! command -v docker &>/dev/null); then
  echo 'Error: docker not found!'
  echo 'Make sure docker is installed from brew!'
  exit 1
else
  if (! docker info &>/dev/null); then
    echo "Launching Docker..."
    open /Applications/Docker.app
    sleep 10
    while (! docker info &>/dev/null); do
      echo "Waiting for Docker to launch..."
      sleep 10
    done
  fi

  docker login
fi

if (! command -v zinit &>/dev/null); then
  echo 'Installing zinit...'
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi
