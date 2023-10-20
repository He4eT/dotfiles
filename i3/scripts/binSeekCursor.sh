#!/bin/bash

temp_file="/tmp/binSeekCursor"

# Reset working area

if [ "$1" == "reset" ]; then
  rm $temp_file
  exit 0
fi

# Fail fast: Check 'direction' parameter

if [ "$1" != "up" ] && [ "$1" != "right" ] && [ "$1" != "down" ] && [ "$1" != "left" ]; then
  echo "Invalid or missing direction. It must be 'up', 'right', 'down', or 'left'."
  exit 1
fi

# Current cursor position: $X and $Y

eval $(xdotool getmouselocation --shell)

# Screen dimensions

screen_size=($(xdpyinfo | awk '/dimensions:/ {print $2}' | tr 'x' ' '))
screen_width=${screen_size[0]}
screen_height=${screen_size[1]}

# Default working area

working_area_left=0
working_area_top=0
working_area_right=$screen_width
working_area_down=$screen_height

# Override values from the temporary file
# if it exists and is not older than 2 seconds
if [ -f $temp_file ]; then
  last_call=$(stat -c %Y $temp_file)
  current_time=$(date +%s)
  if [ $((current_time - last_call)) -le 2 ]; then
    source $temp_file
  fi
fi

# Functions to move the cursor to the center of the working area

move_cursor_to_vertical_center() {
  local center_y=$((working_area_top + (working_area_down - working_area_top) / 2))
  xdotool mousemove $X $center_y
}

move_cursor_to_horizontal_center() {
  local center_x=$((working_area_left + (working_area_right - working_area_left) / 2))
  xdotool mousemove $center_x $Y
}

# Set the working area borders based on the direction

case "$1" in
  "up")
    working_area_down=$Y
    move_cursor_to_vertical_center
    ;;
  "down")
    working_area_top=$Y
    move_cursor_to_vertical_center
    ;;
  "right")
    working_area_left=$X
    move_cursor_to_horizontal_center
    ;;
  "left")
    working_area_right=$X
    move_cursor_to_horizontal_center
    ;;
esac

# Write timestamp and working area to the temporary file

echo "" > $temp_file
echo "working_area_left=$working_area_left" >> $temp_file
echo "working_area_top=$working_area_top" >> $temp_file
echo "working_area_right=$working_area_right" >> $temp_file
echo "working_area_down=$working_area_down" >> $temp_file
