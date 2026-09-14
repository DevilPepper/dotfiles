#!/usr/bin/env bash

# Use this script to post an inline comment given the file path, line number and path to markdown file containing the reply body
# optional options (only use after positional args):
# --side by default this is RIGHT for addition/unchanged line. Can be LEFT for deletion line
# --start-line if used, this is the start of your multi-line review comment
# --start-side same as --side but for the start line

file_path=$1
file_line=$2
comment_md=$3
shift 3

side="RIGHT"
start_line=""
start_side=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --side=*)
      side="${1#*=}"
      shift
      ;;
    --side)
      side="$2"
      shift 2
      ;;
    --start-line=*)
      start_line="${1#*=}"
      shift
      ;;
    --start-line)
      start_line="$2"
      shift 2
      ;;
    --start-side=*)
      start_side="${1#*=}"
      shift
      ;;
    --start-side)
      start_side="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

pr=$(gh pr view --json number -q .number)
commit=$(git rev-parse HEAD)

start_params=""
if [[ -n "${start_line}" ]]; then
  start_params+="-F start_line=${start_line} "
fi
if [[ -n "${start_side}" ]]; then
  start_params+="-f start_side=${start_side} "
fi

gh api -X POST repos/{owner}/{repo}/pulls/${pr}/comments $start_params \
  -f commit_id="${commit}" \
  -f path="${file_path}" \
  -F line=${file_line} \
  -f side=${side} \
  -F body=@${comment_md}
