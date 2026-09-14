#!/usr/bin/env bash

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  cat <<EOF
Use this script to reply to a comment given the comment_id and path to markdown file containing the reply body

Usage: gh-comment-reply.sh <comment_id> <reply_md>
  e.g. gh-comment-reply.sh 1234567890 /tmp/vibecode/TIX-123/reply.md

Options:
  --help, -h    Show this help message
EOF
  exit 0
fi

comment_id=$1
reply_md=$2

pr=$(gh pr view --json number -q .number)
gh api -X POST repos/{owner}/{repo}/pulls/${pr}/comments/${comment_id}/replies -F body=@${reply_md}
