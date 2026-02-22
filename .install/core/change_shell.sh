change_shell() {
  local current_shell
  local zsh_path

  current_shell="$(getent passwd "$USER" | awk -F: '{print $7}')"
  zsh_path="$(command -v zsh)"

  [[ -z "$zsh_path" ]] && {
    log_error "zsh is not installed"
    return 1
  }

  grep -qx "$zsh_path" /etc/shells || {
    log_error "$zsh_path is not listed in /etc/shells"
    return 1
  }

  if [[ "$current_shell" == "$zsh_path" ]]; then
    log_info "zsh is already the default shell"
    return 0
  fi

  if $DRY_RUN; then
    log_info "[dry-run] would change default shell to zsh"
    return 0
  fi

  log_loading "changing default shell to zsh"

  if run_command sudo chsh -s "$zsh_path" "$USER"; then
    log_success "default shell changed to zsh (takes effect on next login)"
  else
    log_error "failed to change default shell"
    return 1
  fi
}
