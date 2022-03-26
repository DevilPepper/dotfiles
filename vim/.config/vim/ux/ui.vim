# Set 7 lines to the cursor - when moving vertically using j/k
set so=7

#Always show current position
set ruler

# Height of the command bar
set cmdheight=1

# A buffer becomes hidden when it is abandoned
set hid

# Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

# Ignore case when searching
set ignorecase

# When searching try to be smart about cases 
set smartcase

# Highlight search results
set hlsearch

# Makes search act like search in modern browsers
set incsearch 

# Don't redraw while executing macros (good performance config)
set lazyredraw 

# For regular expressions turn magic on
set magic

# Show matching brackets when text indicator is over them
set showmatch 
# How many tenths of a second to blink when matching brackets
set mat=2

# No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

# Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


# Add a bit extra margin to the left
set foldcolumn=1

# Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

# Remove toolbar and menu bar, and make text tabs, like terminal vim.
# set guioptions-=T
# set guioptions-=m
# set guioptions-=e

# Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
