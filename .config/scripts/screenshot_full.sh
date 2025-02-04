#!/bin/bash

FILE=~/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png
scrot "$FILE"
xclip -selection clipboard -t image/png -i "$FILE"
