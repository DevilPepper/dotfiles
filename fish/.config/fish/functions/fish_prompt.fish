function fish_prompt
    set -l symbol " ✗"
    if test -n "$VIRTUAL_ENV"
        set symbol 🐍
    end

    set -l color green
    if fish_is_root_user
        set -l color red
    end

    set_color $color
    echo -n "$symbol "
    set_color normal
end
