#!/usr/bin/env bash

options="Theme|Variant"

response=$(printf "%s\n" "$options" | rofi -sep '|' -dmenu \
  -theme ~/.config/rofi/themes/mode-selector.rasi)

[ -z "$response" ] && exit 0

CONFIG_DIR="$HOME/.config/themes"

case "$response" in
  "Theme")
    "$CONFIG_DIR/theme-switcher.sh"
    ;;
  "Variant")
    "$CONFIG_DIR/variant-switcher.sh"
    ;;
  *)
    exit 1
    ;;
esac