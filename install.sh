#!/usr/bin/env bash

# Load modules
source ./scripts/utils.sh
source ./scripts/package_manager.sh
source ./scripts/install_tools.sh
source ./scripts/install_scripts.sh
source ./scripts/stow_config.sh

info "Setting up your configuration..."

read -p "Do you want to setup packages? [y/n] " is_package_install
read -p "Do you want to stow configurations? [y/n] " is_stow_config

if [[ "$is_package_install" == "y" ]]; then
    detect_package_manager
    eval "$update"

    base_tools=(git curl wget zsh stow unzip nvim cargo fastfetch bat)
    cargo_tools=(eza)

    install_packages "${base_tools[@]}"
    install_cargo_tools "${cargo_tools[@]}"

    install_script "starship" "curl -sS https://starship.rs/install.sh | sh"
    install_script "atuin" "curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh"

    if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
        install_script "nvm" "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash"
    else
        info "nvm already installed"
    fi


    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        sudo chsh -s $(which zsh) $USER
    fi

fi

if [[ "$is_stow_config" == "y" ]]; then
    stow_configurations
fi

success "Setup complete! 🎉 Please restart your terminal."
