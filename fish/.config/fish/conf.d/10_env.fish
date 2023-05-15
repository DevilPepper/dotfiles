set FZF_BIND "--bind shift-up:preview-page-up,shift-down:preview-page-down,alt-up:preview-top,alt-down:preview-bottom"
set FZF_PREVIEW "--preview 'bat --color=always {} 2> /dev/null || lsd -la {}'"
set -x FZF_DEFAULT_OPTS "$FZF_BIND $FZF_PREVIEW"
set -x FZF_DEFAULT_COMMAND "fd --strip-cwd-prefix --hidden --exclude .git"

set -x VIRTUAL_ENV_DISABLE_PROMPT true
set -x N_PREFIX ~/.local/share/n

fish_add_path ~/.local/bin $N_PREFIX/bin

set -x HOSTNAME $HOSTNAME
set -x PATH $PATH:./node_modules/.bin
