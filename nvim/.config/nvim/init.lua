function read_file(path)
    local file = io.open(path, 'r')
    if not file then return '' end
    local content = file:read '*all'
    file:close()
    return content
end

vim.opt.number = true
vim.cmd 'highlight LineNr ctermfg=black'
vim.opt.fillchars = {eob = " "}

autocmd = vim.api.nvim_create_autocmd
augroup = vim.api.nvim_create_augroup
