# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

for profile in ~/*.profile
do
    if [ -e $profile ]; then
      source $profile
    fi
done

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

source ~/.config/bash/env
source ~/.config/bash/xdg
source ~/.config/bash/alias
source ~/.config/bash/ssh > /dev/null 2>&1

echo $(whoami)@$HOSTNAME
