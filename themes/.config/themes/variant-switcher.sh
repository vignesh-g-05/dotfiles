#!/usr/bin/env bash

readonly THEMES_DIR="$HOME/.config/themes"
readonly CURRENT_THEME_LINK="$THEMES_DIR/current-theme"
readonly ROFI_THEME="$HOME/.config/rofi/themes/variant-switcher.rasi"

target=$(realpath "$CURRENT_THEME_LINK") || exit 1

current_theme="$(basename "$(dirname "$(dirname "$target")")")"
current_variant="$(basename "$target")"
current_theme_variants_dir="$(dirname "$target")"

build_hyprlock_variables() {
    set -x
    local new_variant="$1"
    local hyprlock_conf="$THEMES_DIR/build/hypr/hyprlock.conf"
    local hyprlock_bg=$(find "$current_theme_variants_dir/$new_variant/assets" -maxdepth 1 -type f -name "lockscreen.*" | head -n 1)
    
    if [ -z "$hyprlock_bg" ]; then
        echo "No wallpaper found in $variant_dir/assets"
        return 11
    fi
    
    echo "\$bg_img=$hyprlock_bg" > "$hyprlock_conf"
}

response=$(
    for d in "$current_theme_variants_dir"/*/; do
        name="${d%/}"
        
        preview="$name/assets/fastfetch.png"
        [ -f "$preview" ] || continue
        name="${name##*/}"
        
        printf "%s\0icon\x1f%s\n" "$name" "$preview"
    done | rofi -dmenu -show-icons -theme "$ROFI_THEME"
)

[[ -z "$response" || "$response" == "$current_variant" ]] && exit 0

selected_variant_dir="$THEMES_DIR/sources/$current_theme/variants/$response"
[ -d "$selected_variant_dir" ] || exit 1

# atomic switch
ln -sfn "$selected_variant_dir" "$CURRENT_THEME_LINK"

# wallpaper
wallpaper=$(find "$CURRENT_THEME_LINK/assets" -maxdepth 1 -type f -name "wallpaper.*" | head -n 1)

build_hyprlock_variables "$response"

[ -f "$wallpaper" ] && swww img "$wallpaper" \
--transition-type wipe \
--transition-angle 45 \
--transition-duration 1.5 \
--transition-step 90 \
--transition-fps 60