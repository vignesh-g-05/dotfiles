INSTALL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── constants ───────────────────────────────
source "$INSTALL_ROOT/constants/styles.sh"
source "$INSTALL_ROOT/constants/packages.sh"

# ── lib ─────────────────────────────────────
source "$INSTALL_ROOT/lib/logging.sh"
source "$INSTALL_ROOT/lib/show_help.sh"

# ── ui ──────────────────────────────────────
source "$INSTALL_ROOT/ui/utils.sh"
source "$INSTALL_ROOT/ui/show_install_summary.sh"
source "$INSTALL_ROOT/ui/show_stow_summary.sh"

# ── core ────────────────────────────────────
source "$INSTALL_ROOT/core/pm_detect.sh"
source "$INSTALL_ROOT/core/collect_user_preferences.sh"
source "$INSTALL_ROOT/core/require_sudo.sh"
source "$INSTALL_ROOT/core/change_shell.sh"

# ── installers ──────────────────────────────
source "$INSTALL_ROOT/installers/enable_copr.sh"
source "$INSTALL_ROOT/installers/install_dependencies.sh"
source "$INSTALL_ROOT/installers/install_package.sh"
source "$INSTALL_ROOT/installers/install_package_group.sh"
source "$INSTALL_ROOT/installers/install_cargo_packages.sh"
source "$INSTALL_ROOT/installers/install_curl_packages.sh"
source "$INSTALL_ROOT/installers/stow_configs.sh"
source "$INSTALL_ROOT/installers/setup_hyprland.sh"

main(){
    
    collect_user_preferences
    
    if [[ "$INSTALL_PACKAGES" == false && "$STOW_DOTFILES" == false && "$SETUP_HYPRLAND" == false ]]; then
        log_info "No installation components selected. Nothing to do."
        log_info "Exiting installer."
        exit 0
    fi
    
    if detect_package_manager; then
        log_success "Detected package manager: $PKG_MANAGER"
    else
        log_error "No supported package manager found (apt, dnf, pacman)"
        exit 1
    fi
    
    if ! require_sudo; then
        exit 1
    fi
    
    if $INSTALL_PACKAGES; then
        install_dependencies
    fi
    
    if $STOW_DOTFILES; then
        stow_configs
    fi
    
    if $SETUP_HYPRLAND; then
        setup_hyprland
    fi
    change_shell
    
    if [[ "$INSTALL_PACKAGES" == true || "$SETUP_HYPRLAND" == true ]]; then
        show_install_summary
    fi
    
    exit 0
}

main "$@"

