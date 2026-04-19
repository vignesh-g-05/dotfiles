#!/usr/bin/env bash

readonly THEMES_DIR="${HOME:?}/.config/themes"
readonly THEME_SOURCES_DIR="$THEMES_DIR/sources"
readonly CURRENT_THEME_LINK="$THEMES_DIR/current-theme"
readonly ROFI_THEME="$HOME/.config/rofi/themes/theme-switcher.rasi"

[[ -d "$THEMES_DIR" ]] || { echo "missing: $THEMES_DIR" >&2; exit 1; }
[[ -d "$THEME_SOURCES_DIR" ]] || { echo "missing: $THEME_SOURCES_DIR" >&2; exit 1; }

get_current_theme() {
    [[ -h "$CURRENT_THEME_LINK" ]] || return 1
    
    local current_variant
    current_variant=$(readlink -f -- "$CURRENT_THEME_LINK") || return 1
    
    realpath --relative-to="$THEME_SOURCES_DIR" "$current_variant" \
    | cut -d/ -f1
}

get_all_themes() {
    local dir
    for dir in "$THEME_SOURCES_DIR"/*/; do
        [[ -d "$dir" ]] && basename "$dir"
    done | sort
}

get_default_variant() {
    local new_theme="$1"
    local theme_config="$THEME_SOURCES_DIR/$new_theme/config.json"
    
    [[ -f "$theme_config" ]] || {
        echo "missing config for theme '$new_theme'" >&2
        return 1
    }
    
    local variant
    variant=$(jq -er '.defaultVariant' "$theme_config") || {
        echo "invalid or missing defaultVariant in $theme_config" >&2
        return 1
    }
    
    printf '%s\n' "$variant"
}

reload_apps() {
    swaync-client -R && swaync-client -rs
    
    pkill -x swayosd-server 2>/dev/null && swayosd-server &
    
    hyprctl reload || echo "hyprctl reload failed" >&2
    
    pkill -USR1 kitty 2>/dev/null
    
    ~/.local/bin/orbit reload-theme || echo "orbit reload failed" >&2
    
    local wallpaper
    wallpaper=$(find "$CURRENT_THEME_LINK/assets" \
    -maxdepth 1 -type f -name "wallpaper.*" -print -quit)
    
    [[ -f "$wallpaper" ]] && swww img "$wallpaper" \
    --transition-type center \
    --transition-duration 1.5 \
    --transition-fps 60 \
    --transition-step 90
}

apply_theme() {
    local new_theme="$1"
    local colors_file="$THEME_SOURCES_DIR/$new_theme/colors.toml"
    
    [[ -f "$colors_file" ]] || {
        echo "missing colors.toml for theme '$new_theme'" >&2
        return 1
    }
    
    python "$THEMES_DIR/build-theme.py" "$colors_file" || {
        echo "theme build failed" >&2
        return 1
    }
    
    link_current_theme "$new_theme" || return 1
    
    build_hyprlock_variables "$new_theme" || {
        echo "hyprlock build failed" >&2
        return 1
    }
    
    apply_gtk_theme "$new_theme" || {
        echo "gtk apply failed" >&2
        return 1
    }
    
    setup_kitty_theme "$new_theme" || {
        echo "kitty theme apply failed" >&2
        return 1
    }
    
}

apply_gtk_theme() {
    local new_theme="$1"
    local theme_config="$THEME_SOURCES_DIR/$new_theme/config.json"
    
    [[ -f "$theme_config" ]] || {
        echo "missing config: $theme_config" >&2
        return 1
    }
    
    local gtk_theme
    gtk_theme=$(jq -er '.gtkTheme' "$theme_config") || {
        echo "missing or invalid gtkTheme in $theme_config" >&2
        return 1
    }
    
    gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme" || {
        echo "failed to apply gtk theme: $gtk_theme" >&2
        return 1
    }
}

build_hyprlock_variables() {
    local new_theme="$1"
    
    local default_variant
    default_variant=$(get_default_variant "$new_theme") || return 1
    
    local variant_dir="$THEME_SOURCES_DIR/$new_theme/variants/$default_variant"
    local assets_dir="$variant_dir/assets"
    local hyprlock_conf="$THEMES_DIR/build/hypr/hyprlock.conf"
    
    [[ -d "$assets_dir" ]] || {
        echo "missing assets dir: $assets_dir" >&2
        return 1
    }
    
    local hyprlock_bg
    hyprlock_bg=$(find "$assets_dir" -maxdepth 1 -type f \
    -name "lockscreen.*" -print -quit)
    
    [[ -n "$hyprlock_bg" ]] || {
        echo "no lockscreen wallpaper found in $assets_dir" >&2
        return 1
    }
    
    mkdir -p "$(dirname "$hyprlock_conf")"
    
    printf '%s\n' "\$bg_img=$hyprlock_bg" > "$hyprlock_conf"
}

link_current_theme() {
    local new_theme="$1"
    
    local default_variant
    default_variant=$(get_default_variant "$new_theme") || return 1
    
    local variant_dir="$THEME_SOURCES_DIR/$new_theme/variants/$default_variant"
    
    [[ -d "$variant_dir" ]] || {
        echo "invalid variant dir: $variant_dir" >&2
        return 1
    }
    
    ln -sfn "$variant_dir" "$CURRENT_THEME_LINK" || {
        echo "failed to update current theme link" >&2
        return 1
    }
}

setup_kitty_theme() {
    local new_theme="$1"
    
    local src_conf="$THEME_SOURCES_DIR/$new_theme/kitty.conf"
    local dest_dir="$THEMES_DIR/build/kitty"
    local dest_conf="$dest_dir/colors.conf"
    
    [[ -f "$src_conf" ]] || {
        echo "missing kitty.conf for theme '$new_theme'" >&2
        return 1
    }
    
    mkdir -p "$dest_dir" || {
        echo "failed to create dir: $dest_dir" >&2
        return 1
    }
    
    cp "$src_conf" "$dest_conf" || {
        echo "failed to copy kitty config" >&2
        return 1
    }
}

main() {
    local selected_theme current_theme
    
    selected_theme=$(get_all_themes | rofi -dmenu -theme "$ROFI_THEME") || return 1
    [[ -n "$selected_theme" ]] || return 0
    
    current_theme=$(get_current_theme) || current_theme=""
    
    [[ "$selected_theme" == "$current_theme" ]] && return 0
    
    apply_theme "$selected_theme" || {
        echo "failed to apply theme: $selected_theme" >&2
        return 1
    }
    
    reload_apps
}

main "$@"