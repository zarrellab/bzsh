#!/bin/bash

ssh-keygen -t ed25519
eval "$(ssh-agent -s)"
echo "Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_ed25519" >>~/.ssh/config

read -r -p 'Create new gpg? [y/n]: ' isNewGPG
echo

if [[ $isNewGPG == 'y' ]]; then
  echo 'Generating gpg key...'
  gpg --full-generate-key

  signkey=$(gpg --list-secret-keys --keyid-format long | rg -Po 'sec.+\/\K(\S+)')
  gpg --export-secret-keys "$signkey" >~/gpg-bu.asc
  echo 'gpg private saved to home. Back this up somewhere secure!'
  read -r -p '?Press any key to continue...'

  gpg --armor --export "$signkey" | pbcopy
  echo 'gpg public key has been copied to clipboard. Save this!'
  read -r -p '?Press any key to continue...'
fi

read -r -p 'Import gpg? [y/n]: ' isImportGPG
echo

if [[ $isImportGPG == 'y' ]]; then
  echo 'Enter your gpg key file with path:'
  read -r gpg_file

  gpg --import "$gpg_file"

  signkey=$(gpg --list-secret-keys --keyid-format long | rg -Po 'sec.+\/\K(\S+)')
fi
