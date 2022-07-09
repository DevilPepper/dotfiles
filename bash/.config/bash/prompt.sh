#!/bin/bash

reset_color=\\033\[00m

red=\\033\[0\;31m
blue=\\033\[0\;34m
green=\\033\[0\;32m
grey=\\033\[0\;30m

_lit(){
    local color=$1
    shift
    echo -e "\x01$color\x02"$*"\x01$reset_color\x02"
}

_prompt() {
  local color=
  case $(id -u) in
    0) color=$red ;;
    *) color=$green ;;
  esac

  echo -e "$(_lit $color $1) "
}

PS1='$(_prompt ✗)'
PS2='$(_prompt "-->>")'
