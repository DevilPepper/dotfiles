#!/usr/bin/env bash

# Use this script to read a comment, given it's ID
comment_id=$1

if body=$(gh api repos/{owner}/{repo}/pulls/comments/${comment_id} -q .body 2>/dev/null); then
  echo "$body"
elif body=$(gh api repos/{owner}/{repo}/issues/comments/${comment_id} -q .body 2>/dev/null); then
  echo "$body"
else
  pr=$(gh pr view --json number -q .number)
  gh api repos/{owner}/{repo}/pulls/${pr}/reviews/${comment_id} -q .body 2>/dev/null
fi
