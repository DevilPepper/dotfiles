flags=$(bash ~/.local/bin/auth.d/process_opts "auth.gcloud" "$@")
IFS=' ' read -r prompt_user initialize <<< "$flags"

if [[ "$prompt_user" == "true" ]]; then
  if [[ "$initialize" == "true" ]]; then
    if gum confirm "Log in to Google Cloud?"; then
      export auth_script_gcloud=1
    fi
  else
    if gum confirm "Re-authenticate on Google Cloud?"; then
      export auth_script_gcloud=1
    fi
  fi
else
  if [[ "$auth_script_gcloud" -eq "1" ]]; then
    if [[ "$initialize" == "true" ]]; then
      gcloud init
    else
      if ! gcloud auth describe "$(gcloud auth list --format 'get(account)')" > /dev/null 2>&1; then
        gcloud auth login --update-adc
      fi
    fi
  fi
fi
