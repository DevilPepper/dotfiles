#!/usr/bin/env bash

if [ -n "$ub_socket" ]; then
    command -v ueberzugpp > /dev/null 2>&1 && ueberzugpp cmd --socket $ub_socket --identifier lf --action remove
fi
