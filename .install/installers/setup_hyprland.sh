enable_dnf_copr_repos() {

  log_info "Ensuring required COPR repositories are enabled..."

  local repos=(
    "solopasha/hyprland"
    "erikreider/SwayNotificationCenter"
    "erikreider/swayosd"
  )

  for repo in "${repos[@]}"; do

    if dnf copr list | grep -q "$repo"; then
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

setup_hyprland() {

  if [[ "$PKG_MANAGER" == "apt" ]]; then
    log_info "Hyprland setup is not supported on apt-based systems. Skipping."
    return 0
  fi

  enable_dnf_copr_repos

  install_package_group "HYPRLAND SETUP" HYPRLAND_PACKAGES
}
