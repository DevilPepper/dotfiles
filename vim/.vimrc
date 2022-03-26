# be iMproved, required
set nocompatible

# you might've copied the default .vimrc because it does some useful stuff.
# i.e. not_my_machine.vimrc does some things specifically useful for
# whatever work place you're in, so you can't just delete it
for vimrc in glob("~/*.vimrc", 0, 1)
    source vimrc
endfor

# load modular settings in lexicographical order
for vimscript in glob("~/.config/vim/*/*.vim", 0, 1)
    source vimrc
endfor
