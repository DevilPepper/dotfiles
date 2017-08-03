#!/bin/bash

# Read links.txt. Expects it to be a text file with
# dotfile in here _space_ dotfile to be symlinked.
# \/\/ See the input redirect at done \/\/
while read -r key value
do
    value=$(eval echo $value)
    # do the symlink
    echo "ln -svf $1/$key $value"
    ln -svf $1/$key $value
done < $1/links.txt

