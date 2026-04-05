#!/usr/bin/env bash

cd ~/.config/themes || exit

target=$(readlink "$HOME/.config/themes/current-theme")

current_theme=$(basename "$(dirname "$(dirname "$target")")")

dirs=()

for d in */; do
    [[ "$d" == "current-theme/" || "$d" == "utils/" ]] && continue
    dirs+=("${d%/}")
done

options=$(IFS='|'; echo "${dirs[*]}")

response=$(printf "%s\n" "$options" | rofi -sep '|' -dmenu \
-theme ~/.config/rofi/themes/theme-switcher.rasi)

[[ -z "$response" || "$response" == "$current_theme" ]] && exit 0

theme_dir="$HOME/.config/themes/${response}"
theme_link="$HOME/.config/themes/current-theme"

mkdir -p "$(dirname "$theme_link")"
rm -f "$theme_link"

variant_dir=$(find "$theme_dir/variants" -mindepth 1 -maxdepth 1 -type d | head -n 1)
[ -z "$variant_dir" ] && exit 1

ln -s "$variant_dir" "$theme_link" || exit 1

wallpaper="$theme_link/wallpaper"
[ -f "$wallpaper" ] && swww img "$wallpaper" \
--transition-type center \
--transition-duration 1.5 \
--transition-fps 60 \
--transition-step 90

pkill waybar
waybar &

swaync-client -R && swaync-client -rs