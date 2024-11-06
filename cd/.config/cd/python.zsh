function activate_correct_venv() {
  if [[ -z "$VIRTUAL_ENV" ]]; then
    if [[ -d ./.venv ]]; then
      source ./.venv/bin/activate
    fi
  else
    parentdir="$(dirname $VIRTUAL_ENV)"
    if [[ "$PWD"/ != "$parentdir"/* ]]; then
      deactivate
      activate_correct_venv
    fi
  fi
}

activate_correct_venv
unfunction activate_correct_venv
