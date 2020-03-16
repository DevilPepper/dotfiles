#!/bin/bash

if [ $# -eq 0 ]; then
    PREFIX="bak"
else
    PREFIX=$1
fi

dotfiles=(
    .bashrc
    .vimrc
)

for dotfile in "${dotfiles[@]}";
do
    cp ~/$dotfile ~/$PREFIX$dotfile
done
