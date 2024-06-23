export GPG_TTY=$(tty)
export OPENER=run-mailcap

export JIRA_PAGER=bat
export VIRTUAL_ENV_DISABLE_PROMPT=true

export HOSTNAME

# Mac doesn't include this in the default PATH
PATH=$PATH:/usr/local/bin
PATH=$PATH:~/.local/bin
PATH=$PATH:./node_modules/.bin
export PATH
