#!/bin/bash

mkdir -p ~/.dotfiles

for dir in $(ls -d */ | sed 's#/##'); do
    source .script/install.sh $(pwd)/$dir
done

