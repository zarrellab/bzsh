#!/bin/bash

echo 'Enter your full name:'
read -r name

echo 'Enter your email:'
read -r email

# If signkey isn't saved from gpg generation
if [[ -z $signkey ]]; then
  echo 'Enter your gpg signkey:'
  read -r signkey
fi

git config --global commit.gpgsign true
git config --global core.editor nvim
git config --global core.excludesfile ~/.gitignore
git config --global gpg.program gpg
git config --global init.defaultBranch main
git config --global user.email "$email"
git config --global user.name "$name"
git config --global user.signkey "$signkey"

echo '============================'
echo 'Here is your git config:'
git config --list
