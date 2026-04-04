#!/usr/bin/env bash

options="Purple|Graphite Dark"
theme_link="$HOME/.config/themes/current-theme"
themes_dir="$HOME/.config/themes"


refresh_system() {
    waypaper --restore
    pkill waybar; waybar &
    swaync-client -R && swaync-client -rs
}

response=$(printf '%s\n' "$options" | rofi -sep '|' -dmenu \
    -theme '~/.config/rofi/themes/theme-switcher.rasi')

[ -z "$response" ] && exit 0

mkdir -p "$(dirname "$theme_link")"
rm -f "$theme_link"

case "$response" in
    "Purple")
        ln -s "$themes_dir/purple/variants/raiden-shogun" "$theme_link"
        refresh_system
        ;;
    "Graphite Dark")
        ln -s "$themes_dir/graphite-dark/variants/firefly" "$theme_link"
        refresh_system
        ;;
esac

