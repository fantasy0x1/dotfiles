#!/bin/bash

export TERM=xterm-256color

picom -b &
flameshot &
discord &

# don't touch it
notify-send -t 8000 -u normal --icon=/home/flame/.config/qtile/assets/waifu_coffe.png "uuuuh?" "welcome back sir! how are u?"