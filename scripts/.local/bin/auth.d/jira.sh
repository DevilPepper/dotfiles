flags=$(bash ~/.local/bin/auth.d/process_opts "auth.jira" "$@")
IFS=' ' read -r prompt_user initialize <<< "$flags"

if [[ "$prompt_user" == "true" ]]; then
  if [[ "$initialize" == "true" ]]; then
    if gum confirm "Log in to Jira?"; then
      export auth_script_jira=1
    fi
  fi
else
  if [[ "$auth_script_jira" -eq "1" ]]; then
    if [[ "$initialize" == "true" ]]; then
      echo "Create a new API Token and paste it below"
      jira_url="https://id.atlassian.com/manage-profile/security/api-tokens"
      open $jira_url || echo "Go to: $jira_url"
      email=$(git config user.email | tr '[:upper:]' '[:lower:]')
      keyring set jira-cli $email
      jira init --login $email
    fi
  fi
fi
