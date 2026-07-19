#!/bin/bash

# Requires wpctl
sleep 3

RAZER_CARD_ID=$(wpctl status | grep "Razer Barracuda X 2.4" | grep "\[alsa\]" | grep -oE '[0-9]+' | head -n 1)

if [ -z "$RAZER_CARD_ID" ]; then
    echo "Razer card not found."
    exit 1
fi

wpctl set-profile "$RAZER_CARD_ID" 1
sleep 1.5

wpctl set-profile "$RAZER_CARD_ID" 2
sleep 1

wpctl set-default "$RAZER_CARD_ID"
