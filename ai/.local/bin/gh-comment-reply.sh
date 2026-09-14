#!/usr/bin/env bash

# Use this script to reply to a comment given the comment_id and path to markdown file containing the reply body
comment_id=$1
reply_md=$2

pr=$(gh pr view --json number -q .number)
gh api -X POST repos/{owner}/{repo}/pulls/${pr}/comments/${comment_id}/replies -F body=@${reply_md}
