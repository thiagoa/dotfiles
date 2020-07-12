#!/bin/bash
# https://www.reddit.com/r/nvidia/comments/4an7js/linux_nvidia_propriatary_driver_tearing_issues/
nvidia-settings --load-config-only --assign CurrentMetaMode="$(xrandr | sed -nr '/(\S+) connected (primary )?[0-9]+x[0-9]+(\+\S+).*/{ s//\1: nvidia-auto-select \3 { ForceFullCompositionPipeline = On }, /; H }; ${ g; s/\n//g; s/, $//; p }')"
