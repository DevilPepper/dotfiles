flags=$(bash ~/.local/bin/auth.d/process_opts "auth.gh" "$@")
IFS=' ' read -r prompt_user initialize <<< "$flags"

if [[ "$prompt_user" == "true" ]]; then
  if [[ "$initialize" == "true" ]]; then
    if gum confirm "Log in to GitHub?"; then
      export auth_script_gh=1
    fi
  else
    if gum confirm "Refresh GitHub Token?"; then
      export auth_script_gh=1
    fi
  fi
else
  if [[ "$auth_script_gh" -eq "1" ]]; then
    if [[ "$initialize" == "true" ]]; then
      gh auth login \
        --hostname github.com \
        --git-protocol ssh \
        --skip-ssh-key
    else
      if ! gh auth status 2> /dev/null; then
        gh auth refresh
      fi
    fi
  fi
fi
