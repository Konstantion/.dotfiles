#!/bin/bash

FILE=~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png
scrot -a 1920,0,2560,1440 "$FILE"
xclip -selection clipboard -t image/png -i "$FILE"
