for conf in ~/.config/bash/conf.d/*.sh
do
    if [ -e $conf ]; then
      source $conf
    fi
done

for conf in ~/.config/zsh/conf.d/*.zsh
do
    if [ -e $conf ]; then
      source $conf
    fi
done
