#!/usr/bin/env bash

WATCH_DIR="$HOME/Pictures"
SOUND="$HOME/.config/shared/audio/screenshot-sound.mp3"

if [[ $1 == "screen" ]]; then
  MODE="screen"
else
  MODE="gui"
fi

# Start inotify watcher in background
inotifywait -m -e create --format '%f' "$WATCH_DIR" |
while read -r file; do
  if [[ "$file" == *.png ]]; then
    pw-play "$SOUND"
    break
  fi
done &

flameshot "$MODE"

killall inotifywait

