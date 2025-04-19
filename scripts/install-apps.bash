#!/bin/bash

# Apple ARM specifics
if [[ $(uname -p) == 'arm' ]]; then
  echo 'Installing rosetta for compatability...'
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

if (! command -v brew &>/dev/null); then
  echo 'Error: homebrew is not found!'
  echo 'Make sure homebrew is installed and in path!'
  exit 1
else
  brew update

  brew tap chrokh/tap
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-versions

  brew install 1password-cli
  brew install aha
  brew install autojump
  brew install awscli
  brew install bat
  brew install brotli
  brew install cargo-nextest
  brew install cmake
  brew install coreutils
  brew install curl
  brew install direnv
  brew install discord
  brew install docker-slim
  brew install epic-games
  brew install figma
  brew install firefox
  brew install firefox-developer-edition
  brew install font-sauce-code-pro-nerd-font
  brew install fzf
  brew install gawk
  brew install gifox
  brew install git
  brew install gpg
  brew install gnutls
  brew install google-chrome
  brew install helm
  brew install htop
  brew install imagemagick
  brew install imageoptim-cli
  brew install iterm2
  brew install jq
  brew install k6
  brew install kubectx
  brew install mas
  brew install microsoft-edge
  brew install mise
  brew install neovim
  brew install pigz
  brew install pinentry-mac
  brew install pipenv
  brew install postman
  brew install python
  brew install quicklook-csv
  brew install quicklook-json
  brew install ripgrep
  brew install rustup-init
  brew install sequel-pro
  brew install shellcheck
  brew install siril
  brew install slack
  brew install speedtest-cli
  brew install starship
  brew install steam
  brew install subversion
  brew install svgo
  brew install the-unarchiver
  brew install tldr
  brew install tree
  brew install visual-studio-code
  brew install watch
  brew install watchman
  brew install wget
  brew install zsh
  brew install zsh-completions

  brew install --cask 1password
  brew install --cask adobe-creative-cloud
  brew install --cask brave-browser
  brew install --cask cinebench
  brew install --cask docker
  brew install --cask elmedia-player
  brew install --cask monitorcontrol
  brew install --cask mouse-fix
  brew install --cask notion
  brew install --cask rectangle
  brew install --cask sf-symbols
  brew install --cask starnet-plus-plus
  brew install --cask stellarium
  brew install --cask vlc
  brew install --cask xnviewmp
  brew install --cask zoom

  # install fzf completions
  "$(brew --prefix)"/opt/fzf/install

  echo 'Checking for issues...'
  brew doctor
fi

if (! command -v mas &>/dev/null); then
  echo 'Error: cannot install apps from App Store'
  echo 'Make sure mas is installed from brew!'
  exit 1
else
  echo 'Installing App Store apps...'
  mas lucky "1password for safari"
  mas lucky "skysafari 6 plus"
  mas lucky amphetamine
  mas lucky keynote
  mas lucky nordvpn
  mas lucky numbers
  mas lucky pages
  mas lucky quickfits
  mas lucky victronconnect
fi

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
