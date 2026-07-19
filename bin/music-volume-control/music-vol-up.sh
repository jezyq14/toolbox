#!/bin/bash

# Requires playerctl!
if playerctl --list-all | grep -iq "^spotify$"; then
  current_vol=$(playerctl -p spotify volume 2>/dev/null)
  if [[ -z "$current_vol" ]]; then
    rmpc volume +5
  else
    new_vol=$(echo "$current_vol + 0.05" | bc)
    new_vol=$(echo "$new_vol" | awk '{if($1 > 1) print 1; else print $1}')
    playerctl -p spotify volume "$new_vol"
  fi
else
  rmpc volume +5
fi


if playerctl --list-all | grep -iq "^spotify$"; then
  vol=$(playerctl -p spotify volume 2>/dev/null)
  vol_percent=$(echo "$vol * 100" | bc | awk '{printf "%d", $1}')
  progress=$(echo "scale=2; $vol" | bc)
else
  vol=$(rmpc volume)
  vol_percent=$vol
  progress=$(echo "scale=2; $vol / 100" | bc)
fi


# Show OSD with volume, useful on tiling WMs like sway, hyprland
#swayosd-client --custom-progress "$progress" --custom-progress-text="${vol_percent}%" --custom-icon=audio-card
