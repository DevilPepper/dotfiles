#!/bin/bash
alias reload='. ~/.bashrc;'
alias beautiful='python -m json.tool'
# alias open='xdg-open'
alias tmux-apocalypse='tmux ls | grep : | cut -d: -f1 | xargs -n 1 -r tmux kill-session -t'
alias comment='sed -i "s/^\"$1\"/#/" '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias avscan='clamscan -ro'
