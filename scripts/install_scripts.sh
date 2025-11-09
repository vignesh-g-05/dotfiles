#!/usr/bin/env bash

install_script() {
    local name="$1"
    local url="$2"
    local shell="${3:-bash}"

    if command -v "$name" >/dev/null 2>&1; then
        info "$name already installed"
    else
        curl -fsSL "$url" | "$shell"
        if command -v "$name" >/dev/null 2>&1; then
            success "$name installed successfully"
        else 
            error "Failed to install $name"
        fi
    fi
}
