#!/usr/bin/env bash

while ! pactl info >/dev/null 2>&1; do
    sleep 0.2
done

AUDIO_FILE="$HOME/.config/shared/audio/startup.wav"

pactl set-sink-volume @DEFAULT_SINK@ 70%

pw-play "$AUDIO_FILE" >/dev/null 2>&1

pactl set-sink-volume @DEFAULT_SINK@ 40%
