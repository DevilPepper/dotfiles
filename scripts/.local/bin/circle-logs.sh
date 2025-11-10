#!/usr/bin/env bash

if [[ -z "$CIRCLECI_PROJECT_SLUG" || -z "$circle_token" || -z "$git_branch" || -z "$git_revision" ]]; then
  echo "Don't run this script directly. Instead run \`circle\`" >&2
  exit 1
fi

function main() {
  if [[ "$1" == "logs" ]]; then
    job_name="$2"
    step_name="$3"
  fi

  # TODO: add support for tag pipelines (CircleCI API should have tag and revision query params)
  pipeline=$( \
    curl --fail --silent --show-error --location \
      --header "Circle-Token: ${circle_token}" \
      --url "https://circleci.com/api/v2/project/${CIRCLECI_PROJECT_SLUG}/pipeline?branch=${git_branch}" \
    | jq --arg revision "$git_revision" \
         --arg trigger "${CIRCLECI_PIPELINE_TRIGGER:-webhook}" \
         '.items | map(select(.vcs.revision == $revision)) | map(select(.trigger.type == $trigger)) | .[0]' \
  )

  pipeline_id=$(echo "$pipeline" | jq -r '.id')
  pipeline_number=$(echo "$pipeline" | jq -r '.number')

  workflow_name="${CIRCLECI_WORKFLOW_NAME:-main}"
  workflow=$( \
    curl --fail --silent --show-error --location \
      --header "Circle-Token: ${circle_token}" \
      --url "https://circleci.com/api/v2/pipeline/${pipeline_id}/workflow" \
    | jq --arg workflow_name "$workflow_name" '.items | map(select(.name == $workflow_name)) | .[0]' \
  )

  if [[ "$workflow" == "null" ]]; then
    echo "Workflow '${workflow_name}' not found for this pipeline" >&2
    exit 1
  fi

  workflow_id=$(echo "$workflow" | jq -r '.id')
  circleci_ui="https://app.circleci.com/pipelines/${CIRCLECI_PROJECT_SLUG}/${pipeline_number}/workflows/${workflow_id}"

  selected_job=$(get_a_job "$workflow_id" "$job_name")

  if [[ -z "$selected_job" ]]; then
    echo "$circleci_ui"
    exit 0
  fi

  job_number=$(echo "$selected_job" | cut -d' ' -f1)
  job_name=$(echo "$selected_job" | cut -d' ' -f2-)
  circleci_ui="${circleci_ui}/jobs/${job_number}"
  steps_file=$(mktemp)

  step_name=$(get_step "$job_number" "$steps_file" "$step_name")

  if [[ -z "$step_name" ]]; then
    echo "$circleci_ui"
    exit 0
  fi

  if [[ -n "$3" ]]; then
    circle-log-fetch.sh "$steps_file" "$step_name"
  else
    echo "You can go straight to these logs with:"
    echo "circle logs '$job_name' '$step_name'"
    circle-log-fetch.sh "$steps_file" "$step_name" | less -R
  fi
}

function get_a_job() {
  workflow_id="$1"
  job_name="$2"

  jobs=$( \
    curl --fail --silent --show-error --location \
      --header "Circle-Token: ${circle_token}" \
      --url "https://circleci.com/api/v2/workflow/${workflow_id}/job" \
    | jq '.items' \
  )

  if [[ -z "$job_name" ]]; then
    job_name=$( \
      echo "$jobs" \
      | jq -r '.[].name' \
      | gum choose --header "What job do you want to see?" \
    )
  fi

  if [[ -n "$job_name" ]]; then
    job_number=$( \
      echo "$jobs" \
      | jq -r --arg job_name "$job_name" 'map(select(.name == $job_name)) | .[0].job_number' \
    )
    echo "$job_number $job_name"
  fi
}

function get_step() {
  job_number="$1"
  steps_file="$2"
  step_name="$3"

  curl --fail --silent --show-error --location \
    --header "Circle-Token: ${circle_token}" \
    --url "https://circleci.com/api/v1.1/project/${CIRCLECI_PROJECT_SLUG}/${job_number}" \
  | jq '.steps' \
  > $steps_file

  if [[ -z "$step_name" ]]; then
    cat $steps_file \
    | jq -r '.[].name' \
    | fzf --ansi \
          --delimiter='\x01' \
          --preview="circle-log-preview.sh $steps_file {}"
  else
    echo "$step_name"
  fi
}

main "$@"
