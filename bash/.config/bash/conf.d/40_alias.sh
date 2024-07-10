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

alias rb-link='\
    { rb_gem_path=$(gem environment gempath | tr ":" "\n" | grep ~/.local/share/gem/ruby) } \
    && ln -sf $(echo -e "$rb_gem_path" | head -n 1) ~/.local/share/gem/ruby/current \
'

[[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "alacritty" ]] && alias ssh='TERM=xterm-256color ssh'
