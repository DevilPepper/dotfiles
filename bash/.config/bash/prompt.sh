#!/bin/bash

source ~/.config/bash/git_prompt.sh

reset_color=\\033\[00m

_lit(){
    local color=$1
    shift
    echo -e "\x01$color\x02"$*"\x01$reset_color\x02"
}

time_color=\\033\[0\;31m       #red
user_color=\\033\[0\;34m       #blue
host_color=\\033\[0\;34m       #blue
dir_color=\\033\[0\;32m        #green
multiline_color=\\033\[0\;30m  #gray

prompt_txt="[00:00 AM]$USER@$HOSTNAME:"
multiline_txt=$(printf %${#prompt_txt}s | tr " " "|")

PS1='[$(_lit $time_color \@)]$(_lit $user_color \u)@$(_lit $host_color \H):$(_lit $dir_color \\\W)$(git_prompt)\$ '
PS2='$(_lit $multiline_color $multiline_txt)$(_lit $dir_color \\\W)$(git_prompt)> '
