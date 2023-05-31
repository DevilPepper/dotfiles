#!/bin/sh

rm -f ~/.xsession-errors
xrdb -merge ~/.config/X11/xresources

system_wallpapers=/usr/share/backgrounds/wallpapers/
user_wallpapers=~/Pictures/wallpapers/
window_manager=~/.local/bin/xmonad-x86_64-linux

command -v feh > /dev/null 2>&1 \
  && feh --no-fehbg \
         --bg-scale \
         --randomize \
         --recursive \
         -- $system_wallpapers $user_wallpapers &

test -f $window_manager && exec $window_manager
