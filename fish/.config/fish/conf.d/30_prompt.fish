function starship_hr
    if test $status -ne 0
        set_color red
    else
        set_color brblack
    end
    echo $(printf %"$COLUMNS"s | tr " " "_")
    set_color normal
end

starship init fish | source

functions -c fish_prompt starfish_prompt

function fish_prompt
    starship_hr
    starfish_prompt
end
