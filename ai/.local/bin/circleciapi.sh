#!/usr/bin/env bash

# Use this script to hit CircleCI endpoints (i.e. to look at job logs)
# See: https://circleci.com/docs/api/v2/llms.txt
# OpenAPI: https://circleci.com/docs/api/v2/openapi.json

curl --fail --silent --show-error --location \
     --header "Circle-Token: $(keyring get circleci Circle-Token)" \
     --url "https://circleci.com/api$1"
