#!/bin/bash

CURRENT_DIR=$(pwd)

for i in `ls`; do
    if [ $i != 'setup.sh' ]; then
        if [ -f "$HOME/.$i" ] || [ -h "$HOME/.$i" ]; then
            rm $HOME/.$i
        fi
        ln -s $CURRENT_DIR/$i $HOME/.$i
    fi
done;

if [ ! -d ~/.rvm/gemsets ]; then
    mkdir -p ~/.rvm/gemsets
fi

rm ~/.global.gems
ln -s $CURRENT_DIR/global.gems ~/.rvm/gemsets/global.gems
