#!/usr/bin/env bash

if [[ $# -eq 0 || "$1" == "--help" || "$1" == "-h" ]]; then
  cat <<EOF
Use this script to hit CircleCI endpoints (i.e. to look at job logs)
See: https://circleci.com/docs/api/v2/llms.txt
OpenAPI: https://circleci.com/docs/api/v2/openapi.json

Usage: circleciapi.sh <endpoint_path>
  e.g. circleciapi.sh /v2/project/github/{owner}/{repo}/pipeline?branch={url_encoded_branch_name}
  e.g. circleciapi.sh /v2/project/github/{owner}/{repo}/workflow/{workflow_id}

Options:
  --help, -h    Show this help message
EOF
  exit 0
fi

curl --fail --silent --show-error --location \
     --header "Circle-Token: $(keyring get circleci Circle-Token)" \
     --url "https://circleci.com/api$1"
