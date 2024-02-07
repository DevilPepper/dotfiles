require('colorizer').setup {
    filetypes = {
        'css',
        html = { mode = 'foreground'; }
    },
    user_default_options = {
      css = true,
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = 'virtualtext',
      sass = { enable = true, parsers = { "css" }, },
      virtualtext = "󰬛󰬌󰬚󰬛Text",
      always_update = true,
    },
    buftypes = {
        '*'
    }
}
