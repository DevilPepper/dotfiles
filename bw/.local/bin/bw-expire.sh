#!/usr/bin/env bash

tmp_dir="/tmp/${USER:-nobody}/bw"
session_file="$tmp_dir/session.gpg"

if [ ! -f "$session_file" ]; then
    bw lock
else
    last_session=$(stat --format '%X' "$session_file")
    now=$(date +%s)

    minutes_since_last_session=$(( (now - last_session) / 60 ))
    if (( minutes_since_last_session >= 5 )); then
        bw lock
    fi
fi
