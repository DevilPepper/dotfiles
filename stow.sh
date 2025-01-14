#!/usr/bin/env bash

code_dir=~/code

main() {
    if [ $# -eq 0 ]; then
        DESTINATION=~
    else
        DESTINATION=$1
    fi

    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    for dir in $(ls -d $SCRIPT_DIR/*/);
    do
        buildTree ${dir%/}
    done

    cleanTree
    # # clone plugins if we have nvim
    # if [ ! -z $(which nvim) ]; then
    #   data_dir=~/.local/share/nvim/site
    #   repo_dir=$code_dir/nvim-plugins

    #   mkdir -p $data_dir
    #   rm -rf $repo_dir

    #   git clone --recurse-submodules https://github.com/DevilPepper/nvim-plugins.git $repo_dir
    #   ln -sf $repo_dir $data_dir/pack
    #   # vim -s <(echo ":helptags ALL" && echo ":q")
    # fi

    # # clone plugins if we have zsh
    # if [ ! -z $(which nvim) ]; then
    #   data_dir=~/.local/share/zsh
    #   repo_dir=$code_dir/zsh-plugins

    #   mkdir -p $data_dir
    #   rm -rf $repo_dir

    #   git clone --recurse-submodules https://github.com/DevilPepper/zsh-plugins.git $repo_dir
    #   ln -sf $repo_dir $data_dir/plugins
    # fi
}

function buildTree {
    local tree=$1
    for node in $(ls -A $tree);
    do
        local path=$tree/$node
        if [ -d "${path}" ]; then
            buildTree $path
        else
            mkdir -p $DESTINATION/${tree#$SCRIPT_DIR/*/}
            ln -sf $path $DESTINATION/${path#$SCRIPT_DIR/*/}
        fi
    done
}

function cleanTree {
  find $DESTINATION/.config -type l ! -exec [ -e {} ] \; -print | xargs -I{} rm {}
  find $DESTINATION/.local  -type l ! -exec [ -e {} ] \; -print | xargs -I{} rm {}
}

main "$@"
