#!/usr/bin/env bash

detect_package_manager() {
    if command -v apt >/dev/null; then
        package_manager="apt"
        install="sudo apt install -y"
        update="sudo apt update"
    elif command -v dnf >/dev/null; then
        package_manager="dnf"
        install="sudo dnf install -y"
        update="sudo dnf upgrade"
    elif command -v pacman >/dev/null; then
        package_manager="pacman"
        install="sudo pacman -S --noconfirm"
        update="sudo pacman -Syy"
    else
        error "No supported package manager found!"
        exit 1
    fi
}
