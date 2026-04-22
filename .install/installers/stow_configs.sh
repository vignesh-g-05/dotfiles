
STOWED_PACKAGES=()
CONFLICTING_PACKAGES=()

stow_config () {
    if run_command stow --target="$HOME" --simulate "$1"; then
        
        if $DRY_RUN; then
            log_info "[dry-run] would stow $1"
            WOULD_STOW_PACKAGES+=("$1")
            return 0
        fi
        
        if run_command stow --target="$HOME" "$1"; then
            log_success "stowed $1 successfully"
            STOWED_PACKAGES+=("$1")
        else
            log_error "failed to stow $1 (real run)"
            CONFLICTING_PACKAGES+=("$1")
        fi
        
    else
        log_error "failed to stow $1 (simulation)"
        CONFLICTING_PACKAGES+=("$1")
    fi
}

stow_configs () {
    
    if ! command -v stow >/dev/null 2>&1; then
        log_error "GNU stow is not installed"
        return 1
    fi
    
    if $VERBOSE; then
        log_info "stowing packages"
    else
        log_loading "stowing packages"
    fi
    
    for pkg in "${STOW_PACKAGES[@]}"; do
        stow_config "$pkg"
    done
    
    log_info "stowing completed"
    show_stow_summary
}
