#!/bin/bash

# Apple ARM specifics
if [[ $(uname -p) == 'arm' ]]; then
  echo 'Installing rosetta for compatibility...'
  sudo softwareupdate --install-rosetta --agree-to-license

  brew_prefix=/opt/homebrew
else
  brew_prefix=/usr/local
fi

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

# Get docker started for later steps because it can take a while
if [ ! -x /Applications/Docker.app ]; then
  echo 'Error: docker not found!'
  echo 'Make sure docker is installed from brew!'
  exit 1
else
  if (! docker info &>/dev/null); then
    echo "Launching Docker..."
    open /Applications/Docker.app
  fi
fi

if (! command -v mise &>/dev/null); then
  echo 'Error: mise not found!'
  echo 'Make sure mise version manager is installed from brew!'
  exit 1
else
  echo 'Installing mise completions...'
  mise use -g usage

  echo 'Installing node...'
  mise use -g node
  npm i -g npm
  # Enable yarn
  corepack enable

  echo 'Installing bun...'
  mise use -g bun

  echo 'Installing java...'
  mise use -g java

  echo 'Installing maven...'
  mise plugins i maven
  mise use -g maven

  echo 'Installing python...'
  mise use -g python
  # Upgrade pip
  pip3 install --upgrade pip

  echo 'Installing ruby...'
  mise use -g ruby

  echo 'Installing rust...'
  mise use -g rust
fi

echo 'Installing iterm utils...'
# iterm shell integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh

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
