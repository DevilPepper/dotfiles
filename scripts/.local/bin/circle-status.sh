#!/usr/bin/env bash

if [[ -z "$CIRCLECI_PROJECT_SLUG" || -z "$circle_token" || -z "$git_branch" || -z "$git_revision" ]]; then
  echo "Don't run this script directly. Instead run \`circle\`" >&2
  exit 1
fi
