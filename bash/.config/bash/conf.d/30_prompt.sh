function starship_hr() {
    if [[ $? -ne 0 && $? -ne 130 ]]; then
        FAHHH=~/.local/share/fahhh.wav
        if [[ "$(uname)" == "Darwin" ]]; then
            (afplay $FAHHH &)
        elif command -v paplay &>/dev/null; then
            (paplay $FAHHH &)
        fi
        tput setaf 1
    else
        tput setaf 0
    fi
    echo $(printf %"$COLUMNS"s | tr " " "_")
    tput sgr0
}

# starship_precmd_user_func=starship_hr
