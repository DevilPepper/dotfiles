#!/usr/bin/env bash

set -e

known_hosts="$1"
host="$2"
url="$3"

diff --color=always \
  <(cat $known_hosts | grep "$host") \
  <(\
    curl -Ls $url \
    | sed 's/<script.*<\/script>//g' \
    | grep -Eo "$host (ssh-rsa|ecdsa-sha2-nistp256|ssh-ed25519).*" \
    | sort \
  )
