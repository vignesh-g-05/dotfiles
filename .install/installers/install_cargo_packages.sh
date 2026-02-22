is_cargo_installed(){
  command -v cargo >/dev/null 2>&1
}

crate_is_installed() {
  command -v "$1" >/dev/null 2>&1
}

install_cargo_crate() {
  local package="$1"

  if crate_is_installed "$package"; then
    log_info "$package already installed"
    SKIPPED_PACKAGES+=("$package")
    return 0
  fi

  if $DRY_RUN; then
    log_info "[dry-run] would install $package"
    INSTALLED_PACKAGES+=("$package")
    return 0
  fi

  if $VERBOSE; then
    log_info "installing $package"
  else
    log_loading "installing $package"
  fi

  if run_command cargo install "$package"; then
    log_success "$package installed"
    INSTALLED_PACKAGES+=("$package")
  else
    log_error "failed to install $package"
    FAILED_PACKAGES+=("$package")
  fi
}

install_cargo_packages(){
  if ! is_cargo_installed; then
    log_error "cargo is not available"
  fi
  for pkg in "${CARGO_PACKAGES[@]}"; do
    install_cargo_crate "$pkg"
  done
}
