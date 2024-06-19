alias beautiful='python -m json.tool'
# alias open='xdg-open'
alias tmux-apocalypse='tmux ls | grep : | cut -d: -f1 | xargs -n 1 -r tmux kill-session -t'
# alias comment='sed -i "s/^\"$1\"/#/" '

# git cd
alias gcd='git is-repo && cd $(git root)/$(fd --base-directory $(git root) --type d --hidden --exclude .git/ | fzf || echo)'
# change workspace
alias cw='cd $(cw.sh)'

alias qrcode='qrencode -t ansiutf8'
alias avscan='clamscan -ro'

alias ls='ls --color=auto'
# alias grep='grep --color=auto'

alias r='R --quiet --no-restore-data --no-save'

[[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "alacritty" ]] && alias ssh='TERM=xterm-256color ssh'
