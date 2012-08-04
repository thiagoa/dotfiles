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
