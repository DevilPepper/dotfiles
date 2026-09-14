#!/usr/bin/env bash

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  cat <<EOF
Use this script to read a comment, given it's ID

Usage: gh-comment-read.sh <comment_id>
  e.g. gh-comment-read.sh 1234567890

Options:
  --help, -h    Show this help message
EOF
  exit 0
fi

comment_id=$1

if body=$(gh api repos/{owner}/{repo}/pulls/comments/${comment_id} -q .body 2>/dev/null); then
  echo "$body"
elif body=$(gh api repos/{owner}/{repo}/issues/comments/${comment_id} -q .body 2>/dev/null); then
  echo "$body"
else
  pr=$(gh pr view --json number -q .number)
  gh api repos/{owner}/{repo}/pulls/${pr}/reviews/${comment_id} -q .body 2>/dev/null
fi
