INSTALLED_PACKAGES=()
FAILED_PACKAGES=()
SKIPPED_PACKAGES=()

pkg_is_installed() {
    local package="$1"
    
    case "$PKG_MANAGER" in
        apt)
            dpkg -s "$package" >/dev/null 2>&1
        ;;
        dnf)
            rpm -q "$package" >/dev/null 2>&1
        ;;
        pacman)
            pacman -Qi "$package" >/dev/null 2>&1
        ;;
        *)
            return 1
        ;;
    esac
}


pkg_exists_in_repo() {
    "${PKG_INFO_CMD[@]}" "$1" &>/dev/null
}

install_pkg() {
    run_command "${PKG_INSTALL_CMD[@]}" "$1"
}

install_package() {
    local package="$1"
    
    if pkg_is_installed "$package" || command -v "$package" >/dev/null 2>&1; then
        log_info "$package already installed"
        SKIPPED_PACKAGES+=("$package")
        return 0
    fi
    
    if $DRY_RUN; then
        
        if $VERBOSE; then
            log_info "checking availability of $package in repositories"
        else
            log_loading "checking availability of $package in repositories"
        fi
        
        if pkg_exists_in_repo "$package"; then
            log_info "[dry-run] would install $package"
            INSTALLED_PACKAGES+=("$package")
        else
            log_warn "[dry-run] package not found: $package"
            FAILED_PACKAGES+=("$package")
        fi
        return 0
    fi
    
    if $VERBOSE; then
        log_info "installing $package"
    else
        log_loading "installing $package"
    fi
    
    if install_pkg "$package"; then
        log_success "$package installed"
        INSTALLED_PACKAGES+=("$package")
        return 0
    else
        log_error "failed to install $package"
        FAILED_PACKAGES+=("$package")
        return 1
    fi
}
