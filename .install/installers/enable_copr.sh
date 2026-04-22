enable_dnf_copr_repos() {
    
    if [[ "$PKG_MANAGER" != "dnf" ]]; then
        return 0
    fi
    
    log_info "Ensuring required COPR repositories are enabled..."
    
    local repos=(
        "solopasha/hyprland"
        "erikreider/SwayNotificationCenter"
        "erikreider/swayosd"
    )
    
    for repo in "${repos[@]}"; do
        
        if dnf copr list --enabled | grep -q "$repo"; then
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
