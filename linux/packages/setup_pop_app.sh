#!/usr/bin/env bash

curl -fsSL https://packagecloud.io/pop/pop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/pop.asc > /dev/null
echo "deb https://packagecloud.io/pop/pop/debian/ buster main" | sudo tee /etc/apt/sources.list.d/pop.list

sudo apt install pop

