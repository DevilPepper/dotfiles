#!/bin/bash

# if [ -z "$TZ" ]; then
#     timelink=$(readlink /etc/localtime)
#     timefile="${timelink##*/}"
#     timepath="${timelink%/*}"
#     export TZ="${timepath##*/}/$timefile"
# fi

# export TZ=$(curl -s http://geoip.ubuntu.com/lookup | grep -Eo '<TimeZone>[^<]+' | cut -d'>' -f2)

TZ_FILE=~/.timezone
if [ -f "$TZ_FILE" ]; then
  export TZ=$(cat $TZ_FILE)
fi

# for d in /opt/*/bin; do PATH="$PATH:$d"; done

# PATH=$PATH:/opt/google/chrome/driver/

# PATH=$PATH:./node_modules/.bin

# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/i386-gnu
# LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/i386-linux-gnu

# export QUARTUS_64BIT=1
# export LD_LIBRARY_PATH
# export public=/media/sf_Public
# export BROWSER="google-chrome"
