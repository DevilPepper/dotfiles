#!/bin/bash
XDG_CACHE_HOME=~/.cache
XDG_CONFIG_HOME=~/.config
XDG_DATA_HOME=~/.local/share
XDG_STATE_HOME=~/.local/state

# Make sure these directories exist...
mkdir -p $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME

export ANSIBLE_HOME=$XDG_CONFIG_HOME/ansible
export DOTNET_CLI_HOME=$XDG_CACHE_HOME/dotnet
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export LESSHISTFILE=$XDG_STATE_HOME/less/history
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export N_PREFIX=$XDG_DATA_HOME/n
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export STACK_XDG=true

PATH=$PATH:~/.local/bin
PATH=$PATH:$N_PREFIX/bin

export PATH