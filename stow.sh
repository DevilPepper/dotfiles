#!/usr/bin/env bash

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

    # clone plugins if we have vim
    if [ ! -z $(which vim) ]; then
      vim_data=~/.local/share/vim
      mkdir -p $vim_data
      rm -rf $vim_data/pack
      git clone --recurse-submodules https://github.com/DevilPepper/vim-plugins.git $vim_data/pack
      vim -s <(echo ":helptags ALL" && echo ":q")
    fi
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

main "$@"
