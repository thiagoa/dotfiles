#!/bin/bash

for file in `find ~/OneDrive/Scripts -type f -maxdepth 1 -not -path '*/\.*'`; do
    ln -s $file ~/bin/$(basename $file) 2> /dev/null
done
