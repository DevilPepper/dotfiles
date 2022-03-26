noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

# Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

# Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

# Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

# Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

# Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

# Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
