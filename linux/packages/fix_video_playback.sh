#!/usr/bin/env bash

# Fixes video playback on Pop!_OS 22.04, at least with my Radeon card. Remove
# when no longer needed.
sudo apt remove gstreamer1.0-vaapi
