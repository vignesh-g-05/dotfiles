#!/usr/bin/env bash

install_script() {
    local name="$1"
    local curl_install="$2"

    if command -v "$name" >/dev/null 2>&1; then
        info "$name already installed"
    else
        eval "$curl_install"
        if command -v "$name" >/dev/null 2>&1; then
            success "$name installed successfully"
        else 
            error "Failed to install $name"
        fi
    fi
}
