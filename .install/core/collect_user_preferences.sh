DRY_RUN=false
VERBOSE=false
INSTALL_PACKAGES=true
STOW_DOTFILES=true
SETUP_HYPRLAND=false

collect_user_preferences() {

  print_header "Dotfiles Installer Configuration"

  ask_yes_no "Install system packages?" "yes" \
    && INSTALL_PACKAGES=true \
    || INSTALL_PACKAGES=false

  ask_yes_no "Stow dotfiles?" "yes" \
    && STOW_DOTFILES=true \
    || STOW_DOTFILES=false

  if [[ "$PKG_MANAGER" != "apt" ]]; then
    ask_yes_no "Setup Hyprland?" "no" \
      && SETUP_HYPRLAND=true \
      || SETUP_HYPRLAND=false
  fi

  ask_yes_no "Run in dry mode (no changes applied)?" "no" \
    && DRY_RUN=true \
    || DRY_RUN=false

  ask_yes_no "Enable verbose output?" "no" \
    && VERBOSE=true \
    || VERBOSE=false

  echo
}

ask_yes_no() {
  local question="$1"
  local default="$2"
  local response

  if [[ "$default" == "yes" ]]; then
    log_prompt "$question (Y/n): "
    read  response
  else
    log_prompt "$question (y/N): "
    read response
  fi

  response="${response,,}"

  if [[ -z "$response" ]]; then
    [[ "$default" == "yes" ]] && return 0 || return 1
  fi

  case "$response" in
    y|yes) return 0 ;;
    n|no)  return 1 ;;
    *)     return 1 ;;
  esac
}
