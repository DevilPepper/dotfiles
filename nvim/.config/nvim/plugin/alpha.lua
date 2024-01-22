local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

ascii = 'NeoVim'
header_path = string.format('%s/.local/share/ascii/%s.txt', os.getenv('HOME'), ascii)
dashboard.section.header.val = read_file(header_path)

vim.cmd 'highlight BlueHLGroup ctermfg=blue guifg=blue'
vim.cmd 'highlight GreenHLGroup ctermfg=green guifg=green'

dashboard.section.header.opts.hl = {
	{{ "BlueHLGroup", 0, 47 }, { "GreenHLGroup", 47, 99 }},
	{{ "BlueHLGroup", 0, 48 }, { "GreenHLGroup", 48, 99 }},
	{{ "BlueHLGroup", 0, 49 }, { "GreenHLGroup", 49, 99 }},
	{{ "BlueHLGroup", 0, 50 }, { "GreenHLGroup", 50, 99 }},
	{{ "BlueHLGroup", 0, 51 }, { "GreenHLGroup", 51, 99 }},
	{{ "BlueHLGroup", 0, 52 }, { "GreenHLGroup", 52, 99 }},
	{{ "BlueHLGroup", 0, 53 }, { "GreenHLGroup", 53, 99 }},
	{{ "BlueHLGroup", 0, 54 }, { "GreenHLGroup", 54, 99 }},
	{{ "BlueHLGroup", 0, 55 }, { "GreenHLGroup", 55, 99 }},
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/<CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

autocmd("FileType", {
  pattern = "alpha",
  group = augroup("filegroup", { clear = true }),
  command = "setlocal laststatus=0 noruler",
})

local nvim_version = vim.version()
dashboard.section.footer.val = string.format(
		' v%s.%s.%s Loaded %s plugins in %sms',
		nvim_version.major,
		nvim_version.minor,
		nvim_version.patch,
		'??',
		'??'
)

alpha.setup(dashboard.config)
