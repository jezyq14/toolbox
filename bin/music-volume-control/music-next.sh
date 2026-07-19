#!/bin/bash

# Requires playerctl!
if playerctl --list-all | grep -iqE "^YoutubeMusic$|^spotify$"; then
  playerctl -p YoutubeMusic,spotify next
else
  rmpc next
fi