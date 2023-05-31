# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# dip if not interactive
[[ $- != *i* ]] && return

HISTIGNORE=clear:exit:history:?:??

# you might've copied the default .bashrc because it does some useful stuff.
# i.e. not_my_machine.bashrc does some things specifically useful for
# whatever work place you're in, so you can't just delete it
for bashrc in ~/*.bashrc
do
    if [ -e $bashrc ]; then
      source $bashrc
    fi
done

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=-1

# in case you load bash with default settings, this prevents the history from being truncated
HISTFILE=~/.local/state/bash_history.sh

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# sometimes, that^ doesn't work right
color_prompt=yes

if [ "$color_prompt" = yes ]; then
    source ~/.config/bash/prompt.sh
else
    PS1='\$ '
fi
unset color_prompt force_color_prompt

# append history every time the propmt is displayed
PROMPT_COMMAND="history -a; set_virtualenv; $PROMPT_COMMAND"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.optional ]; then
    source ~/.optional
fi
