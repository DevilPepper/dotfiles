#!/usr/bin/env bash

steps_file="$1"
step_name="$2"

cat "$steps_file" \
  | filter-json name "$step_name" \
  | jq -r '.[0].actions[0].bash_command' \
  | bat --color=always --language=sh # could be better

echo -e "\n--------------------------------\n"

circle-log-fetch.sh "$steps_file" "$step_name"
