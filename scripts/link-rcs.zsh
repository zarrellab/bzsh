#!/bin/zsh

setopt EXTENDED_GLOB

backup_dir=${HOME}/zsh-backup-$(date +%s)

for rcfile in "${ZDOTDIR:-$HOME}"/.bzsh/runcoms/*; do
  if [[ -s $HOME/.${rcfile:t} ]]; then
    echo "${rcfile:t} already exists. Moving existing file to backup directory: ${backup_dir}..."
    if ! [[ -s ${backup_dir:t} ]]; then
      mkdir "$backup_dir"
    fi
    mv "$HOME/.${rcfile:t}" "$backup_dir"
  fi

  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  echo "${rcfile:t} successfully linked"
done

echo 'Creating ~/.zshprivate for private env variables...'
touch ~/.zshprivate
