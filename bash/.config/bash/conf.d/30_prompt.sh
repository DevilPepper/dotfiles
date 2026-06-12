function starship_hr() {
    if [[ $? -ne 0 ]]; then
        tput setaf 1
    else
        tput setaf 0
    fi
    echo $(printf %"$COLUMNS"s | tr " " "_")
    tput sgr0
}

# starship_precmd_user_func=starship_hr
