function cd() {
  builtin cd "$@"

  for cd_handler in ~/.config/cd/*.zsh
  do
    if [ -e $cd_handler ]; then
      source $cd_handler
    fi
  done
}
