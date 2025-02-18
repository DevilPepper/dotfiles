#!/usr/bin/env bash
set -e

code_path=~/code
zsh_completions_path=~/.local/share/zsh/completions
bash_completions_path=~/.local/share/bash-completion/completions

function main() {
    repos=( \
        "nvim-plugins" \
        "zsh-plugins" \
    )
    repos=($(gum choose "${repos[@]}" --header "What repos do you want to fetch?" --no-limit))

    use_ssh=false
    if [[ ${#repos[@]} -ne 0 ]]; then
        gum confirm "Use ssh?" && use_ssh=true || use_ssh=false
    fi

    completions=( \
        "git" \
        "gcloud" \
    )
    completions=($(gum choose "${completions[@]}" --header "What completions do you need?" --no-limit))

    # spinner "Cloning repos..." symlink_repos "${use_ssh}" "${repos[@]}"
    # spinner "Setting up completions..." get_completions "${completions[@]}"

    symlink_repos "${use_ssh}" "${repos[@]}"
    get_completions "${completions[@]}"
    linux_stuff
    mac_stuff
    purge_dead_links
}

function get_completions() {
    local completions=("$@")

    if [[ ${#completions[@]} -ne 0 ]]; then
        mkdir -p $bash_completions_path
        mkdir -p $zsh_completions_path

        if $(array_contains_string "git" "${completions[@]}"); then
            repo_raw="https://raw.githubusercontent.com/git/git/master"
            curl -o $bash_completions_path/git "$repo_raw/contrib/completion/git-completion.bash"
            curl -o $zsh_completions_path/_git "$repo_raw/contrib/completion/git-completion.zsh"
        fi

        if $(array_contains_string "gcloud" "${completions[@]}"); then
            echo "(gcloud completion) Not yet implemented..." 1>&2
        fi

        rm -f "${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump"
    fi
}

function symlink_repos() {
    local use_ssh="$1"
    shift
    local repos=("$@")

    if $(array_contains_string "zsh-plugins" "${repos[@]}"); then
        symlink_repo "DevilPepper/zsh-plugins" ~/.local/share/zsh/plugins "${use_ssh}"
    fi

    # Do this one last because it's big
    if $(array_contains_string "nvim-plugins" "${repos[@]}"); then
        symlink_repo "DevilPepper/nvim-plugins" ~/.local/share/nvim/site/pack "${use_ssh}"
        if [ ! -z $(which nvim) ]; then
            if [[ "$(uname)" == "Darwin" ]]; then
                # Mac version explodes and idgaf
                echo 'Run `:helptags ALL` in nvim if you want them'
            else
                nvim -s <(echo ":helptags ALL" && echo ":q")
            fi
        else
            echo "Didn't generate helptags because nvim is not installed" 1>&2
        fi
    fi
}

function symlink_repo() {
    local owner_repo="$1"
    local link_path="$2"
    local use_ssh="$3"

    repo_path="$code_path/$owner_repo"
    repo_parent=$(dirname "$repo_path")
    link_parent=$(dirname "$link_path")
    repo_url="https://github.com/${owner_repo}.git"
    if [ "$use_ssh" = true ]; then
        repo_url="git@github.com:${owner_repo}.git"
    fi

    mkdir -p $link_parent
    mkdir -p $repo_parent
    rm -rf $repo_path
    rm -rf $link_path

    git clone --recurse-submodules $repo_url $repo_path
    ln -sf $repo_path $link_path
}

function array_contains_string() {
    local search_string="$1"
    shift
    local arr=("$@")
    local found=false

    for item in "${arr[@]}"; do
        if [[ "$item" == "$search_string" ]]; then
            found=true
            break
        fi
    done

    echo $found
}

function purge_dead_links() {
    find ~/.config ~/.local -type l | while read -r symlink; do
        if [ ! -e "$symlink" ]; then
            echo "Removing deadlink: $symlink"
            rm "$symlink"
        fi
    done
}

function linux_stuff() {
    if [[ "$(uname)" == "Linux" ]]; then
        find ~/.config/systemd/user -mindepth 2 -type l | while read -r symlink; do
            if [ ! -e "$symlink" ]; then
                unit_name=$(basename "$symlink")
                echo "Disabling broken unit: $unit_name"
                systemctl --user disable "$unit_name"
                rm -rf "$symlink"
            fi
        done

        systemctl --user daemon-reload
        systemctl --user list-unit-files --state=enabled | grep enabled | awk '{print $1}' | while read -r unit; do
            if [ -f "$HOME/.config/systemd/user/$unit" ]; then
                systemctl --user restart "$unit"
            fi
        done
    fi
}

function mac_stuff() {
    if [[ "$(uname)" == "Darwin" ]]; then
        # TODO: symlink Amethyst layout and config
        brew completions link
        find ~/Library/LaunchAgents -type l -name 'dev.dotfiles.*.plist' | while read -r symlink; do
            if [ ! -e "$symlink" ]; then
                echo "Removing dead link: $symlink"
                rm "$symlink"
            else
                launchctl bootout gui/$(id -u) "$symlink" 2> /dev/null || true
                launchctl bootstrap gui/$(id -u) "$symlink"
            fi
        done
    fi
}

# function spinner() {
#     local title="$1"
#     local func="$2"
#     shift 2

#     set +o monitor
#     gum spin --title="$title" -- sleep infinity &
#     spinner_pid=$!

#     $func "$@"

#     kill $spinner_pid
#     set -o monitor
# }

main
