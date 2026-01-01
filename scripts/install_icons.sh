#!/usr/bin/env bash

install_icons() {
    ICONS_DIR="/usr/share/icons/"
    THEME_NAME="Mkos-Big-Sur"
    THEME_REPO="https://github.com/zayronxio/Mkos-Big-Sur"

    TARGET="$ICONS_DIR/$THEME_NAME"

    if [ -d "$TARGET/.git" ]; then
        info "Icon theme already installed: $THEME_NAME"
        return 0
    fi

    if git clone "$THEME_REPO" "$TARGET"; then
        success "Installed icon theme: $THEME_NAME"
    else
        error "Failed to install icon theme: $THEME_NAME"
        return 1
    fi
}
