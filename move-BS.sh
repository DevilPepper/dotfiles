#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    PREFIX="bak"
else
    PREFIX=$1
fi

dotfiles=(
    .bashrc
    .profile
)

for dotfile in "${dotfiles[@]}";
do
  git diff bash/$dotfile | grep "^\+" | grep -v "^\++" | cut -c2- >> ~/$PREFIX$dotfile
  git checkout bash/$dotfile
done

