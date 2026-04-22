is_curl_installed() {
    command -v curl >/dev/null 2>&1
}

curl_pkg_is_installed() {
    case "$1" in
        nvm)
            [[ -d "$HOME/.nvm" ]]
        ;;
        *)
            command -v "$1" >/dev/null 2>&1
        ;;
    esac
}

install_curl_package() {
    local package="$1"
    local cmd="$2"
    
    if curl_pkg_is_installed "$package"; then
        log_info "$package already installed"
        SKIPPED_PACKAGES+=("$package")
        return 0
    fi
    
    if $DRY_RUN; then
        log_info "[dry-run] would run: $cmd"
        WOULD_INSTALL_PACKAGES+=("$package")
        return 0
    fi
    
    if $VERBOSE; then
        log_info "installing $package"
    else
        log_loading "installing $package"
    fi
    
    if run_command "bash -c \"$cmd\""; then
        log_success "$package installed"
        INSTALLED_PACKAGES+=("$package")
        return 0
    else
        log_error "failed to install $package"
        FAILED_PACKAGES+=("$package")
        return 1
    fi
}

install_curl_packages() {
    if ! is_curl_installed; then
        log_error "curl is not available"
        return 1
    fi
    
    for pkg in "${!CURL_PACKAGES_MAP[@]}"; do
        install_curl_package "$pkg" "${CURL_PACKAGES_MAP[$pkg]}"
    done
}
