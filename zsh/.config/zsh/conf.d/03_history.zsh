HISTFILE=~/.local/state/history.zsh
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(clear|exit|history|fc *|?|??)"

setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Not needed since dups are excluded from history and session close deletes dups
# setopt HIST_IGNORE_ALL_DUPS

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
