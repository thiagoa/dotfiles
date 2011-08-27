#!/bin/bash

for i in `ls`; do
    if [ $i != 'setup.sh' ]; then
        if [ -f ~/.$i ]; then
            mv ~/.$i ~/.$i"".backup
        fi
        cp ./$i ~/.$i
    fi
done;
