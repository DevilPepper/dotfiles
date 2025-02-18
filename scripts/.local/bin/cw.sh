#!/usr/bin/env bash

export CODE_DIR=~/code
export reset_color=$(printf '\033[0m')

function repo_preview() {
    repo_path="$CODE_DIR/$1"
    git -C $repo_path is-repo && {
        git -c color.status=always -C $repo_path status
    } || {
        lsd -la $repo_path
    }
}
# export -f repo_preview
REPO_PREVIEW="$(declare -f repo_preview)"

git_status() {
    git -C $repo_path is-repo && {
        local repo_path=$1
        # Outputs a series of indicators based on the status of the
        # working directory:
        # + changes are staged and ready to commit
        # ! unstaged changes are present
        # ? untracked files are present
        # S changes have been stashed
        # P local commits need to be pushed to the remote
        local status="$(git -C $repo_path status --porcelain 2>/dev/null)"
        local output=''
        [[ -n $(grep '^[MADRC]' <<<"$status") ]] && output="$output+"
        [[ -n $(grep '^.[MD]' <<<"$status") ]] && output="$output!"
        [[ -n $(grep '^\?\?' <<<"$status") ]] && output="$output?"
        [[ -n $(grep '^[U]|^.[U]' <<<"$status") ]] && output="$output|"
        [[ -n $(git -C $repo_path stash list) ]] && output="${output}S"
        [[ -n $(git -C $repo_path log --branches --not --remotes) ]] && output="${output}P"
        echo $output
    }
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ ! ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    local unmerged=$([[ $1 =~ \| ]] && echo yes)
    local notstaged=$([[ $1 =~ \? ]] && echo yes)

    local esc=\\033\[
    local style=0\;
    local color=37m


    if [[ -n $notstaged ]]; then #italics
        style=3\;
    fi

    if [[ -n $unmerged ]]; then
        color=33m  # yellow
    elif [[ -n $dirty ]]; then
        color=31m   # red
    elif [[ -n $staged ]]; then
        color=32m   # green
    elif [[ -n $needs_push ]]; then
        color=96m  # blue
    fi

    printf "$esc$style$color"
}

get_repos() {
    for repo_path in $(ls -d $CODE_DIR/*/* );
    do
        local owner=$(basename $(dirname $repo_path))
        local repo=$(basename $repo_path)

        local state=$(git_status $repo_path)
        local color=$(git_color $state)

        echo -e "${color}${owner}/${repo}${reset_color}"
    done
}

choices=$(get_repos)
choice=$(echo -e "$choices" \
    | fzf --ansi \
          --preview="$REPO_PREVIEW; repo_preview {}" \
          --preview-window='right:75%:wrap' \
)

if [ -z "$choice" ]; then
    pwd
else
    echo "$CODE_DIR/$choice"
fi
