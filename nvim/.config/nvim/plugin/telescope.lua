require('telescope').setup {
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = 0.66,
        },
        file_ignore_patterns = { '.git' },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        live_grep = {
            additional_args = function(_)
                return { "--hidden" }
            end
        },
    },
}
