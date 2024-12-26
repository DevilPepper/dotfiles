export GPG_TTY=$(tty)
export OPENER=run-mailcap
export PAGER=bat
export EDITOR=nvim
export VISUAL=nvim

export JIRA_PAGER=bat
export VIRTUAL_ENV_DISABLE_PROMPT=true

export HOSTNAME

# Mac doesn't include these in the default PATH and homebrew x86_64 installs in /usr/local/bin
PATH=$PATH:/usr/local/bin
PATH=/opt/homebrew/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=$PATH:./node_modules/.bin
PATH=$PATH:./.venv/bin
export PATH
