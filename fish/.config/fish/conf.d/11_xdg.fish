set XDG_CACHE_HOME ~/.cache
set XDG_CONFIG_HOME ~/.config
set XDG_DATA_HOME ~/.local/share
set XDG_STATE_HOME ~/.local/state

# Make sure these directories exist...
mkdir -p $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME

set -x ANSIBLE_HOME $XDG_CONFIG_HOME/ansible
set -x BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
set -x BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle
set -x BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x DOTNET_CLI_HOME $XDG_CACHE_HOME/dotnet
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x GOPATH $XDG_DATA_HOME/go
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -x LESSHISTFILE $XDG_STATE_HOME/less/history
set -x N_PREFIX $XDG_DATA_HOME/n
set -x NODE_REPL_HISTORY $XDG_STATE_HOME/history.js
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/.npmrc
set -x PYTHONPYCACHEPREFIX $XDG_CACHE_HOME/python
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -x RBENV_ROOT $XDG_DATA_HOME/rbenv
set -x R_ENVIRON_USER $XDG_CONFIG_HOME/R/.Renviron
set -x R_HISTFILE $XDG_STATE_HOME/history.r
set -x R_PROFILE_USER $XDG_CONFIG_HOME/R/.Rprofile
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x VAGRANT_HOME $XDG_DATA_HOME/vagrant
set -x STACK_XDG true

fish_add_path ~/.local/bin /usr/local/go/bin $CARGO_HOME/bin $N_PREFIX/bin

alias wget="command wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
