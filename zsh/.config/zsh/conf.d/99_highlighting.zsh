# How to tweak: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
zsh_syntax_highlighting_path=~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -e $zsh_syntax_highlighting_path ]; then
    source $zsh_syntax_highlighting_path
    ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

    typeset -A ZSH_HIGHLIGHT_STYLES

    ########
    # main #
    ########
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,underline'
    ZSH_HIGHLIGHT_STYLES[global-alias]='fg=blue,bold'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=black,bold'
    # ZSH_HIGHLIGHT_STYLES[hashed-command]=''
    # ZSH_HIGHLIGHT_STYLES[autodirectory]=''
    ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
    # ZSH_HIGHLIGHT_STYLES[path_pathseparator]=''
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan,underline'
    # ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=''
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=cyan'
    # ZSH_HIGHLIGHT_STYLES[command-substitution]=''
    # ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]=''
    # ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]=''
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=black,bold'
    # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]=''
    # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]=''
    # ZSH_HIGHLIGHT_STYLES[process-substitution]=''
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=black,bold'
    ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
    # ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=''
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=red'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=black,bold'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red'
    # ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=''
    # ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]=''
    # ZSH_HIGHLIGHT_STYLES[rc-quote]=''
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=white'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=black,bold'
    # ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=''
    # ZSH_HIGHLIGHT_STYLES[assign]=''
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=green'
    ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
    # ZSH_HIGHLIGHT_STYLES[elided-parameter]=''
    ZSH_HIGHLIGHT_STYLES[named-fd]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[arg0]='fg=white,bold'
    ZSH_HIGHLIGHT_STYLES[default]='fg=white'


    ############
    # brackets #
    ############
    ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red'
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='underline'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#656c72'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#767573'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#84898d'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#949492'
fi
