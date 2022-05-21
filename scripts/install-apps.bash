#!/bin/bash

# Apple ARM specifics
if [[ $(uname -p) == 'arm' ]]; then
  echo 'Installing rosetta for compatability...'
  sudo softwareupdate --install-rosetta --agree-to-license

  brew_prefix=/opt/homebrew
else
  brew_prefix=/usr/local
fi

echo 'Installing homebrew...'
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$($brew_prefix/bin/brew shellenv)"

brew update

brew tap chrokh/tap
brew tap homebrew/cask
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions

brew install \
  1password \
  1password-cli \
  aha \
  asdf \
  autojump \
  awscli \
  bat \
  brotli \
  cmake \
  coreutils \
  curl \
  direnv \
  discord \
  docker-slim \
  epic-games \
  figma \
  firefox \
  firefox-developer-edition \
  font-sauce-code-pro-nerd-font \
  fzf \
  gawk \
  gifox \
  git \
  gnupg \
  gnutls \
  google-chrome \
  helm \
  htop \
  htop \
  imagemagick \
  imageoptim-cli \
  iterm2 \
  iterm2 \
  jq \
  kubectx \
  mas \
  microsoft-edge \
  neovim \
  pigz \
  pinentry-mac \
  pipenv \
  postman \
  python \
  quicklook-csv \
  quicklook-json \
  ripgrep \
  rustup-init \
  sequel-pro \
  shellcheck \
  slack \
  steam \
  subversion \
  svgo \
  the-unarchiver \
  tldr \
  transmission-cli \
  tree \
  visual-studio-code \
  watch \
  watchman \
  wget \
  zinit \
  zsh \
  zsh-completions

brew install --cask \
  adobe-creative-cloud \
  cinebench \
  docker \
  monitorcontrol \
  mouse-fix \
  obsidian \
  rectangle \
  transmission \
  vlc \
  zoom

echo 'Installing App Store apps...'
mas lucky amphetamine
mas lucky keynote
mas lucky nordvpn
mas lucky numbers
mas lucky pages

# install fzf completions
"$(brew --prefix)"/opt/fzf/install

echo 'Checking for issues...'
brew doctor

echo 'Configuring related utils...'

echo 'Starting docker...'
open /Applications/Docker.app

echo 'Installing node...'
# Install node version manager
asdf plugin add nodejs
# Install the default version of nodejs
asdf install nodejs latest
asdf global nodejs latest
# Enable yarn
corepack enable

echo 'Installing java...'
# Install java version manager
asdf plugin-add java
# Install the default version of java
asdf install java adoptopenjdk-jre-18.0.1+10
asdf global java adoptopenjdk-jre-18.0.1+10

echo 'Installing maven...'
# Install maven version manager
asdf plugin-add maven
# Install the default version of maven
asdf install maven latest
asdf global maven latest

echo 'Installing python...'
# Install python version manager
asdf plugin-add python
# Install the default version of python
asdf install python latest
asdf global python latest
# Upgrade pip
pip3 install --upgrade pip

echo 'Installing rust...'
# Install rust version manager
asdf plugin-add rust
# Install the default version of rust
asdf install rust latest
asdf global rust latest

echo 'Installing scala...'
# Install scala version manager
asdf plugin-add scala
# Install the default version of scala
asdf install scala latest
asdf global scala latest

echo 'Configuring gpg...'
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >>~/.gnupg/gpg-agent.conf

echo 'Installing iterm utils...'
# iterm shell integration
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | zsh

echo 'Ensure docker is running before continuing!'
read -r -p '?Press any key to continue...'
docker login
