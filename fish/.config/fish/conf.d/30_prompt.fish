function starship_hr
    set_color brblack
    echo -n $(printf %"$COLUMNS"s | tr " " "_")
    set_color normal
end

starship init fish | source

functions -c fish_prompt starfish_prompt

function fish_prompt
    starship_hr
    starfish_prompt
end
