FZF_BIND_FOCUS="--bind 'focus:transform-preview-label:echo [ {} ]'"
FZF_BIND_KEYS="--bind shift-up:preview-page-up,shift-down:preview-page-down,alt-up:preview-top,alt-down:preview-bottom"
FZF_PREVIEW="--preview-window='right:75%' --preview 'bat --color=always {} 2> /dev/null || lsd -la {}'"
export FZF_DEFAULT_OPTS="--multi $FZF_BIND_KEYS $FZF_BIND_FOCUS $FZF_PREVIEW"
export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git"

export GPG_TTY=$(tty)
export OPENER=run-mailcap

export JIRA_PAGER=bat
export VIRTUAL_ENV_DISABLE_PROMPT=true

export HOSTNAME

PATH=$PATH:./node_modules/.bin
export PATH
