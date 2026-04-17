#!/usr/bin/env bash

readonly THEMES_DIR="$HOME/.config/themes"
readonly THEME_SOURCES_DIR="$THEMES_DIR/sources"
readonly CURRENT_THEME_LINK="$THEMES_DIR/current-theme"
readonly ROFI_THEME="$HOME/.config/rofi/themes/theme-switcher.rasi"

if [[ ! -d "$THEMES_DIR" || ! -d "$THEME_SOURCES_DIR" ]]; then
    echo "missing themes directory" >&2
    exit 1
fi

get_current_theme() {
    [[ ! -h "$CURRENT_THEME_LINK" ]] && return 1
    local current_variant=$(readlink "$CURRENT_THEME_LINK")
    basename $(dirname $(dirname "$current_variant"))
}

get_all_themes() {
    for dir in "$THEME_SOURCES_DIR"/*/; do
        basename "$dir"
    done
}

get_default_variant() {
    local default_variant_file="$THEMES_DIR/sources/$1/default-variant.txt"
    [[ ! -f "$default_variant_file" ]] && {
        echo "missing default-theme.txt for theme '$1'" >&2
        exit 1
    }
    cat "$default_variant_file"
}

open_rofi() {
    rofi -dmenu -theme "$ROFI_THEME"
}

reload_apps() {
    pkill waybar
    waybar &
    swaync-client -R && swaync-client -rs
    pkill swayosd-server && swayosd-server &
    hyprctl reload
    pkill -USR1 kitty
    ~/.local/bin/orbit reload-theme
    wallpaper=$(find "$CURRENT_THEME_LINK/assets" -maxdepth 1 -type f \
    -name "wallpaper.*" | head -n 1)
    [ -f "$wallpaper" ] && swww img "$wallpaper" \
    --transition-type center \
    --transition-duration 1.5 \
    --transition-fps 60 \
    --transition-step 90
}

build_theme() {
    local new_theme="$1"
    link_current_theme "$new_theme"
    local colors_file="$THEME_SOURCES_DIR/$new_theme/colors.toml"
    
    [[ ! -f "$colors_file" ]] && {
        echo "missing colors.toml file for theme '$new_theme'" >&2
        exit 1
    }
    
    python "$THEMES_DIR/build-theme.py" "$colors_file"
    build_hyprlock_variables "$new_theme"
}

build_hyprlock_variables() {
    set -x
    local new_theme="$1"
    local default_variant="$(get_default_variant "$new_theme")"
    local variant_dir="$THEME_SOURCES_DIR/$new_theme/variants/$default_variant"
    local hyprlock_conf="$THEMES_DIR/build/hypr/hyprlock.conf"
    local hyprlock_bg
    
    hyprlock_bg=$(find "$variant_dir/assets" -maxdepth 1 -type f \
        \( -name "lockscreen.png" -o -name "lockscreen.jpg" -o -name "lockscreen.jpeg" -o -name "lockscreen.webp" \) \
    | head -n 1)
    
    if [ -z "$hyprlock_bg" ]; then
        echo "No wallpaper found in $variant_dir/assets"
        return 1
    fi
    
    echo "\$bg_img=$hyprlock_bg" > "$hyprlock_conf"
    set +x
}

link_current_theme() {
    local new_theme="$1"
    local default_variant="$(get_default_variant "$new_theme")"
    local variant_dir="$THEME_SOURCES_DIR/$new_theme/variants/$default_variant"
    [[ -h "$CURRENT_THEME_LINK" ]] && rm "$CURRENT_THEME_LINK"
    ln -s "$variant_dir" "$CURRENT_THEME_LINK"
    setup_kitty_theme "$new_theme"
}

setup_kitty_theme() {
    local new_theme="$1"
    local kitty_conf="$THEME_SOURCES_DIR/$new_theme/kitty.conf"
    if [[ ! -f "$kitty_conf" ]]; then
        echo "missing kitty.conf for theme $new_theme" >&2
        exit 1
    fi
    local current_kitty_dir="$THEMES_DIR/build/kitty"
    mkdir -p "$current_kitty_dir"
    cp "$kitty_conf" "$current_kitty_dir/colors.conf"
}

main() {
    selected_theme="$(get_all_themes | open_rofi)"
    [[ -z "$selected_theme" ]] && exit 0
    current_theme="$(get_current_theme)"
    [[ "$selected_theme" == "$current_theme" ]] && exit 0
    build_theme "$selected_theme"
    reload_apps
}

main