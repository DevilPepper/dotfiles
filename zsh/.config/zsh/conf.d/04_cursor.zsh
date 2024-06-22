# ctrl + left/right
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word

# bc Macs are shit
bindkey '\e[1;9D' backward-word
bindkey '\e[1;9C' forward-word

# home/end
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

# ctrl + Backspace
bindkey '^H' backward-kill-word

function noop() {}
zle -N noop
bindkey '\e[1;5A' noop
bindkey '\e[1;5B' noop
bindkey '\e[5~' noop
bindkey '\e[6~' noop
