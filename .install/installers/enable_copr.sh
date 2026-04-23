enable_dnf_copr_repos() {
    
    if [[ "$PKG_MANAGER" != "dnf" ]]; then
        return 0
    fi
    
    if $VERBOSE; then
        log_info "Ensuring required COPR repositories are enabled..."
    else
        log_loading "Ensuring required COPR repositories are enabled..."
    fi
    
    local repos=(
        "solopasha/hyprland"
        "erikreider/SwayNotificationCenter"
        "erikreider/swayosd"
        "atim/starship"
    )
    
    for repo in "${repos[@]}"; do
        
        if dnf copr list | grep -q "^$repo"; then
            log_info "COPR '$repo' already enabled. Skipping."
            continue
        fi
        
        if [[ "$DRY_RUN" == true ]]; then
            log_info "[dry-run] sudo dnf -y copr enable $repo"
            continue
        fi
        
        run_command sudo dnf -y copr enable "$repo"
        
    done
}
