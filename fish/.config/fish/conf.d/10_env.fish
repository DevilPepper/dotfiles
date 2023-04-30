set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x N_PREFIX ~/.local/share/n

fish_add_path ~/.local/bin $N_PREFIX/bin

set -x HOSTNAME $HOSTNAME
set -x PATH $PATH
