#!/usr/bin/env bash

install_sddm_cursor() {
    local SDDM_CONF_DIR="/etc/sddm.conf.d"
    local CURSOR_CONF="$SDDM_CONF_DIR/cursor.conf"
    local CURSOR_CONTENT='[General]
GreeterEnvironment=XCURSOR_THEME=macOS,XCURSOR_SIZE=24'

    if ! command -v sddm >/dev/null; then
        info "SDDM not installed, skipping SDDM cursor config"
        return
    fi

    if [ -f "$CURSOR_CONF" ]; then
        info "SDDM cursor config already exists"
        return
    fi

    info "Installing SDDM cursor configuration"
    sudo mkdir -p "$SDDM_CONF_DIR"
    echo "$CURSOR_CONTENT" | sudo tee "$CURSOR_CONF" >/dev/null
}


install_sddm_theme() {
    if ! command -v sddm >/dev/null; then
        info "SDDM not installed, skipping SDDM theming"
        return
    fi

    if [ -d "/usr/share/sddm/themes/sddm-astronaut-theme" ]; then
        info "SDDM Astronaut theme already installed"
    else
        info "Installing SDDM Astronaut theme"
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
    fi

    install_sddm_cursor
}
