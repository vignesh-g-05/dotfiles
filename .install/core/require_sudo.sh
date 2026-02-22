require_sudo() {

  if $DRY_RUN; then
    log_info "[dry-run] skipping sudo check"
    return 0
  fi

  if sudo -n true 2>/dev/null; then
    log_success "sudo access available"
    return 0
  fi

  log_info "Requesting sudo access..."

  if sudo -v; then
    log_success "Sudo access granted"
    return 0
  else
    log_error "Failed to obtain sudo access."
    return 1
  fi
}
