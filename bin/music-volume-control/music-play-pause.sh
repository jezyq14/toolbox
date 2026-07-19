#!/bin/bash

# Requires playerctl!
if playerctl --list-all | grep -iqE "^YoutubeMusic$|^spotify$"; then
  playerctl -p YoutubeMusic,spotify play-pause
else
  rmpc togglepause
fi
