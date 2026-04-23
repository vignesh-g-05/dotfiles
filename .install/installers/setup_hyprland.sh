setup_hyprland() {
    
    if [[ "$PKG_MANAGER" == "apt" ]]; then
        log_info "Hyprland setup is not supported on apt-based systems. Skipping."
        return 0
    fi
    
    install_package_group "HYPRLAND SETUP" HYPRLAND_PACKAGES
    install_orbit
}
