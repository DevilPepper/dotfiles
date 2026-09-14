#!/usr/bin/env bash

if [[ -z "$CIRCLECI_PROJECT_SLUG" || -z "$circle_token" || -z "$git_branch" || -z "$git_branch_urlencoded" || -z "$git_revision" || -z "$git_message" ]]; then
  echo "Don't run this script directly. Instead run \`circle\`" >&2
  exit 1
fi

verbose=""
if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
  verbose="true"
fi

function status_symbol() {
  status="$1"
  if [[ $status == "failed" || $status == "failing" ]]; then
    echo '{{ Color "1" "✗" }}'
  elif [[ $status == "on_hold" ]]; then
    echo '{{ Color "5" "⏸" }}'
  elif [[ $status == "success" ]]; then
    echo '{{ Color "2" "✔" }}'
  elif [[ $status == "running" ]]; then
    echo '{{ Color "3" "⧗" }}'
  elif [[ $status == "blocked" ]]; then
    echo '{{ Color "7" "⏹" }}'
  elif [[ $status == "canceled" ]]; then
    echo '{{ Color "7" "-" }}'
  else
    # "error"
    # "not_run" "unauthorized" "retried" "queued" "not_running" "infrastructure_fail" "timedout" "terminated-unknown" "blocked"
    echo '{{ Color "7" "?" }}'
  fi
}

echo "### ${git_branch} | ${git_message}" | gum format

curl --fail --silent --show-error --location \
  --header "Circle-Token: ${circle_token}" \
  --url "https://circleci.com/api/v2/project/${CIRCLECI_PROJECT_SLUG}/pipeline?branch=${git_branch_urlencoded}" \
| jq --arg revision "$git_revision" -c '.items | map(select(.vcs.revision == $revision))[]' \
| while read -r pipeline; do
  pipeline_id=$(echo "$pipeline" | jq -r '.id')
  pipeline_number=$(echo "$pipeline" | jq -r '.number')
  pipeline_timestamp=$(echo "$pipeline" | jq -r '.updated_at')
  pipeline_timestamp=$(uv run python -c "from datetime import datetime; print(datetime.fromisoformat('${pipeline_timestamp}').astimezone().strftime('%b %d %I:%M%p'))" 2> /dev/null)
  pipeline_url="https://app.circleci.com/pipelines/${CIRCLECI_PROJECT_SLUG}/${pipeline_number}"
  echo -e "##### Pipeline# ${pipeline_number} [${pipeline_timestamp}]\n<${pipeline_url}>" | gum format

  curl --fail --silent --show-error --location \
  --header "Circle-Token: ${circle_token}" \
  --url "https://circleci.com/api/v2/pipeline/${pipeline_id}/workflow" \
  | jq -c '.items | unique_by(.name)[]' \
  | while read -r workflow; do
    workflow_id=$(echo "$workflow" | jq -r '.id')
    workflow_name=$(echo "$workflow" | jq -r '.name')
    workflow_status=$(echo "$workflow" | jq -r '.status')
    workflow_url="${pipeline_url}/workflows/${workflow_id}"
    display_url=""
    if [[ "$workflow_status" == "failed" || "$workflow_status" == "failing" || "$workflow_status" == "on_hold" ]]; then
      display_url=" {{ Underline (Color \"4\" \"${workflow_url}\") }}"
    fi
    echo "{{ \"  \" }}$(status_symbol $workflow_status) {{ Bold \"${workflow_name}\" }}${display_url}{{ \"\n\" }}" | gum format -t template

    curl --fail --silent --show-error --location \
      --header "Circle-Token: ${circle_token}" \
      --url "https://circleci.com/api/v2/workflow/${workflow_id}/job" \
    | jq -c 'def status_order: ["failed","on_hold","success","running","blocked","canceled"];
              .items | sort_by(.status as $s | (status_order | index($s) // 9001))[]' \
    | while read -r job; do
      job_number=$(echo "$job" | jq -r '.job_number')
      job_name=$(echo "$job" | jq -r '.name')
      job_status=$(echo "$job" | jq -r '.status')
      job_url="${workflow_url}/jobs/${job_number}"
      display_duration=""
      if [[ "$job_status" == "failed" || "$job_status" == "success" || "$job_status" == "running" ]]; then
        job_start=$(echo "$job" | jq -r '.started_at // empty')
        if [[ -n "job_start" ]]; then
          job_end=$(echo "$job" | jq -r '.stopped_at // empty')
          display_duration=$( \
            uv run python -c \
            "from datetime import datetime, timedelta, UTC; td = (datetime.fromisoformat('${job_end}') if '${job_end}' else datetime.now(tz=UTC)) - datetime.fromisoformat('${job_start}'); print(timedelta(seconds=int(td.total_seconds())))" \
          )
          display_duration=" {{ Italic (Color \"0\" \"${display_duration}\") }}"
        fi
      fi
      display_url=""
      if [[ "$job_status" == "failed" ]]; then
        display_url=" {{ Underline (Color \"4\" \"${job_url}\") }}"
      fi
      echo "{{ \"    \" }}$(status_symbol $job_status)${display_duration} ${job_name}${display_url}{{ \"\n\" }}" | gum format -t template
      if [[ "$job_status" == "failed" ]]; then
        curl --fail --silent --show-error --location \
          --header "Circle-Token: ${circle_token}" \
          --url "https://circleci.com/api/v1.1/project/${CIRCLECI_PROJECT_SLUG}/${job_number}" \
        | jq -c '.steps[]' \
        | while read -r step; do
          step_name=$(echo "$step" | jq -r '.name')
          step_status=$( \
            echo "$step" \
            | jq -r 'def status_order: ["failed","on_hold","running","blocked","canceled","success"];
                      .actions | sort_by(.status as $s | (status_order | index($s) // 9001))[0].status' \
          )
          if [[ "$step_status" == "failed" || -n "$verbose" ]]; then
            echo "{{ \"        \" }}$(status_symbol $step_status) ${step_name}{{ \"\n\" }}" | gum format -t template

            if [[ "$step_status" == "failed" ]]; then
              echo "---" | gum format
              echo "$step" \
              | jq -r '.actions[0].bash_command'\
              | bat --color=always --language=sh
              echo "---" | gum format
            fi

            echo "$step" \
            | jq -c '.actions[]' \
            | while read -r action; do
              action_status=$(echo "$action" | jq -r '.status')
              if [[ "$action_status" == "failed" ]]; then
                output_url=$(echo $action | jq -r '.output_url')
                curl --fail --silent --show-error --location \
                  --header "Circle-Token: ${circle_token}" \
                  --url "$output_url" \
                | jq -r ".[].message"
                echo "---" | gum format
              fi
            done
          fi
        done
      fi
    done
  done
done
