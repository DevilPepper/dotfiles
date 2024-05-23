#!/usr/bin/env bash

filename="$1"
width=${2:-60}
height=${3:-40}
X=${4:-40}
Y=${5:-40}

mime_type=$(file --dereference --brief --mime-type "$filename")

case "$mime_type" in
  image/*) {
    image-print "lf" "$mime_type" "$filename" $X $Y $width $height
    exit 1
  } ;;
  *) print "$filename" ;;
esac
