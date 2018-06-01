#!/bin/bash

cd ~/dotfiles
for f in $(stow --simulate -v * 2>&1 | grep \* | rev | cut -f1 -d' ' | rev)
do
    rm -rf ~/$f
done
stow *

apm install --packages-file ~/.atom/.packages
