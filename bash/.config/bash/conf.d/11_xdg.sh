XDG_CACHE_HOME=~/.cache
XDG_CONFIG_HOME=~/.config
XDG_DATA_HOME=~/.local/share
XDG_STATE_HOME=~/.local/state

# Make sure these directories exist...
mkdir -p $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME

export ANDROID_HOME=$XDG_DATA_HOME/android/sdk
export ANDROID_USER_HOME=$XDG_DATA_HOME/android/user
export ANSIBLE_HOME=$XDG_CONFIG_HOME/ansible
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle
export CARGO_HOME=$XDG_DATA_HOME/cargo
export DOTNET_CLI_HOME=$XDG_CACHE_HOME/dotnet
export GOPATH=$XDG_DATA_HOME/go
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export INPUTRC=$XDG_CONFIG_HOME/readline/inputrc
export IRBRC=$XDG_CONFIG_HOME/irb/config.rb
export LESSHISTFILE=$XDG_STATE_HOME/less/history
export N_PREFIX=$XDG_DATA_HOME/n
export NODE_REPL_HISTORY=$XDG_STATE_HOME/history.js
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/.npmrc
export PIPX_HOME=$XDG_DATA_HOME/pipx
export PIPX_BIN_DIR=$PIPX_HOME/bin
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export PYTHON_HISTORY=$XDG_STATE_HOME/history.py
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
export RBENV_ROOT=$XDG_DATA_HOME/rbenv
export R_ENVIRON_USER=$XDG_CONFIG_HOME/R/.Renviron
export R_HISTFILE=$XDG_STATE_HOME/history.r
export R_PROFILE_USER=$XDG_CONFIG_HOME/R/.Rprofile
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export UV_PYTHON_BIN_DIR=$XDG_DATA_HOME/uv/bin
export UV_TOOL_BIN_DIR=$UV_PYTHON_BIN_DIR
export VAGRANT_HOME=$XDG_DATA_HOME/vagrant
export STACK_XDG=true

PATH=/usr/local/go/bin:$PATH
PATH=$CARGO_HOME/bin:$PATH
PATH=$N_PREFIX/bin:$PATH
PATH=$PYENV_ROOT/shims:$PATH
PATH=$PIPX_BIN_DIR:$PATH
PATH=$UV_TOOL_BIN_DIR:$PATH
PATH=$XDG_DATA_HOME/gem/ruby/current/bin:$PATH
PATH=$PATH:$ANDROID_HOME/cmdline-tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

export PATH

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
# alias adb="HOME=$ANDROID_HOME adb"
