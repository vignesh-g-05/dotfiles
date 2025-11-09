#!/usr/bin/env bash

install_packages() {
    for tool in "$@"; do
        info "Installing ${tool}..."
        if command -v "$tool" >/dev/null 2>&1; then
            info "${tool} already installed"
        elif eval "$install $tool" >/dev/null 2>&1; then
            success "Installed ${tool}"
        else
            error "Failed to install ${tool}"
        fi
    done
}

install_cargo_tools() {
    for tool in "$@"; do
        if command -v "$tool" >/dev/null 2>&1; then
            info "$tool already installed"
        else
            cargo install "$tool" && success "Installed $tool" || error "Failed to install $tool"
        fi
    done
}
