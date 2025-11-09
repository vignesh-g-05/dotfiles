#!/usr/bin/env bash

stow_configurations() {
    info "Stowing configurations..."
    read -p "This will remove all existing configs. Continue? [y/n] " answer
    [[ "$answer" == "n" ]] && { info "Aborted."; exit 0; }

    cd "$HOME/dotfiles" || { error "Failed to access dotfiles directory"; exit 1; }

    config_paths=("atuin" "fastfetch" "nvim" "wezterm" "zsh")

    info "Cleaning and stowing configs..."

    # Clean and stow .config directories
    for config in "${config_paths[@]}"; do
        target="$HOME/.config/$config"
        rm -rf "$target"
        stow "$config"
    done

    # Special cases outside .config
    rm -rf "$HOME/.config/zsh" "$HOME/.zshrc"
    stow zsh

    rm -f "$HOME/.gitconfig"
    stow git

    rm -f "$HOME/.config/starship.toml"
    stow starship

    success "Dotfiles stowed successfully!"
}
