set FZF_BIND "--bind shift-up:preview-page-up,shift-down:preview-page-down,alt-up:preview-top,alt-down:preview-bottom"
set FZF_PREVIEW "--preview-window='right:75%' --preview 'bat --color=always {} 2> /dev/null || lsd -la {}'"
set -x FZF_DEFAULT_OPTS "--multi $FZF_BIND $FZF_PREVIEW"
set -x FZF_DEFAULT_COMMAND "fd --strip-cwd-prefix --hidden --exclude .git"

set -x GPG_TTY $(tty)
set -x VIRTUAL_ENV_DISABLE_PROMPT true

set -x HOSTNAME $HOSTNAME
set -x PATH $PATH:./node_modules/.bin
