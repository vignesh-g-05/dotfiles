#!/usr/bin/env bash

cd ~/.config/themes || exit

target=$(realpath "$HOME/.config/themes/current-theme")

current_variant=$(basename "$target")
current_theme=$(basename "$(dirname "$(dirname "$target")")")

current_variant_dir=$(dirname "$target")
cd "$current_variant_dir" || exit

dirs=()

for d in */; do
    [[ "$d" == "default-variant/" ]] && continue
    dirs+=("${d%/}")
done

response=$(printf "%s\n" "${dirs[@]}" | rofi -dmenu \
-theme ~/.config/rofi/themes/theme-switcher.rasi)

[[ -z "$response" || "$response" == "$current_variant" ]] && exit 0

theme_dir="$HOME/.config/themes/${current_theme}"
theme_link="$HOME/.config/themes/current-theme"
selected_variant_dir="$theme_dir/variants/$response"

[ ! -d "$selected_variant_dir" ] && exit 1

mkdir -p "$(dirname "$theme_link")"
rm -f "$theme_link"

ln -s "$selected_variant_dir" "$theme_link" || exit 1

wallpaper="$theme_link/wallpaper"
[ -f "$wallpaper" ] && swww img "$wallpaper" \
--transition-type wipe \
--transition-angle 45 \
--transition-duration 1.5 \
--transition-step 90 \
--transition-fps 60