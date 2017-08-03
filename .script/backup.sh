#!/bin/bash
backup=~/bak

mkdir -p $backup

# Read links.txt. Expects it to be a text file with
# dotfile in here _space_ dotfile to be symlinked.
# \/\/ See the input redirect at done \/\/
while read -r key value
do
    # If the file exists and is not a symlink, back it up.
    value=$(eval echo $value)
    if [[ -e $value ]] && [[ ! -L $value ]]; then
        echo "cp $value $backup"
        cp $value $backup
    fi
done < $1/links.txt

