set XDG_CACHE_HOME ~/.cache
set XDG_CONFIG_HOME ~/.config
set XDG_DATA_HOME ~/.local/share
set XDG_STATE_HOME ~/.local/state

# Make sure these directories exist...
mkdir -p $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME

set -x ANSIBLE_HOME $XDG_CONFIG_HOME/ansible
set -x DOTNET_CLI_HOME $XDG_CACHE_HOME/dotnet
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -x LESSHISTFILE $XDG_STATE_HOME/less/history
set -x N_PREFIX $XDG_DATA_HOME/n
set -x PYTHONPYCACHEPREFIX $XDG_CACHE_HOME/python
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -x STACK_XDG true

fish_add_path ~/.local/bin $N_PREFIX/bin

alias wget="command wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
