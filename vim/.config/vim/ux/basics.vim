filetype off

filetype plugin indent on

# Sets how many lines of history VIM has to remember
set history=500

# Enable filetype plugins
filetype plugin on
filetype indent on

# Set to auto read when a file is changed from the outside
set autoread

# Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

# Use Unix as the standard file type
set ffs=unix,dos,mac

# Turn backup off, since most stuff is in SVN, git, etc. anyway...
set nobackup
set nowb
set noswapfile

# Use spaces instead of tabs
set expandtab

# Be smart when using tabs ;)
set smarttab

# 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

# Always show the status line
#set laststatus=2

# Format the status line
#set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
