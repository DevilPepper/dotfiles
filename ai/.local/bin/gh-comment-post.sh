#!/usr/bin/env bash

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  cat <<EOF
Use this script to post an inline comment given the file path, line number and path to markdown file containing the comment body

Usage: gh-comment-post.sh <file_path> <file_line> <comment_md> [options]
  e.g. gh-comment-post.sh src/main.rs 42 /tmp/vibecode/TIX-123/comment.md
  e.g. gh-comment-post.sh src/main.rs 42 /tmp/vibecode/TIX-123/comment.md --side LEFT
  e.g. gh-comment-post.sh src/main.rs 42 /tmp/vibecode/TIX-123/comment.md --start-line 40 --start-side LEFT

Options:
  --side <RIGHT|LEFT>       Comment side (default: RIGHT for addition/unchanged, LEFT for deletion)
  --start-line <number>     Start line for multi-line review comment
  --start-side <RIGHT|LEFT> Same as --side but for the start line
  --help, -h                Show this help message
EOF
  exit 0
fi

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
