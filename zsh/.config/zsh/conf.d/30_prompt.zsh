typeset -a precmd_functions
precmd_functions=("${precmd_functions[@]/#starship_hr}")
precmd_functions+=(starship_hr)

eval "$(starship init zsh)"
