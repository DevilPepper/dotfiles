# Copied from https://raw.githubusercontent.com/Phantas0s/.dotfiles/master/zsh/completion.zsh

if type brew &>/dev/null
then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi
fpath=(~/.local/share/zsh/completions $fpath)

# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'l' vi-forward-char

autoload -Uz compinit; compinit
_comp_options+=(globdots)

# setopt GLOB_COMPLETE
# setopt MENU_COMPLETE
# setopt AUTO_LIST
setopt COMPLETE_IN_WORD
