#!/usr/bin/env bash

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  cat <<EOF
Use this script to resolve a github thread by id

Usage: gh-comment-resolve.sh <thread_id>
  e.g. gh-comment-resolve PRRT_xxx

Options:
  --help, -h    Show this help message
EOF
  exit 0
fi

threadId=$1

gh api graphql \
  -F threadId=$threadId \
  -f query='
    mutation($threadId:ID!) {
      resolveReviewThread(input: {threadId:$threadId}) {
        thread {
          isResolved
        }
      }
    }
  '
