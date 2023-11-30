#!/bin/bash

delay="0.5"

# Press Alt + Shift + 0
sleep $delay
xdotool keydown alt keydown shift keydown 0
sleep $delay
xdotool keyup 0 keyup shift keyup alt
sleep $delay

# Press Win + f
xdotool keydown Super_L keydown f
xdotool keyup f keyup Super_L

# Press Win + Shift + 0
xdotool keydown Super_L keydown shift keydown 0
xdotool keyup 0 keyup shift keyup Super_L

# Press Win + 0
xdotool keydown Super_L keydown 0
xdotool keyup 0 keyup Super_L

# Press Win + Shift + Space
xdotool keydown Super_L keydown shift keydown space
xdotool keyup space keyup shift keyup Super_L
