setup_orbit_service() {
    local tmp_dir="$1"
    local service_dir="$HOME/.config/systemd/user"
    
    if $DRY_RUN; then
        log_info "[dry-run] would setup orbit systemd service"
        return 0
    fi
    
    mkdir -p "$service_dir"
    
    if systemctl --user is-enabled orbit >/dev/null 2>&1; then
        log_info "orbit service already enabled"
        return 0
    fi
    
    if ! cp "$tmp_dir/aur/orbit.service" "$service_dir/"; then
        log_error "failed to copy orbit service"
        return 1
    fi
    
    if ! systemctl --user daemon-reload; then
        log_error "systemd user session not available"
        return 1
    fi
    
    systemctl --user enable --now orbit
    
    log_success "orbit service enabled"
}

install_orbit() {
    local repo="https://github.com/LifeOfATitan/orbit.git"
    local install_dir="$HOME/.local/bin"
    local tmp_dir="/tmp/orbit-install"
    
    if command -v orbit >/dev/null 2>&1; then
        log_info "orbit already installed"
        return 0
    fi
    
    if $DRY_RUN; then
        log_info "[dry-run] would install orbit to $install_dir"
        return 0
    fi
    
    log_loading "installing orbit"
    
    rm -rf "$tmp_dir"
    
    if ! git clone "$repo" "$tmp_dir"; then
        log_error "failed to clone orbit"
        return 1
    fi
    
    cd "$tmp_dir" || return 1
    
    if ! cargo build --release; then
        log_error "failed to build orbit"
        return 1
    fi
    
    mkdir -p "$install_dir"
    
    if ! install -Dm755 target/release/orbit "$install_dir/orbit"; then
        log_error "failed to install orbit binary"
        return 1
    fi
    
    log_success "orbit installed to $install_dir"
    
    setup_orbit_service "$tmp_dir"
    
    rm -rf "$tmp_dir"
}