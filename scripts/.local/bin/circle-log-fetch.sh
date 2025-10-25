#!/usr/bin/env bash

function main() {
  steps_file="$1"
  step_name="$2"

  cache=""
  if command -v bkt &> /dev/null; then
    cache="bkt --ttl=30m --stale=1m --"
  fi

  cat $steps_file \
  | filter-json name "$step_name" \
  | jq -r '.[].actions[].output_url' \
  | while read -r output_url; do
    $cache bash -c "$GET_CIRCLECI_LOGS; get_circleci_logs '$output_url'"
  done
}

function get_circleci_logs() {
  output_url="$1"

  curl --fail --silent --show-error --location \
    --header "Circle-Token: ${circle_token}" \
    --url "$output_url" \
  | jq -r ".[].message"
}
# export -f get_circleci_logs
export GET_CIRCLECI_LOGS="$(declare -f get_circleci_logs)"

main "$@"
