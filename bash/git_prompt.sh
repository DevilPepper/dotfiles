# Adds the current branch to the bash prompt when the working directory is
# part of a Git repository. Includes color-coding and indicators to quickly
# indicate the status of working directory.
#
# To use: Copy into ~/.bashrc and tweak if desired.
#
# Based upon the following gists:
# <https://gist.github.com/henrik/31631>
# <https://gist.github.com/srguiwiz/de87bf6355717f0eede5>
# Modified by me, using ideas from comments on those gists.
#
# License: MIT, unless the authors of those two gists object :)

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(grep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(grep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(grep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(grep '^[U]|^.[U]' <<<"$status") ]] && output="$output|"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    echo $output
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

    echo -e $esc$style$color
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e " \x01$color\x02($branch)\x01\033[00m\x02"  # last bit resets color
    fi
}
