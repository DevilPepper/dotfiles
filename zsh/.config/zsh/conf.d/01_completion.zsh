# Copied from https://raw.githubusercontent.com/Phantas0s/.dotfiles/master/zsh/completion.zsh

fpath=(~/.local/share/zsh/completions $fpath)

# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'l' vi-forward-char

autoload -U compinit; compinit
_comp_options+=(globdots)

# setopt GLOB_COMPLETE
# setopt MENU_COMPLETE
# setopt AUTO_LIST
setopt COMPLETE_IN_WORD
